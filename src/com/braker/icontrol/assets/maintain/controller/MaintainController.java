package com.braker.icontrol.assets.maintain.controller;

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
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Lookups;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.assets.maintain.manager.MaintainMng;
import com.braker.icontrol.assets.maintain.manager.MaintainRegMng;
import com.braker.icontrol.assets.maintain.model.Maintain;
import com.braker.icontrol.assets.maintain.model.MaintainReg;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
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
@RequestMapping("/Maintain")
public class MaintainController extends BaseController{

	@Autowired
	private MaintainMng maintainMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private MaintainRegMng maintainRegMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/**
	 * 调后转到list列表页面
	 * @param model
	 * @return
	 * @createTime 2019-04-22
	 * @author 陈睿超
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/assets/maintain/maintain_fixed_list";
	}
	
	/**
	 * 固定资产维修申请页面数据
	 * @param maintain
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createTime 2019-04-22
	 * @author 陈睿超
	 */
	@ResponseBody
	@RequestMapping("/jsonPagination")
	public JsonPagination jsonPagination(Maintain maintain,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = maintainMng.list(maintain, getUser(),sort, order, page, rows);
		List<Maintain> list = (List<Maintain>) p.getList();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNumber(i+1);
		}
		p.setList(list);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到新增页面
	 * @param model
	 * @return
	 * @createTime 2019-04-22
	 * @author 陈睿超
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		Maintain m=new Maintain();
		m.settAssetMainCode(StringUtil.Random("WX"));
		User user=getUser();
		m.setfMainDept(user.getDepartName());
		m.setfMainDeptID(user.getDepart().getId());
		m.setfMainUser(user.getName());
		m.setfMainUserID(user.getId());
		m.setfMainTime(new Date());
		model.addAttribute("bean", m);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("固定资产维修");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"GDZCWX", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);

		return "/WEB-INF/view/assets/maintain/maintain_add";
	}

	/**
	 * 弹出选择维修资产页面
	 * @param model
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@RequestMapping("/chooseAss")
	public String chooseAss(ModelMap model){
		return "/WEB-INF/view/assets/maintain/maintain_add_asset";
	}
	
	/**
	 * 加载选择维修资产页面
	 * @param abi
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createTime 2019-04-22
	 * @author 陈睿超
	 */
	@ResponseBody
	@RequestMapping("/chooseJsonPagination")
	public JsonPagination chooseJsonPagination(AssetBasicInfo abi, String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = assetBasicInfoMng.maintainchoose(abi, page, rows);
		List<AssetBasicInfo> abiList = (List<AssetBasicInfo>) p.getList();
		for (int i = 0; i < abiList.size(); i++) {
			abiList.get(i).setNumber(i+1);
		}
		p.setList(abiList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 弹出选指标页面
	 * @param model
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@RequestMapping("/BudgetIndexCode")
	public String BudgetIndexCode(ModelMap model){
		return "/WEB-INF/view/choiceIndex";
	}
	
	/**
	 * 保存维修申请单
	 * @param maintain
	 * @param files
	 * @param storageFiles
	 * @param model
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Result save(Maintain maintain,String maintainFiles ,String storageFiles,ModelMap model){
		try {
			maintainMng.save(maintain, maintainFiles, storageFiles, getUser());
			return getJsonResult(true,Result.saveSuccessMessage );
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage );
		}
	}
	
	/**
	 * 查询字典里资产类型
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = maintainMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
	/**
	 * 查看
	 * @param id 主键
	 * @param model
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id ,ModelMap model){
		Maintain bean = maintainMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		//维修附件
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("maintianAttaList", attaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GDZCWX", bean.getfMainDeptID(),bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(),bean.gettAssetMainCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfMainUser(), bean.getfMainDept(), bean.getfMainTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCWX",bean.getfMainDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
		
		return "/WEB-INF/view/assets/maintain/maintain_add";
	}

	/**
	 * 修改
	 * @param id 主键
	 * @param model
	 * @return
	 * @createTime 2019-04-23
	 * @author 陈睿超
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		Maintain bean = maintainMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "edit");
		model.addAttribute("detailType", "detail");
		//维修附件
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("maintianAttaList", attaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("固定资产维修");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GDZCWX", bean.getfMainDeptID(),bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(),bean.gettAssetMainCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfMainUser(), bean.getfMainDept(), bean.getfMainTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCWX",bean.getfMainDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
				
		return "/WEB-INF/view/assets/maintain/maintain_add";
	}
	
	/**
	 * 根据id逻辑删除
	 * @param id 主键
	 * @param model
	 * @return
	 * @createTime 2019-04-2
	 * @author 陈睿超
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			maintainMng.delete(Integer.valueOf(id));
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}

	/**
	 * 跳转到维修审批的list页面
	 * @param model
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/approvalList")
	public String approvalList(ModelMap model){
		return "/WEB-INF/view/assets/maintain/approval/maintain_fixed_approval_list";
	}
	
	/**
	 * 加载维修申请待审批数据
	 * @param maintain 
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/approvalJson")
	@ResponseBody
	public JsonPagination approvalJson(Maintain maintain, String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = maintainMng.approvalList(maintain, getUser(), sort, order, page, rows);
		List<Maintain> list = (List<Maintain>) p.getList();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNumber(i+1);
		}
		p.setList(list);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到审批页面
	 * @param id
	 * @param model
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/approvalMaintain/{id}")
	public String approvalMaintain(@PathVariable String id ,ModelMap model){
		Maintain bean = maintainMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "app");
		model.addAttribute("detailType", "detail");
		//维修附件
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("maintianAttaList", attaList);
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("固定资产维修");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GDZCWX", bean.getfMainDeptID(),bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.gettAssetMainCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfMainUser(), bean.getfMainDept(), bean.getfMainTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCWX",bean.getfMainDeptID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
		
		return "/WEB-INF/view/assets/maintain/approval/maintain_add_approval";
	}
	
	/**
	 * 保存审批记录
	 * @param stauts
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/approve/{stauts}")
	@ResponseBody
	public Result approve(@PathVariable String stauts,String id,TProcessCheck checkBean,String spjlFile,ModelMap model){
		try {
			if("btg".equals(stauts)){
				 checkBean = new TProcessCheck("0", checkBean.getFcheckRemake());
			 }else{
				 checkBean = new TProcessCheck("1", checkBean.getFcheckRemake());
			 }
			maintainMng.approveMaintain(id, getUser(), checkBean, spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 跳转到登记list页面
	 * @param model
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/registrationList")
	public String registrationList(ModelMap model){
		return "/WEB-INF/view/assets/maintain/registration/maintain_registration_list";
	}
	
	/**
	 * 加载维修登记数据
	 * @param maintainReg
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createTime 2019-04-24
	 * @author 陈睿超
	 */
	@RequestMapping("/registrationJson")
	@ResponseBody
	public JsonPagination registrationJson(MaintainReg maintainReg, String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=maintainRegMng.registrationJson(maintainReg, getUser(), sort, order, page, rows);
		List<MaintainReg> abiList = (List<MaintainReg>) p.getList();
		for (int i = 0; i < abiList.size(); i++) {
			abiList.get(i).setNumber(i+1);
		}
		p.setList(abiList);
		return getJsonPagination(p, page);
	}

	/**
	 * 新增一条数据
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/addReg")
	public String addReg(ModelMap model){
		User user = getUser();
		MaintainReg maintainReg=new MaintainReg();
		maintainReg.settMianRegCode(StringUtil.Random("WXDJ"));
		maintainReg.setfMainRegDept(user.getDepartName());
		maintainReg.setfMainRegUser(user.getName());
		model.addAttribute("bean", maintainReg);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		return "/WEB-INF/view/assets/maintain/registration/maintain_registration_add";
	}
	
	
	/**
	 * 跳转到登记页面
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/registration/{id}")
	public String registration(@PathVariable String id,ModelMap model){
		Maintain maitain=maintainMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", maitain);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		//显示审批记录
		model.addAttribute("checkinfo", "1");
		return "/WEB-INF/view/assets/maintain/registration/maintain_registration_add";
	}
	
	/**
	 * 维修登记时跳转到选择维修单页面
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/chooseMain")
	public String chooseMain(ModelMap model){
		return "/WEB-INF/view/assets/maintain/registration/maintain_choose_list";
	}

	/**
	 * 加载维修登记时选择维修单数据
	 * @param maintain 
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/chooseMainJson")
	@ResponseBody
	public JsonPagination chooseMainJson(Maintain maintain,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=maintainMng.regList(maintain, getUser(), sort, order, page, rows);
		List<Maintain> abiList = (List<Maintain>) p.getList();
		for (int i = 0; i < abiList.size(); i++) {
			abiList.get(i).setNumber(i+1);
		}
		p.setList(abiList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 保存维修登记信息
	 * @param maintainReg
	 * @param model
	 * @createTime 2019-04-25
	 * @author 陈睿超
	 */
	@RequestMapping("/saveRegistration")
	@ResponseBody
	public Result saveRegistration(MaintainReg maintainReg,ModelMap model){
		try {
			maintainRegMng.saveRegistration(maintainReg, getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(true, Result.saveFailureMessage);
		}
		
	}
	
	/**
	 * 跳转查看维修登记
	 * @param id
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/detailReg/{id}")
	public String detailReg(@PathVariable String id ,ModelMap model){
		MaintainReg maintainReg=maintainRegMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", maintainReg);
		model.addAttribute("openType", "detil");
		model.addAttribute("detailType", "detail");
		return "/WEB-INF/view/assets/maintain/registration/maintain_registration_add";
	}
	/**
	 * 跳转到修改维修登记
	 * @param id
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/editReg/{id}")
	public String editReg(@PathVariable String id ,ModelMap model){
		MaintainReg maintainReg=maintainRegMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", maintainReg);
		model.addAttribute("openType", "edit");
		model.addAttribute("detailType", "detail");
		return "/WEB-INF/view/assets/maintain/registration/maintain_registration_add";
	}
	/**
	 * 删除维修登记
	 * @param id
	 * @param model
	 * @return
	 * @createTime 2019-04-26
	 * @author 陈睿超
	 */
	@RequestMapping("/deleteReg/{id}")
	@ResponseBody
	public Result deleteReg(@PathVariable String id ,ModelMap model){
		try {
			maintainRegMng.deleteReg(id);
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}
	
}
