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
 * ???????????????????????????????????????????????????????????????
 * @author ?????????
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
	private PaymentMethodInfoMng paymentMethodInfoMng;	//??????????????????
	
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
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-06-02
	 * @updatetime 2020-06-02
	 */
	@RequestMapping(value = "/applyTravel")
	public String list(Integer id, ModelMap model) throws Exception {
		//??????????????????????????????
		ApplicationBasicInfo bean = applyMng.findById(id);
		//??????????????????
		TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
		model.addAttribute("travelBean", travelBean);
		
		//??????type????????????
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		if("GWCX".equals(bean.getTravelType())){
			strType = "GWCXSQ";
		}
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		List<TProcessCheck> listTProcessCheck = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
		model.addAttribute("listTProcessCheck", listTProcessCheck);
		
		return "/WEB-INF/view/expend/export/apply/exportTravel";
	}
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-06-02
	 * @updatetime 2020-06-02
	 */
	@RequestMapping(value = "/reimburseTravel")
	public String reimburseTravel(String id, ModelMap model) {
		model.addAttribute("id", id);
		return "/WEB-INF/view/expend/export/reimburse/exportReimburse";
	}
	
	/**
	 * ??????????????????
	 * @param id ??????id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???2???
	 * @updator ?????????
	 * @updatetime 2020???6???2???
	 */
	@RequestMapping("/applyExprot")
	public String edit(Integer id, ModelMap model) {	
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			//??????????????????????????????
			ApplicationBasicInfo bean = applyMng.findById(id);
			//??????????????????
			String type = bean.getType();
			TProExpendDetail expendDetail = new TProExpendDetail();
			TProBasicInfo pro = new TProBasicInfo();
			if("4".equals(type)){
				BudgetMessageList budgetMessageList = new BudgetMessageList();
				budgetMessageList.setgId(bean.getgId());
				//??????????????????
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
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);
			model.addAttribute("pro", pro);
			bean.setProDetailName(pro.getFProName()+"("+pro.getFProCode()+")");
			bean.setProCharger(pro.getFProHead());
			//?????????????????????
			User user = userMng.findById(bean.getUser());
			bean.setUserNames(user.getName());
			bean.setApplyAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			//??????type????????????
			String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
			//????????????????????????
			Integer detailId = bean.getProDetailId();
			Integer indexId = bean.getIndexId();
			if (detailId != null && indexId != null) {
				TProExpendDetail detail = detailMng.findById(detailId);
				TBudgetIndexMgr index = indexMng.findById(indexId);
				if (detail != null && index != null) {
					//????????????
					bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
					//????????????
					bean.setPfAmount(detail.getOutAmount());		
					//????????????
					if (index.getAppDate() != null) {
						bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
					}
					//????????????
					bean.setPfDepartName(index.getDeptName());			
					//????????????
					bean.setSyAmount(detail.getSyAmount());			
				}
			}else if(indexId != null){
				TBudgetIndexMgr index = indexMng.findById(indexId);
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
				//????????????
				bean.setPfAmount(index.getPfAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(index.getSyAmount());			
			}
			//??????????????????
			List<Attachment> attaList = attachmentMng.list(bean);
			model.addAttribute("attaList", attaList);
			ReceptionAppliInfo receptionBean =new ReceptionAppliInfo();
			if(type.equals("1")){
				model.addAttribute("userid", getUser().getId());
				//????????????
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
						DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
						String time =fmt.format(tProcessCheck.getFcheckTime());     // ????????? X???X???X???
						tProcessCheck.setFcheckTimes(time);
						String StringNum = MatheUtil.ToCH(num);
						tProcessCheck.setFroleName("???"+StringNum+"?????????");
						listTProcessChecksTY.add(tProcessCheck);
						num-=1;
					}
				}
				Collections.reverse(listTProcessChecksTY); // ???????????? 
				model.addAttribute("listTProcessChecksTY", listTProcessChecksTY);*/
				
			}else if(type.equals("2")) {
				
				//??????????????????
				MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", id);
				model.addAttribute("meetingBean", meetingBean);
				String startTime =fmt.format(meetingBean.getDateStart());
				String endTime =fmt.format(meetingBean.getDateEnd());
				model.addAttribute("startTime", startTime);
				model.addAttribute("endTime", endTime);
				int day = DateUtil.getDaySpan(meetingBean.getDateStart(), meetingBean.getDateEnd());
				model.addAttribute("day", day);
				//????????????
				List<Object> listMeetingPlan = applyMng.getObjectList("MeetingPlan", "gId", id);
				model.addAttribute("listMeetingPlan", listMeetingPlan);
				
				//????????????
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "gId", id);
				model.addAttribute("mingxiList", mingxiList);
				
			} else if(type.equals("3")) {
				//??????????????????
				TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", id);
				model.addAttribute("trainingBean", trainingBean);
				int day = DateUtil.getDaySpan(trainingBean.getTrDateStart(), trainingBean.getTrDateEnd());
				model.addAttribute("day", day);
				//????????????
				List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
				model.addAttribute("listLecturer", listLecturer);
				//????????????
				List<Object> listMeetPlan = applyMng.getObjectList("MeetPlan", "tId", trainingBean.gettId());
				model.addAttribute("listMeetPlan", listMeetPlan);
				//????????????
				List<Object> listZongHe = applyMng.getMingxi("ApplicationDetail", "gId", id);
				model.addAttribute("listZongHe", listZongHe);
				//?????????????????????
				List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
				model.addAttribute("listTeacherCost", listTeacherCost);
				//?????????????????????
				List<TrainTeacherCost> listHotel = applyMng.getTeacherMingxi(trainingBean.gettId(), "hotel");
				model.addAttribute("listHotel", listHotel);
				//?????????????????????
				List<TrainTeacherCost> listFood = applyMng.getTeacherMingxi(trainingBean.gettId(), "food");
				model.addAttribute("listFood", listFood);
				//??????????????????????????????
				List<TrainTeacherCost> listTraffic1 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic1");
				model.addAttribute("listTraffic1", listTraffic1);
				BigDecimal listTraffic1applySum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic1.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic1.get(i);
					listTraffic1applySum=listTraffic1applySum.add(trainTeacherCost.getApplySum());
				}
				model.addAttribute("listTraffic1applySum", listTraffic1applySum);
				
				//????????????????????????
				List<TrainTeacherCost> listTraffic2 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic2");
				model.addAttribute("listTraffic2", listTraffic2);
				BigDecimal listTraffic2applySum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic2.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic2.get(i);
					listTraffic2applySum=listTraffic2applySum.add(trainTeacherCost.getApplySum());
				}
				model.addAttribute("listTraffic2applySum", listTraffic2applySum);
			} else if(type.equals("4")) {
				//??????????????????
				TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", id);
				model.addAttribute("travelBean", travelBean);
				if("GWCC".equals(bean.getTravelType())){
					int day = DateUtil.getDaySpan(travelBean.getTravelDateStart(), travelBean.getTravelDateEnd());
					model.addAttribute("day", day);
				}
				//??????
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
				//???????????????
				String travelAreaName = new String();
				for (int i = 0; i < Travellist.size(); i++) {
					travelAreaName = travelAreaName + Travellist.get(i).getTravelAreaName() + ",";
				}
				
				//????????????????????????????????????????????????????????????
					Set<String> peopleSet = new HashSet<String>();
					for (int i = Travellist.size()-1; i >= 0; i--) {
						String[] peopId =  Travellist.get(i).getTravelAttendPeopId().split(",");
						for (int j = 0; j < peopId.length; j++){
							peopleSet.add(peopId[j]);
							
						}
						//?????????????????????????????????????????????????????????
						/*for (int j = 0; j < peopId.length; j++) {
							TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
							User peop = userMng.findById(peopId[j]);
							travelAppliInfo.setTravelAttendPeop(peop.getName());
							travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
							travelAppliInfo.setTravelAttendPeopId(peop.getId());
							String roleslevel = new String();
							switch (peop.getRoleslevel()) {//1????????????2????????????3???????????????
							case 1:
								roleslevel ="??????";
								break;
							case 2:
								roleslevel ="??????";
								break;
							case 3:
								roleslevel ="????????????";
								break;
							}
							travelAppliInfo.setTravelPersonnelLevel(roleslevel);
							travelAppliInfo.setfTel(peop.getTelNo());
							Travellist.add(travelAppliInfo);
						}*/
						//??????????????????????????????????????????
						Travellist.remove(i);
					}
					for (Object object : peopleSet) {
						TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
						User peop = userMng.findById(object.toString());
						travelAppliInfo.setTravelAttendPeop(peop.getName());
						travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
						travelAppliInfo.setTravelAttendPeopId(peop.getId());
						String roleslevel = new String();
						switch (peop.getRoleslevel()) {//1????????????2????????????3???????????????
						case 1:
							roleslevel ="??????";
							break;
						case 2:
							roleslevel ="??????";
							break;
						case 3:
							roleslevel ="????????????";
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
					travelAppliInfo.setTravelPersonnelLevel("??????");
					travelAppliInfo.setfTel(studentsList.get(i).getfTel());
					Travellist.add(travelAppliInfo);
				}
				model.addAttribute("travellist", Travellist);
				model.addAttribute("travelAreaName", travelAreaName.subSequence(0, travelAreaName.length()-1));
				//???????????????
				List<InCityTrafficInfo> inCitylist =new ArrayList<InCityTrafficInfo>();
				InCityTrafficInfo InCitybean = (InCityTrafficInfo) applyMng.getObject("InCityTrafficInfo", "gId", id);
				if(InCitybean!=null){
					Pagination InCitybeanp = inCityTrafficInfoMng.inCityInfoPageList(1, 100, InCitybean);
					inCitylist = (List<InCityTrafficInfo>) InCitybeanp.getList();
				}
				model.addAttribute("inCitylist", inCitylist);
				//?????????
				List<HotelExpenseInfo> hotellist = hotelExpenseInfoMng.findbygId(bean.getgId(),null);
				model.addAttribute("hotellist", hotellist);
				//????????????
				List<FoodAllowanceInfo> foodlist = foodAllowanceInfoMng.findbygId(bean.getgId(),null);
				model.addAttribute("foodlist", foodlist);
				
				/*//????????????????????????
				TravelPeopleInfo tPeopBean = (TravelPeopleInfo) applyMng.getObject("TravelPeopleInfo", "trId", travelBean.getTrId());
				model.addAttribute("tPeopBean", tPeopBean);*/
				
			} else if(type.equals("5")) {
				//??????????????????
				receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", id);
				model.addAttribute("receptionBean", receptionBean);
				//??????????????????
				List<Object> listObserve =applyMng.getObjectList("ReceptionObservePlan", "jId", receptionBean.getjId());
				model.addAttribute("listObserve", listObserve);
				/*//?????????
				List<Object> listHotel = applyMng.getObjectList("ReceptionHotel", "gId", id);
				model.addAttribute("listHotel", listHotel);*/
				//??????
				List<Object> listFood = applyMng.getObjectList("ReceptionFood", "gId", id);
				model.addAttribute("listFood", listFood);
				//????????????
				List<Object> listOther = applyMng.getObjectList("ReceptionOther", "gId", id);
				model.addAttribute("listOther", listOther);
				
			} else if(type.equals("6")) {
				//????????????????????????
				
				OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", id);
				model.addAttribute("officeCar", officeBean);
				
			} else if(type.equals("7")) {
				//????????????????????????
				/*expendDetail = detailMng.findById(bean.getProDetailId());
				pro = projectMng.findById(expendDetail.getFProId());
				model.addAttribute("pro", pro);*/
				AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", id);
				model.addAttribute("abroad", abroadBean);
				int day = DateUtil.getDaySpan(abroadBean.getfAbroadDateStart(), abroadBean.getfAbroadDateEnd());
				model.addAttribute("day", day);
				//??????????????????
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
				bean.setArriveCountry(arriveCountry.substring(0, arriveCountry.length()-1));//??????????????????
				bean.setArrivePlan(arrivePlan);//????????????
				model.addAttribute("listAbroadPlan", listAbroadPlan);
				model.addAttribute("bean", bean);
				
//				Pagination p = userMng.getUserByIds(abroadBean.getfAbroadPeople());
//				List<UserTransient> abroadPeopleList = (List<UserTransient>) p.getList();
				List<Object> abroadPeopleList =applyMng.getObjectList("AbroadAppliPepoleInfo", "aId", abroadBean.getFaId());
				model.addAttribute("abroadPeopleList", abroadPeopleList);
				
				//????????????
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
					if (outsideTrafficInfo.getVehicle().contains("??????")) {
						model.addAttribute("airplane", "airplane");
						
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							airplaneSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "???";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("??????")) {
						model.addAttribute("ship", "ship");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							shipSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "???";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("??????")) {
						model.addAttribute("train", "train");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							trainSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "???";
						}
						
					} else if (outsideTrafficInfo.getVehicle().contains("??????")) {
						model.addAttribute("otherTraffic", "otherTraffic");
						if (!StringUtil.isEmpty(outsideTrafficInfo.getVehicleLevel())) {
							otherTrafficSet.add(outsideTrafficInfo.getVehicleLevel());
							//shipLevel = shipLevel + outsideTrafficInfo.getVehicleLevel() + "???";
						}
						
					}
				}
				for (Object object : airplaneSet) {
					airplaneLevel = airplaneLevel + object + "???";
				}
				for (Object object : shipSet) {
					shipLevel = shipLevel + object + "???";
				}
				for (Object object : trainSet) {
					trainLevel = trainLevel + object + "???";
				}
				for (Object object : otherTrafficSet) {
					otherTrafficLevel = otherTrafficLevel + object + "???";
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
				
				//????????????
				List<InternationalTravelingExpense> listInternationalTravelingExpense = internationalTravelingExpenseInfoMng.findbygId(id);
				for (InternationalTravelingExpense expense : listInternationalTravelingExpense) {
					if (expense.getVehicle() != null) {
						Vehicle vehicle = vehicleMng.findById(Integer.valueOf(expense.getVehicle()));
						expense.setVehicleText(vehicle.getName());
					}
				}
				model.addAttribute("listInternationalTravelingExpense", listInternationalTravelingExpense);
				
				//??????????????????????????????
				List<Object> listOutsideTrafficInfo = applyMng.getObjectList("OutsideTrafficInfo", "gId", id);
				model.addAttribute("listOutsideTrafficInfo", listOutsideTrafficInfo);
				//?????????
				List<HotelExpenseInfo> listHotelExpenseInfo = hotelExpenseInfoMng.findbygId(bean.getgId(),bean.getTravelType());
				model.addAttribute("listHotelExpenseInfo", listHotelExpenseInfo);
				//?????????
				List<FoodAllowanceInfo> listFoodAllowanceInfo = foodAllowanceInfoMng.findbygId(bean.getgId(),bean.getTravelType());
				model.addAttribute("listFoodAllowanceInfo", listFoodAllowanceInfo);
				//?????????
				List<Object> listMiscellaneousFeeInfo = applyMng.getObjectList("MiscellaneousFeeInfo", "gId", id);
				model.addAttribute("listMiscellaneousFeeInfo", listMiscellaneousFeeInfo);
				//????????????
				List<FeteCostInfo> listFeteCostInfo = feteCostInfoMng.findbygId(id);
				model.addAttribute("listFeteCostInfo", listFeteCostInfo);
				//????????????
				List<Object> listReceptionOther = applyMng.getObjectList("ReceptionOther", "gId", id);
				model.addAttribute("listReceptionOther", listReceptionOther);
			}
			model.addAttribute("bean", bean);
			/*if(!"1".equals(type)){*/
			//??????type????????????
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
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes(strType,bean.getDept(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
//			//????????????
//			List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("ApplicationBasicInfo", "gId", bean.getgId());
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			/*}*/
			//????????????
			model.addAttribute("foCode",bean.getBeanCode());	
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			
			//????????????
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(type.equals("5")){
				if(1==pro.getFProOrBasic()){//?????????????????????????????????
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("???????????????")){//????????????????????????????????????????????????????????????
					model.addAttribute("role1", bean.getUserNames());
				}
				if("1".equals(receptionBean.getReceptionLevel1())){
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}


						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}else{
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}
			}else{
				Calendar c = Calendar.getInstance();
				if(1==pro.getFProOrBasic()){//?????????????????????????????????
					model.addAttribute("proHead", pro.getFProHead());
					c.setTime(checkList.get(0).getFcheckTime());
					model.addAttribute("proHeadYear",c.get(Calendar.YEAR));
					model.addAttribute("proHeadMonth",c.get(Calendar.MONTH)+1);
					model.addAttribute("proHeadDay",c.get(Calendar.DAY_OF_MONTH));
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("???????????????")){//????????????????????????????????????????????????????????????
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
				
				//??????????????????????????????????????????
				Depart depart = user.getDepart();
				if (depart != null) {
					User manager =  depart.getManager();
					if (manager != null && manager.getId().equals(getUser().getId())) {//?????????????????????????????????????????????
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
//				if("GWCX".equals(bean.getTravelType())){//????????????
//					return "/WEB-INF/view/expend/export/apply/travelcx";
//				}else{//??????
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
	 * ??????????????????
	 * @param id ????????????id
	 * @param model
	 * @param editType
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???2???
	 * @updator ?????????
	 * @updatetime 2020???6???2???
	 */
	@RequestMapping("/reimburseExprot")
	public String edit(Integer id, ModelMap model ,String editType) {
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
			//????????????id?????????
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			//??????????????????
			String type = bean.getType();
			TProBasicInfo pro =new TProBasicInfo();
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getReimburseReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);
			if("4".equals(type)){
				BudgetMessageList budgetMessageList = new BudgetMessageList();
				budgetMessageList.setgId(bean.getrId());
				//??????
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
			//?????????????????????
			User user = userMng.findById(bean.getUser());
			
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			//????????????????????????
			ApplicationBasicInfo apply = applyMng.findByCode(bean.getgCode());
			model.addAttribute("applyBean", apply);
			model.addAttribute("pro", pro);
			//???????????????
//			List<ReimbPayeeInfo> reimbPayeeInfolist = reimbPayeeMng.getByRId(bean.getrId());
//			model.addAttribute("reimbPayeeInfolist", reimbPayeeInfolist);
			if (apply != null) {
				Integer detailId = apply.getProDetailId();
				Integer indexId = bean.getIndexId();
				if (detailId != null && indexId != null) {
					TProExpendDetail detail = detailMng.findById(detailId);
					TBudgetIndexMgr index = indexMng.findById(indexId);
					if (detail != null && index != null) {
						//????????????
						bean.setPfAmount(detail.getOutAmount());		
						//????????????
						if (index.getAppDate() != null) {
							bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
						}
						//????????????
						bean.setPfDepartName(index.getDeptName());			
						//????????????
						bean.setSyAmount(detail.getSyAmount());			
					}
				}else if(indexId != null){
					TBudgetIndexMgr index = indexMng.findById(indexId);
					//????????????
					bean.setPfAmount(index.getPfAmount());		
					//????????????
					if (index.getAppDate() != null) {
						bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
					}
					//????????????
					bean.setPfDepartName(index.getDeptName());			
					//????????????
					bean.setSyAmount(index.getSyAmount());			
				}
			}
			bean.setIndexName(apply.getIndexName());
			//??????????????????
			List<Attachment> attaList = attachmentMng.list(apply);
			model.addAttribute("attaList", attaList);
			List<Attachment> attaList1 = attachmentMng.list(bean);
			model.addAttribute("attaList1", attaList1);
			String reimburseType = apply.getType();
			//??????type????????????
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
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//????????????
			model.addAttribute("foCode",bean.getBeanCode());
			//?????????????????????????????????
			ApplicationBasicInfo abi = applicationBasicInfoMng.getByGCode(bean.getgCode());
//			List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("ReimbAppliBasicInfo", "rId", bean.getrId());
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			
			
			/*//?????????????????????????????????????????????
			String strTypeApply = tProcessCheckMng.JudgmentProcess(String.valueOf(reimburseType));
			if("GWCX".equals(bean.getTravelType())){
				strTypeApply = "GWCXSQ";
			}
			//???????????????id
			TProcessDefin tProcessDefinApply=tProcessDefinMng.getByBusiAndDpcode(strTypeApply, bean.getDept());
			model.addAttribute("fpIdAplly", tProcessDefinApply.getFPId());
			//????????????
			model.addAttribute("foCodeAplly",bean.getBeanCode());*/
			
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			//????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			
			//????????????
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(type.equals("5")){
				if(1==pro.getFProOrBasic()){//?????????????????????????????????
					checkList.remove(0);
				}
				if(userMng.findById(bean.getUser()).getRoleName().contains("???????????????")){//????????????????????????????????????????????????????????????
					model.addAttribute("role1", apply.getUserNames());
				}
				ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				if("1".equals(receptionBeans.getReceptionLevel1())){
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}


						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}else{
					for (TProcessCheck tProcessCheck : checkList) {
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
							model.addAttribute("role1", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
							model.addAttribute("role2", tProcessCheck.getFuserName());
						}

						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
							model.addAttribute("role3", tProcessCheck.getFuserName());
						}
						if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
							model.addAttribute("role4", tProcessCheck.getFuserName());
						}
					}
				}
			}else{
				List<TProcessCheck> financeList = new ArrayList<TProcessCheck>();
				if(1==pro.getFProOrBasic()){//?????????????????????????????????
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
				if(beauser.getRoleName().contains("???????????????")){//????????????????????????????????????????????????????????????
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
			//??????????????????
			List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
			//???????????????
			List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
			for (int i = 0; i < listPayee.size(); i++) {
				listPayee.get(i).setNum(i + 1);
			}
			model.addAttribute("listPayee", listPayee);
			model.addAttribute("id", id);

			if(type.equals("1")){
				//????????????
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
						DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
						String time =fmt.format(tProcessCheck.getFcheckTime());     // ????????? X???X???X???
						tProcessCheck.setFcheckTimes(time);
						String StringNum = MatheUtil.ToCH(num);
						tProcessCheck.setFroleName("???"+StringNum+"?????????");
						listTProcessChecksTY.add(tProcessCheck);
						num-=1;
					}
				}
				Collections.reverse(listTProcessChecksTY); // ???????????? 
				model.addAttribute("listTProcessChecksTY", listTProcessChecksTY);*/
			} else if(type.equals("2")) {
				//??????????????????
				MeetingAppliInfo meetingBeanApply = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", apply.getgId());
				model.addAttribute("meetingBeanApply", meetingBeanApply);
				MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "rId", id);
				model.addAttribute("meetingBean", meetingBean);
				//????????????
				List<Object> listMeetingPlan = applyMng.getObjectList("MeetingPlan", "rId", id);
				model.addAttribute("listMeetingPlan", listMeetingPlan);
				
				//????????????
				List<Object> mingxiList = applyMng.getMingxi("ApplicationDetail", "rId", id);
				model.addAttribute("mingxiList", mingxiList);
				
				String startTime =fmt.format(meetingBean.getDateStart());
			    String endTime =fmt.format(meetingBean.getDateEnd());
			    model.addAttribute("reimbStartTime", startTime);
			    model.addAttribute("reimbEndTime", endTime);
			    int day = DateUtil.getDaySpan(meetingBean.getDateStart(), meetingBean.getDateEnd());
			    model.addAttribute("reimbDay", day + 1);
			} else if(type.equals("3")) {
				//????????????????????????
				TrainingAppliInfo trainingBeanApply = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", apply.getgId());
				model.addAttribute("trainingBeanApply", trainingBeanApply);
				
				//????????????????????????
				TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", id);
				model.addAttribute("trainingBean", trainingBean);
				
				
				int day = DateUtil.getDaySpan(trainingBean.getTrDateStart(), trainingBean.getTrDateEnd());
				model.addAttribute("day", day);
				//????????????
				List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
				model.addAttribute("listLecturer", listLecturer);
				//????????????
				List<Object> listMeetPlan = applyMng.getObjectList("MeetPlan", "tId", trainingBean.gettId());
				model.addAttribute("listMeetPlan", listMeetPlan);
				//????????????
				List<Object> listZongHe = applyMng.getMingxi("ApplicationDetail", "rId", id);
				model.addAttribute("listZongHe", listZongHe);
				//?????????????????????
				List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
				model.addAttribute("listTeacherCost", listTeacherCost);
				//?????????????????????
				List<TrainTeacherCost> listHotel = applyMng.getTeacherMingxi(trainingBean.gettId(), "hotel");
				model.addAttribute("listHotel", listHotel);
				//?????????????????????
				List<TrainTeacherCost> listFood = applyMng.getTeacherMingxi(trainingBean.gettId(), "food");
				model.addAttribute("listFood", listFood);
				//??????????????????????????????
				List<TrainTeacherCost> listTraffic1 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic1");
				model.addAttribute("listTraffic1", listTraffic1);
				//???????????????????????????
				List<TrainTeacherCost> listTraffic2 = applyMng.getTeacherMingxi(trainingBean.gettId(), "traffic2");
				model.addAttribute("listTraffic2", listTraffic2);	
				BigDecimal listTraffic2reimburseSum = BigDecimal.ZERO;
				for (int i = 0; i < listTraffic2.size(); i++) {
					TrainTeacherCost trainTeacherCost = listTraffic2.get(i);
					listTraffic2reimburseSum=listTraffic2reimburseSum.add(trainTeacherCost.getReimbSum());
				}
				model.addAttribute("listTraffic2reimburseSum", listTraffic2reimburseSum);
				
			} else if(type.equals("4")) {
				//??????????????????
				TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "rId", id);
				model.addAttribute("travelBean", travelBean);
				
				TravelAppliInfo travelBeanApply = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", apply.getgId());
				model.addAttribute("travelBeanApply", travelBeanApply);
				//??????
				Pagination p = travelAppliInfoMng.rtravelPageList(1, 100, travelBean);
				List<TravelAppliInfo> Travellist = (List<TravelAppliInfo>) p.getList();
				//??????????????????
				if(!"GWCX".equals(bean.getTravelType())){
					OutsideTrafficInfo outsidebean = new OutsideTrafficInfo();
					outsidebean.setrId(id);
					Pagination outsidep = outsideTrafficInfoMng.routsideTrafficInfoPageList(1, 100, outsidebean);
					List<OutsideTrafficInfo> outsidelist = (List<OutsideTrafficInfo>) outsidep.getList();
					model.addAttribute("outsidelist", outsidelist);
				}
				
				//????????????????????????????????????????????????????????????
				if("GWCC".equals(bean.getTravelType())){//????????????
					for (int i = Travellist.size()-1; i >= 0; i--) {
						String[] peopId =  Travellist.get(i).getTravelAttendPeopId().split(",");

						//?????????????????????????????????????????????????????????
						for (int j = 0; j < peopId.length; j++) {
							TravelAppliInfo travelAppliInfo = new TravelAppliInfo();
							User peop = userMng.findById(peopId[j]);
							travelAppliInfo.setTravelAttendPeop(peop.getName());
							travelAppliInfo.setfIdentityNumber(peop.getiDnumber());
							String roleslevel = new String();
							switch (peop.getRoleslevel()) {//1????????????2????????????3???????????????
							case 1:
								roleslevel ="??????";
								break;
							case 2:
								roleslevel ="??????";
								break;
							case 3:
								roleslevel ="????????????";
								break;
							}
							travelAppliInfo.setTravelPersonnelLevel(roleslevel);
							travelAppliInfo.setfTel(peop.getTelNo());
							Travellist.add(travelAppliInfo);
						}
						//??????????????????????????????????????????
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
					travelAppliInfo.setTravelPersonnelLevel("??????");
					travelAppliInfo.setfTel(studentsList.get(i).getfTel());
					Travellist.add(travelAppliInfo);
				}
				//???????????????
				String travelAreaName = new String();
				String travelAttendPeop = new String();
				for (int i = 0; i < Travellist.size(); i++) {
					travelAreaName = travelAreaName + Travellist.get(i).getTravelAreaName() + ",";
					travelAttendPeop = travelAttendPeop + Travellist.get(i).getTravelAttendPeop() + ",";
				}
				//?????????
				model.addAttribute("travelAreaName", travelAreaName.subSequence(0, travelAreaName.length()-1));
				//????????????
				model.addAttribute("travelpepolnumber", Travellist.size()-1);
				//????????????
				model.addAttribute("travelpepol", travelAttendPeop);
				model.addAttribute("travellist", Travellist);

				//???????????????
				InCityTrafficInfo InCitybean = (InCityTrafficInfo) applyMng.getObject("InCityTrafficInfo", "rId", id);
				Pagination InCitybeanp = inCityTrafficInfoMng.rinCityInfoPageList(1, 100, InCitybean);
				List<InCityTrafficInfo> inCitylist = (List<InCityTrafficInfo>) InCitybeanp.getList();
				model.addAttribute("inCitylist", inCitylist);
				//?????????
				List<HotelExpenseInfo> hotellist = hotelExpenseInfoMng.rfindbygId(bean.getrId(),null);
				model.addAttribute("hotellist", hotellist);
				//????????????
				List<FoodAllowanceInfo> foodlist = foodAllowanceInfoMng.rfindbygId(bean.getrId(),null);
				model.addAttribute("foodlist", foodlist);
				//??????????????????
				ReceptionOther receptionOther = new ReceptionOther();
				receptionOther.setrId(id);
				List<ReceptionOther> receptionOtherlist = applyMng.getReceptionOther(receptionOther,getUser());
				model.addAttribute("receptionOtherlist", receptionOtherlist);
				
			} else if(type.equals("5")) {
				//??????????????????
				ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				model.addAttribute("receptionBean", receptionBean);
				
				ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
				model.addAttribute("receptionBeanEdit", receptionBeans);
				//??????????????????
				List<Object> listPeople = applyMng.getObjectList("ReceptionPeopleInfo", "jId", receptionBeans.getjId());
				model.addAttribute("listPeople", listPeople);
				//??????
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
				//??????
				List<Object> listFood = applyMng.getObjectList("ReceptionFood", "rId", bean.getrId());
				model.addAttribute("listFood", listFood);
				//????????????
				List<Object> listOther = applyMng.getObjectList("ReceptionOther", "rId", bean.getrId());
				model.addAttribute("listOther", listOther);
				//??????????????????
				List<Object> listAccompany = applyMng.getObjectList("AccompanyPeopleInfo", "jId", receptionBeans.getjId());
				model.addAttribute("listAccompany", listAccompany);
				
			} else if(type.equals("6")) {
				//????????????????????????
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
				model.addAttribute("Invoicelist1", list1);//???????????????
			} else if(type.equals("7")) {
				
				//????????????????????????
				AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId",  bean.getrId());
				model.addAttribute("abroad", abroadBean);
				//??????????????????
				AbroadAppliInfo abroadEdit = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId", bean.getrId());
				model.addAttribute("abroadEdit", abroadEdit);
				//????????????
				String abroadPeopleName = "";
				List<Object> peopleList =applyMng.getObjectList("AbroadAppliPepoleInfo", "aId", abroadEdit.getFaId());
			/*	if (!StringUtil.isEmpty(abroadEdit.getfAbroadPeople())) {
					String[] abroadPeople = abroadEdit.getfAbroadPeople().split(",");
					for (String userId : abroadPeople) {
						User u = userMng.findById(userId);
						abroadPeopleName = abroadPeopleName + u.getName() + "???";
					}
				}*/
				for (Object object : peopleList) {
					AbroadAppliPepoleInfo abroad =(AbroadAppliPepoleInfo) object;
					abroadPeopleName = abroadPeopleName + abroad.getTravelPeopName()+ "???";
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
				bean.setArriveCountry(arriveCountry.substring(0, arriveCountry.length()-1));//??????????????????
				bean.setArrivePlan(arrivePlan);//????????????
				
				List<InternationalTravelingExpense> expenselist = internationalTravelingExpenseInfoMng.rfindbygId(bean.getrId());
				//?????????
				BigDecimal airplaneAmount = BigDecimal.ZERO;
				String airplaneStartAndEnd = "";
				//?????????
				BigDecimal trainAmount = BigDecimal.ZERO;
				String trainStartAndEnd = "";
				//?????????
				BigDecimal shipAmount = BigDecimal.ZERO;
				String shipStartAndEnd = "";
				for (InternationalTravelingExpense expense : expenselist) {
					Vehicle vehicle = vehicleMng.findByCode(expense.getVehicle()).get(0);
					expense.setVehicleText(vehicle.getName());
					//??????
					if (vehicle.getName().contains("??????")) {
						if (expense.getApplyAmount() != null) {
							airplaneAmount = airplaneAmount.add(expense.getApplyAmount());
						}
						airplaneStartAndEnd = airplaneStartAndEnd + expense.getStartCity() + "-" + expense.getArriveCity() + ",";
					}
					//??????
					if (vehicle.getName().contains("??????")) {
						if (expense.getApplyAmount() != null) {
							trainAmount = trainAmount.add(expense.getApplyAmount());
						}
						trainStartAndEnd = trainStartAndEnd + expense.getStartCity() + "-" + expense.getArriveCity() + ",";
					}
					//??????
					if (vehicle.getName().contains("??????")) {
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
				
				//??????????????????????????????
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
				
				//?????????
				List<HotelExpenseInfo> listHotelExpenseInfo = hotelExpenseInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
				model.addAttribute("listHotelExpenseInfo", listHotelExpenseInfo);
				BigDecimal hotelExpenseInfoAmount = BigDecimal.ZERO;
				for (int i = 0; i < listHotelExpenseInfo.size(); i++) {
					if (listHotelExpenseInfo.get(i).getApplyAmount() != null) {
						hotelExpenseInfoAmount=hotelExpenseInfoAmount.add(listHotelExpenseInfo.get(i).getApplyAmount());
					}
				}
				model.addAttribute("hotelExpenseInfoAmount", hotelExpenseInfoAmount);
				
				//?????????
				List<FoodAllowanceInfo> listFoodAllowanceInfo = foodAllowanceInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
				model.addAttribute("listFoodAllowanceInfo", listFoodAllowanceInfo);
				//?????????
				List<Object> listMiscellaneousFeeInfo = applyMng.getObjectList("MiscellaneousFeeInfo", "rId",  bean.getrId());
				model.addAttribute("listMiscellaneousFeeInfo", listMiscellaneousFeeInfo);
				//????????????
				List<FeteCostInfo> listFeteCostInfo = feteCostInfoMng.rfindbygId(bean.getrId());
				BigDecimal feteCostAmount = BigDecimal.ZERO;
				for (FeteCostInfo feteCostInfo : listFeteCostInfo) {
					if (feteCostInfo.getfApplyAmount() != null) {
						feteCostAmount = feteCostAmount.add(feteCostInfo.getfApplyAmount());
					}
				}
				model.addAttribute("listFeteCostInfo", listFeteCostInfo);
				//????????????
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
				//??????
				BigDecimal totalAmount = BigDecimal.ZERO;
				totalAmount = totalAmount.add(airplaneAmount);
				totalAmount = totalAmount.add(trainAmount);
				totalAmount = totalAmount.add(shipAmount);
				totalAmount = totalAmount.add(hotelExpenseInfoAmount);
				totalAmount = totalAmount.add(outsideTrafficAmount);
				totalAmount = totalAmount.add(otherReimbAmount);
				model.addAttribute("totalAmount", totalAmount);
				//???????????????????????????????????????????????????
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
					//??????
					calendar.setTime(abroadPlan.getAbroadDate());
					int startMonth = calendar.get(Calendar.MONTH);
					int startDay = calendar.get(Calendar.DATE);
					ap.setStartMonth(startMonth);
					ap.setStartDay(startDay);
					//??????
					calendar.setTime(abroadPlan.getTimeEnd());
					int endMonth = calendar.get(Calendar.MONTH);;
					int endDay = calendar.get(Calendar.DATE);
					ap.setEndMonth(endMonth);
					ap.setEndDay(endDay);
					//??????
					int dayNum = DateUtil.getDaySpan(abroadPlan.getAbroadDate(), abroadPlan.getTimeEnd());
					
					if(i==lists.size()-1){
						ap.setDayNum(dayNum + 1);
					}else{
						ap.setDayNum(dayNum);
					}
					//??????
					ap.setPeopleNum(Integer.valueOf(abroadEdit.getfThisUnitTeamPersonNum()));
					//??????
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
					String foodAndFeeStdAmountStr = foodAndFeeStdAmount + "???" + currency + "???";
					ap.setStandardAmount(foodAndFeeStdAmountStr);
					//??????
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
				if("GWCX".equals(apply.getTravelType())){//????????????
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
	 * ???????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???6???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
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
			//???????????????
			LoanPayeeInfo payeeBean = loanPayeeMng.findBylId(bean.getlId()).get(0);
			List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(bean.getUserId());
			model.addAttribute("payerinfoList", infoList);
			model.addAttribute("payee", payeeBean);
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);
			
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"JKSQ",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getlCode(),"1");
			
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", bean.getDept());
			
			//????????????
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
	 * ????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???6???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
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
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
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
//					DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
//					String time =fmt.format(check.getFcheckTime());     // ????????? X???X???X???
//					check.setFcheckTimes(time);
//				}
//			}
//			model.addAttribute("listTProcessChecks", listTProcessChecks);
			
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HKDJ",bean.getApplyDepId(),bean.getBeanCode(),bean.getNextNodeCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getCode(),"1");
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HKDJ", bean.getApplyDepId());
			//????????????
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
	 * ??????????????????
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???5???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
	 */
	@RequestMapping("/PastePage")
	public String pastePage(String id,ModelMap model){
//		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
//		model.addAttribute("code", bean.getrCode());
		return "/WEB-INF/view/expend/export/PastePage";
	}
	/**
	 * ??????????????????????????????
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???5???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
	 */
	@RequestMapping("/PastePageDir")
	public String PastePageDir(String id,ModelMap model){
		DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(Integer.valueOf(id));
		model.addAttribute("code", bean.getDrCode());
		return "/WEB-INF/view/expend/export/PastePage";
	}
	
	/**
	 * ??????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???6???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
	 */
	@RequestMapping("/requestApply")
	public String requestApply(String id ,ModelMap model){
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		ApplicationBasicInfo abi = applicationBasicInfoMng.getByGCode(bean.getgCode());
		return "redirect:/exportApplyAndReim/applyExprot?id="+abi.getgId();
	}
	
	
	
	/**
	 * ????????????????????????
	 * @param id ????????????id
	 * @param reimburseExprotDirectly
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???6???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
	 */
	@RequestMapping("/reimburseExprotDirectly")
	public String reimburseExprotDirectly(Integer id, ModelMap model ,String editType) {
		try {
			model.addAttribute("urlbase", "http://111.202.125.165:8084/gxjzy_nk");
			//????????????id?????????
			DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(id);
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getReqTime());     // ????????? X???X???X???
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
			//???????????????
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
			
			//?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(), user.getDepartName(), bean.getReqTime());
			model.addAttribute("proposer", proposer);
			List<TProcessPrintDetail> listTProcessChecks  = tProcessPrintDetailMng.findbytab("DirectlyReimbAppliBasicInfo", "drId", bean.getDrId());
			model.addAttribute("listTProcessChecks", listTProcessChecks);
			model.addAttribute("id", id);
			//??????????????????
			List<DirectlyReimbDetail> listDirectly = directlyReimbDetailMng.getMingxi(id);
			model.addAttribute("listDirectly", listDirectly);
			
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//????????????
			List<TProcessCheck> checkList = tProcessCheckMng.checkHistory(tProcessDefin.getFPId(),bean.getBeanCode());
			checkList = tProcessCheckMng.getTrueResult(checkList);
			Collections.reverse(checkList);
			if(1==pro.getFProOrBasic()){//?????????????????????????????????
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
	 * ??????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???6???6???
	 * @updator ?????????
	 * @updatetime 2020???6???6???
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
			//????????????id?????????
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			//?????????????????????
			User user = userMng.findById(bean.getUser());
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			//???????????????
			List<ReimbPayeeInfo> reimbPayeeInfolist = reimbPayeeMng.getByRId(bean.getrId());
			model.addAttribute("listPayee", reimbPayeeInfolist);
			
			//????????????
			ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(bean.getPayId()));
			ReceivPlan receivPlan = new ReceivPlan();
			if("1".equals(cbi.getfUpdateStatus())){//?????????
				Upt upt = uptMng.findByFContId_U(String.valueOf(cbi.getFcId())).get(0);
				if(upt.getfPlanChangeStatus()==1){
					receivPlan.setDataType(1);
					receivPlan.setfUptId_R(upt.getfId_U());
				}
			}else{//?????????
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
			//????????????
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
			//????????????id?????????
			ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
			DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
			String time =fmt.format(bean.getReimburseReqTime());     // ????????? X???X???X???
			model.addAttribute("time",time);	
			//?????????????????????
			User user = userMng.findById(bean.getUser());
			bean.setUserName(user.getName());
			bean.setDeptName(user.getDepartName());
			bean.setReqTime(bean.getReimburseReqTime());
			bean.setReimAmountcapital(MoneyUtil.toChinese(String.valueOf(bean.getAmount())));
			model.addAttribute("bean", bean);
			
			//??????????????????
			List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
			
			List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
			model.addAttribute("listPayee", listPayee);
			//????????????
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
			//??????type????????????
			String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(9));
			if("GWCX".equals(bean.getTravelType())){
				strType = "GWCXBX";
			}
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			
			//????????????
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
	 * <p>Description: ?????????????????????????????????</p>  
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???11???19???
	 * @updator ?????????
	 * @updatetime 2020???11???19???
	 */
	@RequestMapping(value="/laborfee")
	public String laborfee(Integer id, ModelMap model){
		
		model.addAttribute("urlbase", "http://111.202.125.165:8081/gxjzy_nk");
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
		String time =fmt.format(bean.getReimburseReqTime());     // ????????? X???X???X???
		model.addAttribute("time",time);		
		model.addAttribute("bean", bean);
		
		//????????????????????????
		TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", id);
		model.addAttribute("trainingBean", trainingBean);
		
		//????????????
		List<Object> listLecturer = applyMng.getObjectList("LecturerInfo", "tId", trainingBean.gettId());
		
		//?????????????????????
		List<TrainTeacherCost> listTeacherCost = applyMng.getTeacherMingxi(trainingBean.gettId(), "lesson");
		model.addAttribute("listTeacherCost", listTeacherCost);
		BigDecimal netAmount = BigDecimal.ZERO;
		BigDecimal fIndividualIncomeTax = BigDecimal.ZERO;
		BigDecimal amountpayable = BigDecimal.ZERO;
		for (int i = 0; i < listLecturer.size(); i++) {
			LecturerInfo lLInfo= (LecturerInfo) listLecturer.get(i);
			for (int j = 0; j < listTeacherCost.size(); j++) {
				TrainTeacherCost lTeacherCost= listTeacherCost.get(j);
				//??????????????????
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
	 * ???????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ??????
	 * @throws Exception 
	 * @createtime 2020???11???19???
	 * @updator ??????
	 * @updatetime 2020???11???19???
	 */
	@RequestMapping(value="/receptionPayee")
	public String receptionPayee(Integer id, ModelMap model) throws Exception{
		
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		
		//?????????????????????
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
		//??????????????????
		ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
		model.addAttribute("receptionBean", receptionBean);
		
		//??????
		List<Object> listHotel = applyMng.getObjectList("ReceptionHotel", "rId", bean.getrId());
		model.addAttribute("listHotel", listHotel);
		//??????
		List<Object> listFood = applyMng.getObjectList("ReceptionFood", "rId", bean.getrId());
		model.addAttribute("listFood", listFood);
		//????????????
		List<Object> listOther = applyMng.getObjectList("ReceptionOther", "rId", bean.getrId());
		model.addAttribute("listOther", listOther);
		//???????????????
		List<ReimbPayeeInfo> listPayee = reimbPayeeMng.getByRId(id);
		String payType ="";
		String paymentType="";
		String paymentPeople="";
		for (int i = 0; i < listPayee.size(); i++) {
			paymentType=paymentType+listPayee.get(i).getPaymentType()+"/";
			paymentPeople =paymentPeople+listPayee.get(i).getPayeeName()+",";
		}
		
		/*if(paymentType.contains("??????")){
			payType=payType+"??????/";
		}
		if(paymentType.contains("??????")){
			payType=payType+"??????/";
		}
		if(paymentType.contains("??????")){
			payType=payType+"??????/";
		}
		if(paymentType.contains("?????????")){
			payType=payType+"?????????/";
		}
		if(paymentType.contains("????????????")){
			payType=payType+"????????????/";
		}*/
		model.addAttribute("payType", bean.getPaymentType());
		model.addAttribute("paymentPeople", paymentPeople.substring(0, paymentPeople.length()-1));
		DateFormat fmt = new SimpleDateFormat("yyyy???MM???dd???");
		String time =fmt.format(bean.getReqTime());     // ????????? X???X???X???
		model.addAttribute("time",time);
		//????????????
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
		if(1==pro.getFProOrBasic()){//?????????????????????????????????
			model.addAttribute("fPorHead", pro.getFProHead());
			checkList.remove(0);
		}
		if("1".equals(receptionBeans.getReceptionLevel1())){
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("25")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}


				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
					model.addAttribute("role4", tProcessCheck.getFuserName());
				}
			}
		}else{
			for (TProcessCheck tProcessCheck : checkList) {
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals(bean.getDept())){
					model.addAttribute("role1", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("39")){
					model.addAttribute("role2", tProcessCheck.getFuserName());
				}

				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("???????????????")&&userMng.findById(tProcessCheck.getFuserId()).getDepart().getId().equals("29")){
					model.addAttribute("role3", tProcessCheck.getFuserName());
				}
				if(userMng.findById(tProcessCheck.getFuserId()).getRoleName().contains("????????????")){
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
