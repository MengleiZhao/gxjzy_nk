package com.braker.icontrol.cgmanage.cgreveive.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.Dispute;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 采购验收的controller
 * 本模块用于采购验收的操作
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */
@Controller
@RequestMapping(value = "/cgreceive")
public class CgReceiveController extends BaseController{
				
	@Autowired
	private CgReceiveMng reciveMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private CgBidMng cgbidMng;
	
	@Autowired
	private CgProcessMng processMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private UptMng uptMng;

	@Autowired
	private TProExpendDetailMng detailMng;
	
	@Autowired
	private BudgetIndexMgrMng indexMng;
	
	@Autowired
	private DisputeMng disputeMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private FilingMng filingMng;
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/receive/receive_list";
	}
	
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@RequestMapping(value = "/cgreceivePage")
	@ResponseBody
	public JsonPagination loanPage(AcceptCheck bean, String sign, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = purchaseApplyMng.queryReceiveList(bean, page, rows,getUser());
    	List<AcceptCheck> li = (List<AcceptCheck>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/*
	 * 跳转验收页面
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@RequestMapping(value = "/receive")
	public String receive(String id,ModelMap model) {
		//传回来的id是主键 fpid
		AcceptCheck acptbean = reciveMng.findById(Integer.valueOf(id));
		//查询采购基本信息				
		PurchaseApplyBasic bean = cgsqMng.findById(acptbean.getFpId());
		
		if("0".equals(bean.getfIsContract())&&!"CGLX-01".equals(bean.getFpPype())){
			model.addAttribute("fIsContract", "");
		}else{
			model.addAttribute("fIsContract", "1");
		}
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
		model.addAttribute("bean", bean);
		//查询采购附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询验收的附件信息
		List<Attachment> reciveattac=attachmentMng.list(acptbean);
		model.addAttribute("reciveattac", reciveattac);
		
		//获取当前登录人给前台页面的验收人赋值
		model.addAttribute("receive_people", getUser().getName());
		
		User user = getUser();
		model.addAttribute("acptbean", acptbean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购验收");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(acptbean.getUserId(), "HWCGYS", user.getDpID(), acptbean.getBeanCode(), acptbean.getnCode(), acptbean.getJoinTable(), acptbean.getBeanCodeField(), acptbean.getFacpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGYS", getUser().getDpID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), acptbean.getFacpTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", acptbean.getBeanCode());
		//获取采购申请的审批记录
		//查询工作流
		TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
		model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/receive/receive_main";
		
	}
	
	/*
	 * 进行验收提交操作
	 * @author 冉德茂
	 * @createtime 2018-07-18
	 * @updatetime 2018-07-18
	 */
	@RequestMapping(value = "/receive_submit")
	@ResponseBody
	public Result receiverSubmit(AcceptCheck acptbean,PurchaseApplyBasic bean,String shqdfiles,String ysbgfiles) {
		try {
			reciveMng.saveReceive(acptbean, bean, shqdfiles,ysbgfiles, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 
	 * @Description: 查看验收页面
	 * @author 汪耀
	 * @param @param id
	 * @param @param model
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/detail")
	public String detail(String id,ModelMap model) {
		//传回来的id是主键 fpid
		AcceptCheck acptbean = reciveMng.findById(Integer.valueOf(id));
		//查询采购基本信息				
		PurchaseApplyBasic bean = cgsqMng.findById(acptbean.getFpId());
		if("0".equals(bean.getfIsContract())){
			model.addAttribute("fIsContract", "");
		}else{
			model.addAttribute("fIsContract", "1");
		}
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
		model.addAttribute("bean", bean);
		//查询采购附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询验收的附件信息
		List<Attachment> reciveattac=attachmentMng.list(acptbean);
		model.addAttribute("reciveattac", reciveattac);
		model.addAttribute("acptbean", acptbean);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购验收");
		model.addAttribute("cheterInfo", cheterInfo);
				
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(acptbean.getUserId(), "HWCGYS", acptbean.getfDepartId(), acptbean.getBeanCode(), acptbean.getnCode(), acptbean.getJoinTable(), acptbean.getBeanCodeField(), acptbean.getFacpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGYS", acptbean.getfDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(acptbean.getFacpUsername(), acptbean.getfDepartName(), acptbean.getFacpTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", acptbean.getBeanCode());
		if(bean.getfItems().equals("A20")){
			model.addAttribute("fItems", "A20");
		}else{
			model.addAttribute("fItems", "");
		}
		//获取采购申请的审批记录
		//查询工作流
		//得到工作流id
		TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
		model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/receive/receive_detail";		
	}
	
	/**
	 * 
	 * @Description: 跳转到审批列表页面
	 * @author 汪耀
	 * @param @param model
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/checkList")
	public String checkList( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/check/cgreceive_check_list";
	}

	/**
	 * 验收审批分页数据获得
	 * @author 赵孟雷
	 * @createtime 2020-12-11
	 * @updatetime 2020-12-11
	 */
	@RequestMapping(value = "/cgreceiveCheckPage")
	@ResponseBody
	public JsonPagination cgreceiveCheckPage(PurchaseApplyBasic bean, String sign, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = purchaseApplyMng.queryReceiveCheckList(bean, page, rows,getUser());
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/**
	 * 
	 * @Description: 跳转到审批页面
	 * @author 汪耀
	 * @param @param id
	 * @param @param model
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/check")
	public String check(String id,ModelMap model){
		AcceptCheck acptbean = reciveMng.findById(Integer.valueOf(id));
		//通过fpid查询采购计划信息
		PurchaseApplyBasic bean = purchaseApplyMng.findById(acptbean.getFpId());
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询采购验收的信息
		model.addAttribute("acptbean", acptbean);
		//查询验收的附件信息
		List<Attachment> reciveattac=attachmentMng.list(acptbean);
		model.addAttribute("reciveattac", reciveattac);
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
		
		//查询制度中心文件
		List<CheterInfo> cheterInfoList = cheterMng.getCheterInfoList("采购验收");
		model.addAttribute("cheterInfo", cheterInfoList);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(acptbean.getUserId(), "HWCGYS", acptbean.getfDepartId(), acptbean.getBeanCode(), acptbean.getnCode(), acptbean.getJoinTable(), acptbean.getBeanCodeField(), acptbean.getFacpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
			
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("HWCGYS", acptbean.getfDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(acptbean.getFacpUsername(), acptbean.getfDepartName(), acptbean.getFacpTime());
		model.addAttribute("proposer", proposer);
		
		//对象编码
		model.addAttribute("foCode", acptbean.getBeanCode());
		//获取采购申请的审批记录
		//查询工作流
		//得到工作流id
		TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
		model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/check/check_cgreceive";
	}
	
	/**
	 * 
	 * @Description: 进行审核
	 * @author 汪耀
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param spjlFile
	 * @param @return    
	 * @return Result
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, AcceptCheck acptbean, PurchaseApplyBasic bean, String spjlFile,String zjyjfiles) {
		try {
			reciveMng.saveCheck(checkBean, acptbean, bean, spjlFile, getUser(),zjyjfiles);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	
	/**
	 * 验收撤回
	 * @author 焦广兴
	 * @createtime 2019-10-08
	 * @updatetime 2019-10-08
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			AcceptCheck acptbean = reciveMng.findById(Integer.valueOf(id));
			Boolean tof = tProcessCheckMng.findbyCode(acptbean.getFacpCode(), "0");
			tof = false;
			if(tof){
				return getJsonResult(false,"该申请已经被审批，不得撤回！");
			}else {
				reciveMng.reCall(acptbean.getFacpId());
				return getJsonResult(true, "操作成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
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
		PurchaseApplyBasic purchaseApplyBasic2 = cgsqMng.findById(Integer.valueOf(id));
		List<Object> p = reciveMng.mingxi(purchaseApplyBasic2,type);
		return p;
	}
	
	
	/**
	 * 查看合同信息
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detailContract/{id}")
	public String detail(@PathVariable String id,ModelMap model,String type){
		//合同变更信息
		ContractBasicInfo contractBasicInfo = formulationMng.findAttacByFPurchNo(id);
		
		model.addAttribute("bean", contractBasicInfo);
		//得到工作流id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		Upt upt =new Upt();
		if("1".equals(contractBasicInfo.getfUpdateStatus())){
			upt =uptMng.findByFContId_U(String.valueOf(contractBasicInfo.getFcId())).get(0);
			model.addAttribute("uptShow", "0");
		}else{
			model.addAttribute("uptShow", "");
		}
		model.addAttribute("Upt", upt);
		
		Dispute dispute = new Dispute();
		if("1".equals(contractBasicInfo.getfDisputeStatus())){
			dispute =disputeMng.findByContId(String.valueOf(contractBasicInfo.getFcId())).get(0);
			model.addAttribute("disputeShow", "0");
		}else{
			model.addAttribute("disputeShow", "");
		}
		model.addAttribute("dispute", dispute);
		//合同备案合同正本附件
		if(dispute!=null){
			List<Attachment> disputeattac = attachmentMng.list(dispute);
			model.addAttribute("disputeAttaList", disputeattac);
		}
		//合同备案信息
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//合同备案合同正本附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getFcType().equals("HTFL-03")){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);

		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		String dept[]=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId());
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(),dept[1], contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//根据申请人得到申请部门id
		//得到工作流id
		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", departId);
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		//对象编码
		model.addAttribute("foCodeBG",upt.getBeanCode());
		return "/WEB-INF/view/contract/ledger/ledger_contract";
		
	}
	
	/*
	 * 采购验收删除
	 * @author 赵孟雷
	 * @createtime 2021-02-01
	 * @updatetime 2021-02-01
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//传回来的id是主键
			User user = getUser();
			reciveMng.delete(id,user,fId);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
}
