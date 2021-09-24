package com.braker.icontrol.expend.exprint.controller;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.MoneyUtil;
import com.braker.common.util.SortList;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.ExpenditureMatterMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.core.model.UserTransient;
import com.braker.core.model.Vehicle;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.manager.ApplyAttacMng;
import com.braker.icontrol.expend.apply.manager.ApplyCheckMng;
import com.braker.icontrol.expend.apply.manager.ApplyMeetMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.manager.FeteCostInfoMng;
import com.braker.icontrol.expend.apply.manager.FoodAllowanceInfoMng;
import com.braker.icontrol.expend.apply.manager.HotelExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.InCityTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.InternationalTravelingExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.OfficeCarMng;
import com.braker.icontrol.expend.apply.manager.OutsideTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.TravelAppliInfoMng;
import com.braker.icontrol.expend.apply.manager.TravelRecordMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.AbroadAppliPepoleInfo;
import com.braker.icontrol.expend.apply.model.AbroadPlan;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;
import com.braker.icontrol.expend.apply.model.LecturerInfo;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.MiscellaneousFeeInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.OutsideTrafficInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.ReceptionHotel;
import com.braker.icontrol.expend.apply.model.StudentsList;
import com.braker.icontrol.expend.apply.model.ReceptionOther;
import com.braker.icontrol.expend.apply.model.TrainTeacherCost;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbDetailMng;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbDetailMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbDetail;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimCXInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.expend.standard.manager.AboardCountryStandardMng;
import com.braker.icontrol.expend.standard.manager.StandardMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.entity.TProcessPrintDetail;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 导出支出管理中的事前申请和事后报销的报销单
 * @author 赵孟雷
 * @createtime 2020-06-02
 * @updatetime 2020-06-02
 *
 */
@Controller
@RequestMapping(value = "/exportApplyAndReim")
public class ExportApplyAndReimController extends BaseController{

	@Autowired
	private TProBasicInfoMng projectMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private ApplyMeetMng meetMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private ApplyCheckMng applyCheckMng;
	
	@Autowired
	private ApplyAttacMng attacMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private StandardMng standardMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private TravelRecordMng travelRecordMng;
	
	@Autowired
	private ExpenditureMatterMng expMatterMng;
	
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
	private RoleMng roleMng;
	
	@Autowired
	private FoodAllowanceInfoMng foodAllowanceInfoMng;
	
	@Autowired
	private HotelExpenseInfoMng hotelExpenseInfoMng;
	
	@Autowired
	private TravelAppliInfoMng travelAppliInfoMng;
	
	@Autowired
	private OutsideTrafficInfoMng outsideTrafficInfoMng;
	
	@Autowired
	private InCityTrafficInfoMng inCityTrafficInfoMng;
	
	@Autowired
	private AboardCountryStandardMng aboardCountryStandardMng;
	
	@Autowired
	private InternationalTravelingExpenseInfoMng internationalTravelingExpenseInfoMng;
	
	@Autowired
	private VehicleMng vehicleMng;
	
	@Autowired
	private FeteCostInfoMng feteCostInfoMng;

	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private TProItfMng itfMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private ReimbPayeeMng reimbPayeeMng;
	
	@Autowired
	private ReimbDetailMng reimbDetailMng;
	
	@Autowired
	private InvoiceMng invoiceMng;
	
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	
	@Autowired
	private ApplicationBasicInfoMng applicationBasicInfoMng;
	
	@Autowired
	private ReimbAttacMng reimbAttacMng;
	
	@Autowired
	private AuditInfoMng auditInfoMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;	//个人收款信息
	
	@Autowired
	private OfficeCarMng officeCarMng;
	
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private LoanPayeeMng loanPayeeMng;
	
	@Autowired
	private DirectlyReimbPayeeMng directlyReimbPayeeMng;
	
	@Autowired
	private DirectlyReimbDetailMng directlyReimbDetailMng;
	
	@Autowired
	private PaymentMng paymentMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private UptMng uptMng;
	
	@Autowired
	private FilingMng filingMng;
	
	@Autowired
	private LookupsMng lookupsMng;
	
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	
	/*
	 * 跳转到导出差旅申请预览页面
	 * @author 赵孟雷
	 * @createtime 2020-06-02
	 * @updatetime 2020-06-02
	 */
	@RequestMapping(value = "/applyTravel")
	public String list(Integer id, ModelMap model) throws Exception {
		//获取需要修改的申请单
		ApplicationBasicInfo bean = applyMng.findById(id);
		//查询差旅信息
		TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
		model.addAttribute("travelBean", travelBean);
		
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		if("GWCX".equals(bean.getTravelType())){
			strType = "GWCXSQ";
		}
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		List<TProcessCheck> listTProcessCheck = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
		model.addAttribute("listTProcessCheck", listTProcessCheck);
		
		return "/WEB-INF/view/expend/export/apply/exportTravel";
	}
	/*
	 * 跳转到导出差旅报销预览页面
	 * @author 赵孟雷
	 * @createtime 2020-06-02
	 * @updatetime 2020-06-02
	 */
	@RequestMapping(value = "/reimburseTravel")
	public String reimburseTravel(String id, ModelMap model) {
		model.addAttribute("id", id);
		return "/WEB-INF/view/expend/export/reimburse/exportReimburse";
	}
	
