package com.braker.core.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.util.LookupsUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.core.model.Vehicle;
import com.braker.icontrol.assets.handle.manager.HandleMng;
import com.braker.icontrol.assets.handle.model.AssetRegistration;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.rece.manager.ReceListMng;
import com.braker.icontrol.assets.rece.manager.ReceMng;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.RegistMng;
import com.braker.icontrol.assets.storage.manager.StorageMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.adjust.manager.InsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexAdItfMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.PerformanceIndicatorModelMng;
import com.braker.icontrol.budget.project.manager.TProBasicFundsMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.manager.FeteCostInfoMng;
import com.braker.icontrol.expend.apply.manager.FoodAllowanceInfoMng;
import com.braker.icontrol.expend.apply.manager.HotelExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.InCityTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.InternationalTravelingExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.MeetingMng;
import com.braker.icontrol.expend.apply.manager.OutsideTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.TrainingMng;
import com.braker.icontrol.expend.apply.manager.TravelAppliInfoMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OutsideTrafficInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainTeacherCost;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbDetailMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.purchase.apply.manager.PurchaseItemsMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.icontrol.purchase.apply.model.PurchaseItemsDetail;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
import com.fasterxml.jackson.databind.util.BeanUtil;


/**
 * APP查看详情
 * 作用：接受APP后台发送的审批请求
 * 实现方式：请求转发
 * 返回请求端值的类型：由转发后方法定义
 * @author 张迅
 * @createtime 2020-04-23
 */

