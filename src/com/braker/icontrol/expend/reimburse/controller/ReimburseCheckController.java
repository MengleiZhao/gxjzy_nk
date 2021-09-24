package com.braker.icontrol.expend.reimburse.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.Dispute;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.ContractReimburseInfo;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 报销审批的控制层
 * @author 叶崇晖
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
@Controller
@RequestMapping(value = "/reimburseCheck")
public class ReimburseCheckController extends BaseController {
	
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private DirectlyReimbPayeeMng directlyReimbPayeeMng;
	
	@Autowired
	private DirectlyReimbAttacMng directlyReimbAttacMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng itfMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private ReimbPayeeMng reimbPayeeMng;
	
	@Autowired
	private ReimbAttacMng reimbAttacMng;
	
	@Autowired
	private ApplicationBasicInfoMng applicationBasicInfoMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private AuditInfoMng auditInfoMng;
	
	@Autowired
	private FilingMng filingMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	@Autowired
	private ContPayMng contPayMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;	//个人收款信息
	
	@Autowired
	private DisputeMng disputeMng;
	
	@Autowired
	private UptMng uptMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;

	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;

	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/reimburse/check/reimburse_check_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@RequestMapping(value = "/reimbursePage")
	@ResponseBody
	public JsonPagination reimbursePage(DirectlyReimbAppliBasicInfo drBean, ReimbAppliBasicInfo rBean, ContPay payBean ,String reimburseType,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = null;
    	//0位直接报销1为申请报销2位合同报销
    	if(reimburseType.equals("0")) {
    		p = directlyReimbMng.checkPageList(drBean, page, rows, getUser());
    		List<DirectlyReimbAppliBasicInfo> li = (List<DirectlyReimbAppliBasicInfo>) p.getList();
    		for(int x=0; x<li.size(); x++) {
    			//序号设置	
    			li.get(x).setNum((x+1)+(page-1)*rows);
    			//设置申请人姓名（id查姓名）,申请人所属部门
    			User user = userMng.findById(li.get(x).getUser());
    			li.get(x).setUserName(user.getName());
    		}
    	} else if(reimburseType.equals("1")){
    		p = reimbAppliMng.checkPageList(rBean, page, rows, getUser());
    		List<ReimbAppliBasicInfo> li = (List<ReimbAppliBasicInfo>) p.getList();
    		for(int x=0; x<li.size(); x++) {
    			//序号设置	
    			li.get(x).setNum((x+1)+(page-1)*rows);	
    			//设置申请人姓名（id查姓名）,申请人所属部门
    			User user = userMng.findById(li.get(x).getUser());
    			li.get(x).setUserName(user.getName());
    		}
    	} else if(reimburseType.equals("2")){
    		p = contPayMng.contractCheckPageList(payBean, page, rows, getUser(), "0");//0为checkType(0位合同审批，1位财务审定)
    		List<ContractReimburseInfo> li = (List<ContractReimburseInfo>) p.getList();
    		for(int x=0; x<li.size(); x++) {
    			//序号设置	
    			li.get(x).setNum((x+1)+(page-1)*rows);	
    		}
    	}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 跳转审批页面
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@RequestMapping(value = "/check")
	public String check(Integer id , String reimburseType, ModelMap model, Integer fPlanId, Integer payId) {
		try {
			//reimburseType 0为直接报销 1位申请报销 2位合同报销
			if(reimburseType.equals("0")){
				//传回来的id是主键
				DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(id);
				//获得申请人信息
				User user = userMng.findById(bean.getUser());
				bean.setUserName(user.getName());
				bean.setDeptName(user.getDepartName());
				
				model.addAttribute("bean", bean);
				
				List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getDrId(),"directly-1");
				model.addAttribute("Invoicelist", list1);//发票
				
				model.addAttribute("xzbgsFile", "xzbgsFile");
				model.addAttribute("dwhFile", "dwhFile");
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
						//预算年度
						if (index.getAppDate() != null) {
							bean.setPfDate(index.getYears());				
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
					//预算年度
					if (index.getAppDate() != null) {
						bean.setPfDate(index.getYears());				
					}
					//使用部门
					bean.setPfDepartName(index.getDeptName());			
					//可用余额
					bean.setSyAmount(index.getSyAmount());			
				}
				
				//查询附件信息
				List<Attachment> attaList = attachmentMng.list(bean);
				model.addAttribute("attaList", attaList);

				TProcessDefin tProcessDefin;
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(user.getName(), user.getDepartName(), bean.getReqTime());
				model.addAttribute("proposer", proposer);
				//得到工作流id
				if (("0").equals(bean.getIsconvention())) {
					 tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("BXTYLC", bean.getDept());
				}else {
					 tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", bean.getDept());
				}
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编号
				model.addAttribute("foCode",bean.getBeanCode());
				//查询制度中心文件
				List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("直接报销");
				model.addAttribute("cheterInfo", cheterInfo);
				//当前用户
				model.addAttribute("currentUser",getUser());
				
				model.addAttribute("detail", "1");
				
				//查询费用明细
				List<CostDetailInfo> cost =reimbAppliMng.findByDrId(bean.getDrId());
				Integer x=0;
				Integer y=0;
				for(int i = 0;i <cost.size();i++){
					y=y+1;
					List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
					for(int j = 0;j <fp.size();j++){
						x=x+1;
						fp.get(j).setNum(x);
					}
					cost.get(i).setCouponList(fp);
					cost.get(i).setNum(y);
				}
				Integer index =cost.size();
				model.addAttribute("x", x);
				model.addAttribute("y", y);
				model.addAttribute("index", index);
				model.addAttribute("cost", cost);
				
				//查询工作流
//				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(), bean.getDrCode(),"1");
				TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
				TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
				List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),bean.getBeanCodeField(), bean.getDrCode(),"1",bean.getIndexId());
				}else {
					if (("0").equals(bean.getIsconvention())) {
						nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"BXTYLC", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1");

					}else {
						nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJBX", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getDrCode(),"1");
					}
				}
				if("0".equals(bean.getIfDeptIndex())){
					for (int i = 0; i < nodeConfList.size(); i++) {
						if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
							if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
								TProBasicInfo basicInfo = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
								User user2 = userMng.findById(basicInfo.getFProHeadId());
								nodeConfList.get(i).setText(user2.getName());
								nodeConfList.get(i).setUserId(user2.getId());
								nodeConfList.get(i).setUser(user2);
							}
						}
					}
				}
				model.addAttribute("nodeConf", nodeConfList);
				
				return "/WEB-INF/view/expend/reimburse/check/directly_reimburse_check";
			} else if(reimburseType.equals("1")) {
				ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
				String rtype = bean.getType();
				String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(bean.getType()));
				if("GWCX".equals(bean.getTravelType())){
					strType = "CXBX";
				}
				if(bean.getType().equals("5")){
					ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
					if("2".equals(receptionBeans.getReceptionLevel1())){
						if(receptionBeans.getIsForeign().equals("1")){
							strType = "GWJDBX-WB";
						}else{
							strType = "GWJDBX-YJYX";
						}
					}
				}
				//获得申请人信息
				User user = userMng.findById(bean.getUser());
				
				bean.setUserName(user.getName());
				bean.setDeptName(user.getDepartName());
				bean.setReqTime(bean.getReimburseReqTime());
				model.addAttribute("bean", bean);
				
				//查询四级指标信息
				ApplicationBasicInfo apply = applyMng.findByCode(bean.getgCode());
				model.addAttribute("applyBean", apply);
				if(!"8".equals(bean.getType()) && !"4".equals(bean.getType())){
					if (apply != null) {
						Integer detailId = apply.getProDetailId();
						Integer indexId = bean.getIndexId();
						if (detailId != null && indexId != null) {
							TProExpendDetail detail = detailMng.findById(detailId);
							TBudgetIndexMgr index = indexMng.findById(indexId);
							if (detail != null && index != null) {
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
						}
					}
				}
				if("4".equals(bean.getType())){
					Integer detailId = bean.getProDetailId();
					Integer indexId = bean.getIndexId();
					if (detailId != null && indexId != null) {
						TProExpendDetail detail = detailMng.findById(detailId);
						TBudgetIndexMgr index = indexMng.findById(indexId);
						if (detail != null && index != null) {
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
					}
				
				}
				if(!"WLKBX".equals(strType)){
					//查询附件信息
					List<Attachment> attaList = attachmentMng.list(apply);
					model.addAttribute("attaList", attaList);
				}
				List<Attachment> attaList1 = attachmentMng.list(bean);
				model.addAttribute("attaList1", attaList1);
				/*if(!"1".equals(bean.getType())){*/
				List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
				
				if(!"4".equals(bean.getType())){
					TBudgetIndexMgr budgetIndexMgr = new TBudgetIndexMgr();
					TProBasicInfo pro = new TProBasicInfo();
					if(!"WLKBX".equals(strType)){
						budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
						pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
					}
					if(null==pro.getFProOrBasic()||0==pro.getFProOrBasic()){
						nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType, bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getrCode(),"1");
					}else if(1==pro.getFProOrBasic()){
						nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),strType, bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getrCode(),"1",bean.getIndexId());
					}
				}
					
					
					/*
					BudgetMessageList budgetMessageList = new BudgetMessageList();
					budgetMessageList.setrId(bean.getrId());
					//查询接待明细
					List<BudgetMessageList> budgetMessageLists = applyMng.getBudgetMessageList(budgetMessageList,getUser());
					for (BudgetMessageList messageList : budgetMessageLists) {
						if(!"".equals(messageList.getfCostClassifyShow())){
							if("1".equals(budgetMessageList.getfIndexType())){
								budgetMessageList = messageList;
								break;
							}else{
								if(StringUtil.isEmpty(messageList.getfCostClassifyShow())){
									continue;
								}
								budgetMessageList = messageList;
							}
						}
					}

					TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(budgetMessageList.getfIndexId());
					TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
					if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
						nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1",budgetMessageList.getfIndexId());
					}else {
						nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
					}
					if("CXSQ".equals(strType)&&user.getRoleName().contains("普通用户")&&!user.getRoleName().contains("部门负责人")){
						for (int i = nodeConfList.size()-1; i >= 0; i--) {
							if(nodeConfList.get(i).getUserId().equals(user.getDepart().getManager().getId())){
								nodeConfList.remove(i);
							}
						}
					}
				*/
				if("4".equals(bean.getType())){
					nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");

				}
				//查询工作流
				model.addAttribute("nodeConf", nodeConfList);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
				model.addAttribute("fpId", tProcessDefin.getFPId());
				/*}*/
				//对象编号
				model.addAttribute("foCode",bean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
				model.addAttribute("proposer", proposer);
				//查询制度中心文件
				List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("直接报销");
				model.addAttribute("cheterInfo", cheterInfo);
				
				if(!"WLKBX".equals(strType)){
					//查询相应的申请基本信息
					String type = apply.getType();
					if("8".equals(bean.getType())){
						type="8";
					}
					//以下几行是获取事前申请的工作流
					String strTypeApply = tProcessCheckMng.JudgmentProcess(String.valueOf(type));
					if("GWCX".equals(apply.getTravelType())){
						strTypeApply = "CXSQ";
					}
					/*if(type.equals("5")){
						ReceptionAppliInfo	receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", apply.getgId());
						if(receptionBean.getReceptionLevel1().equals("2")){
							if(receptionBean.getIsForeign().equals("1")){
								strTypeApply = "GWJDSQ-WB";
							}else{
								strTypeApply = "GWJDSQ-YJYX";
							}
						}
					}*/
					//得到工作流id
					TProcessDefin tProcessDefinApply=tProcessDefinMng.getByBusiAndDpcode(strTypeApply, bean.getDept());
					model.addAttribute("fpIdAplly", tProcessDefinApply.getFPId());
				}
				//对象编号
				model.addAttribute("foCodeAplly",bean.getBeanCode());
				//查询费用明细
				List<CostDetailInfo> cost = reimbAppliMng.findByRId(bean.getrId());
				//判断申请类型
				if(rtype.equals("1")){

					Integer x=0;
					for(int i = 0;i <cost.size();i++){
						List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
						for(int j = 0;j <fp.size();j++){
							x=x+1;
							fp.get(j).setNum(x);
						}
						cost.get(i).setCouponList(fp);
						cost.get(i).setNum(x);
					}
					Integer index =cost.size();
					model.addAttribute("x", x);
					model.addAttribute("index", index);
					model.addAttribute("cost", cost);
					List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"comm-1");
					model.addAttribute("Invoicelist", list);//通用事项发票
				} else if(rtype.equals("2")) {
					//查询会议信息
					MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", apply.getgId());
					model.addAttribute("meetingBean", meetingBean);
					MeetingAppliInfo reimbMeetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "rId", bean.getrId());
					model.addAttribute("reimbMeetingBean", reimbMeetingBean);
					List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"meeting");
					model.addAttribute("Invoicelist", list);//会议发票
				} else if(rtype.equals("3")) {
					//查询培训信息
					TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", apply.getgId());
					model.addAttribute("trainingBean", trainingBean);
					//查询培训信息
					TrainingAppliInfo reimbTrainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", bean.getrId());
					model.addAttribute("reimbTrainingBean", reimbTrainingBean);
					//综合预算发票
					List<InvoiceCouponInfo> Invoicelist1 = invoiceCouponMng.findByrID(bean.getrId(),"trainzonghe");
					model.addAttribute("Invoicelist1", Invoicelist1);
					//住宿费发票
					List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
					model.addAttribute("Invoicelist2", Invoicelist2);
					//餐费发票
					List<InvoiceCouponInfo> Invoicelist3= invoiceCouponMng.findByrID(bean.getrId(),"receptionfood");
					model.addAttribute("Invoicelist3", Invoicelist3);
					//城市间交通费发票
					List<InvoiceCouponInfo> Invoicelist4 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
					model.addAttribute("Invoicelist4", Invoicelist4);									
					//市内交通费发票
					List<InvoiceCouponInfo> Invoicelist5 = invoiceCouponMng.findByrID(bean.getrId(),"travelincity");
					model.addAttribute("Invoicelist5", Invoicelist5);		
				} else if(rtype.equals("4")) {
					//查询差旅信息
					TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", apply.getgId());
					model.addAttribute("travelBean", travelBean);
					List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
					model.addAttribute("Invoicelist1", list1);//市内交通费
					List<InvoiceCouponInfo> list2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
					model.addAttribute("Invoicelist2", list2);//住宿费
					List<InvoiceCouponInfo> list3 = invoiceCouponMng.findByrID(bean.getrId(),"meetTrain");
					model.addAttribute("Invoicelist3", list3);//会务费、培训费
					/*for(int i = 0;i <cost.size();i++){
						if("住宿费".equals(cost.get(i).getCostName())){
							List<InvoiceCouponInfo> fp1=reimbAppliMng.findfp(cost.get(i).getcId());
							model.addAttribute("fp1", fp1);
							Integer a =fp1.size();
							model.addAttribute("a", a);
						}if("伙食费".equals(cost.get(i).getCostName())){
							List<InvoiceCouponInfo> fp2=reimbAppliMng.findfp(cost.get(i).getcId());
							model.addAttribute("fp2", fp2);
							Integer b =fp2.size();
							model.addAttribute("b",b);
						}if("长途交通费".equals(cost.get(i).getCostName())){
							List<InvoiceCouponInfo> fp3=reimbAppliMng.findfp(cost.get(i).getcId());
							model.addAttribute("fp3", fp3);
							Integer c =fp3.size();
							model.addAttribute("c", c);
						}if("室内交通费".equals(cost.get(i).getCostName())){
							List<InvoiceCouponInfo> fp4=reimbAppliMng.findfp(cost.get(i).getcId());
							model.addAttribute("fp4", fp4);
							Integer d =fp4.size();
							model.addAttribute("d", d);
						}if("其他费用".equals(cost.get(i).getCostName())){
							List<InvoiceCouponInfo> fp5=reimbAppliMng.findfp(cost.get(i).getcId());
							model.addAttribute("fp5", fp5);
							Integer f =fp5.size();
							model.addAttribute("f", f);
						}
					}*/
				} else if(rtype.equals("5")) {
					//查询接待信息
					ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", apply.getgId());
					model.addAttribute("receptionBean", receptionBean);
					
					ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
					model.addAttribute("receptionBeanEdit", receptionBeans);
					//住宿费
					List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
					model.addAttribute("Invoicelist2", Invoicelist2);
					//餐费
					List<InvoiceCouponInfo> InvoicelistFood= invoiceCouponMng.findByrID(bean.getrId(),"receptionfood");
					model.addAttribute("InvoicelistFood", InvoicelistFood);
					//交通费
					List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"hotel");
					model.addAttribute("Invoicelist1", list1);									
					//会议室租金费用
					List<InvoiceCouponInfo> costRent= invoiceCouponMng.findByrID(bean.getrId(),"costRent");
					model.addAttribute("costRentList", costRent);
					//其他费用
					List<InvoiceCouponInfo> InvoicelistOther= invoiceCouponMng.findByrID(bean.getrId(),"receptionother");
					model.addAttribute("InvoicelistOther", InvoicelistOther);
				} else if(rtype.equals("6")) {
					//查询公务用车信息
					OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", apply.getgId());
					model.addAttribute("officeCar", officeBean);
					/*Integer x=0;
					for(int i = 0;i <cost.size();i++){
						List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
						for(int j = 0;j <fp.size();j++){
							x=x+1;
							fp.get(j).setNum(x);
						}
						cost.get(i).setCouponList(fp);
						cost.get(i).setNum(x);
					}
					Integer index =cost.size();
					model.addAttribute("x", x);
					model.addAttribute("index", index);
					model.addAttribute("cost", cost);*/
					
					List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"car");
					model.addAttribute("Invoicelist1", list1);//市内交通费
				} else if(rtype.equals("7")) {
					//查询公务出国信息
					AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", apply.getgId());
					model.addAttribute("abroad", abroadBean);
					//查询公务出国信息
					AbroadAppliInfo abroadEdit = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId", bean.getrId());
					model.addAttribute("abroadEdit", abroadEdit);
					//国际旅费发票
					List<InvoiceCouponInfo> Invoicelist1 = invoiceCouponMng.findByrID(bean.getrId(),"mix");
					model.addAttribute("Invoicelist1", Invoicelist1);
					//国外城市间交通费发票
					List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
					model.addAttribute("Invoicelist2", Invoicelist2);
					//住宿费发票
					List<InvoiceCouponInfo> Invoicelist3= invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
					model.addAttribute("Invoicelist3", Invoicelist3);
					//宴请费发票
					List<InvoiceCouponInfo> Invoicelist4 = invoiceCouponMng.findByrID(bean.getrId(),"travelfete");
					model.addAttribute("Invoicelist4", Invoicelist4);									
					//其他费用发票
					List<InvoiceCouponInfo> Invoicelist5 = invoiceCouponMng.findByrID(bean.getrId(),"travelother");
					model.addAttribute("Invoicelist5", Invoicelist5);
				}else if(rtype.equals("8")) {
					
					//获取报销人信息
					model.addAttribute("operation", "edit");
					model.addAttribute("openType", "detail");
					//查询费用明细
					List<CostDetailInfo> cost1 =reimbAppliMng.findByRId(bean.getrId());
					Integer x=0;
					for(int i = 0;i <cost1.size();i++){
						List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost1.get(i).getcId());
						for(int j = 0;j <fp.size();j++){
							x=x+1;
							fp.get(j).setNum(x);
						}
						cost1.get(i).setCouponList(fp);
						cost1.get(i).setNum(x);
					}
					Integer index =cost1.size();
					model.addAttribute("x", x);
					model.addAttribute("index", index);
					model.addAttribute("cost", cost1);
					model.addAttribute("userid", getUser().getId());
					List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"contract-1");
					model.addAttribute("Invoicelist", list);//发票
					//查询附件信息
					List<Attachment> attaList2 = attachmentMng.list(bean);
					model.addAttribute("attaList1", attaList2);
				}else if(rtype.equals("9")){

					Integer x=0;
					for(int i = 0;i <cost.size();i++){
						List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
						for(int j = 0;j <fp.size();j++){
							x=x+1;
							fp.get(j).setNum(x);
						}
						cost.get(i).setCouponList(fp);
						cost.get(i).setNum(x);
					}
					Integer index =cost.size();
					model.addAttribute("x", x);
					model.addAttribute("index", index);
					model.addAttribute("cost", cost);
					List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"comm-1");
					model.addAttribute("Invoicelist", list);//通用事项发票
				}  else if(rtype.equals("12")) {
					//查询差旅信息
					TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", apply.getgId());
					model.addAttribute("travelBean", travelBean);
					TravelAppliInfo reimTravelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "rId", bean.getrId());
					model.addAttribute("reimTravelBean", reimTravelBean);
					List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"outsideAttend");
					model.addAttribute("Invoicelist1", list1);//市内交通费
					List<InvoiceCouponInfo> list2 = invoiceCouponMng.findByrID(bean.getrId(),"hotelAttend");
					model.addAttribute("Invoicelist2", list2);//住宿费
				}
				
				model.addAttribute("detail", "1");
				model.addAttribute("detail2", "1");
				//当前用户
				model.addAttribute("currentUser",getUser());
				if(rtype.equals("2")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_meeting";
				}else if(rtype.equals("3")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_train";
				}else if(rtype.equals("4")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_travel";
				}else if(rtype.equals("5")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_reception";
				}else if(rtype.equals("6")){
					model.addAttribute("type", "check");
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_car";
				}else if(rtype.equals("7")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_abroad";
				}else if(rtype.equals("8")){
					return "/WEB-INF/view/expend/reimburse/check/contract_reimburse_check";
				}else if(rtype.equals("9")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_current";
				}else if(rtype.equals("12")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_attend_train";
				}else if(rtype.equals("13")){
					return "/WEB-INF/view/expend/reimburse/check/reimburse_check_travel_city";
				}else 
					model.addAttribute("type", "check");
				return "/WEB-INF/view/expend/reimburse/check/reimburse_check";
			} else if(reimburseType.equals("2")) {
				ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
				User user = userMng.findById(contractBasicInfo.getfOperatorId());	//获得合同申请人信息
				model.addAttribute("findById", contractBasicInfo);
				
				//得到工作流id
				TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
				model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
				//对象编码
				model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
				
				model.addAttribute("openType", "edit");
				/*if(contractBasicInfo.getfUpdateStatus().equals("1")){
					Upt upt=uptMng.findByFContId_U(id.toString()).get(0);
					//合同变更附件
					List<Attachment> uptAttaList = attachmentMng.list(upt);
					model.addAttribute("changeAttaList", uptAttaList);
					model.addAttribute("Upt", upt);

					TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
					model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
					//对象编码
					model.addAttribute("foCodeBG",upt.getBeanCode());
					
					//变更合同归档信息
					List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
					if(uptContId!=null&&uptContId.size()>0){
						Archiving archivingUpt = uptContId.get(0);
						//归档附件
						List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
						model.addAttribute("archivingAttaListUpt", attaListgdUpt);
						model.addAttribute("archivingUpt", archivingUpt);
					}
				}*/
				//查询归档信息
				List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(id));
				if(contOriginal!=null&&contOriginal.size()>0){
					Archiving archivingOriginal = contOriginal.get(0);
					//归档附件
					List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
					model.addAttribute("archivingAttaListOriginal", attaListOriginal);
					model.addAttribute("archivingOriginal", archivingOriginal);
				}
				
				//根据申请人得到申请部门id
				String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
				SignInfo sign=new SignInfo();
				List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
				if(signInfoList!=null&&signInfoList.size()>0){
					sign = signInfoList.get(0);
					model.addAttribute("signInfo", sign);
				}
				//计划付款阶段信息
				ReceivPlan payBean = receivPlanMng.findById(fPlanId);
				model.addAttribute("payBean", payBean);
				//查询付款申请信息
				ContPay contPay=new ContPay();
				contPay = contPayMng.findById(payBean.getPayId());
				model.addAttribute("contBean", contPay);
				ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
				model.addAttribute("payee", payee);
				//合同付款申請附件
				List<Attachment> contPayattaList = attachmentMng.list(contPay);
				model.addAttribute("attaList", contPayattaList);
				Integer x=0;
				//查询费用明细
				List<CostDetailInfo> cost =new ArrayList<CostDetailInfo>();
				for(int i = 0;i <cost.size();i++){
					List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
					for(int j = 0;j <fp.size();j++){
						x=x+1;
						fp.get(j).setNum(x);
					}
					cost.get(i).setCouponList(fp);
					cost.get(i).setNum(x);
				}
				Integer index =cost.size();
				model.addAttribute("x", x);
				model.addAttribute("index", index);
				model.addAttribute("cost", cost);
				model.addAttribute("userid", getUser().getId());
				List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(contPay.getPayId(),"contract");
				model.addAttribute("Invoicelist", list);//通用事项发票
				PurchaseApplyBasic cgsq = cgsqMng.findById(Integer.valueOf(contractBasicInfo.getfPurchNo()));
				TProBasicInfo pro = projectMng.findById(cgsq.getIndexId());
				String type = null;
				if (("JIJIAN").equals(pro.getProUseType())) {
					type = "HTFKSQJJ";
				}else if (("WEIXIU").equals(pro.getProUseType())){
					type = "HTFKSQ";
				}else {
					type = "HYBX";
				}
				if(!StringUtil.isEmpty(contPay.getDepateID())){
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),type, contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
					model.addAttribute("nodeConf", nodeConfList);
				}else{
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),type, departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
					model.addAttribute("nodeConf", nodeConfList);
				}

				Proposer proposer =null;
				if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
					//建立工作流发起人的信息
					proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
				}else {
					proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
				}
				model.addAttribute("proposer", proposer);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, departId);
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",contPay.getBeanCode());

				return "/WEB-INF/view/expend/reimburse/check/contract_reimburse_check";
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/*
	 * 直接报销和申请报销审批结果
	 * @author 叶崇晖
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,DirectlyReimbAppliBasicInfo drBean, ReimbAppliBasicInfo rBean,String spjlFile) {
		try {
			//List<Role> roleli = userMng.getUserRole(getUser().getId());
			//直接报销
			if(drBean.getDrId() != null) {
				checkBean.setFProID(drBean.getProId());
				directlyReimbMng.check(checkBean, drBean, getUser(), spjlFile);
				//drBean = directlyReimbMng.findById(drBean.getDrId());
			}
			//申请报销
			if(rBean.getrId() != null) {
				/*if("1".equals(rBean.getType())){
					//通用事项事前申请
					reimbAppliMng.saveCheckInfoTYSXBX(checkBean, rBean, getUser(), spjlFile);
				}else{*/
					reimbAppliMng.saveCheckInfo(checkBean, rBean, getUser(), spjlFile);
				/*}*/
				//rBean = reimbAppliMng.findById(rBean.getrId());
			}
			//reimbCheckInfoMng.saveCheckInfo(checkBean, drBean, rBean, getUser(), roleli.get(0));
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/*
	 * 合同报销审批结果
	 * @author 叶崇晖
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	@RequestMapping(value = "/contractCheckResult")
	@ResponseBody
	public Result contractCheckResult(TProcessCheck checkBean,ContPay bean, ReceivPlan receivPlanBean, Integer payId,String spjlFile) {
		try {
			//TODO保存审批记录
			bean= contPayMng.findById(payId);//合同付款基本信息
			receivPlanBean = receivPlanMng.findById(receivPlanBean.getfPlanId());//合同付款计划
			contPayMng.saveContractCheckInfo(checkBean, bean, receivPlanBean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * <p>Title: checkCurrent</p>  
	 * <p>Description: 往来款报销</p>  
	 * @param id
	 * @param reimburseType
	 * @param model
	 * @param fPlanId
	 * @param payId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月12日
	 * @updator 陈睿超
	 * @updatetime 2020年11月12日
	 */
	@RequestMapping(value = "/checkCurrent")
	public String checkCurrent(Integer id , String reimburseType, ModelMap model, Integer fPlanId, Integer payId) {
		try {
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			String rtype = bean.getType();
			String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(bean.getType()));

			//获得申请人信息
			User user = userMng.findById(bean.getUser());
			
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			model.addAttribute("bean", bean);
			
			//查询附件信息
			List<Attachment> attaList1 = attachmentMng.list(bean);
			model.addAttribute("attaList1", attaList1);
			/*if(!"1".equals(bean.getType())){*/
			
			List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType, bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getrCode(),"1");
			//查询工作流
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			/*}*/
			//对象编号
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("直接报销");
			model.addAttribute("cheterInfo", cheterInfo);
			
			//对象编号
			model.addAttribute("foCodeAplly",bean.getBeanCode());
			//查询费用明细
			List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
			//判断申请类型

			Integer x=0;
			for(int i = 0;i <cost.size();i++){
				List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
				for(int j = 0;j <fp.size();j++){
					x=x+1;
					fp.get(j).setNum(x);
				}
				cost.get(i).setCouponList(fp);
				cost.get(i).setNum(x);
			}
			Integer index =cost.size();
			model.addAttribute("x", x);
			model.addAttribute("index", index);
			model.addAttribute("cost", cost);
			List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"comm-1");
			model.addAttribute("Invoicelist", list);//通用事项发票
			
			model.addAttribute("detail", "1");
			model.addAttribute("detail2", "1");
			//当前用户
			model.addAttribute("currentUser",getUser());
			model.addAttribute("type", "check");
			return "/WEB-INF/view/expend/reimburse/check/reimburse_check_current";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	/*
	 * 采购报销 查看和修改
	 * @author 沈帆
	 * @createtime 2020-12-16
	 * @updatetime 2020-12-16
	 */
	@RequestMapping(value = "/checkPurchase")
	public String addReimb(String id,ModelMap model){
		//查询基本信息
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		PurchaseApplyBasic purchase = cgsqMng.findById(bean.getPurchaseId());
		//查询申请人信息
		User user = userMng.findById(purchase.getfUser());
		purchase.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = purchase.getProDetailId();
		Integer indexId = purchase.getIndexId();
		bean.setIndexId(indexId);
		bean.setProDetailId(detailId);
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
		model.addAttribute("purchase",purchase);
		model.addAttribute("bean",bean);
		//查询收款人信息
		ReimbPayeeInfo payee =reimbPayeeMng.getByRId(bean.getrId()).get(0);
		model.addAttribute("payee",payee);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(purchase);
		model.addAttribute("attac", attac);
		List<Attachment> attaList =attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"CGBX",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGBX", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
		Integer x=0;
		//查询费用明细
		List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
		for(int i = 0;i <cost.size();i++){
			List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
			for(int j = 0;j <fp.size();j++){
				x=x+1;
				fp.get(j).setNum(x);
			}
			cost.get(i).setCouponList(fp);
			cost.get(i).setNum(x);
		}
		Integer index =cost.size();
		model.addAttribute("x", x);
		model.addAttribute("index", index);
		model.addAttribute("cost", cost);
		model.addAttribute("userid", getUser().getId());
		List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"purchase");
		model.addAttribute("Invoicelist", list);//通用事项发票
		return "/WEB-INF/view/purchase_manage/purchase/cgReimb_check";
	}
}