	/**
	 * 支出事前打印
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月2日
	 * @updator 陈睿超
	 * @updatetime 2020年6月2日
	 */
	@RequestMapping("/applyExprot")
	public String edit(Integer id, ModelMap model) {	
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			//获取需要修改的申请单
			ApplicationBasicInfo bean = applyMng.findById(id);
			//判断申请类型
			String type = bean.getType();
			TProExpendDetail expendDetail = new TProExpendDetail();
			TProBasicInfo pro = new TProBasicInfo();
			if("4".equals(type)){
				BudgetMessageList budgetMessageList = new BudgetMessageList();
				budgetMessageList.setgId(bean.getgId());
				//查询接待明细
				List<BudgetMessageList> budgetMessageLists = applyMng.getBudgetMessageList(budgetMessageList,getUser());
				for (BudgetMessageList messageList : budgetMessageLists) {
					if(!"".equals(messageList.getfCostClassifyShow())){
						if("1".equals(budgetMessageList.getfIndexType())){
							budgetMessageList = messageList;
							break;
						}else{
							budgetMessageList = messageList;
						}
					}
				}

				TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(budgetMessageList.getfIndexId());
				pro = projectMng.findById(budgetIndexMgr.getFProId());
			}else{
				expendDetail = detailMng.findById(bean.getProDetailId());
				pro = projectMng.findById(expendDetail.getFProId());
			}
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			model.addAttribute("pro", pro);
			bean.setProDetailName(pro.getFProName()+"("+pro.getFProCode()+")");
			bean.setProCharger(pro.getFProHead());
			//查询申请人信息
			User user = userMng.findById(bean.getUser());
			bean.setUserNames(user.getName());
			bean.setApplyAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			//转换type选择流程
			String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
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
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			ReceptionAppliInfo receptionBean =new ReceptionAppliInfo();
			if(type.equals("1")){
				model.addAttribute("userid", getUser().getId());
				//通用明细
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "gId", id);
				model.addAttribute("mingxiList", mingxiList);
				/*List<TProcessCheck> listTProcessChecksTY = new ArrayList<TProcessCheck>();
				List<TProcessCheck> listTProcessCheck = tProcessCheckMng.checkHistory(10000,bean.getBeanCode());
				int num =listTProcessCheck.size();
				for (TProcessCheck tProcessCheck : listTProcessCheck) {
					if("0".equals(tProcessCheck.getFcheckResult())){
						break;
					}else{
						User user2 = userMng.findById(tProcessCheck.getFuserId());
						tProcessCheck.setCheckDeptName(user2.getDepart().getName());
						DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
						String time =fmt.format(tProcessCheck.getFcheckTime());     // 转换成 X年X月X日
						tProcessCheck.setFcheckTimes(time);
						String StringNum = MatheUtil.ToCH(num);
						tProcessCheck.setFroleName("第"+StringNum+"审核人");
						listTProcessChecksTY.add(tProcessCheck);
						num-=1;
					}
				}
				Collections.reverse(listTProcessChecksTY); // 倒序排列 
				model.addAttribute("listTProcessChecksTY", listTProcessChecksTY);*/
				
			}else if(type.equals("2")) {
				
				//查询会议信息
				MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", id);
				model.addAttribute("meetingBean", meetingBean);
				String startTime =fmt.format(meetingBean.getDateStart());
				String endTime =fmt.format(meetingBean.getDateEnd());
				model.addAttribute("startTime", startTime);
				model.addAttribute("endTime", endTime);
				int day = DateUtil.getDaySpan(meetingBean.getDateStart(), meetingBean.getDateEnd());
				model.addAttribute("day", day);
				//会议日程
				List<Object> listMeetingPlan = applyMng.getObjectList("MeetingPlan", "gId", id);
				model.addAttribute("listMeetingPlan", listMeetingPlan);
				
				//费用明细
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "gId", id);
				model.addAttribute("mingxiList", mingxiList);
				
			} else if(type.equals("3")) {
				//查询培训信息
				TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", id);
				model.addAttribute("trainingBean", trainingBean);
				int day = DateUtil.getDaySpan(trainingBean.getTrDateStart(), trainingBean.getTrDateEnd());
				model.addAttribute("day", day);
				//讲师信息
				List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
				model.addAttribute("listLecturer", listLecturer);
				//培训日程
				List<Object> listMeetPlan = applyMng.getObjectList("MeetPlan", "tId", trainingBean.gettId());
				model.addAttribute("listMeetPlan", listMeetPlan);
				//综合预算
				List<Object> listZongHe = applyMng.getMingxi("ApplicationDetail", "gId", id);
				model.addAttribute("listZongHe", listZongHe);
				//师资费—讲课费
				List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
				model.addAttribute("listTeacherCost", listTeacherCost);
				//师资费—住宿费
				List<TrainTeacherCost> listHotel = applyMng.getTeacherMingxi(trainingBean.gettId(), "hotel");
				model.addAttribute("listHotel", listHotel);
				//师资费—伙食费
				List<TrainTeacherCost> listFood = applyMng.getTeacherMingxi(trainingBean.gettId(), "food");
				model.addAttribute("listFood", listFood);
				//师资费—城市间交通费
				List<TrainTeacherCost> listTraffic1 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic1");
				model.addAttribute("listTraffic1", listTraffic1);
				BigDecimal listTraffic1applySum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic1.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic1.get(i);
					listTraffic1applySum=listTraffic1applySum.add(trainTeacherCost.getApplySum());
				}
				model.addAttribute("listTraffic1applySum", listTraffic1applySum);
				
				//师资费—其他费用
				List<TrainTeacherCost> listTraffic2 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic2");
				model.addAttribute("listTraffic2", listTraffic2);
				BigDecimal listTraffic2applySum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic2.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic2.get(i);
					listTraffic2applySum=listTraffic2applySum.add(trainTeacherCost.getApplySum());
				}
				model.addAttribute("listTraffic2applySum", listTraffic2applySum);
			} else if(type.equals("4")) {
				//查询差旅信息
				TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
				model.addAttribute("travelBean", travelBean);
				if("GWCC".equals(bean.getTravelType())){
					int day = DateUtil.getDaySpan(travelBean.getTravelDateStart(), travelBean.getTravelDateEnd());
					model.addAttribute("day", day);
				}
				//行程
				Pagination p = travelAppliInfoMng.travelPageList(1, 100, travelBean);
				List<TravelAppliInfo> Travellist = (List<TravelAppliInfo>) p.getList();

				if(!"GWCX".equals(bean.getTravelType())){
					List<OutsideTrafficInfo> outsidelist =new ArrayList<OutsideTrafficInfo>();
					OutsideTrafficInfo Outsidebean = (OutsideTrafficInfo) applyMng.getObject("OutsideTrafficInfo", "gId", id);
					if(Outsidebean!=null){
						Pagination outsidep = outsideTrafficInfoMng.outsideTrafficInfoPageList(1, 100, Outsidebean);
						outsidelist = (List<OutsideTrafficInfo>) outsidep.getList();
					}
					model.addAttribute("outsidelist", outsidelist);
				}
				//获取目的地
				String travelAreaName = new String();
				for (int i = 0; i < Travellist.size(); i++) {
					travelAreaName = travelAreaName + Travellist.get(i).getTravelAreaName() + ",";
				}
				
				//获取学生信息，把学生信息加到出行人员中去
					Set<String> peopleSet = new HashSet<String>();
					for (int i = Travellist.size()-1; i >= 0; i--) {
						String[] peopId =  Travellist.get(i).getTravelAttendPeopId().split(",");
						for (int j = 0; j < peopId.length; j++){
							peopleSet.add(peopId[j]);
							
						}
						//多选的情况下循环出来人员信息添加到里面
						/*for (int j = 0; j < peopId.length; j++) {
							TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
							User peop = userMng.findById(peopId[j]);
							travelAppliInfo.setTravelAttendPeop(peop.getName());
							travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
							travelAppliInfo.setTravelAttendPeopId(peop.getId());
							String roleslevel = new String();
							switch (peop.getRoleslevel()) {//1：市级，2：局级，3：其他人员
							case 1:
								roleslevel ="市级";
								break;
							case 2:
								roleslevel ="局级";
								break;
							case 3:
								roleslevel ="其他人员";
								break;
							}
							travelAppliInfo.setTravelPersonnelLevel(roleslevel);
							travelAppliInfo.setfTel(peop.getTelNo());
							Travellist.add(travelAppliInfo);
						}*/
						//先删除这一条数据，再从新添加
						Travellist.remove(i);
					}
					for (Object object : peopleSet) {
						TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
						User peop = userMng.findById(object.toString());
						travelAppliInfo.setTravelAttendPeop(peop.getName());
						travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
						travelAppliInfo.setTravelAttendPeopId(peop.getId());
						String roleslevel = new String();
						switch (peop.getRoleslevel()) {//1：市级，2：局级，3：其他人员
						case 1:
							roleslevel ="市级";
							break;
						case 2:
							roleslevel ="局级";
							break;
						case 3:
							roleslevel ="其他人员";
							break;
						}
						travelAppliInfo.setTravelPersonnelLevel(roleslevel);
						travelAppliInfo.setfTel(peop.getTelNo());
						Travellist.add(travelAppliInfo);
					}
				
				StudentsList stl = new StudentsList();
				stl.setgId(id);
				List<StudentsList> studentsList = (List<StudentsList>) travelAppliInfoMng.studentsPageList(1, 10000, stl).getList();
				for (int i = 0; i < studentsList.size(); i++) {
					TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
					travelAppliInfo.setTravelAttendPeop(studentsList.get(i).getfName());
					travelAppliInfo.setfIdentityNumber(studentsList.get(i).getfIdentityNumber());
					travelAppliInfo.setTravelPersonnelLevel("学生");
					travelAppliInfo.setfTel(studentsList.get(i).getfTel());
					Travellist.add(travelAppliInfo);
				}
				model.addAttribute("travellist", Travellist);
				model.addAttribute("travelAreaName", travelAreaName.subSequence(0, travelAreaName.length()-1));
				//市内交通费
				List<InCityTrafficInfo> inCitylist =new ArrayList<InCityTrafficInfo>();
				InCityTrafficInfo InCitybean = (InCityTrafficInfo) applyMng.getObject("InCityTrafficInfo", "gId", id);
				if(InCitybean!=null){
					Pagination InCitybeanp = inCityTrafficInfoMng.inCityInfoPageList(1, 100, InCitybean);
					inCitylist = (List<InCityTrafficInfo>) InCitybeanp.getList();
				}
				model.addAttribute("inCitylist", inCitylist);
				//住宿费
				List<HotelExpenseInfo> hotellist = hotelExpenseInfoMng.findbygId(bean.getgId(),null);
				model.addAttribute("hotellist", hotellist);
				//伙食补助
				List<FoodAllowanceInfo> foodlist = foodAllowanceInfoMng.findbygId(bean.getgId(),null);
				model.addAttribute("foodlist", foodlist);
				
				/*//查询差旅人员信息
				TravelPeopleInfo tPeopBean = (TravelPeopleInfo) applyMng.getObject("TravelPeopleInfo", "trId", travelBean.getTrId());
				model.addAttribute("tPeopBean", tPeopBean);*/
				
			} else if(type.equals("5")) {
				//查询接待信息
				receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", id);
				model.addAttribute("receptionBean", receptionBean);
				//参观考察安排
				List<Object> listObserve =applyMng.getObjectList("ReceptionObservePlan", "jId", receptionBean.getjId());
				model.addAttribute("listObserve", listObserve);
				/*//住宿费
				List<Object> listHotel = applyMng.getObjectList("ReceptionHotel", "gId", id);
				model.addAttribute("listHotel", listHotel);*/
				//餐费
				List<Object> listFood = applyMng.getObjectList("ReceptionFood", "gId", id);
				model.addAttribute("listFood", listFood);
				//其他费用
				List<Object> listOther = applyMng.getObjectList("ReceptionOther", "gId", id);
				model.addAttribute("listOther", listOther);
				
			} else if(type.equals("6")) {
				//查询公务用车信息
				
				OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", id);
				model.addAttribute("officeCar", officeBean);
				
			} else if(type.equals("7")) {
				//查询公务出国信息
				/*expendDetail = detailMng.findById(bean.getProDetailId());
				pro = projectMng.findById(expendDetail.getFProId());
				model.addAttribute("pro", pro);*/
				AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", id);
				model.addAttribute("abroad", abroadBean);
				int day = DateUtil.getDaySpan(abroadBean.getfAbroadDateStart(), abroadBean.getfAbroadDateEnd());
				model.addAttribute("day", day);
				//查询出访计划
				List<Object> listAbroadPlan = applyMng.getObjectList("AbroadPlan", "gId", id);
				String arriveCountry = new String();
				String arrivePlan = new String();
				Set arriveCountrySet = new HashSet();
				for (int i = 0; i < listAbroadPlan.size(); i++) {
					AbroadPlan abroadPlan = (AbroadPlan) listAbroadPlan.get(i);
					arriveCountrySet.add(abroadPlan.getArriveCountry());
					//arriveCountry = arriveCountry + abroadPlan.getArriveCountry() + ",";
					arrivePlan = arrivePlan + fmt.format(abroadPlan.getAbroadDate())+"-"+
						fmt.format(abroadPlan.getTimeEnd())+" "+abroadPlan.getArriveCountry()+" "+
						abroadPlan.getArriveCity()+"</br>";
				}
				for (Object object : arriveCountrySet) {
					arriveCountry = arriveCountry + object + ",";
				}
				bean.setArriveCountry(arriveCountry.substring(0, arriveCountry.length()-1));//设置出访国家
				bean.setArrivePlan(arrivePlan);//出访计划
				model.addAttribute("listAbroadPlan", listAbroadPlan);
				model.addAttribute("bean", bean);
				
//				Pagination p = userMng.getUserByIds(abroadBean.getfAbroadPeople());
//				List<UserTransient> abroadPeopleList = (List<UserTransient>) p.getList();
				List<Object> abroadPeopleList =applyMng.getObjectList("AbroadAppliPepoleInfo", "aId", abroadBean.getFaId());
				model.addAttribute("abroadPeopleList", abroadPeopleList);
				
				//出行方式
				List<OutsideTrafficInfo> outsideTrafficInfoList = outsideTrafficInfoMng.getTravelWayById(id);
				String airplaneLevel = "";
				String shipLevel = "";
				String otherTrafficLevel = "";
				String trainLevel = "";
				Set airplaneSet = new HashSet();
				Set shipSet = new HashSet();
				Set trainSet = new HashSet();
				Set otherTrafficSet = new HashSet();
				for (OutsideTrafficInfo outsideTrafficInfo : outsideTrafficInfoList) {
					if (outsideTrafficInfo.getVehicle().contains("飞机")) {
						model.addAttribute("airplane", "airplane");
						
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							airplaneSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "、";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("轮船")) {
						model.addAttribute("ship", "ship");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							shipSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "、";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("火车")) {
						model.addAttribute("train", "train");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							trainSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "、";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("其他")) {
						model.addAttribute("otherTraffic", "otherTraffic");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							otherTrafficSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "、";
						}
						
					}
				}
				for (Object object : airplaneSet) {
					airplaneLevel = airplaneLevel + object + "、";
				}
				for (Object object : shipSet) {
					shipLevel = shipLevel + object + "、";
				}
				for (Object object : trainSet) {
					trainLevel = trainLevel + object + "、";
				}
				for (Object object : otherTrafficSet) {
					otherTrafficLevel = otherTrafficLevel + object + "、";
				}
				if (airplaneLevel.length() > 0) {
					airplaneLevel = airplaneLevel.substring(0, airplaneLevel.length() - 1);
					model.addAttribute("airplaneLevel", airplaneLevel);
				}
				if (shipLevel.length() > 0) {
					shipLevel = shipLevel.substring(0, shipLevel.length() - 1);
					model.addAttribute("shipLevel", shipLevel);
				}
				if (trainLevel.length() > 0) {
					trainLevel = trainLevel.substring(0, trainLevel.length() - 1);
					model.addAttribute("trainLevel", trainLevel);
				}
				if (otherTrafficLevel.length() > 0) {
					otherTrafficLevel = otherTrafficLevel.substring(0, otherTrafficLevel.length() - 1);
					model.addAttribute("otherTrafficLevel", otherTrafficLevel);
				}
				
				//国际旅费
				List<InternationalTravelingExpense> listInternationalTravelingExpense = internationalTravelingExpenseInfoMng.findbygId(id);
				for (InternationalTravelingExpense expense : listInternationalTravelingExpense) {
					if (expense.getVehicle() != null) {
						Vehicle vehicle = vehicleMng.findById(Integer.valueOf(expense.getVehicle()));
						expense.setVehicleText(vehicle.getName());
					}
				}
				model.addAttribute("listInternationalTravelingExpense", listInternationalTravelingExpense);
				
				//获取国外城市间交通费
				List<Object> listOutsideTrafficInfo = applyMng.getObjectList("OutsideTrafficInfo", "gId", id);
				model.addAttribute("listOutsideTrafficInfo", listOutsideTrafficInfo);
				//住宿费
				List<HotelExpenseInfo> listHotelExpenseInfo = hotelExpenseInfoMng.findbygId(bean.getgId(),bean.getTravelType());
				model.addAttribute("listHotelExpenseInfo", listHotelExpenseInfo);
				//伙食费
				List<FoodAllowanceInfo> listFoodAllowanceInfo = foodAllowanceInfoMng.findbygId(bean.getgId(),bean.getTravelType());
				model.addAttribute("listFoodAllowanceInfo", listFoodAllowanceInfo);
				//公杂费
				List<Object> listMiscellaneousFeeInfo = applyMng.getObjectList("MiscellaneousFeeInfo", "gId", id);
				model.addAttribute("listMiscellaneousFeeInfo", listMiscellaneousFeeInfo);
				//宴请费用
				List<FeteCostInfo> listFeteCostInfo = feteCostInfoMng.findbygId(id);
				model.addAttribute("listFeteCostInfo", listFeteCostInfo);
				//其他费用
				List<Object> listReceptionOther = applyMng.getObjectList("ReceptionOther", "gId", id);
				model.addAttribute("listReceptionOther", listReceptionOther);
			}
			model.addAttribute("bean", bean);
			/*if(!"1".equals(type)){*/
			//转换type选择流程
			strType = tProcessCheckMng.JudgmentProcess(String.valueOf(type));
			if("GWCX".equals(bean.getTravelType())){
				strType = "GWCXSQ";
			}
			if(type.equals("5")&&receptionBean!=null){
				if("2".equals(receptionBean.getReceptionLevel1())){
					if(receptionBean.getIsForeign().equals("1")){
						strType = "GWJDSQ-WB";
					}else{
						strType = "GWJDSQ-YJYX";
					}
				}
			}
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes(strType,bean.getDept(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
//			//审签信息
//			List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("ApplicationBasicInfo", "gId", bean.getgId());
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			/*}*/
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());	
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("事前申请");
			model.addAttribute("cheterInfo", cheterInfo);
			
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(type.equals("5")){
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("部门负责人")){//报销人是否为部门负责人若是则添加一条数据
					model.addAttribute("role1", bean.getUserNames());
				}
				if("1".equals(receptionBean.getReceptionLevel1())){
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}


						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}else{
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}
			}else{
				Calendar c = Calendar.getInstance();
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					model.addAttribute("proHead", pro.getFProHead());
					c.setTime(checkList.get(0).getFcheckTime());
					model.addAttribute("proHeadYear",c.get(Calendar.YEAR));
					model.addAttribute("proHeadMonth",c.get(Calendar.MONTH)+1);
					model.addAttribute("proHeadDay",c.get(Calendar.DAY_OF_MONTH));
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("部门负责人")){//报销人是否为部门负责人若是则添加一条数据
					model.addAttribute("role1", bean.getUserNames());
					c.setTime(bean.getReqTime());
					model.addAttribute("roleYear1",c.get(Calendar.YEAR));
					model.addAttribute("roleMonth1",c.get(Calendar.MONTH)+1);
					model.addAttribute("roleDay1",c.get(Calendar.DAY_OF_MONTH));
					for (int i = checkList.size()-1; i >= 0; i--) {
						model.addAttribute("role"+(i+2), checkList.get(i).getFuserName());
						c.setTime(checkList.get(i).getFcheckTime());
						model.addAttribute("roleYear"+(i+2),c.get(Calendar.YEAR));
						model.addAttribute("roleMonth"+(i+2),c.get(Calendar.MONTH)+1);
						model.addAttribute("roleDay"+(i+2),c.get(Calendar.DAY_OF_MONTH));
						model.addAttribute("date"+(i+2), fmt.format(checkList.get(i).getFcheckTime()));
					}
				}else{
					int count = 1;
					if(type.equals("1")){
						checkList.remove(0);
					}
					for (int i = checkList.size()-1; i >= 0; i--) {
							model.addAttribute("role"+count, checkList.get(count-1).getFuserName());
							model.addAttribute("date"+count, fmt.format(checkList.get(count-1).getFcheckTime()));
							c.setTime(checkList.get(count-1).getFcheckTime());
							model.addAttribute("roleYear"+count,c.get(Calendar.YEAR));
							model.addAttribute("roleMonth"+count,c.get(Calendar.MONTH)+1);
							model.addAttribute("roleDay"+count,c.get(Calendar.DAY_OF_MONTH));
							count++;
					}
				}
				
				//判断是否显示部门主管领导意见
				Depart depart = user.getDepart();
				if (depart != null) {
					User manager =  depart.getManager();
					if (manager != null && manager.getId().equals(getUser().getId())) {//当前用户是申报部门部门主管校长
						model.addAttribute("showSuggestCap", true);
					}
				}
			}
			
			model.addAttribute("id", id);
			if(type.equals("2")){
				return "/WEB-INF/view/expend/export/apply/meeting";
			}else if(type.equals("3")){
				return "/WEB-INF/view/expend/export/apply/train";
			}else if(type.equals("4")){
//				if("GWCX".equals(bean.getTravelType())){//公务出行
//					return "/WEB-INF/view/expend/export/apply/travelcx";
//				}else{//出差
					return "/WEB-INF/view/expend/export/apply/travel";
//				}
			}else if(type.equals("5")){
				return "/WEB-INF/view/expend/export/apply/reception";
			}else if(type.equals("6")){
				return "/WEB-INF/view/expend/apply/add/apply_add_car";
			}else if(type.equals("7")){
				return "/WEB-INF/view/expend/export/apply/abroad";
			}else{
				return "/WEB-INF/view/expend/export/apply/common";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 支出报销打印
	 * @param id 报销主键id
	 * @param model
	 * @param editType
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月2日
	 * @updator 陈睿超
	 * @updatetime 2020年6月2日
	 */
	@RequestMapping("/reimburseExprot")
	public String edit(Integer id, ModelMap model ,String editType) {
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			//传回来的id是主键
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			//判断申请类型
			String type = bean.getType();
			TProBasicInfo pro =new TProBasicInfo();
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getReimburseReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			if("4".equals(type)){
				BudgetMessageList budgetMessageList = new BudgetMessageList();
				budgetMessageList.setgId(bean.getrId());
				//查询
				List<BudgetMessageList> budgetMessageLists = applyMng.getBudgetMessageList(budgetMessageList,getUser());
				for (BudgetMessageList messageList : budgetMessageLists) {
					if(!"".equals(messageList.getfCostClassifyShow())){
						if("1".equals(budgetMessageList.getfIndexType())){
							budgetMessageList = messageList;
							break;
						}else{
							budgetMessageList = messageList;
						}
					}
				}

				TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(budgetMessageList.getfIndexId());
				pro = projectMng.findById(budgetIndexMgr.getFProId());
			}else{
				TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
				pro = projectMng.findById(expendDetail.getFProId());
			}
			
			bean.setProDetailName(pro.getFProName()+"("+pro.getFProCode()+")");
			bean.setProCharger(pro.getFProHead());
			//获取报销人信息
			User user = userMng.findById(bean.getUser());
			
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			//查询四级指标信息
			ApplicationBasicInfo apply = applyMng.findByCode(bean.getgCode());
			model.addAttribute("applyBean", apply);
			model.addAttribute("pro", pro);
			//收款人信息
//			List<ReimbPayeeInfo> reimbPayeeInfolist = reimbPayeeMng.getByRId(bean.getrId());
//			model.addAttribute("reimbPayeeInfolist", reimbPayeeInfolist);
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
				}else if(indexId != null){
					TBudgetIndexMgr index = indexMng.findById(indexId);
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
			}
			bean.setIndexName(apply.getIndexName());
			//查询附件信息
			List<Attachment> attaList = attachmentMng.list(apply);
			model.addAttribute("attaList", attaList);
			List<Attachment> attaList1 = attachmentMng.list(bean);
			model.addAttribute("attaList1", attaList1);
			String reimburseType = apply.getType();
			//转换type选择流程
			String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(reimburseType));
			if("GWCX".equals(bean.getTravelType())){
				strType = "GWCXBX";
			}
			if(bean.getType().equals("5")){
				ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				if(receptionBeans.getReceptionLevel1().equals("2")){
					if(receptionBeans.getIsForeign().equals("1")){
						strType = "GWJDBX-WB";
					}else{
						strType = "GWJDBX-YJYX";
					}
				}
			}
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编号
			model.addAttribute("foCode",bean.getBeanCode());
			//查询相应的申请基本信息
			ApplicationBasicInfo abi = applicationBasicInfoMng.getByGCode(bean.getgCode());