@Controller
@RequestMapping(value = "/appDetail")
public class AppDetailController extends BaseController{
	
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private CgConPlanMng confplanMng;
	@Autowired
	private CgProcessMng cgProcessMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private CgReceiveMng cgReceiveMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private TProBasicFundsMng tProBasicFundsMng;
	@Autowired
	private PerformanceIndicatorModelMng performancModelMng;
	@Autowired
	private TProBasicInfoMng proMng;
	@Autowired
	private InsideAdjustMny insideAdjustMng;
	@Autowired
	TIndexAdItfMng adItfMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private SignInfoMng signInfoMng;
	@Autowired
	private StorageMng storageMng;
	@Autowired
	private RegistMng registMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private PurchaseItemsMng purchaseItemsMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private CgReceiveMng reciveMng;
	@Autowired
	private CgProcessMng processMng;	
	@Autowired
	private CgSelMng cgselMng;
	@Autowired
	private UptMng uptMng;	
	@Autowired
	private CgConPlanListMng cgConPlanListMng;	
	@Autowired
	private ContractPlanListMng contractPlanListMng;
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	
		//项目审批
		@RequestMapping("/project")
		@ResponseBody
		public Object project(String pid){
			Map<String,Object> map = new LinkedHashMap<>();
			
			TProBasicInfo project = projectMng.findById(Integer.valueOf(pid));
			List<TProExpendDetail> expDetailList = tProExpendDetailMng.getByProId(Integer.valueOf(pid));
			//List<TProGoal> goalList = tProGoalMng.getTProGoalByPro(pid);
			List<PerformanceIndicatorModel> goalList = performancModelMng.findByProperty("fProId", Integer.valueOf(pid));
			List<TProBasicFunds> fundsList = tProBasicFundsMng.findByProperty("FProId", Integer.valueOf(pid));
			
			map.put("project", project);
			map.put("expDetailList", expDetailList);
			map.put("goalList", goalList);
			map.put("fundsList", fundsList);
			/*if (project != null) {
				if(project.getFProOrBasic()==0){
				List<TProcessCheck> logList = checkHistoryMng.findCheckHistorys("JBZCSB",project.getBeanCode(),null);//审批记录
				map.put("logList", logList);
				}else{
					List<TProcessCheck> logList = checkHistoryMng.findCheckHistorys("XMSB",project.getBeanCode(),null);//审批记录
					map.put("logList", logList);
				}
			}*/
			
			//工作流字段 
			String userId = project.getUserId();
//			map.put("f_userId", userId);//操作人主键
//			map.put("f_departId", project.getFProAppliDepartId());//发起人部门主键
			String ywfw ="";
			if(project.getFProOrBasic()==0){
				//map.put("f_area", "JBZCSB");//操作人业务范围
				ywfw="JBZCSB";
			}else if(project.getFProOrBasic()==1){
				//map.put("f_area", "XMSB");//操作人业务范围
				ywfw="XMSB";
			}else if(project.getFProOrBasic()==2){
				//map.put("f_area", "XMSB");//操作人业务范围
				ywfw="ZXMSB";
			}
			/*if (!StringUtil.isEmpty(userId)) {//首个审批人姓名
				User user = userMng.findById(userId);
				map.put("f_userName", user.getName());
			}*/
			User user = userMng.findById(userId);
			/*map.put("f_foCode", project.getBeanCode());//表单编码
			map.put("f_nCode", project.getFExt11());//下一节点编码
			map.put("f_joinTable", "t_pro_basic_info");//数据库表
			map.put("f_beanCodeField", project.getBeanCodeField());//编码字段
			map.put("f_beanCode", project.getFProCode());//表单编码
*/			//查询工作流节点
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, ywfw, project.getFProAppliDepartId(),project.getBeanCode(),project.getFExt11(), "t_pro_basic_info", project.getBeanCodeField(), project.getFProCode(),"1");
			TNodeData node =new TNodeData();
			node.setUser(user);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(project.getFProAppliTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			//User user = userMng.findById(userId);
			map.put("流程发起人", user.getName());
			//map.put("发起人部门", user.getDepartName());
			map.put("发起时间", project.getFProAppliTime());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(project.getFFlowStauts().equals("-11")){
				map.put("当前流程节点人", user.getName());
				map.put("当前流程节点数", 1);
			}else if(project.getFFlowStauts().equals("19")||Math.abs(Integer.valueOf(project.getFFlowStauts()))>20){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(project.getNextCheckKey())){
						map.put("当前流程节点人", project.getNextAssignerName());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(project);
			map.put("attaList", attaList);
			return map;
		}
		
		//二上审批
		@RequestMapping("/esproject")
		@ResponseBody
		public Object esproject(String pid){
			Map<String,Object> map = new HashMap<>();
			TProBasicInfo project = projectMng.findById(Integer.valueOf(pid));
			List<TProExpendDetail> expDetailList = tProExpendDetailMng.getByProId(Integer.valueOf(pid));
			//List<TProGoal> goalList = tProGoalMng.getTProGoalByPro(pid);
			List<PerformanceIndicatorModel> goalList = performancModelMng.findByProperty("fProId", Integer.valueOf(pid));
			List<TProBasicFunds> fundsList = tProBasicFundsMng.findByProperty("FProId", Integer.valueOf(pid));
			
			
			
			map.put("project", project);
			map.put("expDetailList", expDetailList);
			map.put("goalList", goalList);
			map.put("fundsList", fundsList);
			String ywfw = null;
			if(project.getFProOrBasic()==0){
				ywfw = "JBZCESSB";
			}else if(project.getFProOrBasic()==1){
				ywfw = "ESSB";
			}
			/*if (project != null) {
				List<TProcessCheck> logList = checkHistoryMng.findCheckHistorys(ywfw,project.getBeanCode(),null);//审批记录
				map.put("logList", logList);
			}*/
			
			//工作流字段 
			String userId = project.getUserId();
			User user = userMng.findById(userId);
			/*map.put("f_userId", userId);//操作人主键
			map.put("f_departId", project.getFProAppliDepartId());//发起人部门主键
			map.put("f_area", ywfw);//操作人业务范围
			if (!StringUtil.isEmpty(userId)) {//首个审批人姓名
				User user = userMng.findById(userId);
				map.put("f_userName", user.getName());
			}*/
			
			/*map.put("f_foCode", project.getBeanCode());//表单编码
			map.put("f_nCode", project.getFExt11());//下一节点编码
			map.put("f_joinTable", "t_pro_basic_info");//数据库表
			map.put("f_beanCodeField", project.getBeanCodeField());//编码字段
			map.put("f_beanCode", project.getFProCode());//表单编码
*/			//查询工作流节点
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, ywfw, project.getFProAppliDepartId(),project.getBeanCode(),project.getFExt11(), "t_pro_basic_info", project.getBeanCodeField(), project.getFProCode(),"1");
			TNodeData node =new TNodeData();
			node.setUser(user);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(project.getFProAppliTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			/*map.put("流程发起人", user.getName());
			map.put("发起人部门", user.getDepartName());
			map.put("发起时间", project.getFProAppliTime());*/
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(project.getFFlowStauts().equals("-11")||project.getFFlowStauts().equals("-21")||project.getFFlowStauts().equals("-31")||project.getFFlowStauts().equals("-14")){
				map.put("当前流程节点人", user.getName());
				map.put("当前流程节点数", 1);
			}else if(project.getFFlowStauts().equals("19")||project.getFFlowStauts().equals("29")||project.getFFlowStauts().equals("39")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(project.getNextCheckKey())){
						map.put("当前流程节点人", project.getNextAssignerName());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(project);
			/*List<Attachment> attaList1 = new ArrayList();
			List<Attachment> attaList2 = new ArrayList();
			for (Attachment attc:attaList){
				if (attc.getServiceType().equals("lxyj")){
					attaList1.add(attc);
				}else if(attc.getServiceType().equals("ssfa")){
					attaList2.add(attc);
				}
			}
			map.put("attaList1", attaList1);
			map.put("attaList2", attaList2);*/
			map.put("attaList", attaList);
			return map;
		}
		
		//详情-预算调整审批
		@RequestMapping("/adjust")
		@ResponseBody
		public Object adjust(String pid){
			Map<String,Object> map = new HashMap<>();
			TIndexInnerAd bean = insideAdjustMng.findById(Integer.valueOf(pid));
			if(!StringUtil.isEmpty(bean.getInsideDeptId())){
				Depart depart =departMng.findById(bean.getInsideDeptId());
				bean.setInSideDepartName(depart.getName());
			}
			List<TIndexAdItf> inList =  adItfMng.findByInId(pid,"IN");
			List<TIndexAdItf> outList =  adItfMng.findByInId(pid,"OUT");
			
			map.put("ajustBean", bean);
			map.put("inList", inList);
			map.put("outList", outList);
			
			//工作流字段 TODO 该工作流测试后，流程节点显示不正确，参考InseideCheckController.edit
			String userId = bean.getUserId();
			User applyUser = userMng.findById(userId);
			//查询工作流节点
			User user = userMng.findById(userId);
			//List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, "NBZBDZ", applyUser.getDepart().getId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),bean.getBeanCodeField(), bean.getInCode(),"1");
			//如果是部门内部调整，则走配置好的流程
			List<TNodeData> nodeConfList=new ArrayList();
			if(StringUtils.isEmpty(bean.getInsideDeptId())){
				 nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), "NBZBDZ", bean.getDeptCode(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getInCode(), "1");
			}else {
				 nodeConfList = tProcessCheckMng.getInSideAdjustNodeConf(bean.getUserId(), bean.getInsideDeptId(), bean.getInCode());
			}
			TNodeData node =new TNodeData();
			node.setUser(user);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(bean.getOpTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			map.put("流程发起人", applyUser.getName());
			map.put("发起人部门", applyUser.getDepartName());
			map.put("发起时间",  bean.getOpTime());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(bean.getFlowStauts().equals("-1")||bean.getFlowStauts().equals("-4")){
				map.put("当前流程节点人", applyUser.getName());
				map.put("当前流程节点数", 1);
			}else if(bean.getFlowStauts().equals("9")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(bean.getNextCheckKey())){
						map.put("当前流程节点人", bean.getFuserName());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			return map;
		}
		
		//根据项目id判断项目类型
		@RequestMapping("/getProTypeById")
		@ResponseBody
		public Object getProTypeById(String pid){
			TProBasicInfo pro = proMng.findById(Integer.valueOf(pid));
			if (pro != null) {
				return pro.getFProOrBasic();
			}
			return null;
		}
		
		@RequestMapping("/purchasePlan")
		@ResponseBody
		//详情-采购计划(采购申请)审批
		public Object purchasePlan(String pid, String userId){
			Map<String,Object> map = new HashMap<>();
			//采购信息
			PurchaseApplyBasic oldbean = cgsqMng.findById(Integer.valueOf(pid));
			PurchaseApplyBasic bean =new PurchaseApplyBasic();
			BeanUtils.copyProperties(oldbean,bean);
			String cglx =LookupsUtil.getNameByCategoryCodeAndCode("CGLX", bean.getFpPype());
			String cgfs =LookupsUtil.getNameByCategoryCodeAndCode(bean.getFpPype(), bean.getFpMethod());
			/*String fpItemsNames =LookupsUtil.getNameByCategoryCodeAndCode("PMMC", bean.getFpItemsName());
			String budgetPriceBasisShow =LookupsUtil.getNameByCategoryCodeAndCode("YSJGYJ", bean.getBudgetPriceBasis());
			if(fpItemsNames!=null){
				bean.setFpItemsNames(fpItemsNames);
			}*/
			if(cglx!=null){
				bean.setFpPype(cglx);
			}
			if(cgfs!=null){
				bean.setFpMethod(cgfs);
			}
			
			/*bean.setBudgetPriceBasisShow(budgetPriceBasisShow);
			bean.setProSignContent(StringUtil.htmlRemoveTag(bean.getProSignContent()));*/
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
					//资金渠道
				/*	if("0".equals(index.getIndexType())){
						bean.setPfIndexType("基本预算");		
					}else{
						bean.setPfIndexType("项目预算");		
					}*/
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
				//资金渠道
				/*if("0".equals(index.getIndexType())){
					bean.setPfIndexType("基本预算");		
				}else{
					bean.setPfIndexType("项目预算");		
				}*/
			}
			//采购清单
			List<Object> mingxiList = reciveMng.mingxi(bean,"1");
			//只有归口部门负责人（目前是设备安技处和总务处）才可以填写采购方式和采购类型
			User user =userMng.findById(userId);
			String roleName=user.getRoleName();
			String deptId =user.getDpID();
			String isZc ="0";
			if(roleName.contains("部门负责人")&&((deptId.equals("14")&&(bean.getfItems().equals("A10") || "A30".equals(bean.getfItems()) || "A20".equals(bean.getfItems())))
					||(deptId.equals("35"))&&"A40".equals(bean.getfItems()))){
				String[] itemIds =bean.getfItemsDetailIds().split(",");
				for (String itemId : itemIds) {
					PurchaseItemsDetail detail =purchaseItemsMng.findById(Integer.valueOf(itemId));
					if(!StringUtil.isEmpty(detail.getfCode())){
						isZc="1";
					}
				}
				map.put("isZc", isZc);
				map.put("isRoleCggl", true);
			}else{
				map.put("isRoleCggl", false);
			}
			
			map.put("bean", bean);
			map.put("mingxiList", mingxiList);
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			map.put("attaList", attaList);
			//工作流字段
			User applyUser = userMng.findById(bean.getUserId());
			map.put("f_userId", bean.getUserId());//操作人主键
			map.put("f_departId", applyUser.getDepart()!=null? applyUser.getDepart().getId() : null);//发起人部门主键
			/*String busiArea="CGSQ";
			map.put("f_area", busiArea);//操作人业务范围
*/			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			String userName = proposer.getUserName();
			if (!StringUtil.isEmpty(userId)) {//首个审批人姓名
				map.put("f_userName", userName);
			}
			
			
			map.put("f_foCode", bean.getBeanCode());//表单编码
			map.put("f_nCode", bean.getnCode());//下一节点编码
			map.put("f_joinTable", "T_PURCHASE_APPLY_BASIC");//表名
			map.put("f_beanCodeField", bean.getBeanCodeField());//编码字段
			map.put("f_beanCode", bean.getBeanCode());//表单编码
			//查询工作流节点
			TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			List<TNodeData> nodeConfList= new ArrayList<TNodeData>();
			if(bean.getfItems().equals("A10")|| "A30".equals(bean.getfItems())|| "A20".equals(bean.getfItems())){
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"HWCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
				}else {
					nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HWCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
				}
			}else{
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"GCCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
				}else {
					nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
				}
			}
			TNodeData node =new TNodeData();
			node.setUser(applyUser);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(bean.getfReqTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			//User user = userMng.findById(userId);
			map.put("流程发起人", applyUser.getName());
			map.put("发起人部门", applyUser.getDepartName());
			map.put("发起时间",  bean.getfReqTime());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(bean.getfCheckStauts().equals("-1")||bean.getfCheckStauts().equals("-4")){
				map.put("当前流程节点人", applyUser.getName());
				map.put("当前流程节点数", 1);
			}else if(bean.getfCheckStauts().equals("9")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(bean.getNextCheckKey())){
						map.put("当前流程节点人", bean.getUserName2());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			return map;
		}
		
		//采购登记详情
		@RequestMapping("/purchaseReg")
		@ResponseBody
		public Object purchaseReg(String pid){
			
			Map<String,Object> map = new LinkedHashMap<>();
			//过程登记基本信息
			//RegisterApplyBasic rBean =registerApplyMng.findById(Integer.valueOf(pid));
			BiddingRegist rBean = processMng.findByProperty("fpId", Integer.valueOf(pid)).get(0);
			map.put("regBean", rBean);
			//查询登记过程附件信息
			List<Attachment> brAttac = attachmentMng.list(rBean);
			map.put("brAttac", brAttac);
			//根据中标登记表查询供应商的信息
			WinningBidder fwbean = cgselMng.findById(rBean.getFwId());
			map.put("fwbean", fwbean);
			//采购结果
			List<ProcurementPlanList> mingxiList =  cgConPlanListMng.findbyIdAndTypes("fbId", String.valueOf(rBean.getFbId()),"2");
			map.put("mingxiList",mingxiList);
			return map;
		}
		
		
		@RequestMapping("/purchaseInspect")
		@ResponseBody
		//详情-采购验收审批
		public Object purchaseInspect(String pid,String userId){
			Map<String,Object> map = new HashMap<>();
			//查询采购验收基本信息
			AcceptCheck acBean = cgReceiveMng.findById(Integer.valueOf(pid));
			//采购基本信息
			PurchaseApplyBasic bean = cgsqMng.findById(acBean.getFpId());
			//验收明细
			//List<AcceptContractRegisterList> acceptContractRegisterList = acceptContractRegisterListMng.findFpIdbyMingxi(String.valueOf(acBean.getFacpId()));
			List<Object> mingxiList = reciveMng.mingxi(bean,"3");
			map.put("inspectBean", acBean);
			map.put("mingxiList", mingxiList);
			if("1".equals(bean.getFbidStauts())){
				map.put("ShowCgdj", true);//登记显示 
			}else{
				map.put("ShowCgdj", false);//登记隐藏 
			}
			//判断审批人是否为设备安技处部门负责人
			User user = userMng.findById(userId);
			if(user.getRoleName().contains("部门负责人")&& "设备与安技处".equals(user.getDepart().getName())){
				map.put("zjyjFile", true);
			}else{
				map.put("zjyjFile", false);
			}
			//采购验收附件
			List<Attachment> attaList = attachmentMng.list(acBean);
			map.put("attaList", attaList);
			//工作流字段
			String applyUserId = acBean.getUserId();
			User applyUser = userMng.findById(applyUserId);
			//map.put("f_userId", userId);//操作人主键
			//map.put("f_departId", applyUser.getDepart()!=null? applyUser.getDepart().getId() : null);//发起人部门主键
			String busiArea = "";
			if(bean.getFpPype().equals("A10")|| "A30".equals(bean.getFpPype())){
				busiArea ="HWCGYS";
			}else{
				busiArea ="BGCGYS";
			}
			//map.put("f_area", busiArea);//操作人业务范围
			Proposer proposer = new Proposer(acBean.getFacpUsername(), acBean.getfDepartName(), acBean.getFacpTime());
			String userName = proposer.getUserName();
			if (!StringUtil.isEmpty(userId)) {//首个审批人姓名
				map.put("f_userName", userName);
			}
			//查询工作流节点
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, busiArea, applyUser.getDepart().getId(),acBean.getBeanCode(),acBean.getnCode(), acBean.getJoinTable(),acBean.getBeanCodeField(), acBean.getBeanCode(),"1");
			TNodeData node =new TNodeData();
			node.setUser(applyUser);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(bean.getfReqTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			//User user = userMng.findById(userId);
			map.put("流程发起人", applyUser.getName());
			map.put("发起人部门", applyUser.getDepartName());
			map.put("发起时间",  acBean.getFacpTime());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(acBean.getfCheckStauts().equals("-1")||acBean.getfCheckStauts().equals("-4")){
				map.put("当前流程节点人", applyUser.getName());
				map.put("当前流程节点数", 1);
			}else if(acBean.getfCheckStauts().equals("9")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(acBean.getNextCheckKey())){
						map.put("当前流程节点人", acBean.getUserName2());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			return map;
		}
		
		@RequestMapping("/contractDraw")
		@ResponseBody
		//详情-合同拟定审批
		public Object contractDraw(String pid,String userId){
			Map<String,Object> map = new LinkedHashMap<>();
			
			//合同拟定信息
			ContractBasicInfo oldBean = formulationMng.findById(Integer.valueOf(pid));
			ContractBasicInfo bean =new ContractBasicInfo();
			BeanUtils.copyProperties(oldBean,bean);
			//签约方信息
			SignInfo signInfo = new SignInfo();
			List<SignInfo> signInfoList = filingMng.find_Sign(bean);
			if(signInfoList != null && signInfoList.size() > 0){
				signInfo = signInfoList.get(0);
			}
			if(bean.getFcType().equals("HTFL-01")){
				//付款计划
				Pagination p = filingMng.find_ReceivPlan(String.valueOf(bean.getFcId()),1,500);
				List<ReceivPlan> planList = (List<ReceivPlan>) p.getList();
				map.put("planList", planList);
				//采购清单
				List<Object> mingxiList = contractPlanListMng.findbyIdAndType("fconId",bean.getFcId().toString(),"0");
				map.put("cgplan", mingxiList);
			}else if(bean.getFcType().equals("HTFL-02")){
				//收款计划
				List<ProceedsPlan> skList = proceedsPlanMng.finduptandbase("0", bean.getFcId());
				map.put("skList", skList);
			}
			map.put("basicBean", bean);
			map.put("signerInfo", signInfo);
			//合同拟定的附件
			List<Attachment> attaList = attachmentMng.list(bean);
			map.put("attaList", attaList);
			User user = userMng.findById(userId);
			String fsyjsFile ="";
			if(user.getRoleName().contains("合同法审岗")&&Double.valueOf(bean.getFcAmount())>=100000&&bean.getStandard()==0){
				fsyjsFile ="1";
			}else{
				if(Double.valueOf(bean.getFcAmount())>=100000&&bean.getStandard()==0){
					fsyjsFile ="0";
				}else{
					fsyjsFile ="";
				}
			}
			map.put("fsyjsFile",fsyjsFile);
			//工作流字段
			String applyUserId = bean.getUserId();
			User applyUser = userMng.findById(applyUserId);
			//查询工作流节点
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, "HTND", applyUser.getDepart().getId(),bean.getBeanCode(),bean.getfNCode(), bean.getJoinTable(),bean.getBeanCodeField(), bean.getBeanCode(),"1");
			TNodeData node =new TNodeData();
			node.setUser(applyUser);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(bean.getfReqtIME());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			map.put("流程发起人", applyUser.getName());
			map.put("发起人部门", applyUser.getDepartName());
			map.put("发起时间",  bean.getfReqtIME());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(bean.getfFlowStauts().equals("-1")||bean.getfFlowStauts().equals("-4")){
				map.put("当前流程节点人", applyUser.getName());
				map.put("当前流程节点数", 1);
			}else if(bean.getfFlowStauts().equals("9")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数", nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(bean.getNextCheckKey())){
						map.put("当前流程节点人", bean.getfUserName());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			return map;
		}
		
		@RequestMapping("/contractChange")
		@ResponseBody
		//详情-合同变更审批
		public Object contractChange(String pid){
			Map<String,Object> map = new LinkedHashMap<>();
			
			//合同变更信息
			Upt oldupdateBean = uptMng.findById(Integer.valueOf(pid));
			//合同基本信息
			ContractBasicInfo oldcontractBean = formulationMng.findById(Integer.valueOf(oldupdateBean.getfContId_U()));
			Upt updateBean =new Upt();
			ContractBasicInfo contractBean =new ContractBasicInfo();
			BeanUtils.copyProperties(oldupdateBean,updateBean);
			BeanUtils.copyProperties(oldcontractBean,contractBean);
			String fcType=lookupsMng.getNameByCategoryCodeAndCode("HTFL", contractBean.getFcType());
			contractBean.setFcType(fcType);
			//签约方信息
			SignInfo sign = new SignInfo();
			List<SignInfo> signInfoList=filingMng.find_Sign(contractBean);
			if(signInfoList!=null&&signInfoList.size()>0){
				sign = signInfoList.get(0);
			}
			/*//新付款计划
			//List<ReceivPlan> newPlanList = receivPlanMng.findbyUptId(updateBean.getfId_U());
			ReceivPlan receivPlan = new ReceivPlan();
			receivPlan.setfUptId_R(updateBean.getfId_U());
			receivPlan.setDataType(1);
			List<ReceivPlan> newPlanList = filingMng.getReceivPlan(receivPlan);
			for (int i = 0; i < newPlanList.size(); i++) {
				Lookups lookups=lookupsMng.findByLookCode(newPlanList.get(i).getfReceProof());
				newPlanList.get(i).setfReceProofs(lookups.getName());	
			}
			//旧付款计划
			Pagination p = filingMng.find_ReceivPlan(String.valueOf(contractBean.getFcId()),1,500);
			List<ReceivPlan> oldList = (List<ReceivPlan>) p.getList();
			if(oldList!=null&oldList.size()>0){
				for (int i = 0; i < oldList.size(); i++) {
					Lookups lookups=lookupsMng.findByLookCode(oldList.get(i).getfReceProof());
					oldList.get(i).setfReceProofs(lookups.getName());	
				}
			}
			//新采购清单
			ContractRegisterList contractRegisterList =new ContractRegisterList();
			contractRegisterList.setfDataType(1);
			contractRegisterList.setfId_U(updateBean.getfId_U());
			List<ContractRegisterList> newCgplan = contractRegisterListMng.getContractRegisterList(contractRegisterList);
			//旧采购清单
			List<Object> oldmingxiList = confplanMng.getMingxi("PurcMaterialRegisterList", "fbiddingCode", contractBean.getfContractor());
			List<BiddingRegist> brlist = cgProcessMng.findFbIdByFpId(null,contractBean.getfContractor(),null);
			if(brlist!=null&&brlist.size()>0){
				contractBean.setfContractor(brlist.get(0).getFbiddingName());
			}*/
			map.put("updateBean", updateBean);
			map.put("contractBean", contractBean);
			/*map.put("newPlanList", newPlanList);
			map.put("oldPlanList", oldList);
			map.put("newCgplan", newCgplan);
			map.put("oldCgplan", oldmingxiList);*/
			map.put("sign", sign);
			map.put("foCode", updateBean.getBeanCode());
			//合同拟定的附件
			List<Attachment> attaList2 = attachmentMng.list(contractBean);
			map.put("attaList2", attaList2);
			//合同变更附件
			List<Attachment> attaList1 = attachmentMng.list(updateBean);
			map.put("attaList1", attaList1);
			//签约方信息附件
			List<Attachment> signAttaList = attachmentMng.list(sign);
			map.put("signAttaList", signAttaList);
			//工作流字段
			String userId = updateBean.getUserId();
			User applyUser = userMng.findById(userId);
			map.put("f_userId", userId);//操作人主键
			map.put("f_departId", applyUser.getDepart()!=null? applyUser.getDepart().getId() : null);//发起人部门主键
			map.put("f_area", "HTBG");//操作人业务范围
			Proposer proposer = new Proposer(updateBean.getfOperator(),applyUser.getDepart().getName(), updateBean.getfReqTime());
			String userName = proposer.getUserName();
			if (!StringUtil.isEmpty(userId)) {//首个审批人姓名
				map.put("f_userName", userName);
			}
			
			map.put("f_foCode", updateBean.getBeanCode());//表单编码
			map.put("f_nCode", updateBean.getfNCode());//下一节点编码
			map.put("f_joinTable", "T_CONTRACT_UPT");//表名
			map.put("f_beanCodeField", updateBean.getBeanCodeField());//编码字段
			map.put("f_beanCode", updateBean.getBeanCode());//表单编码
			//查询工作流节点
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(userId, "HTBG", applyUser.getDepart().getId(),updateBean.getBeanCode(),updateBean.getfNCode(), updateBean.getJoinTable(),updateBean.getBeanCodeField(), updateBean.getBeanCode(),"1");
			TNodeData node =new TNodeData();
			node.setUser(applyUser);
			TProcessCheck checkInfo =new TProcessCheck();
			checkInfo.setFcheckTime(updateBean.getfReqTime());
			node.setCheckInfo(checkInfo);
			nodeConfList.add(node);
			Collections.reverse(nodeConfList);
			//流程发起人信息
			//User user = userMng.findById(userId);
			map.put("流程发起人", applyUser.getName());
			map.put("发起人部门", applyUser.getDepartName());
			map.put("发起时间",  updateBean.getfReqTime());
			//工作流节点信息
			map.put("总节点数", nodeConfList.size());
			if(updateBean.getfUptFlowStauts().equals("-1")||updateBean.getfUptFlowStauts().equals("-4")){
				map.put("当前流程节点人", applyUser.getName());
				map.put("当前流程节点数", 1);
			}else if(updateBean.getfUptFlowStauts().equals("9")){
				map.put("当前流程节点人", "已完结");
				map.put("当前流程节点数",nodeConfList.size());
			}else{
				for(int i=0;i<nodeConfList.size();i++){
					if(String.valueOf(nodeConfList.get(i).getKeyId()).equals(updateBean.getNextCheckKey())){
						map.put("当前流程节点人", updateBean.getfUserName());
						map.put("当前流程节点数", i+1);
					}
				}
			}
			map.put("nodeConfList", nodeConfList);
			return map;
		}
}
