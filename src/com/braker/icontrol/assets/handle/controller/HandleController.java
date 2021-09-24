package com.braker.icontrol.assets.handle.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.assets.handle.manager.HandleMng;
import com.braker.icontrol.assets.handle.manager.RegistrationMng;
import com.braker.icontrol.assets.handle.model.AssetRegistration;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Handle")
public class HandleController extends BaseController{

	@Autowired
	private HandleMng handleMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private RegistrationMng registrationMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private AttachmentMng attachmentMng;
	
	
	/**
	 * 跳转到资产处置申请List页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/lowapplicationList")
	public String lowapplicationList(ModelMap model){
		return "/WEB-INF/view/assets/handle/handle_low_list";
	}
	
	/**
	 * 跳转到资产处置申请List页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/fixedapplicationList")
	public String fixedapplicationList(ModelMap model){
		return "/WEB-INF/view/assets/handle/handle_fixed_list";
	}
	
	/**
	 * 加载资产处置申请的List页面数据
	 * @param handle 搜索条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/applicationJson")
	@ResponseBody
	public JsonPagination applicationJson(Handle handle,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = handleMng.applicationList(handle, getUser(), page, rows);
		List<Handle> li= (List<Handle>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}

	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = handleMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
	/**
	 * 弹出新增申请界面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/addApplication")
	public String addApplication(String fAssType,ModelMap model){
		Handle handle=new Handle();
		User user = getUser();
		handle.setfAssHandleCode(StringUtil.Random("CZ"));
		Lookups assType = lookupsMng.findByLookCode(fAssType);
		handle.setfAssType(assType);
		handle.setfReqUserid(user.getId());
		handle.setfReqUser(user.getName());
		handle.setfRecDept(user.getDepartName());
		handle.setfReqTime(new Date());
		handle.setfSumAmount(0.00);
		model.addAttribute("bean", handle);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		
		if(fAssType.equals("ZCLX-02")){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"GDZCCZ", user.getDpID(),null,null, null, null, null, "1");
			model.addAttribute("nodeConf", nodeConfList);
			model.addAttribute("type", "ZCLX-02");
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}else if(fAssType.equals("ZCLX-01")){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"DZYHPCZ", user.getDpID(),null,null, null, null, null, "1");
			model.addAttribute("nodeConf", nodeConfList);
			model.addAttribute("type", "ZCLX-01");
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}
		return null;
	}
	
	/**
	 * 加载处置的修改查看时清单表数据
	 * @param fId handle的主键
	 * @param fAssType 类型：低值易耗品，固定资产
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/assetRegJson")
	public JsonPagination regJsonPagination(String fId , String fAssType,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = handleMng.lowAndFixedHandle(fId, fAssType);
		return getJsonPagination(p, page);
	}
	
	
	
	
	
	/**
	 * 弹出选择处置物资编号页面
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/AssCodeList")
	public String receCodeList(ModelMap model,String Type){
		model.addAttribute("type", Type);
		return "/WEB-INF/view/assets/handle/handle_add_assCode";
	}
	
	/**
	 * 弹出选择姓名和部门信息的页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/nameAndDept")
	public String nameAndDept(ModelMap model){
		return "/WEB-INF/view/assets/handle/handle_add_nameAndDept";
	}
	
	/**
	 * 加载项目部门信息
	 * @param user
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-16
	 */
	@RequestMapping("/allocaNameAndDeptList")
	@ResponseBody
	public JsonPagination allocaNameAndDeptList(User user,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = userMng.getNameAndDept(user, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 加载库存里的物资品目
	 * @param ABI
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/AssCodeJson")
	@ResponseBody
	public JsonPagination AssCodeJson(AssetBasicInfo ABI,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=assetBasicInfoMng.allStork(ABI, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 保存修改资产处置申请单
	 * @param handle
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/applicationSave")
	@ResponseBody
	public Result applicationSave(String  planJson,Handle handle,String LowHandleFlies,ModelMap model){
		try {
			
			handleMng.save(planJson,handle, getUser(),LowHandleFlies);
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}
	
	/**
	 * 查看资产处置申请单
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/detail/{id}")
	public String Detail(@PathVariable String id,ModelMap model,String ledger){
		Handle handle = new Handle();
		if("detailLedger".equals(ledger)){
			handle = handleMng.findbyCode(id);
			model.addAttribute("detailType", "ledger");
		}else{
			model.addAttribute("detailType", "detail");
			handle = handleMng.findById(Integer.valueOf(id));
		}
		model.addAttribute("bean", handle);
		model.addAttribute("openType", "detail");
		//处置单附件
		List<Attachment> handleAttaList = attachmentMng.list(handle);
		model.addAttribute("handleList", handleAttaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//得到申请部门id
		String departId=departMng.findDeptByUserId(handle.getfReqUserid())[0];
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(handle.getfReqUser(), handle.getfRecDept(), handle.getfReqTime());
		model.addAttribute("proposer", proposer);	
		//对象id
		model.addAttribute("foCode",handle.getBeanCode());
		if("ZCLX-02".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"GDZCCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(), handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-02");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_detail";
		}else if("ZCLX-01".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("DZYHPCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"DZYHPCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(), handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-01");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_detail";
		}
		return null;
	}
	
	/**
	 * 弹出修改资产处置单
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		Handle handle = handleMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", handle);
		model.addAttribute("openType", "edit");
		model.addAttribute("detailType", "detail");
		//处置单附件
		List<Attachment> handleAttaList = attachmentMng.list(handle);
		model.addAttribute("handleList", handleAttaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//得到申请部门id
		String departId=departMng.findDeptByUserId(handle.getfReqUserid())[0];
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(handle.getfReqUser(), handle.getfRecDept(), handle.getfReqTime());
		model.addAttribute("proposer", proposer);	
		//对象id
		model.addAttribute("foCode",handle.getBeanCode());
		if("ZCLX-02".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"GDZCCZ", departId,handle.getBeanCode(),handle.getfNextCode(),handle.getJoinTable(), handle.getBeanCodeField(),handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-02");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}else if("ZCLX-01".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("DZYHPCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"DZYHPCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(),handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-01");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}
		return null;
	}
	
	/**
	 * 删除物资处置申请
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			handleMng.delete(id, getUser());;
			return getJsonResult(true, "操作成功！");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}
	
	/**
	 * 跳转到物资处置审批List页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/approvalList")
	public String approvalList(String fAssType,ModelMap model){
		model.addAttribute("fAssType", fAssType);
		return "/WEB-INF/view/assets/handle/approval/handle_approval_list";
	}
	
	/**
	 * 加载物资处置审批List页面数据
	 * @param handle
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/approvalJson")
	@ResponseBody
	public JsonPagination approvalJson(Handle handle,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=handleMng.approvalList(handle, getUser(), page, rows);
		List<Handle> li= (List<Handle>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 查看资产审批申请单
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-17
	 */
	@RequestMapping("/approvalDetail/{id}")
	public String approvalDetail(@PathVariable String id,ModelMap model){
		Handle handle = handleMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", handle);
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		//处置单附件
		List<Attachment> handleAttaList = attachmentMng.list(handle);
		model.addAttribute("handleList", handleAttaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//得到申请部门id
		String departId=departMng.findDeptByUserId(handle.getfReqUserid())[0];
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(handle.getfReqUser(), handle.getfRecDept(), handle.getfReqTime());
		model.addAttribute("proposer", proposer);	
		//对象id
		model.addAttribute("foCode",handle.getBeanCode());
		if("ZCLX-02".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"GDZCCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(),handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-02");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}else if("ZCLX-01".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("DZYHPCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"DZYHPCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(), handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-01");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/handle_base_add";
		}
		return "/WEB-INF/view/assets/handle/handle_base_add";
	}
	
	/**
	 * 弹出审批的页面
	 * @param id
	 * @param model
	 * @return@author 陈睿超
	 * @createtime 2018-08-18
	 */
	@RequestMapping("/approvalHandle/{id}")
	public String approvalHandle(@PathVariable String id,ModelMap model){
		Handle handle = handleMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", handle);
		model.addAttribute("openType", "approval");	
		model.addAttribute("detailType", "detail");
		model.addAttribute("fAssType", handle.getfAssType().getCode());
		//处置单附件
		List<Attachment> handleAttaList = attachmentMng.list(handle);
		model.addAttribute("handleList", handleAttaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//得到申请部门id
		String departId=departMng.findDeptByUserId(handle.getfReqUserid())[0];
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(handle.getfReqUser(), handle.getfRecDept(), handle.getfReqTime());
		model.addAttribute("proposer", proposer);	
		//对象id
		model.addAttribute("foCode",handle.getBeanCode());
		if("ZCLX-02".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"GDZCCZ", departId,handle.getBeanCode(),handle.getfNextCode(),handle.getJoinTable(),  handle.getBeanCodeField(), handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-02");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/approval/handle_base_add";
		}else if("ZCLX-01".equals(handle.getfAssType().getCode())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("DZYHPCZ", departId);
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(handle.getUserId(),"DZYHPCZ", departId,handle.getBeanCode(),handle.getfNextCode(), handle.getJoinTable(), handle.getBeanCodeField(),handle.getfAssHandleCode(),"1");
			model.addAttribute("type", "ZCLX-01");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/assets/handle/approval/handle_base_add";
		}
		return "/WEB-INF/view/assets/handle/approval/handle_base_add";
	}
	
	/**
	 * 保存审批
	 * @param stauts
	 * @param handle
	 * @param ACI
	 * @param model
	 * @return@author 陈睿超
	 * @createtime 2018-08-18
	 */
	@RequestMapping("/approval/{stauts}")
	@ResponseBody
	public Result approval(@PathVariable String stauts,Handle handle,TProcessCheck checkBean,String spjlFile,ModelMap model){
		try {
			handleMng.updateStauts(stauts, handle, checkBean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
/*	*//**
	 * 跳转到处置登记页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationList")
	public String registrationList(String fAssType,ModelMap model){
		model.addAttribute("fAssType", fAssType);
		return "/WEB-INF/view/assets/handle/registration/handle_registration_list";
	}
	
	*//**
	 * 修改新增时选择处置登记list页面数据
	 * @param handle
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationJson")
	@ResponseBody
	public JsonPagination registrationJson(String fAssType,AssetRegistration assetRegistration,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = registrationMng.registrationList(assetRegistration,fAssType, getUser(), page, rows);
		List<AssetRegistration> li= (List<AssetRegistration>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	*//**
	 * 弹出登记新增页面
	 * @param molde
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationAdd")
	public String registrationAdd(String fAssType,ModelMap model){
		model.addAttribute("openType", "add");
		model.addAttribute("fAssType", fAssType);
		AssetRegistration AR=new AssetRegistration();
		AR.setfAssHandleRegCode(StringUtil.Random("DJ"));
		model.addAttribute("bean", AR);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/handle/registration/handle_registration_add";
	}
	
	*//**
	 * 弹出选择处置单的页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/HandleList")
	public String HandleList(ModelMap model){
		return "/WEB-INF/view/assets/handle/registration/handle_registration_handlelist";
	}
	
	*//**
	 * 选择处置单的数据
	 * @param handle
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/handleRegJson")
	@ResponseBody
	public JsonPagination handleRegJson(Handle handle,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = handleMng.handleRegList(handle, getUser(), page, rows);
		List<Handle> li= (List<Handle>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	*//**
	 * 处置登记保存
	 * @param assetRegistration
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationSave")
	@ResponseBody
	public Result registrationSave(AssetRegistration assetRegistration){
		try {
			registrationMng.save(assetRegistration, getUser());
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}
	
	*//**
	 * 处置修改弹窗
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationEdit/{id}")
	public String registrationEdit(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "edit");
		AssetRegistration AR=registrationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", AR);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/handle/registration/handle_registration_add";
	}
	
	*//**
	 * 查看处置登记单详情
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationDetail/{id}")
	public String registrationDetail(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		AssetRegistration AR=registrationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", AR);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/handle/registration/handle_registration_add";
	}
	
	*//**
	 * 删除处置登记表
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-21
	 *//*
	@RequestMapping("/registrationDelete/{id}")
	@ResponseBody
	public Result registrationDelete(@PathVariable String id,ModelMap model){
		try {
			AssetRegistration AR=registrationMng.findById(Integer.valueOf(id));
			AR.setfRegStauts("99");
			registrationMng.saveOrUpdate(AR);
			return getJsonResult(true, "操作成功！");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
	}*/
	
	/**
	 * 跳转到台账页面
	 * @param fAssType
	 * @return
	 */
	@RequestMapping("/ledgerList")
	public String ledgerList(String fAssType){
		
		return "/WEB-INF/view/assets/handle/handle_base_ledger_list";
	}
	
	/**
	 * 
	 * @param handle
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ledgerJson")
	public JsonPagination ledgerJson(Handle handle,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = handleMng.ledgerPagination(handle, getUser(), page, rows);
		List<Handle> li= (List<Handle>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 撤回
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-10-08
	 * @updatetime 2019-12-17
	 */
	@ResponseBody
	@RequestMapping("/reCall")
	public Result reCall(String id,ModelMap model){
		try {
			handleMng.reCall(id);
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
	
	
	
}