//			List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("ReimbAppliBasicInfo", "rId", bean.getrId());
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			
			
			/*//以下几行是获取事前申请的工作流
			String strTypeApply = tProcessCheckMng.JudgmentProcess(String.valueOf(reimburseType));
			if("GWCX".equals(bean.getTravelType())){
				strTypeApply = "GWCXSQ";
			}
			//得到工作流id
			TProcessDefin tProcessDefinApply=tProcessDefinMng.getByBusiAndDpcode(strTypeApply, bean.getDept());
			model.addAttribute("fpIdAplly", tProcessDefinApply.getFPId());
			//对象编号
			model.addAttribute("foCodeAplly",bean.getBeanCode());*/
			
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("申请报销");
			model.addAttribute("cheterInfo", cheterInfo);
			
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(type.equals("5")){
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("部门负责人")){//报销人是否为部门负责人若是则添加一条数据
					model.addAttribute("role1", apply.getUserNames());
				}
				ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				if("1".equals(receptionBeans.getReceptionLevel1())){
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}


						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}else{
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}
			}else{
				List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
				if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
					model.addAttribute("proHead", pro.getFProHead());
					checkList.remove(0);
				}

				User beauser = userMng.findById(bean.getUser());
				int checkNum =1;
				for (int i = checkList.size()-1; i >= 0; i--) {
					User checkuser = userMng.findById(checkList.get(i).getFuserId());
					if("32".equals(checkuser.getDpID())&&checkNum<=3){
						financeList.add(checkList.get(i));
						checkNum++;
						checkList.remove(i);
					}
				}
				if(beauser.getRoleName().contains("部门负责人")){//报销人是否为部门负责人若是则添加一条数据
					model.addAttribute("role1", beauser.getName());
					for (int i = checkList.size()-1; i >= 0; i--) {
						model.addAttribute("role"+(i+2), checkList.get(i).getFuserName());


					}
				}else {
					for (int i = checkList.size()-1; i >= 0; i--) {
						model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
					}
				}

				String financeCheck = new String();
				for (int i = 0; i < financeList.size(); i++) {
					financeCheck+=financeList.get(i).getFuserName()+",";
				}
				if(financeList.size()>0){
					model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
				}
			}
			//查询费用明细
			List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
			//收款人信息
			List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
			for (int i = 0; i < listPayee.size(); i++) {
				listPayee.get(i).setNum(i + 1);
			}
			model.addAttribute("listPayee", listPayee);
			model.addAttribute("id", id);

			if(type.equals("1")){
				//通用明细
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "rId", id);
				//List<ReimbDetail> mingxiList = reimbDetailMng.getMingxi(id);
				model.addAttribute("mingxiList", mingxiList);
				String payeeName = new String();
				String paymentType = new String();
				for (int i = 0; i < listPayee.size(); i++) {
					payeeName = payeeName + listPayee.get(i).getPayeeName()+",";
					if(!paymentType.contains(listPayee.get(i).getPaymentType())){
						paymentType = paymentType + listPayee.get(i).getPaymentType() + "/";
					}
				}
				model.addAttribute("payeeName", payeeName.subSequence(0, payeeName.length()-1));
				model.addAttribute("paymentType", paymentType.subSequence(0, paymentType.length()-1));


				/*List<TProcessCheck> listTProcessChecksTY = new ArrayList<TProcessCheck>();
				List<TProcessCheck> listTProcessCheck = tProcessCheckMng.checkHistory(10001,bean.getrCode());
				int num =listTProcessCheck.size();
				for (TProcessCheck tProcessCheck : listTProcessCheck) {
					if("0".equals(tProcessCheck.getFcheckResult())){
						break;
					}else{
						User user2 = userMng.findById(tProcessCheck.getFuserId());
						tProcessCheck.setCheckDeptName(user2.getDepart().getName());
						DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
						String time =fmt.format(tProcessCheck.getFcheckTime());     // 转换成 X年X月X日
						tProcessCheck.setFcheckTimes(time);
						String StringNum = MatheUtil.ToCH(num);
						tProcessCheck.setFroleName("第"+StringNum+"审核人");
						listTProcessChecksTY.add(tProcessCheck);
						num-=1;
					}
				}
				Collections.reverse(listTProcessChecksTY); // 倒序排列 
				model.addAttribute("listTProcessChecksTY", listTProcessChecksTY);*/
			} else if(type.equals("2")) {
				//查询会议信息
				MeetingAppliInfo meetingBeanApply = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", apply.getgId());
				model.addAttribute("meetingBeanApply", meetingBeanApply);
				MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "rId", id);
				model.addAttribute("meetingBean", meetingBean);
				//会议日程
				List<Object> listMeetingPlan = applyMng.getObjectList("MeetingPlan", "rId", id);
				model.addAttribute("listMeetingPlan", listMeetingPlan);
				
				//费用明细
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "rId", id);
				model.addAttribute("mingxiList", mingxiList);
				
				String startTime =fmt.format(meetingBean.getDateStart());
			    String endTime =fmt.format(meetingBean.getDateEnd());
			    model.addAttribute("reimbStartTime", startTime);
			    model.addAttribute("reimbEndTime", endTime);
			    int day = DateUtil.getDaySpan(meetingBean.getDateStart(), meetingBean.getDateEnd());
			    model.addAttribute("reimbDay", day + 1);
			} else if(type.equals("3")) {
				//查询事前培训信息
				TrainingAppliInfo trainingBeanApply = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", apply.getgId());
				model.addAttribute("trainingBeanApply", trainingBeanApply);
				
				//查询报销培训信息
				TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", id);
				model.addAttribute("trainingBean", trainingBean);
				
				
				int day = DateUtil.getDaySpan(trainingBean.getTrDateStart(), trainingBean.getTrDateEnd());
				model.addAttribute("day", day);
				//讲师信息
				List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
				model.addAttribute("listLecturer", listLecturer);
				//培训日程
				List<Object> listMeetPlan = applyMng.getObjectList("MeetPlan", "tId", trainingBean.gettId());
				model.addAttribute("listMeetPlan", listMeetPlan);
				//综合预算
				List<Object> listZongHe = applyMng.getMingxi("ApplicationDetail", "rId", id);
				model.addAttribute("listZongHe", listZongHe);
				//师资费—讲课费
				List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
				model.addAttribute("listTeacherCost", listTeacherCost);
				//师资费—住宿费
				List<TrainTeacherCost> listHotel = applyMng.getTeacherMingxi(trainingBean.gettId(), "hotel");
				model.addAttribute("listHotel", listHotel);
				//师资费—伙食费
				List<TrainTeacherCost> listFood = applyMng.getTeacherMingxi(trainingBean.gettId(), "food");
				model.addAttribute("listFood", listFood);
				//师资费—城市间交通费
				List<TrainTeacherCost> listTraffic1 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic1");
				model.addAttribute("listTraffic1", listTraffic1);
				//师资费—市内交通费
				List<TrainTeacherCost> listTraffic2 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic2");
				model.addAttribute("listTraffic2", listTraffic2);	
				BigDecimal listTraffic2reimburseSum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic2.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic2.get(i);
					listTraffic2reimburseSum=listTraffic2reimburseSum.add(trainTeacherCost.getReimbSum());
				}
				model.addAttribute("listTraffic2reimburseSum", listTraffic2reimburseSum);
				
			} else if(type.equals("4")) {
				//查询差旅信息
				TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "rId", id);
				model.addAttribute("travelBean", travelBean);
				
				TravelAppliInfo travelBeanApply = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", apply.getgId());
				model.addAttribute("travelBeanApply", travelBeanApply);
				//行程
				Pagination p = travelAppliInfoMng.rtravelPageList(1, 100, travelBean);
				List<TravelAppliInfo> Travellist = (List<TravelAppliInfo>) p.getList();
				//城市间交通费
				if(!"GWCX".equals(bean.getTravelType())){
					OutsideTrafficInfo outsidebean = new OutsideTrafficInfo();
					outsidebean.setrId(id);
					Pagination outsidep = outsideTrafficInfoMng.routsideTrafficInfoPageList(1, 100, outsidebean);
					List<OutsideTrafficInfo> outsidelist = (List<OutsideTrafficInfo>) outsidep.getList();
					model.addAttribute("outsidelist", outsidelist);
				}
				
				//获取学生信息，把学生信息加到出行人员中去
				if("GWCC".equals(bean.getTravelType())){//公务出差
					for (int i = Travellist.size()-1; i >= 0; i--) {
						String[] peopId =  Travellist.get(i).getTravelAttendPeopId().split(",");

						//多选的情况下循环出来人员信息添加到里面
						for (int j = 0; j < peopId.length; j++) {
							TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
							User peop = userMng.findById(peopId[j]);
							travelAppliInfo.setTravelAttendPeop(peop.getName());
							travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
							String roleslevel = new String();
							switch (peop.getRoleslevel()) {//1：市级，2：局级，3：其他人员
							case 1:
								roleslevel ="市级";
								break;
							case 2:
								roleslevel ="局级";
								break;
							case 3:
								roleslevel ="其他人员";
								break;
							}
							travelAppliInfo.setTravelPersonnelLevel(roleslevel);
							travelAppliInfo.setfTel(peop.getTelNo());
							Travellist.add(travelAppliInfo);
						}
						//先删除这一条数据，再从新添加
						Travellist.remove(i);
					}
				}
				
				StudentsList stl = new StudentsList();
				stl.setgId(id);
				List<StudentsList> studentsList = (List<StudentsList>) travelAppliInfoMng.studentsPageList(1, 10000, stl).getList();
				for (int i = 0; i < studentsList.size(); i++) {
					TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
					travelAppliInfo.setTravelAttendPeop(studentsList.get(i).getfName());
					travelAppliInfo.setfIdentityNumber(studentsList.get(i).getfIdentityNumber());
					travelAppliInfo.setTravelPersonnelLevel("学生");
					travelAppliInfo.setfTel(studentsList.get(i).getfTel());
					Travellist.add(travelAppliInfo);
				}
				//获取目的地
				String travelAreaName = new String();
				String travelAttendPeop = new String();
				for (int i = 0; i < Travellist.size(); i++) {
					travelAreaName = travelAreaName + Travellist.get(i).getTravelAreaName() + ",";
					travelAttendPeop = travelAttendPeop + Travellist.get(i).getTravelAttendPeop() + ",";
				}
				//目的地
				model.addAttribute("travelAreaName", travelAreaName.subSequence(0, travelAreaName.length()-1));
				//出行人数
				model.addAttribute("travelpepolnumber", Travellist.size()-1);
				//出行人员
				model.addAttribute("travelpepol", travelAttendPeop);
				model.addAttribute("travellist", Travellist);

				//市内交通费
				InCityTrafficInfo InCitybean = (InCityTrafficInfo) applyMng.getObject("InCityTrafficInfo", "rId", id);
				Pagination InCitybeanp = inCityTrafficInfoMng.rinCityInfoPageList(1, 100, InCitybean);
				List<InCityTrafficInfo> inCitylist = (List<InCityTrafficInfo>) InCitybeanp.getList();
				model.addAttribute("inCitylist", inCitylist);
				//住宿费
				List<HotelExpenseInfo> hotellist = hotelExpenseInfoMng.rfindbygId(bean.getrId(),null);
				model.addAttribute("hotellist", hotellist);
				//伙食补助
				List<FoodAllowanceInfo> foodlist = foodAllowanceInfoMng.rfindbygId(bean.getrId(),null);
				model.addAttribute("foodlist", foodlist);
				//会务、培训费
				ReceptionOther receptionOther = new ReceptionOther();
				receptionOther.setrId(id);
				List<ReceptionOther> receptionOtherlist = applyMng.getReceptionOther(receptionOther,getUser());
				model.addAttribute("receptionOtherlist", receptionOtherlist);
				
			} else if(type.equals("5")) {
				//查询接待信息
				ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				model.addAttribute("receptionBean", receptionBean);
				
				ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				model.addAttribute("receptionBeanEdit", receptionBeans);
				//接待人员名单
				List<Object> listPeople = applyMng.getObjectList("ReceptionPeopleInfo", "jId", receptionBeans.getjId());
				model.addAttribute("listPeople", listPeople);
				//住宿
				List<Object> listHotel = applyMng.getObjectList("ReceptionHotel", "rId", bean.getrId());
				if(listHotel!=null&&listHotel.size()>0){
					for (int i = 0; i < listHotel.size(); i++) {
						ReceptionHotel hotel =(ReceptionHotel) listHotel.get(i);
						String[] person =hotel.getfName().split(",");
						int num =person.length;
						hotel.setPersonNum(num);
					}
				}
				model.addAttribute("listHotel", listHotel);
				//餐费
				List<Object> listFood = applyMng.getObjectList("ReceptionFood", "rId", bean.getrId());
				model.addAttribute("listFood", listFood);
				//其他费用
				List<Object> listOther = applyMng.getObjectList("ReceptionOther", "rId", bean.getrId());
				model.addAttribute("listOther", listOther);
				//陪同人员名单
				List<Object> listAccompany = applyMng.getObjectList("AccompanyPeopleInfo", "jId", receptionBeans.getjId());
				model.addAttribute("listAccompany", listAccompany);
				
			} else if(type.equals("6")) {
				//查询公务用车信息
				OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", abi.getgId());
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
			} else if(type.equals("7")) {
				
				//查询公务出国信息
				AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId",  bean.getrId());
				model.addAttribute("abroad", abroadBean);
				//查询培训信息
				AbroadAppliInfo abroadEdit = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId", bean.getrId());
				model.addAttribute("abroadEdit", abroadEdit);
				//出国人员
				String abroadPeopleName = "";
				List<Object> peopleList =applyMng.getObjectList("AbroadAppliPepoleInfo", "aId", abroadEdit.getFaId());
			/*	if (!StringUtil.isEmpty(abroadEdit.getfAbroadPeople())) {
					String[] abroadPeople = abroadEdit.getfAbroadPeople().split(",");
					for (String userId : abroadPeople) {
						User u = userMng.findById(userId);
						abroadPeopleName = abroadPeopleName + u.getName() + "、";
					}
				}*/
				for (Object object : peopleList) {
					AbroadAppliPepoleInfo abroad =(AbroadAppliPepoleInfo) object;
					abroadPeopleName = abroadPeopleName + abroad.getTravelPeopName()+ "、";
				}
				if (!StringUtil.isEmpty(abroadPeopleName)) {
					abroadPeopleName = abroadPeopleName.substring(0, abroadPeopleName.length() - 1);
				}
				model.addAttribute("abroadPeopleName", abroadPeopleName);
				
				
				List<Object> abroadPlanlist = applyMng.getObjectList("AbroadPlan", "rId", bean.getrId());
				model.addAttribute("abroadPlanlist", abroadPlanlist);
				String arriveCountry = new String();
				String arrivePlan = new String();
				Set arriveCountrySet = new HashSet();
				for (int i = 0; i < abroadPlanlist.size(); i++) {
					AbroadPlan abroadPlan = (AbroadPlan) abroadPlanlist.get(i);
					arriveCountrySet.add(abroadPlan.getArriveCountry());
					//arriveCountry = arriveCountry + abroadPlan.getArriveCountry() + ",";
					arrivePlan = arrivePlan + DateUtil.formatDate(abroadPlan.getAbroadDate())+" "+
						DateUtil.formatDate(abroadPlan.getTimeEnd())+" "+abroadPlan.getArriveCountry()+" "+
						abroadPlan.getArriveCity()+"</br>";
				}
				for (Object object : arriveCountrySet) {
					arriveCountry = arriveCountry + object + ",";
				}
				bean.setArriveCountry(arriveCountry.substring(0, arriveCountry.length()-1));//设置出访国家
				bean.setArrivePlan(arrivePlan);//出访计划
				
				List<InternationalTravelingExpense> expenselist = internationalTravelingExpenseInfoMng.rfindbygId(bean.getrId());
				//飞机票
				BigDecimal airplaneAmount = BigDecimal.ZERO;
				String airplaneStartAndEnd = "";
				//火车票
				BigDecimal trainAmount = BigDecimal.ZERO;
				String trainStartAndEnd = "";
				//轮船票
				BigDecimal shipAmount = BigDecimal.ZERO;
				String shipStartAndEnd = "";
				for (InternationalTravelingExpense expense : expenselist) {
					Vehicle vehicle = vehicleMng.findByCode(expense.getVehicle()).get(0);
					expense.setVehicleText(vehicle.getName());
					//飞机
					if (vehicle.getName().contains("飞机")) {
						if (expense.getApplyAmount() != null) {
							airplaneAmount = airplaneAmount.add(expense.getApplyAmount());
						}
						airplaneStartAndEnd = airplaneStartAndEnd + expense.getStartCity() + "-" + expense.getArriveCity() + ",";
					}
					//火车
					if (vehicle.getName().contains("火车")) {
						if (expense.getApplyAmount() != null) {
							trainAmount = trainAmount.add(expense.getApplyAmount());
						}
						trainStartAndEnd = trainStartAndEnd + expense.getStartCity() + "-" + expense.getArriveCity() + ",";
					}
					//轮船
					if (vehicle.getName().contains("轮船")) {
						if (expense.getApplyAmount() != null) {
							shipAmount = shipAmount.add(expense.getApplyAmount());
						}
						shipStartAndEnd = shipStartAndEnd + expense.getStartCity() + "-" + expense.getArriveCity() + ",";
					}
				}
				if (airplaneStartAndEnd != "") {
					airplaneStartAndEnd = airplaneStartAndEnd.substring(0, airplaneStartAndEnd.length() - 1);
				}
				if (trainStartAndEnd != "") {
					trainStartAndEnd = trainStartAndEnd.substring(0, trainStartAndEnd.length() - 1);
				}
				if (shipStartAndEnd != "") {
					shipStartAndEnd = shipStartAndEnd.substring(0, shipStartAndEnd.length() - 1);
				}
				model.addAttribute("airplaneAmount", airplaneAmount);
				model.addAttribute("airplaneStartAndEnd", airplaneStartAndEnd);
				model.addAttribute("trainAmount", trainAmount);
				model.addAttribute("trainStartAndEnd", trainStartAndEnd);
				model.addAttribute("shipAmount", shipAmount);
				model.addAttribute("shipStartAndEnd", shipStartAndEnd);
				
				model.addAttribute("expenselist", expenselist);
				
				//获取国外城市间交通费
				List<Object> listOutsideTrafficInfo = applyMng.getObjectList("OutsideTrafficInfo", "rId", bean.getrId());
				BigDecimal outsideTrafficAmount = BigDecimal.ZERO;
				for (int i = 0; i < listOutsideTrafficInfo.size(); i++) {
					OutsideTrafficInfo o = (OutsideTrafficInfo) listOutsideTrafficInfo.get(i);
					if (o.getApplyAmount() != null) {
						outsideTrafficAmount = outsideTrafficAmount.add(o.getApplyAmount());
					}
				}
				model.addAttribute("outsideTrafficAmount", outsideTrafficAmount);
				model.addAttribute("listOutsideTrafficInfo", listOutsideTrafficInfo);
				
				//住宿费
				List<HotelExpenseInfo> listHotelExpenseInfo = hotelExpenseInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
				model.addAttribute("listHotelExpenseInfo", listHotelExpenseInfo);
				BigDecimal hotelExpenseInfoAmount = BigDecimal.ZERO;
				for (int i = 0; i < listHotelExpenseInfo.size(); i++) {
					if (listHotelExpenseInfo.get(i).getApplyAmount() != null) {
						hotelExpenseInfoAmount=hotelExpenseInfoAmount.add(listHotelExpenseInfo.get(i).getApplyAmount());
					}
				}
				model.addAttribute("hotelExpenseInfoAmount", hotelExpenseInfoAmount);
				
				//伙食费
				List<FoodAllowanceInfo> listFoodAllowanceInfo = foodAllowanceInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
				model.addAttribute("listFoodAllowanceInfo", listFoodAllowanceInfo);
				//公杂费
				List<Object> listMiscellaneousFeeInfo = applyMng.getObjectList("MiscellaneousFeeInfo", "rId",  bean.getrId());
				model.addAttribute("listMiscellaneousFeeInfo", listMiscellaneousFeeInfo);
				//宴请费用
				List<FeteCostInfo> listFeteCostInfo = feteCostInfoMng.rfindbygId(bean.getrId());
				BigDecimal feteCostAmount = BigDecimal.ZERO;
				for (FeteCostInfo feteCostInfo : listFeteCostInfo) {
					if (feteCostInfo.getfApplyAmount() != null) {
						feteCostAmount = feteCostAmount.add(feteCostInfo.getfApplyAmount());
					}
				}
				model.addAttribute("listFeteCostInfo", listFeteCostInfo);
				//其他费用
				List<Object> listReceptionOther = applyMng.getObjectList("ReceptionOther", "rId",  bean.getrId());
				BigDecimal otherAmount = BigDecimal.ZERO;
				for (int i = 0; i < listReceptionOther.size(); i++) {
					ReceptionOther receptionOther = (ReceptionOther) listReceptionOther.get(i);
					if (receptionOther.getfCost() != null) {
						otherAmount = otherAmount.add(receptionOther.getfCost());
					}
				}
				BigDecimal otherReimbAmount = feteCostAmount.add(otherAmount);
				model.addAttribute("otherReimbAmount", otherReimbAmount);
				model.addAttribute("listReceptionOther", listReceptionOther);
				//小计
				BigDecimal totalAmount = BigDecimal.ZERO;
				totalAmount = totalAmount.add(airplaneAmount);
				totalAmount = totalAmount.add(trainAmount);
				totalAmount = totalAmount.add(shipAmount);
				totalAmount = totalAmount.add(hotelExpenseInfoAmount);
				totalAmount = totalAmount.add(outsideTrafficAmount);
				totalAmount = totalAmount.add(otherReimbAmount);
				model.addAttribute("totalAmount", totalAmount);
				//启程、规程、天数、人数、标准、金额
				List<AbroadPlan> abroadPlanList = new ArrayList<AbroadPlan>();
				List<AbroadPlan> lists = new ArrayList<AbroadPlan>();
				for (int i = 0; i < abroadPlanlist.size(); i++) {
					AbroadPlan abroadPlan = (AbroadPlan) abroadPlanlist.get(i);
					lists.add(abroadPlan);
				}
				Calendar calendar = Calendar.getInstance();
				SortList<AbroadPlan> l = new SortList<>();
				l.Sort(abroadPlanList, "getTimeEndSort", "asc", "date");
				
				for (int i = 0; i < lists.size(); i++) {
					AbroadPlan abroadPlan =  lists.get(i);
					AbroadPlan ap = new AbroadPlan();
					//启程
					calendar.setTime(abroadPlan.getAbroadDate());
					int startMonth = calendar.get(Calendar.MONTH);
					int startDay = calendar.get(Calendar.DATE);
					ap.setStartMonth(startMonth);
					ap.setStartDay(startDay);
					//归程
					calendar.setTime(abroadPlan.getTimeEnd());
					int endMonth = calendar.get(Calendar.MONTH);;
					int endDay = calendar.get(Calendar.DATE);
					ap.setEndMonth(endMonth);
					ap.setEndDay(endDay);
					//天数
					int dayNum = DateUtil.getDaySpan(abroadPlan.getAbroadDate(), abroadPlan.getTimeEnd());
					
					if(i==lists.size()-1){
						ap.setDayNum(dayNum + 1);
					}else{
						ap.setDayNum(dayNum);
					}
					//人数
					ap.setPeopleNum(Integer.valueOf(abroadEdit.getfThisUnitTeamPersonNum()));
					//标准
					BigDecimal foodStdAmount = BigDecimal.ZERO;
					if (listFoodAllowanceInfo.get(i).getStandard() != null) {
						foodStdAmount = listFoodAllowanceInfo.get(i).getStandard();
					}
					MiscellaneousFeeInfo miscellaneousFeeInfo = (MiscellaneousFeeInfo)listMiscellaneousFeeInfo.get(i);
					BigDecimal feeStdAmount = BigDecimal.ZERO;
					if (miscellaneousFeeInfo.getStandard() != null) {
						feeStdAmount = miscellaneousFeeInfo.getStandard();
					}
					BigDecimal foodAndFeeStdAmount = foodStdAmount.add(feeStdAmount);
					String currency = listFoodAllowanceInfo.get(i).getCurrency();
					String foodAndFeeStdAmountStr = foodAndFeeStdAmount + "（" + currency + "）";
					ap.setStandardAmount(foodAndFeeStdAmountStr);
					//金额
					BigDecimal foodReimbAmount = BigDecimal.ZERO;
					if (listFoodAllowanceInfo.get(i).getfApplyAmount() != null) {
						foodReimbAmount = listFoodAllowanceInfo.get(i).getfApplyAmount();
					}
					BigDecimal feeReimbAmount = BigDecimal.ZERO;
					if (miscellaneousFeeInfo.getfApplyAmount() != null) {
						feeReimbAmount = miscellaneousFeeInfo.getfApplyAmount();
					}
					BigDecimal foodAndFeeReimbAmount = foodReimbAmount.add(feeReimbAmount);
					ap.setReimbAmount(foodAndFeeReimbAmount);
					abroadPlanList.add(ap);
				}
				model.addAttribute("abroadPlanList", abroadPlanList);
			}
			if(type.equals("1")){
				return "/WEB-INF/view/expend/export/reimburse/common";
			}else if(type.equals("2")){
				return "/WEB-INF/view/expend/export/reimburse/meeting";
			}else if(type.equals("3")){
				return "/WEB-INF/view/expend/export/reimburse/train";
			}else if(type.equals("4")){
				if("GWCX".equals(apply.getTravelType())){//公务出行
					return "/WEB-INF/view/expend/export/reimburse/travelcx";
				}else{
					return "/WEB-INF/view/expend/export/reimburse/travel";
				}
			}else if(type.equals("5")){
				return "/WEB-INF/view/expend/export/reimburse/reception";
			}else if(type.equals("6")){
				model.addAttribute("type", "detail");
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_car_detail";
			}else if(type.equals("7")){
				return "/WEB-INF/view/expend/export/reimburse/abroad";
			}else 
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_detail";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 借款单打印
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月6日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/loanyExprot")
	public String loanyExprot(Integer id ,ModelMap model){
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			LoanBasicInfo bean = loanMng.findById(id);
			User user = userMng.findById(bean.getUserId());
			bean.setUserName(user.getName());
			bean.setDxLamount(MoneyUtil.toChinese(String.valueOf(bean.getlAmount())));
			model.addAttribute("bean", bean);
			//收款人信息
			LoanPayeeInfo payeeBean = loanPayeeMng.findBylId(bean.getlId()).get(0);
			List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(bean.getUserId());
			model.addAttribute("payerinfoList", infoList);
			model.addAttribute("payee", payeeBean);
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"JKSQ",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getlCode(),"1");
			
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", bean.getDept());
			
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
				User checkuser = userMng.findById(checkList.get(i).getFbyUserId());
				if(i>(checkList.size()-4)&&"32".equals(checkuser.getDpID())){
					financeList.add(checkList.get(i));
				}
			}
			String financeCheck = new String();
			for (int i = 0; i < financeList.size(); i++) {
				financeCheck+=financeList.get(i).getFuserName()+",";
			}
			if(financeList.size()>0){
				model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
			}

			return "/WEB-INF/view/expend/export/loan/loan";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 还款打印
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月6日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("paymentExprot")
	public String paymentExprot(Integer id ,ModelMap model){
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			Payment bean =  paymentMng.findByLId(Integer.valueOf(id));
			model.addAttribute("id", id);
			model.addAttribute("bean", bean);
			LoanBasicInfo loan=loanMng.findById(Integer.valueOf(bean.getlId()));
			model.addAttribute("loan", loan);
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			List<DirectlyReimbAppliBasicInfo> directlyList = directlyReimbMng.findByLoanId(String.valueOf(id));
			List<ReimbAppliBasicInfo> applyReimbList =reimbAppliMng.findByLoanId(String.valueOf(id));
			List<ReimCXInfo> reimbList = new ArrayList<ReimCXInfo>();
			BigDecimal totalCxAmount =BigDecimal.ZERO;
			if(applyReimbList !=null && applyReimbList.size()>0){
				for(int i = 0;i < applyReimbList.size();i++){
					if(applyReimbList.get(i).getCxAmount() !=null){
						totalCxAmount =applyReimbList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(applyReimbList.get(i).getrId());
					info.setgName(applyReimbList.get(i).getgName());
					info.setType(1);
					info.setCxAmount(applyReimbList.get(i).getCxAmount());
					info.setReimburseReqTime(applyReimbList.get(i).getReimburseReqTime());
					reimbList.add(info);
				}
			}
			if(directlyList !=null && directlyList.size()>0){
				for(int i = 0;i < directlyList.size();i++){
					if(directlyList.get(i).getCxAmount() !=null){
						totalCxAmount =directlyList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(directlyList.get(i).getDrId());
					info.setgName(directlyList.get(i).getSummary());
					info.setType(0);
					info.setCxAmount(directlyList.get(i).getCxAmount());
					info.setReimburseReqTime(directlyList.get(i).getReqTime());
					reimbList.add(info);
				}
			}
			int a = 0;
			int b = 0;
			if(applyReimbList.isEmpty()){
				a =0;
			}else{
				a=applyReimbList.size();
			}
			if(directlyList.isEmpty()){
				b=0;
			}else{
				b=directlyList.size();
			}
			model.addAttribute("cxNum",  a+b);
			model.addAttribute("totalCxAmount", totalCxAmount);
			User user = userMng.findById(bean.getUserId());
			
//			List<TProcessPrintDetail> listTProcessChecks  = tProcessPrintDetailMng.findbytab("Payment", "id",Integer.valueOf(bean.getId()));
//			for (TProcessPrintDetail check : listTProcessChecks) {
//				if(check.getFcheckTime() !=null){
//					DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
//					String time =fmt.format(check.getFcheckTime());     // 转换成 X年X月X日
//					check.setFcheckTimes(time);
//				}
//			}
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HKDJ",bean.getApplyDepId(),bean.getBeanCode(),bean.getNextNodeCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getCode(),"1");
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HKDJ", bean.getApplyDepId());
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
				User checkuser = userMng.findById(checkList.get(i).getFbyUserId());
				if(i>(checkList.size()-4)&&"32".equals(checkuser.getDpID())){
					financeList.add(checkList.get(i));
				}
			}
			String financeCheck = new String();
			for (int i = 0; i < financeList.size(); i++) {
				financeCheck+=financeList.get(i).getFuserName()+",";
			}
			if(financeList.size()>0){
				model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
			}
			
			return "/WEB-INF/view/expend/export/loan/payment";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	
	/**
	 * 跳转到粘贴单
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/PastePage")
	public String pastePage(String id,ModelMap model){
//		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
//		model.addAttribute("code", bean.getrCode());
		return "/WEB-INF/view/expend/export/PastePage";
	}
	/**
	 * 跳转到直接报销粘贴单
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/PastePageDir")
	public String PastePageDir(String id,ModelMap model){
		DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(Integer.valueOf(id));
		model.addAttribute("code", bean.getDrCode());
		return "/WEB-INF/view/expend/export/PastePage";
	}
	
	/**
	 * 报销打印跳转事前申请
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月6日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/requestApply")
	public String requestApply(String id ,ModelMap model){
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		ApplicationBasicInfo abi = applicationBasicInfoMng.getByGCode(bean.getgCode());
		return "redirect:/exportApplyAndReim/applyExprot?id="+abi.getgId();
	}
	
	
	
	/**
	 * 直接报销报销打印
	 * @param id 报销主键id
	 * @param reimburseExprotDirectly
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年6月6日
	 * @updator 赵孟雷
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/reimburseExprotDirectly")
	public String reimburseExprotDirectly(Integer id, ModelMap model ,String editType) {
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8084/gxjzy_nk");
			//传回来的id是主键
			DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(id);
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);
			
			TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
			TProBasicInfo pro = projectMng.findById(expendDetail.getFProId());
			model.addAttribute("pro", pro);
			bean.setProDetailName(pro.getFProName()+"("+pro.getFProCode()+")");
			bean.setProCharger(pro.getFProHead());
			
			User user = userMng.findById(bean.getUser());
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			Lookups lookups  = lookupsMng.findByLookCode(bean.getDirType());
			bean.setDirTypeName(lookups.getName());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			//收款人信息
			List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByDrId(bean.getDrId());
			model.addAttribute("listPayee", listPayee);
			/*
			String payeeName = new String();
			String paymentType = new String();
			for (int i = 0; i < listPayee.size(); i++) {
				payeeName = payeeName + listPayee.get(i).getPayeeName()+",";
				if(!paymentType.contains(listPayee.get(i).getPaymentType())){
					paymentType = paymentType + listPayee.get(i).getPaymentType() + ",";
				}
			}
			model.addAttribute("paymentType", paymentType.subSequence(0, paymentType.length()-1));*/
			/*Lookups lookups=lookupsMng.findByLookCode(bean.getPaymentType());
			if(lookups!=null){
				model.addAttribute("paymentType", lookups.getName());
			}*/
			
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepartName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			List<TProcessPrintDetail> listTProcessChecks  = tProcessPrintDetailMng.findbytab("DirectlyReimbAppliBasicInfo", "drId", bean.getDrId());
			model.addAttribute("listTProcessChecks", listTProcessChecks);
			model.addAttribute("id", id);
			//查询费用明细
			List<DirectlyReimbDetail> listDirectly = directlyReimbDetailMng.getMingxi(id);
			model.addAttribute("listDirectly", listDirectly);
			
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				model.addAttribute("proHead", pro.getFProHead());
				checkList.remove(0);
			}
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
			}
			return "/WEB-INF/view/expend/export/reimburse/directly";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "/WEB-INF/view/expend/export/reimburse/directly";
		}
	}
	/**
	 * 报销打印跳转借款申请
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月6日
	 * @updator 陈睿超
	 * @updatetime 2020年6月6日
	 */
	@RequestMapping("/requestLoan")
	public String requestLoan(String id ,ModelMap model){
		Payment bean =  paymentMng.findByLId(Integer.valueOf(id));
		LoanBasicInfo loan=loanMng.findById(Integer.valueOf(bean.getlId()));
		return "redirect:/exportApplyAndReim/loanyExprot?id="+loan.getlId();
	}
	
	/*@RequestMapping("/contractExport")
	public String contractExport(Integer id,ModelMap model){
		try {
			//传回来的id是主键
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			//获取报销人信息
			User user = userMng.findById(bean.getUser());
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			//收款人信息
			List<ReimbPayeeInfo> reimbPayeeInfolist = reimbPayeeMng.getByRId(bean.getrId());
			model.addAttribute("listPayee", reimbPayeeInfolist);
			
			//付款计划
			ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(bean.getPayId()));
			ReceivPlan receivPlan = new ReceivPlan();
			if("1".equals(cbi.getfUpdateStatus())){//有变更
				Upt upt = uptMng.findByFContId_U(String.valueOf(cbi.getFcId())).get(0);
				if(upt.getfPlanChangeStatus()==1){
					receivPlan.setDataType(1);
					receivPlan.setfUptId_R(upt.getfId_U());
				}
			}else{//无变更
				receivPlan.setfContId_R(cbi.getFcId());
				receivPlan.setDataType(0);
			}
			List<ReceivPlan> newRP = new ArrayList<ReceivPlan>();
			String[] a = bean.getReceivplanid().split(",");
			for (int h = 0; h < a.length; h++) {
				ReceivPlan receivPlan2 = receivPlanMng.findById(Integer.valueOf(a[h]));
				newRP.add(receivPlan2);
			}
			for (int i = 0; i < newRP.size(); i++) {
				Lookups lookups=lookupsMng.findByLookCode(newRP.get(i).getfReceProof());
				newRP.get(i).setfReceProofs(lookups.getName());	
			}
			model.addAttribute("receivPlanList", newRP);
			//审签信息
			List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("ReimbAppliBasicInfo", "rId", bean.getrId());
			model.addAttribute("listTProcessChecks", listTProcessChecks);
			model.addAttribute("id", id);
			return "/WEB-INF/view/expend/export/reimburse/contract";
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "/WEB-INF/view/expend/export/reimburse/contract";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "/WEB-INF/view/expend/export/reimburse/contract";
		}
	}*/
	
	
	@RequestMapping(value="/currentExprot")
	public String currentExprot(Integer id, ModelMap model){
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			//传回来的id是主键
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
			String time =fmt.format(bean.getReimburseReqTime());     // 转换成 X年X月X日
			model.addAttribute("time",time);	
			//获取报销人信息
			User user = userMng.findById(bean.getUser());
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			
			//查询费用明细
			List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
			
			List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
			model.addAttribute("listPayee", listPayee);
			//通用明细
			List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "rId", id);
			model.addAttribute("mingxiList", mingxiList);
			String payeeName = "";
			String paymentType = "";
			for (int i = 0; i < listPayee.size(); i++) {
				payeeName = payeeName + listPayee.get(i).getPayeeName()+",";
				if(!paymentType.contains(listPayee.get(i).getPaymentType())){
					paymentType = paymentType + listPayee.get(i).getPaymentType() + ",";
				}
			}
			if("".equals(payeeName)){
				model.addAttribute("payeeName", "");
			}else{
				model.addAttribute("payeeName", payeeName.subSequence(0, payeeName.length()-1));
			}
			if("".equals(paymentType)){
				model.addAttribute("paymentType", "");
			}else{
				model.addAttribute("paymentType", paymentType.subSequence(0, paymentType.length()-1));
			}
			//转换type选择流程
			String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(9));
			if("GWCX".equals(bean.getTravelType())){
				strType = "GWCXBX";
			}
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			
			//审批记录
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
			for (int i = checkList.size()-1; i >= 0; i--) {
				model.addAttribute("role"+(i+1), checkList.get(i).getFuserName());
				model.addAttribute("date"+(i+1), fmt.format(checkList.get(i).getFcheckTime()));
				User checkuser = userMng.findById(checkList.get(i).getFbyUserId());
				if(i>(checkList.size()-4)&&"32".equals(checkuser.getDpID())){
					financeList.add(checkList.get(i));
				}
			}
			String financeCheck = new String();
			for (int i = 0; i < financeList.size(); i++) {
				financeCheck+=financeList.get(i).getFuserName()+",";
			}
			if(financeList.size()>0){
				model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
			}
			
			return "/WEB-INF/view/expend/export/reimburse/current";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/expend/export/reimburse/current";
		}
	}
	
	
	/**
	 * 
	 * <p>Title: laborfee</p>  
	 * <p>Description: 跳转到劳务费发放明细表</p>  
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月19日
	 * @updator 陈睿超
	 * @updatetime 2020年11月19日
	 */
	@RequestMapping(value="/laborfee")
	public String laborfee(Integer id, ModelMap model){
		
		model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
		//传回来的id是主键
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
		String time =fmt.format(bean.getReimburseReqTime());     // 转换成 X年X月X日
		model.addAttribute("time",time);		
		model.addAttribute("bean", bean);
		
		//查询报销培训信息
		TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", id);
		model.addAttribute("trainingBean", trainingBean);
		
		//讲师信息
		List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
		
		//师资费—讲课费
		List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
		model.addAttribute("listTeacherCost", listTeacherCost);
		BigDecimal netAmount = BigDecimal.ZERO;
		BigDecimal fIndividualIncomeTax = BigDecimal.ZERO;
		BigDecimal amountpayable = BigDecimal.ZERO;
		for (int i = 0; i < listLecturer.size(); i++) {
			LecturerInfo lLInfo= (LecturerInfo) listLecturer.get(i);
			for (int j = 0; j < listTeacherCost.size(); j++) {
				TrainTeacherCost lTeacherCost= listTeacherCost.get(j);
				//如果名字相等
				if(lLInfo.getLecturerName().equals(lTeacherCost.getLecturerName())){
					lLInfo.setAmountpayable(lTeacherCost.getfIndividualIncomeTax().add(lTeacherCost.getfNetAmount()));
					lLInfo.setfNetAmount(lTeacherCost.getfNetAmount());
					lLInfo.setfIndividualIncomeTax(lTeacherCost.getfIndividualIncomeTax());
					lLInfo.setRealityLessonStd(BigDecimal.valueOf(Double.valueOf(lTeacherCost.getRealityLessonStd())));
					lLInfo.setLessonTime(lTeacherCost.getLessonTime());
					netAmount = netAmount.add(lTeacherCost.getfNetAmount());
					fIndividualIncomeTax = fIndividualIncomeTax.add(lTeacherCost.getfIndividualIncomeTax());
					amountpayable = amountpayable.add(lTeacherCost.getfIndividualIncomeTax()).add(lTeacherCost.getfNetAmount());
				}
			}
		}
		
		model.addAttribute("netAmount", netAmount);
		model.addAttribute("fIndividualIncomeTax", fIndividualIncomeTax);
		model.addAttribute("amountpayable", amountpayable);
		model.addAttribute("listLecturer", listLecturer);
		
		return "/WEB-INF/view/expend/export/reimburse/laborfee";
	}
	
	
	
	/**
	 * 公务接待财务报账单
	 * @param id
	 * @param model
	 * @return
	 * @author 沈帆
	 * @throws Exception 
	 * @createtime 2020年11月19日
	 * @updator 沈帆
	 * @updatetime 2020年11月19日
	 */
	@RequestMapping(value="/receptionPayee")
	public String receptionPayee(Integer id, ModelMap model) throws Exception{
		
		//传回来的id是主键
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		
		//获取报销人信息
		User user = userMng.findById(bean.getUser());
		
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
		model.addAttribute("bean", bean);
		TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
		TProBasicInfo pro = projectMng.findById(expendDetail.getFProId());
		model.addAttribute("pro", pro);
		bean.setProDetailName(pro.getFProName()+"("+pro.getFProCode()+")");
		//查询接待信息
		ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
		model.addAttribute("receptionBean", receptionBean);
		
		//住宿
		List<Object> listHotel = applyMng.getObjectList("ReceptionHotel", "rId", bean.getrId());
		model.addAttribute("listHotel", listHotel);
		//餐费
		List<Object> listFood = applyMng.getObjectList("ReceptionFood", "rId", bean.getrId());
		model.addAttribute("listFood", listFood);
		//其他费用
		List<Object> listOther = applyMng.getObjectList("ReceptionOther", "rId", bean.getrId());
		model.addAttribute("listOther", listOther);
		//收款人信息
		List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
		String payType ="";
		String paymentType="";
		String paymentPeople="";
		for (int i = 0; i < listPayee.size(); i++) {
			paymentType=paymentType+listPayee.get(i).getPaymentType()+"/";
			paymentPeople =paymentPeople+listPayee.get(i).getPayeeName()+",";
		}
		
		/*if(paymentType.contains("现金")){
			payType=payType+"现金/";
		}
		if(paymentType.contains("支票")){
			payType=payType+"支票/";
		}
		if(paymentType.contains("电汇")){
			payType=payType+"电汇/";
		}
		if(paymentType.contains("公务卡")){
			payType=payType+"公务卡/";
		}
		if(paymentType.contains("银行代发")){
			payType=payType+"银行代发/";
		}*/
		model.addAttribute("payType", bean.getPaymentType());
		model.addAttribute("paymentPeople", paymentPeople.substring(0, paymentPeople.length()-1));
		DateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日");
		String time =fmt.format(bean.getReqTime());     // 转换成 X年X月X日
		model.addAttribute("time",time);
		//审批记录
		String strType ="GWJDBX";
		ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
		if(receptionBeans.getReceptionLevel1().equals("2")){
			if(receptionBeans.getIsForeign().equals("1")){
				strType = "GWJDBX-WB";
			}else{
				strType = "GWJDBX-YJYX";
			}
		}
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
		List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
		checkList = tProcessCheckMng.getTrueResult(checkList);
		Collections.reverse(checkList);
		if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
			model.addAttribute("fPorHead", pro.getFProHead());
			checkList.remove(0);
		}
		if("1".equals(receptionBeans.getReceptionLevel1())){
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}


				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
					model.addAttribute("role4", tProcessCheck.getFuserName());
				}
			}
		}else{
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("部门负责人")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
					model.addAttribute("role3", tProcessCheck.getFuserName());
				}
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("主管校长")){
					model.addAttribute("role4", tProcessCheck.getFuserName());
				}
			}
		}
		List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
		int checkNum =1;
		for (int i = checkList.size()-1; i >= 0; i--) {
			User checkuser = userMng.findById(checkList.get(i).getFuserId());
			if("32".equals(checkuser.getDpID())&&checkNum<=3){
				financeList.add(checkList.get(i));
				checkNum++;
				checkList.remove(i);
			}
		}
		String financeCheck = new String();
		for (int i = 0; i < financeList.size(); i++) {
			financeCheck+=financeList.get(i).getFuserName()+",";
		}
		if(financeList.size()>0){
			model.addAttribute("financeCheck", financeCheck.substring(0, financeCheck.length()-1));
		}
		return "/WEB-INF/view/expend/export/reimburse/receptionPayee";
	}
	
}
