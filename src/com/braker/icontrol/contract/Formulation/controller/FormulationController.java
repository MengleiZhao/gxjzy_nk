package com.braker.icontrol.contract.Formulation.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Lookups;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Formulation")
public class FormulationController extends BaseController{
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private ContractPlanListMng contractPlanListMng;
	@Autowired
	private CgApplysqMng applysqMng;
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private CgSelMng cgselMng;
	@Autowired
	private ContPayMng contPayMng;
	/**
	 * 跳转主页面
	 * @param model
	 * @return
	 * @createtime 2018-06-12
	 * @author crc
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String fpId){
		model.addAttribute("beanClass",ContractBasicInfo.class.getName());
		if(!StringUtil.isEmpty(fpId)){
			model.addAttribute("fpId", fpId);
			return "/WEB-INF/view/contract/formulation/formulation_list_zxk";
		}
		return "/WEB-INF/view/contract/formulation/formulation_list";
	}
	
	/**
	 * 显示主页面的信息（带查询）
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2018-06-12
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=formulationMng.queryList(contractBasicInfo,getUser(),page,rows);
    	List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
			if("HTFL-03".equals(li.get(i).getFcType())){
				li.get(i).setFcAmount(null);
			}
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到新增页面
	 * @param model
	 * @return
	 * @createtime 2018-06-12
	 * @author crc
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		ContractBasicInfo cbi=new ContractBasicInfo();
		User user = getUser();
		String fcCode = formulationMng.getFcCode();
		cbi.setFcCode(fcCode);
		cbi.setStandard(1);
		cbi.setfOperator(user.getName());
		cbi.setfOperatorId(user.getId());
		cbi.setfReqtIME(new Date());
		cbi.setfIsAuthor("0");
		cbi.setfUpdateStatus("0");
		cbi.setfDisputeStatus("0");
		cbi.setfDeptName(user.getDepartName());
		cbi.setfDeptId(user.getDpID());
		model.addAttribute("bean",cbi);
		model.addAttribute("openType", "add");
		
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(cbi);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTND", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同拟定");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/formulation/formulation_add";
	}
	
	/**
	 * 保存/送审
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ContractBasicInfo contractBasicInfo, String files, SignInfo signInfo, String htwbfiles, String planJson, ModelMap model,String mingxi,String proceedsJson){
		try {
			if("1".equals(contractBasicInfo.getfFlowStauts())){
				if (StringUtils.isNotEmpty(proceedsJson)) {
					ArrayList<String> arrayList = new ArrayList<>();
					List<ProceedsPlan> proceedsPlans = JSON.parseObject(proceedsJson,new TypeReference<List<ProceedsPlan>>(){});
					if (proceedsPlans.size() > 0) {
						for (int i = 0; i < proceedsPlans.size(); i++) {
							if (StringUtils.isEmpty(proceedsPlans.get(i).getfProceedsCondition())) {
								return getJsonResult(false,"请填写收款条件！");
							}else if (StringUtils.isEmpty(proceedsPlans.get(i).getfProceedsTime().toString())) {
								return getJsonResult(false,"请填写预计收款时间！");
							}
							arrayList.add(proceedsPlans.get(i).getfProceedsProperty());
						}
					}
					int a = Collections.frequency(arrayList,"首款");
					int b = Collections.frequency(arrayList,"验收款");
					int c = Collections.frequency(arrayList,"质保款");
					if (a>1) {
						return getJsonResult(false,"首款只能填写一个！");
					}
					if (b>1) {
						return getJsonResult(false,"验收款只能填写一个！");
					}
					if (c>1) {
						return getJsonResult(false,"质保款只能填写一个！");
					}
				}
				if (StringUtils.isNotEmpty(planJson)) {
					ArrayList<String> array = new ArrayList<>();
					List<DataEntity> list2 =(List<DataEntity>)JSONArray.toList(JSONArray.fromObject(planJson), DataEntity.class);
					//转换成ReceivPlan类型的list
					List<ReceivPlan> receivPlan = filingMng.getReceivPlan(list2, getUser(), contractBasicInfo);
					if (receivPlan.size() > 0) {
						for (int i = 0; i < receivPlan.size(); i++) {
							if (StringUtils.isEmpty(receivPlan.get(i).getfReceCondition())) {
								return getJsonResult(false,"请填写付款条件！");
							}else if (StringUtils.isEmpty(receivPlan.get(i).getfRecePlanTime().toString())) {
								return getJsonResult(false,"请填写预计付款时间！");
							}
							array.add(receivPlan.get(i).getfReceProperty());
						}
					}
					int a = Collections.frequency(array,"首款");
					int b = Collections.frequency(array,"验收款");
					int c = Collections.frequency(array,"质保款");
					if (a>1) {
						return getJsonResult(false,"首款只能填写一个！");
					}
					if (b>1) {
						return getJsonResult(false,"验收款只能填写一个！");
					}
					if (c>1) {
						return getJsonResult(false,"质保款只能填写一个！");
					}
				}
				//送审
				if(StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
					return getJsonResult(false,"请填写合同名称！");
				}else if(StringUtil.isEmpty(contractBasicInfo.getFcNum())){
					return getJsonResult(false,"请填写合同份数！");
				}else if(StringUtil.isEmpty(contractBasicInfo.getFcType())){
					return getJsonResult(false,"请选择合同类型！");
				}else if(contractBasicInfo.getFcNum().length()>2){
					return getJsonResult(false,"合同份数请填写两位数以内！");
				}else if("HTFL-01".equals(contractBasicInfo.getFcType())&&(StringUtil.isEmpty(contractBasicInfo.getfPurchName())||StringUtil.isEmpty(contractBasicInfo.getfPurchNo()))){
					return getJsonResult(false,"请选择采购订单！");
				}else {
					formulationMng.save_CBI(contractBasicInfo, getUser(), files, signInfo, htwbfiles, planJson,mingxi,proceedsJson);
					return getJsonResult(true,Result.saveSuccessMessage);
				}
			}else{
				//暫存不做校验
				formulationMng.save_CBI(contractBasicInfo, getUser(), files, signInfo, htwbfiles, planJson,mingxi,proceedsJson);
				return getJsonResult(true,Result.saveSuccessMessage);
			}
		} catch (ServiceException es) {
			es.printStackTrace();
			return getJsonResult(false,es.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
	
	/**
	 * 删除
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			formulationMng.delete_CBI(id,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 跳转到修改合同页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "edit");
		
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		//合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		String fcAmount = contractBasicInfo.getFcAmount();
		if("".equals(fcAmount)) {
			fcAmount = "0";
		}
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		model.addAttribute("formulationAttaList", attaList);
		
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		/*//签约方信息的附件
		List<Attachment> signattac = attachmentMng.list(signInfo);
		model.addAttribute("filingattac", signattac);*/
		
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), contractBasicInfo.getJoinTable(), contractBasicInfo.getBeanCodeField(), contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同拟定");
		model.addAttribute("cheterInfo", cheterInfo);
		//审批信息
		model.addAttribute("CheckInfoHave", "1");
		//查询四级指标信息
		Integer detailId = contractBasicInfo.getProDetailId();
		Integer indexId = contractBasicInfo.getfBudgetIndexCode();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//可用余额
				contractBasicInfo.setfAvailableAmount(detail.getSyAmount().multiply(BigDecimal.valueOf(10000))+"");
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//可用余额
			contractBasicInfo.setfAvailableAmount(index.getSyAmount()+"");
		}
		return "/WEB-INF/view/contract/formulation/formulation_add";
	}
	
	/**
	 * 跳转到查看合同页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
		String fcAmount = contractBasicInfo.getFcAmount();
		if("".equals(fcAmount)) {
			fcAmount = "0";
		}
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//查询归档信息
		List<Archiving> contOriginal = archivingMng.findByContId(id);
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//归档附件
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//签约方信息
		SignInfo signInfo = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//审批信息
		if(contractBasicInfo.getFcId()!=null){
			model.addAttribute("CheckInfoHave", "1");
		}
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同拟定");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/formulation/formulation_detail";
	}
	
	/**
	 * 弹出选择合同编号页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/fProCode")
	public String fProCodeList(ModelMap model){
		return "/WEB-INF/view/contract/formulation/formulation_add_fProCode";
	}
	
	/**
	 * 加载项目编号的列表信息
	 * @param tProBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/fProCodejsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(TProBasicInfo tProBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = tProBasicInfoMng.fProCode(tProBasicInfo, page, rows);
		
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = formulationMng.getLookupsJson(parentCode, blanked,selected);
		return getComboboxJson(list,selected);
	}
	
	
	/**
	 * 弹出选指标页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/BudgetIndexCode")
	public String BudgetIndexCode(ModelMap model){
		return "/WEB-INF/view/choiceIndex";
	}
	
	/*
	 * 上传附件
	 * 
	 * @author zhangxun
	 * 
	 * @createtime 2018-10-31
	 * 
	 * @updatetime 2018-11-13
	 */
	@RequestMapping("/uploadAtt")
	@ResponseBody
	public Result uploadAtt(
			ModelMap model,
			String serviceType,
			@RequestParam(value = "attFiles", required = false) MultipartFile[] attFiles) {

		try {
			// 保存附件到服务器
			String ids = attachmentMng.uploadAjax(attFiles, serviceType,
					FileUpLoadUtil.getHTGLSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}
	
	/**
	 * 撤回
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-10-08
	 * @updatetime 2018-10-08
	 */
	@ResponseBody
	@RequestMapping("/reCall")
	public Result reCall(String id,ModelMap model){
		try {
			formulationMng.reCall(id);
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
	
	
	/**
	 * 查询采购品目明细
	 * @author 赵孟雷
	 * @createtime 2020-12-11
	 * @updatetime 2020-12-11
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public List<Object> mingxi(String id,String type) {
		List<Object> p = contractPlanListMng.findbyIdAndType("fconId",id,type);
		return p;
	}
	
	/**
	 * 点击采购单通过fpId来判断是取采购申请的采购明细还是采购登记的采购明细
	 * @author 赵孟雷
	 * @createtime 2020-12-18
	 * @updatetime 2020-12-18
	 */
	@RequestMapping(value = "/registerOrApplymingxi")
	@ResponseBody
	public List<Object> registerOrApplymingxi(String id) {
		List<Object> p = formulationMng.registerOrApplymingxi(id);
		return p;
	}
	/**
	 * 点击采购单通过fpId来获取登记时的供应商信息
	 * @author 赵孟雷
	 * @createtime 2020-12-18
	 * @updatetime 2020-12-18
	 */
	@RequestMapping(value = "/registerWinning")
	@ResponseBody
	public WinningBidder registerWinning(String id) {
		WinningBidder p = formulationMng.registerWinning(id);
		return p;
	}
	
	@RequestMapping(value = "/selectGys")
	@ResponseBody
	public WinningBidder selectGys(String id) {
		WinningBidder p = formulationMng.getGys(id);
		return p;
	}
	/**
	 * 查询收款明细
	 * @author 赵孟雷
	 * @createtime 2020-12-11
	 * @updatetime 2020-12-11
	 */
	@RequestMapping(value = "/proceedsmingxi")
	@ResponseBody
	public List<ProceedsPlan> proceedsmingxi(String id,String type) {
		List<ProceedsPlan> p = proceedsPlanMng.finduptandbase(type, Integer.valueOf(id));
		return p;
	}
	
	@RequestMapping("/savebg")
	@ResponseBody
	public Result savebg(ContractBasicInfo contractBasicInfo, String files, SignInfo signInfo, String htwbfiles, String planJson, ModelMap model,String mingxi,String proceedsJson,String openType){
		try {
			if("1".equals(contractBasicInfo.getfFlowStauts())){
				if (null != proceedsJson) {
					ArrayList<String> arrayList = new ArrayList<>();
					List<ProceedsPlan> proceedsPlans = JSON.parseObject(proceedsJson,new TypeReference<List<ProceedsPlan>>(){});
					if (proceedsPlans.size() > 0) {
						for (int i = 0; i < proceedsPlans.size(); i++) {
							if (StringUtils.isEmpty(proceedsPlans.get(i).getfProceedsCondition())) {
								return getJsonResult(false,"请填写收款条件！");
							}else if (StringUtils.isEmpty(proceedsPlans.get(i).getfProceedsTime().toString())) {
								return getJsonResult(false,"请填写预计收款时间！");
							}
							arrayList.add(proceedsPlans.get(i).getfProceedsProperty());
						}
					}
					int a = Collections.frequency(arrayList,"首款");
					int b = Collections.frequency(arrayList,"验收款");
					int c = Collections.frequency(arrayList,"质保款");
					if (a>1) {
						return getJsonResult(false,"首款只能填写一个！");
					}
					if (b>1) {
						return getJsonResult(false,"验收款只能填写一个！");
					}
					if (c>1) {
						return getJsonResult(false,"质保款只能填写一个！");
					}
				}
				if (null != planJson) {
					List<WinningBidder> findBysingName = formulationMng.findBysingName(signInfo.getfSignName());
					Double dealAmount = findBysingName.get(0).getDealAmount();
					Double floatAmount = findBysingName.get(0).getFloatAmount();
					ArrayList<String> array = new ArrayList<>();
					List<DataEntity> list2 =(List<DataEntity>)JSONArray.toList(JSONArray.fromObject(planJson), DataEntity.class);
					//转换成ReceivPlan类型的list
					int mount = 0;
					List<ReceivPlan> receivPlan = filingMng.getReceivPlan(list2, getUser(), contractBasicInfo);
					if (receivPlan.size() > 0) {
						for (int i = 0; i < receivPlan.size(); i++) {
							if (StringUtils.isEmpty(receivPlan.get(i).getfReceCondition())) {
								return getJsonResult(false,"请填写付款条件！");
							}else if (StringUtils.isEmpty(receivPlan.get(i).getfRecePlanTime().toString())) {
								return getJsonResult(false,"请填写预计付款时间！");
							}
							mount += receivPlan.get(i).getfRecePlanAmount().intValue();
							array.add(receivPlan.get(i).getfReceProperty());
						}
					}
					if (mount > dealAmount.intValue() + floatAmount.intValue()) {
						return getJsonResult(false,"预计付款金额大于中标登记金额和允许浮增金额总和！");
					}
					int a = Collections.frequency(array,"首款");
					int b = Collections.frequency(array,"验收款");
					int c = Collections.frequency(array,"质保款");
					if (a>1) {
						return getJsonResult(false,"首款只能填写一个！");
					}
					if (b>1) {
						return getJsonResult(false,"验收款只能填写一个！");
					}
					if (c>1) {
						return getJsonResult(false,"质保款只能填写一个！");
					}
				}
				if(("HTFL-01").equals(contractBasicInfo.getFcType())){//只有采购合同才有付款
					List<ReceivPlan> queryMoney1 = receivPlanMng.findByProperty("fContId_R", contractBasicInfo.getFcId());
					List<ContPay> findByFPlanid = contPayMng.findByFPlanid(queryMoney1.get(0).getfPlanId());
					if (findByFPlanid.size()>0) {
						if (findByFPlanid.get(0).getFlowStauts().equals("1")) {
							return getJsonResult(false, "合同付款时合同不能变更！");
						}
						if (findByFPlanid.get(0).getCashierType().equals("1")) {
							return getJsonResult(false, "已付讫的合同不能再变更！");
						}
					}
				}
				//送审
				if(StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
					return getJsonResult(false,"请填写合同名称！");
				}else if(StringUtil.isEmpty(contractBasicInfo.getFcNum())){
					return getJsonResult(false,"请填写合同份数！");
				}else if(StringUtil.isEmpty(contractBasicInfo.getFcType())){
					return getJsonResult(false,"请选择合同类型！");
				}else if(contractBasicInfo.getFcNum().length()>2){
					return getJsonResult(false,"合同份数请填写两位数以内！");
				}else if("HTFL-01".equals(contractBasicInfo.getFcType())&&(StringUtil.isEmpty(contractBasicInfo.getfPurchName())||StringUtil.isEmpty(contractBasicInfo.getfPurchNo()))){
					return getJsonResult(false,"请选择采购订单！");
				}else {
					formulationMng.save_CBIBG(contractBasicInfo, getUser(), files, signInfo, htwbfiles, planJson,mingxi,proceedsJson,openType);
					return getJsonResult(true,Result.saveSuccessMessage);
				}
			}else{
				//暫存不做校验
				formulationMng.save_CBIBG(contractBasicInfo, getUser(), files, signInfo, htwbfiles, planJson,mingxi,proceedsJson,openType);
				return getJsonResult(true,Result.saveSuccessMessage);
			}
		} catch (ServiceException es) {
			es.printStackTrace();
			return getJsonResult(false,es.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
	
	/*
	 * 采购申请 查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value ="/cgdetail")
	public String Cgdetail(String id,String openType,ModelMap model){
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("cggl",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		List<TNodeData> nodeConfList= new ArrayList<TNodeData>();
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//货物和服务采购，设备安技处采购管理岗可见
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"HWCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HWCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}else{
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"GCCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//是否是合同跳转过来打开的
		model.addAttribute("openType",openType);
		return "/WEB-INF/view/contract/formulation/cggl_detail_ht";
	}
	
	/*
	 * 采购申请 查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value ="/cgdetailsp")
	public String Cgdetailsp(String id,String openType,ModelMap model){
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("cggl",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		List<TNodeData> nodeConfList= new ArrayList<TNodeData>();
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//货物和服务采购，设备安技处采购管理岗可见
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"HWCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HWCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}else{
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"GCCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//是否是合同跳转过来打开的
		model.addAttribute("openType",openType);
		return "/WEB-INF/view/contract/approval/cggl_approval_detail_ht";
	}
	
	@RequestMapping(value = "/detailcg")
	@ResponseBody
	public Double Detailcg(String id) {
		List<WinningBidder> bwlist = cgselMng.findByWid(Integer.valueOf(id));
		Double money = 0.00;
		for (int i = 0; i < bwlist.size(); i++) {
			money +=bwlist.get(i).getDealAmount();
		}
		return money;
	}
}
