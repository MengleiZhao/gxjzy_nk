package com.braker.icontrol.expend.reimburse.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import javassist.bytecode.ExceptionsAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.LookupsUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.UserMng;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.core.model.Vehicle;
import com.braker.exception.ServiceException;
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
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.manager.FeteCostInfoMng;
import com.braker.icontrol.expend.apply.manager.FoodAllowanceInfoMng;
import com.braker.icontrol.expend.apply.manager.HotelExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.InCityTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.InternationalTravelingExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.OfficeCarMng;
import com.braker.icontrol.expend.apply.manager.OutsideTrafficInfoMng;
import com.braker.icontrol.expend.apply.manager.TravelAppliInfoMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.OutsideTrafficInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.ReceptionOther;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbDetailMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.expend.standard.entity.AboardStandard;
import com.braker.icontrol.expend.standard.entity.HotelStandard;
import com.braker.icontrol.expend.standard.entity.MeetStandard;
import com.braker.icontrol.expend.standard.entity.RecepStandard;
import com.braker.icontrol.expend.standard.entity.Region;
import com.braker.icontrol.expend.standard.entity.TrainStandard;
import com.braker.icontrol.expend.standard.manager.RegionMng;
import com.braker.icontrol.expend.standard.manager.StandardMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ????????????????????????
 * @author ?????????
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
/**
 * ClassName: ReimburseController 
 * @Description: TODO
 * @author yokoboy
 * @date 2019???8???28???
 */
@Controller
@RequestMapping(value = "/reimburse")
public class ReimburseController extends BaseController {
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private ApplyMng applyMng;
	
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
	private CheterMng cheterMng;
	
	@Autowired
	private AuditInfoMng auditInfoMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;	//??????????????????
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TravelAppliInfoMng travelAppliInfoMng;
	
	@Autowired
	private StandardMng standardMng;
	
	@Autowired
	private InCityTrafficInfoMng inCityTrafficInfoMng;
	
	@Autowired
	private OutsideTrafficInfoMng outsideTrafficInfoMng;
	
	@Autowired
	private FoodAllowanceInfoMng foodAllowanceInfoMng;
	
	@Autowired
	private HotelExpenseInfoMng hotelExpenseInfoMng;
	
	@Autowired
	private OfficeCarMng officeCarMng;
	
	@Autowired
	private InternationalTravelingExpenseInfoMng internationalTravelingExpenseInfoMng;
	
	@Autowired
	private FeteCostInfoMng feteCostInfoMng;
	
	@Autowired
	private VehicleMng vehicleMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private UptMng uptMng;
	
	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	@Autowired
	private RegionMng regionMng;
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@RequestMapping(value = "/list")
	public String list(String reimburseType, ModelMap model) {
		model.addAttribute("reimburseType", reimburseType);
		if("8".equals(reimburseType)){//?????????????????????????????????
			return "/WEB-INF/view/contract/enforcing/enforcing_list";
		}else if("9".equals(reimburseType)){//???????????????????????????
			return "/WEB-INF/view/expend/reimburse/reimburse/current_list";
		}else{
			return "/WEB-INF/view/expend/reimburse/reimburse/apply_reimb_list";
		}
	}
	
	
	/**
	 * @Description:??????????????????????????????????????????
	 * @param @param reimburseType
	 * @param @param model
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author ?????????
	 * @date 2019???8???28???
	 */
	@RequestMapping(value = "/overfulfil")
	public String overfulfil(String standard,String amount,String applyAmount,String sts, ModelMap model) {
		model.addAttribute("standard", standard);
		model.addAttribute("amount", amount);
		model.addAttribute("applyAmount", applyAmount);
		model.addAttribute("sts", sts);
		return "/WEB-INF/view/expend/reimburse/reimburse/overfulfil";
	}
	/**
	 * @Description:?????????????????????????????????
	 * @param @param reimburseType
	 * @param @param model
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author ?????????
	 * @date 2019???8???28???
	 */
	@RequestMapping(value = "/overfulfils")
	public String overfulfils(String standard,String amount,String applyAmount,String sts, ModelMap model) {
		model.addAttribute("standard", standard);
		model.addAttribute("amount", amount);
		model.addAttribute("applyAmount", applyAmount);
		model.addAttribute("sts", sts);
		return "/WEB-INF/view/expend/reimburse/reimburse/overfulfils";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@RequestMapping(value = "/reimbursePage")
	@ResponseBody
	public JsonPagination applyPage(ReimbAppliBasicInfo bean, String reimburseType, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = reimbAppliMng.pageList(bean, reimburseType, page, rows, getUser());
    	List<ReimbAppliBasicInfo> li = (List<ReimbAppliBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
    		//????????????	
			li.get(i).setNum((i+1)+(page-1)*rows);
			//????????????????????????id????????????,?????????????????????
			User user = userMng.findById(li.get(i).getUser());
			if(user!=null){
				li.get(i).setUserName(user.getName());
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * ???????????????id????????????????????????
	 * @param payerbean
	 * @param bean
	 * @param reimburseType
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???21???
	 * @updator ?????????
	 * @updatetime 2020???4???21???
	 */
	@ResponseBody
	@RequestMapping(value = "/payerInfojson")
	public JsonPagination payerInfojson(ReimbPayeeInfo payerbean,ReimbAppliBasicInfo bean, String reimburseType, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
		Pagination p = new Pagination();
		List<ReimbPayeeInfo> list = reimbPayeeMng.getByRId(payerbean.getrId());
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(list.size());
		return getJsonPagination(p, page);
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2020-04-18
	 * @updatetime 2020-04-18
	 */
	@RequestMapping(value = "/applyTravelPage")
	@ResponseBody
	public JsonPagination applyTravelPage(TravelAppliInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		Pagination p = travelAppliInfoMng.rtravelPageList(page, rows, bean);
		
		if("GWCC".equals(bean.getTravelType())){
			List<TravelAppliInfo> list = (List<TravelAppliInfo>) p.getList();
			for(int x=0; x<list.size(); x++) {
				//????????????	
				list.get(x).setTravelAreaId(Integer.valueOf(list.get(x).getTravelArea()));	
			}
			
		}
		
		/*for(int x=0; x<list.size(); x++) {
			//????????????	
			if(list.get(x).getTravelArea()==null){
				list.get(x).setTravelAreaId(null);
			}else{
				list.get(x).setTravelAreaId(Integer.valueOf(list.get(x).getTravelArea().getId()));
			}
			list.get(x).setTravelType(bean.getTravelType());
		}*/
		return getJsonPagination(p, page);
	}
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2020-04-18
	 * @updatetime 2020-04-18
	 */
	@RequestMapping(value = "/applyCarPage")
	@ResponseBody
	public JsonPagination applyCarPage(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		Pagination p = officeCarMng.carPageList(page, rows, rId);
		return getJsonPagination(p, page);
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2020-04-18
	 * @updatetime 2020-04-18
	 */
	@RequestMapping(value = "/applyOutsideTrafficPage")
	@ResponseBody
	public JsonPagination applyOutsideTrafficPage(OutsideTrafficInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		Pagination p = outsideTrafficInfoMng.routsideTrafficInfoPageList(page, rows, bean);
		return getJsonPagination(p, page);
	}
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2020-04-18
	 * @updatetime 2020-04-18
	 */
	@RequestMapping(value = "/applyInCityPage")
	@ResponseBody
	public JsonPagination applyInCityPage(InCityTrafficInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		Pagination p = inCityTrafficInfoMng.rinCityInfoPageList(page, rows, bean);
		return getJsonPagination(p, page);
	}
	/*
	 * ????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-05-12
	 * @updatetime 2020-05-12
	 */
	@RequestMapping(value = "/applyReceptionFoodPage")
	@ResponseBody
	public JsonPagination applyReceptionFoodPage(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("ReceptionFood", "rId", rId);
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, page);
	}
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-05-12
	 * @updatetime 2020-05-12
	 */
	@RequestMapping(value = "/applyReceptionHotelPage")
	@ResponseBody
	public JsonPagination applyReceptionHotelPage(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("ReceptionHotel", "rId", rId);
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, page);
	}
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-05-12
	 * @updatetime 2020-05-12
	 */
	@RequestMapping(value = "/applyReceptionOtherPage")
	@ResponseBody
	public JsonPagination applyReceptionOtherPage(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("ReceptionOther", "rId", rId);
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * ?????????????????????????????????
	 * @author ?????????
	 * @createtime 2020???4???20???
	 * @updator ?????????
	 * @updatetime 2020???4???20???
	 */
	@RequestMapping("/choose")
	public String choose(ModelMap map ,String type,String index,String tabId,String areaId){
		map.addAttribute("type", type);
		map.addAttribute("index", index);
		map.addAttribute("tabId", tabId);
		Region region = new Region();
		Region region1 = new Region();
		Region region2 = new Region();
		Integer shengId = null;
		Integer shiId = null;
		Integer quId = null;
		if(StringUtils.isNotEmpty(areaId)){
			region =regionMng.findById(Integer.valueOf(areaId));
			if(!"0".equals(String.valueOf(region.getpCode()))){
				region1 =regionMng.findById(region.getpCode());
				if(!"0".equals(String.valueOf(region1.getpCode()))){
					shiId = region1.getCode();
					quId = region.getCode();
					region2 =regionMng.findById(region1.getpCode());
					shengId =region2.getCode();
				}else{
					shiId = region.getCode();
					shengId =region1.getCode();
				}
			}
		}
		if(shengId == null){
			shengId = 2260;
		}
		map.addAttribute("shengId", shengId);
		map.addAttribute("shiId", shiId);
		map.addAttribute("quId", quId);
		return "/WEB-INF/view/expend/reimburse/hotelstd_choose";
	}
	
	/**
	 * ???????????????????????????
	 * @author ?????????
	 * @createtime 2020???4???20???
	 * @updator ?????????
	 * @updatetime 2020???4???20???
	 */
	@RequestMapping("/pageList")
	@ResponseBody
	public JsonPagination pageList(String outType,  ModelMap model, Integer page, Integer rows){
		
		if (page == null) page = 1;
		if (rows == null) rows = 100;
		Pagination p = null;
		if ("travel".equals(outType)) {
			HotelStandard bean = new HotelStandard();
			p = standardMng.pageListTravel(bean, getUser(), page, rows);
			
		} else if ("meet".equals(outType)) {
			MeetStandard bean = new MeetStandard();
			p = standardMng.pageListMeet(bean, getUser(), page, rows);
			
		} else if ("train".equals(outType)) {
			TrainStandard bean = new TrainStandard();
			p = standardMng.pageListTrain(bean, getUser(), page, rows);
			
		} else if ("recep".equals(outType)) {
			RecepStandard bean = new RecepStandard();
			p = standardMng.pageListRecep(bean, getUser(), page, rows);
			
		} else if ("aboard".equals(outType)) {
			AboardStandard bean = new AboardStandard();
			p = standardMng.pageListAboard(bean, getUser(), page, rows);
		}
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * ??????????????????????????????????????????
	 * @param model
	 * @param index
	 * @param editType
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???20???
	 * @updatetime 2020???4???20???
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(ModelMap model,String index,String editType,String tabId,String peopId){
		model.addAttribute("index", index);
		model.addAttribute("editType", editType);		
		model.addAttribute("tabId", tabId);
		model.addAttribute("peopId", peopId);
		return "/WEB-INF/view/expend/reimburse/choose_userrole";
	}
	/**
	 * ?????????????????????????????????????????????
	 * @param model
	 * @param index
	 * @param editType
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???20???
	 * @updatetime 2020???4???20???
	 */
	@RequestMapping("/chooseUserAttendTrain")
	public String chooseUserAttendTrain(ModelMap model,String index,String editType,String tabId,String peopId){
		model.addAttribute("index", index);
		model.addAttribute("editType", editType);		
		model.addAttribute("tabId", tabId);
		model.addAttribute("peopId", peopId);
		return "/WEB-INF/view/expend/reimburse/choose_userrole_attend_train";
	}
	
	/**
	 * ????????????????????????????????????
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???18???
	 * @updator ?????????
	 * @updatetime 2020???4???18???
	 */
	@ResponseBody
	@RequestMapping("/foodJson")
	public JsonPagination foodJsonPage(FoodAllowanceInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<FoodAllowanceInfo> list = foodAllowanceInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
		Pagination p = new Pagination();
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(list.size());
		return getJsonPagination(p, page);
	}
	
	/**
	 * ?????????????????????????????????
	 * @param bean
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???18???
	 * @updator ?????????
	 * @updatetime 2020???4???18???
	 */
	@ResponseBody
	@RequestMapping("/hotelJson")
	public JsonPagination hotelJson(HotelExpenseInfo bean, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<HotelExpenseInfo> list = hotelExpenseInfoMng.rfindbygId(bean.getrId(),bean.getTravelType());
		Pagination p = new Pagination();
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(list.size());
		return getJsonPagination(p, page);
	}
	
	/**
	 * ?????????????????????????????????
	 * @param bean
	 * @param model
	 * @param page
	 * @param rows
	 * @return
	 * @author ?????????
	 * @createtime 2020???5???24???
	 * @updator ?????????
	 * @updatetime 2020???5???24???
	 */
	@ResponseBody
	@RequestMapping("/feteCostJson")
	public JsonPagination feteCostJson(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		List<FeteCostInfo> list = feteCostInfoMng.rfindbygId(rId);
		Pagination p = new Pagination();
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(list.size());
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 * @author ?????????
	 * @createtime 2020???5???24???
	 * @updator ?????????
	 * @updatetime 2020???5???24???
	 */
	@RequestMapping(value = "/receptionOther")
	@ResponseBody
	public List<Object> receptionOther(Integer rId) {
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("ReceptionOther", "rId", rId);
		}
		return list;
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping("/add")
	public String add(String reimburseType ,ModelMap model,Integer gId) {
		ApplicationBasicInfo applyBean =applicationBasicInfoMng.findById(gId);
		model.addAttribute("applyBean", applyBean);
		//reimburseType????????????
		ReimbAppliBasicInfo bean = new ReimbAppliBasicInfo();
		bean.setgCode(applyBean.getgCode());
		bean.setgName(applyBean.getgName());     
		bean.setTravelAttendPeop(applyBean.getTravelAttendPeop());
		bean.setTravelAttendPeopId(applyBean.getTravelAttendPeopId());
		bean.setStatement(applyBean.getStatement());
		bean.setReimName(applyBean.getApplyName());
		bean.setFupdateStatus(0);
		bean.setReimburseReason(applyBean.getReason());
		bean.setAmount(applyBean.getAmount());
		bean.setApplyAmount(applyBean.getAmount());
		//?????????????????????
		User user = getUser();
		bean.setType(reimburseType);
		bean.setDept(user.getDpID());
		bean.setUser(user.getId());
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		bean.setWithLoan(0);
		bean.setUserLevel(user.getRoleslevel());
		bean.setfWhetherAccompany(applyBean.getfWhetherAccompany());
		model.addAttribute("xzbgsFile", "xzbgsFile");
		model.addAttribute("dwhFile", "dwhFile");
		
		//????????????????????????
		if(!"4".equals(reimburseType)){
			if (applyBean != null) {
				Integer detailId = applyBean.getProDetailId();
				Integer indexId = applyBean.getIndexId();
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
				bean.setIndexName(applyBean.getIndexName());
				bean.setIndexId(applyBean.getIndexId());
				bean.setProDetailId(applyBean.getProDetailId());
			}
			
		}
		if("1".equals(reimburseType)){
			List<Object> mx = new ArrayList<Object>();
			//??????????????????
			mx = applyMng.getMingxi("ApplicationDetail", "gId",gId);
			Integer index=mx.size();
			model.addAttribute("index", index);
			model.addAttribute("mx", mx);
			model.addAttribute("userid", user.getId());
		}if("6".equals(reimburseType)){
			List<Object> mx = new ArrayList<Object>();
			//??????????????????
			mx = applyMng.getMingxi("OfficeCar", "gId",gId);
			Integer index=mx.size();
			model.addAttribute("index", index);
			model.addAttribute("mx", mx);
		}
		model.addAttribute("bean", bean);
		String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(applyBean.getType()));
		if("GWCX".equals(applyBean.getTravelType())){
			strType = "CXBX";
		}
		if(applyBean.getType().equals("5")){
			ReceptionAppliInfo	receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", applyBean.getgId());
			if("2".equals(receptionBean.getReceptionLevel1())){
				if("1".equals(receptionBean.getIsForeign())){
					strType = "GWJDBX-WB";
				}else{
					strType = "GWJDBX-YJYX";
				}
			}
		}
		//?????????????????????????????????
		List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
		/*if("4".equals(applyBean.getType())){*/
		if(!"4".equals(applyBean.getType())){
			if(null!=bean.getIndexId()){
				TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
				TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
				if(1==pro.getFProOrBasic()){//?????????????????????????????????
					nodeConfList=tProcessCheckMng.getNodeConfZCandCG(user.getId(),strType, user.getDpID(),null,bean.getnCode(), null, null, null, "1", applyBean.getIndexId());
				}else {
					nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),strType, user.getDpID(),null,bean.getnCode(), null, null, null, "1");
				}
			}else{
				nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),strType, user.getDpID(),null,bean.getnCode(), null, null, null, "1");
			}
		}else{
			/*BudgetMessageList budgetMessageList = new BudgetMessageList();
			budgetMessageList.setgId(applyBean.getgId());
			//??????????????????
			List<BudgetMessageList> budgetMessageLists = applyMng.getBudgetMessageList(budgetMessageList,user);
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
			if(1==pro.getFProOrBasic()){//?????????????????????????????????
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(user.getId(),strType,user.getDepart().getId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1",budgetMessageList.getfIndexId());
			}else {
			}*/
		}
		nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),strType,user.getDepart().getId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
		/*}else {
			nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),strType, getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
		}*/
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//??????type????????????JudgmentProcessOff(String type)
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, applyBean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",applyBean.getBeanCode());
		
		//?????????????????????????????????????????????
		String strTypeApply = tProcessCheckMng.JudgmentProcess(String.valueOf(reimburseType));
		if("4".equals(String.valueOf(reimburseType))){
			if("CCLX-01".equals(applyBean.getTravelType())){
				strTypeApply = "CJHY";
			}
			if("CCLX-02".equals(applyBean.getTravelType())){
				strTypeApply = "KCXX";
			}
			if("CCLX-03".equals(applyBean.getTravelType())){
				strTypeApply = "CLQT";
			}
		}
//		if(applyBean.getType().equals("5")){
//			ReceptionAppliInfo	receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", applyBean.getgId());
//			if(receptionBean.getReceptionLevel1().equals("2")){
//				if(receptionBean.getIsForeign().equals("1")){
//					strTypeApply = "GWJDSQ-WB";
//				}else{
//					strTypeApply = "GWJDSQ-YJYX";
//				}
//			}
//		}
		//???????????????id
		TProcessDefin tProcessDefinApply=tProcessDefinMng.getByBusiAndDpcode(strTypeApply, applyBean.getDept());
		model.addAttribute("fpIdAplly", tProcessDefinApply.getFPId());
		//????????????
		model.addAttribute("foCodeAplly",applyBean.getBeanCode());
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(applyBean);
		model.addAttribute("attaList", attaList);
		List<Attachment> attaList1 = attachmentMng.list(bean);
		model.addAttribute("attaList1", attaList1);
		//??????????????????????????????(????????????????????????????????????????????????????????????????????????????????????)
		model.addAttribute("operation", "add");
		if("1".equals(reimburseType)){
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_comm";
		}else if("2".equals(reimburseType)){
			//??????????????????
			MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", gId);
			model.addAttribute("meetingBean", meetingBean);
			model.addAttribute("reimbMeetingBean", meetingBean);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_meeting";
		} else if ("3".equals(reimburseType)) {
			//??????????????????
			TrainingAppliInfo trainBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", gId);
			TrainingAppliInfo reimbTrainingBean = new TrainingAppliInfo();
			
			BeanUtils.copyProperties(trainBean, reimbTrainingBean);
			
			//TrainingAppliInfo reimbTrainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", gId);
			reimbTrainingBean.setZongheMoney(trainBean.getZongheMoney());
			reimbTrainingBean.setLessonsMoney(trainBean.getLessonsMoney());
			reimbTrainingBean.setLessonsHotelMoney(trainBean.getLessonsHotelMoney());
			reimbTrainingBean.setLessonsFoodMoney(trainBean.getLessonsFoodMoney());
			reimbTrainingBean.setLessonsOutMoney(trainBean.getLessonsOutMoney());
			reimbTrainingBean.setLessonsInMoney(trainBean.getLessonsInMoney());
			reimbTrainingBean.setHotelMoney(trainBean.getHotelMoney());
			reimbTrainingBean.setFoodMoney(trainBean.getFoodMoney());
			reimbTrainingBean.setLongTrafficMoney(trainBean.getLongTrafficMoney());
			reimbTrainingBean.setTransportMoney(trainBean.getTransportMoney());
			model.addAttribute("trainingBean", trainBean);
			model.addAttribute("reimbTrainingBean", reimbTrainingBean);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_train";
		}else if("4".equals(reimburseType)){
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", gId);
			model.addAttribute("travelBean", travelBean);
			TravelAppliInfo reimTravelBean = new TravelAppliInfo();
			BeanUtils.copyProperties(travelBean, reimTravelBean);
			model.addAttribute("reimTravelBean", reimTravelBean);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel";
		}else if("5".equals(reimburseType)){
			//??????????????????
			ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", gId);
			ReceptionAppliInfo receptionBeanEdit =new ReceptionAppliInfo();
			BeanUtils.copyProperties(receptionBean, receptionBeanEdit);
			receptionBeanEdit.setReceptionContent(receptionBean.getReceptionContent());
			receptionBeanEdit.setCostFood(null);
			receptionBeanEdit.setCostHotel(null);
			model.addAttribute("receptionBean", receptionBean);
			model.addAttribute("receptionBeanEdit", receptionBeanEdit);     //???????????????
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_reception";
		}else if("6".equals(reimburseType)){
			//????????????????????????
			OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "gId", gId);
			model.addAttribute("officeCar", officeBean);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_car";
		}else if("7".equals(reimburseType)){
			//????????????????????????
			AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", gId);
			model.addAttribute("abroad", abroadBean);
			AbroadAppliInfo abroadEdit = new AbroadAppliInfo();
			BeanUtils.copyProperties(abroadBean, abroadEdit);
			abroadEdit.setTrafficMoney(null);
			abroadEdit.setHotelMoney(null);
			abroadEdit.setFoodMoney(null);
			abroadEdit.setFeteMoney(null);
			abroadEdit.setTravelMoney(null);
			abroadEdit.setMixMoney(null);
			abroadEdit.setTotalOtherMoney(null);
			model.addAttribute("abroadEdit", abroadEdit);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_abroad";
		}else if("12".equals(reimburseType)){
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", gId);
			model.addAttribute("travelBean", travelBean);
			TravelAppliInfo reimTravelBean = new TravelAppliInfo();
			BeanUtils.copyProperties(travelBean, reimTravelBean);
			model.addAttribute("reimTravelBean", reimTravelBean);
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_attend_train";
		}else if("13".equals(reimburseType)){
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_city";
		}else{
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_add3";
		}
	}
	
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/applyList")
	public String applyList(String applyType, ModelMap model) {
		//applyType??????????????????
		model.addAttribute("applyType", applyType);
		return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_apply_list";
	}
	
	/*
	 * AJAX??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-09
	 * @updatetime 2018-08-09
	 */
	@RequestMapping(value = "/findApply")
	@ResponseBody
	public ApplicationBasicInfo findApply(Integer gId) {
		//????????????id?????????
		ApplicationBasicInfo bean = applyMng.findById(gId);
		User user = userMng.findById(bean.getUser());
		bean.setUserNames(user.getName());
		//????????????????????????
		ApplicationBasicInfo apply = bean;
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
		
		return bean;
	}
	
	/*
	 * AJAX?????????????????????????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@RequestMapping(value = "/findOther")
	@ResponseBody
	public Object findOther(Integer gId, String type) {
		if("2".equals(type)) {
			//??????????????????
			MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", gId);
			return meetingBean;
		} else if("3".equals(type)) {
			//??????????????????
			TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", gId);
			return trainingBean;
		} else if("4".equals(type)) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", gId);
			/*//????????????????????????
			TravelPeopleInfo tPeopBean = (TravelPeopleInfo) applyMng.getObject("TravelPeopleInfo", "trId", travelBean.getTrId());*/
			return travelBean;
		} else if("5".equals(type)) {
			//??????????????????
			ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", gId);
			return receptionBean;
		} else if("6".equals(type)) {
			//????????????????????????
			OfficeCar officeCar = (OfficeCar) applyMng.getObject("OfficeCar", "abi.gId", gId);
			return officeCar;
		} else if("7".equals(type)) {
			//????????????????????????
			AbroadAppliInfo abroad = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "abi.gId", gId);
			return abroad;
		} else {
			return null;
		}
	}
	
	/*
	 * ??????????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(ReimbAppliBasicInfo bean,ReimbPayeeInfo payeeBean,String mingxi,String fapiao,String files,ModelMap model,String form1,String form2,
			String form3,String form4,String form5,String form6,String form7,String form8,String form9,String form10,String arry,String travelPeop,TravelAppliInfo travelAppliInfo, 
			String outsideTraffic,					//??????????????????Json
			String inCity,							//???????????????Json
			String hotelJson,						//?????????Json
			String foodJson,                        //??????????????????
			String otherJson,                       //????????????
			String payerinfoJson,					//?????????json
			String travelJson,	                    //????????????json
			String feeJson,							//?????????json
			String feteJson,						//?????????json
			String abroadPlanJson,					//????????????
			String reimburseCartJson,				//????????????????????????json
			MeetingAppliInfo meetingBean,			//????????????
			ReceptionAppliInfo receptionAppliInfo,	//??????????????????
			TrainingAppliInfo trainingBean, 		//????????????
			AbroadAppliInfo abroadBean,             //????????????
			String checkintangibleAssetid,   		//?????????????????????id
			String checkFixedAssetid,   		    //?????????????????????id
			String checkacceptid,   				//?????????id
			String meetPlan, 						//?????????????????????
			String trainPlan,						//????????????
			String trainLecturer,					//????????????
			String zongheJson,						//??????-??????????????????
			String lessonJson,						//??????-???????????????
			String trafficJson1,					//??????????????????
			String trafficJson2,						//???????????????
			String peopleJson,         			//??????????????????
			String accompanyPeopJson,         			//??????????????????
			String observePlanJson,         			//??????????????????
			String studentsJson,         			//??????????????????
			String indexJsons,         			//????????????json
			String abroadPeopleJson
			) {
		try {
			synchronized (this) {
				//??????????????????????????????????????????
				//JSONArray array =JSONArray.fromObject(arry.toString());
				/*JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
				List<ReimbDetail> newmxs = (List<ReimbDetail>)JSONArray.toList(array, ReimbDetail.class);
				for(int i = 0 ; i < newmxs.size() ; i++){
					if((newmxs.get(i).getReimbSum()>newmxs.get(i).getStandard())&&"????????????".equals(newmxs.get(i).getStandard())){//????????????????????????????????????
						return getJsonResult(false,"??????????????????????????????????????????????????????????????????????????????");
					}
				}*/
				Boolean	b = new Boolean(true);
				if(!"8".equals(bean.getType())&&!"9".equals(bean.getType())&&!"4".equals(bean.getType())&&!"10".equals(bean.getType())&&!"5".equals(bean.getType())&&!"12".equals(bean.getType())){
					b = budgetIndexMgrMng.checkAmount(bean);
					TProExpendDetail expendDetail = detailMng.findById(bean.getProDetailId());
					bean.setIndexAmount(expendDetail.getSyAmount());
				}
				
				if(b){
					//???????????????????????????????????????????????????????????????
					User user = getUser();
					Depart depart = departMng.findById(user.getDepart().getId());
					User usera = userMng.findById(depart.getManager().getId());
					if(usera.getRoleName().contains("??????????????????")){
						bean.setIfCfo("???");
					}else{
						bean.setIfCfo("???");
					}
					//??????
					if("2".equals(bean.getType())){
						reimbAppliMng.saveMeeting(bean,meetingBean,form1,payerinfoJson,files, user,meetPlan,mingxi);
					}else if("3".equals(bean.getType())){
						reimbAppliMng.saveTrain(bean, trainingBean, form1,form2,form3,form4,form5,trainLecturer,trainPlan,zongheJson,lessonJson,hotelJson,foodJson,trafficJson1,trafficJson2,payerinfoJson,files, getUser());
					}else if("4".equals(bean.getType())){
						reimbAppliMng.saveTravel(bean, payeeBean,travelPeop,outsideTraffic,inCity,hotelJson,foodJson,otherJson,payerinfoJson,studentsJson,indexJsons,form1,form2,form3,form4,form5,files, getUser());
					}else if("5".equals(bean.getType())){
						reimbAppliMng.saveReception(bean,form1,form2,form3,form4,form5,files, user, receptionAppliInfo, hotelJson, foodJson, otherJson, payerinfoJson,peopleJson,accompanyPeopJson,observePlanJson);
					}else if("6".equals(bean.getType())){
						reimbAppliMng.saveCar(bean, reimburseCartJson,payerinfoJson, arry,files, user);
					}else if("7".equals(bean.getType())){
						reimbAppliMng.saveAbroad(bean, payerinfoJson, form1,form2,form3,form4,form5,
								 travelJson,	     
								 trafficJson1,						//?????????????????????????????????????????????
								 hotelJson,	                    	//?????????json
								 foodJson,							//?????????json
								 feeJson,							//?????????json
								 feteJson,							//?????????json
								 otherJson,							//????????????json
								 abroadPlanJson,					//????????????
								 abroadBean,						//????????????
								files, user,abroadPeopleJson);
					}else if("1".equals(bean.getType())){	
						reimbAppliMng.saveCommon(bean, payeeBean, mingxi,files, user, form1, payerinfoJson);
					}else if("8".equals(bean.getType())){
						reimbAppliMng.saveContract(bean, payeeBean, arry, files, user, form1, payerinfoJson);;
					}else if("9".equals(bean.getType())){	
						reimbAppliMng.saveCurrent(bean, payeeBean, mingxi,files, user, form1, payerinfoJson);
					}else if("10".equals(bean.getType())){	
						reimbAppliMng.savePurchase(bean, payeeBean, files, user, form1);
					}else if("12".equals(bean.getType())){
						reimbAppliMng.saveAttendTrain(bean, payeeBean,travelPeop,outsideTraffic,inCity,hotelJson,foodJson,payerinfoJson,indexJsons,form1,form2,files, getUser(),travelAppliInfo);
					}else if("13".equals(bean.getType())){
						reimbAppliMng.saveTravelCity(bean, payerinfoJson, travelPeop, files, user);
					}else{
						reimbAppliMng.save(bean, payeeBean, mingxi, fapiao, files, user);
					}
				}else {
					return getJsonResult(false,"???????????????????????????????????????????????????");
				}
			}
		} catch (ServiceException ec) {
			ec.printStackTrace();
			return getJsonResult(false,getException(ec));
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,getException(e));
		}
		return getJsonResult(true,"???????????????");
	}
	
	/*
	 * ????????????,????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		try {
			
		
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		//?????????????????????
		User user = userMng.findById(bean.getUser());
		
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		
		
		model.addAttribute("bean", bean);
		//????????????????????????
		ApplicationBasicInfo apply = new ApplicationBasicInfo();
		apply = applyMng.findByCode(bean.getgCode());
		model.addAttribute("applyBean", apply);
		model.addAttribute("xzbgsFile", "xzbgsFile");
		model.addAttribute("dwhFile", "dwhFile");
		if(!"8".equals(bean.getType()) && !"4".equals(bean.getType())){
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
		}
		
		if("4".equals(bean.getType())){
			Integer detailId = bean.getProDetailId();
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
		bean.setIndexName(bean.getIndexName());
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(apply);
		model.addAttribute("attaList", attaList);
		List<Attachment> attaList1 = attachmentMng.list(bean);
		model.addAttribute("attaList1", attaList1);
		String reimburseType = apply.getType();
		if("8".equals(bean.getType())){
			reimburseType="8";
		}
		//??????type????????????
		String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(reimburseType));
		if("GWCX".equals(bean.getTravelType())){
			strType = "CXBX";
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
		List<TNodeData> nodeConfList = new ArrayList<TNodeData>();
		
		//if("4".equals(bean.getType())){
			/*TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			if(1==pro.getFProOrBasic()){//?????????????????????????????????
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1",bean.getIndexId());
			}else {
			}*/
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
			/*}else{
			BudgetMessageList budgetMessageList = new BudgetMessageList();
			budgetMessageList.setrId(bean.getrId());
			//??????????????????
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
			if(1==pro.getFProOrBasic()){//?????????????????????????????????
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1",budgetMessageList.getfIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
			}
			if("CXSQ".equals(strType)&&user.getRoleName().contains("????????????")&&!user.getRoleName().contains("???????????????")){
				for (int i = nodeConfList.size()-1; i >= 0; i--) {
					if(nodeConfList.get(i).getUserId().equals(user.getDepart().getManager().getId())){
						nodeConfList.remove(i);
					}
				}
			}
		}*/
		
		
		
		
		
		model.addAttribute("nodeConf", nodeConfList);
		
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		
		//?????????????????????????????????????????????
		String strTypeApply = tProcessCheckMng.JudgmentProcess(String.valueOf(reimburseType));
		if("GWCX".equals(apply.getTravelType())){
			strTypeApply = "CXSQ";
		}
		/*if("5".equals(apply.getType())){
			ReceptionAppliInfo	receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", apply.getgId());
			if(receptionBean.getReceptionLevel1().equals("2")){
				if(receptionBean.getIsForeign().equals("1")){
					strTypeApply = "GWJDSQ-WB";
				}else{
					strTypeApply = "GWJDSQ-YJYX";
				}
			}
		}*/
		
		//???????????????id
		TProcessDefin tProcessDefinApply=tProcessDefinMng.getByBusiAndDpcode(strTypeApply, bean.getDept());
		model.addAttribute("fpIdAplly", tProcessDefinApply.getFPId());
		//????????????
		model.addAttribute("foCodeAplly",bean.getBeanCode());
		
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//?????????????????????????????????
		ApplicationBasicInfo abi = apply;
		
		//??????????????????
		List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
		//??????????????????
		String type = abi.getType();
		if("8".equals(bean.getType())){
			type="8";
		}
		if("1".equals(type)){
			
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
			model.addAttribute("userid", getUser().getId());
			List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"comm");
			model.addAttribute("Invoicelist", list);//??????????????????
		} else if("2".equals(type)) {
			//??????????????????
			MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", abi.getgId());
			model.addAttribute("meetingBean", meetingBean);
			MeetingAppliInfo reimbMeetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "rId", bean.getrId());
			model.addAttribute("reimbMeetingBean", reimbMeetingBean);
			List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"meeting");
			model.addAttribute("Invoicelist", list);//????????????
			
			
		} else if(type.equals("3")) {
			//??????????????????
			TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", abi.getgId());
			model.addAttribute("trainingBean", trainingBean);
			//??????????????????
			TrainingAppliInfo reimbTrainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "rId", bean.getrId());
			model.addAttribute("reimbTrainingBean", reimbTrainingBean);
			//??????????????????
			List<InvoiceCouponInfo> Invoicelist1 = invoiceCouponMng.findByrID(bean.getrId(),"trainzonghe");
			model.addAttribute("Invoicelist1", Invoicelist1);
			//???????????????
			List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
			model.addAttribute("Invoicelist2", Invoicelist2);
			//????????????
			List<InvoiceCouponInfo> Invoicelist3= invoiceCouponMng.findByrID(bean.getrId(),"receptionfood");
			model.addAttribute("Invoicelist3", Invoicelist3);
			//????????????????????????
			List<InvoiceCouponInfo> Invoicelist4 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
			model.addAttribute("Invoicelist4", Invoicelist4);									
			//?????????????????????
			List<InvoiceCouponInfo> Invoicelist5 = invoiceCouponMng.findByrID(bean.getrId(),"travelincity");
			model.addAttribute("Invoicelist5", Invoicelist5);		
			
		} else if(type.equals("4")) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", abi.getgId());
			model.addAttribute("travelBean", travelBean);
			TravelAppliInfo reimTravelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "rId", bean.getrId());
			model.addAttribute("reimTravelBean", reimTravelBean);
			List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
			model.addAttribute("Invoicelist1", list1);//???????????????
			List<InvoiceCouponInfo> list2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
			model.addAttribute("Invoicelist2", list2);//?????????
			List<InvoiceCouponInfo> list3 = invoiceCouponMng.findByrID(bean.getrId(),"meetTrain");
			model.addAttribute("Invoicelist3", list3);//?????????????????????
			
		} else if(type.equals("5")) {
			//??????????????????
			ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", abi.getgId());
			model.addAttribute("receptionBean", receptionBean);
			
			ReceptionAppliInfo receptionBeans = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "rId", bean.getrId());
			model.addAttribute("receptionBeanEdit", receptionBeans);
			//?????????
			List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
			model.addAttribute("Invoicelist2", Invoicelist2);
			//??????
			List<InvoiceCouponInfo> InvoicelistFood= invoiceCouponMng.findByrID(bean.getrId(),"receptionfood");
			model.addAttribute("InvoicelistFood", InvoicelistFood);
			//?????????
			List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"hotel");
			model.addAttribute("Invoicelist1", list1);									
			//?????????????????????
			List<InvoiceCouponInfo> costRent= invoiceCouponMng.findByrID(bean.getrId(),"costRent");
			model.addAttribute("costRentList", costRent);
			//????????????
			List<InvoiceCouponInfo> InvoicelistOther= invoiceCouponMng.findByrID(bean.getrId(),"receptionother");
			model.addAttribute("InvoicelistOther", InvoicelistOther);

			
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
			AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "gId", abi.getgId());
			model.addAttribute("abroad", abroadBean);
			//??????????????????
			AbroadAppliInfo abroadEdit = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "rId", bean.getrId());
			model.addAttribute("abroadEdit", abroadEdit);
			//??????????????????
			List<InvoiceCouponInfo> Invoicelist1 = invoiceCouponMng.findByrID(bean.getrId(),"mix");
			model.addAttribute("Invoicelist1", Invoicelist1);
			//??????????????????????????????
			List<InvoiceCouponInfo> Invoicelist2 = invoiceCouponMng.findByrID(bean.getrId(),"traveloutside");
			model.addAttribute("Invoicelist2", Invoicelist2);
			//???????????????
			List<InvoiceCouponInfo> Invoicelist3= invoiceCouponMng.findByrID(bean.getrId(),"travelhotel");
			model.addAttribute("Invoicelist3", Invoicelist3);
			//???????????????
			List<InvoiceCouponInfo> Invoicelist4 = invoiceCouponMng.findByrID(bean.getrId(),"travelfete");
			model.addAttribute("Invoicelist4", Invoicelist4);									
			//??????????????????
			List<InvoiceCouponInfo> Invoicelist5 = invoiceCouponMng.findByrID(bean.getrId(),"travelother");
			model.addAttribute("Invoicelist5", Invoicelist5);
		} else if(type.equals("8")) {
			ContractBasicInfo beanC = formulationMng.findById(Integer.valueOf(bean.getPayId()));
			if("1".equals(beanC.getfUpdateStatus())){
				Upt upt = uptMng.findByFContId_U(String.valueOf(beanC.getFcId())).get(0);
				model.addAttribute("upt", upt);
				model.addAttribute("contractUpdateStatus", "1");
			}else{
				model.addAttribute("contractUpdateStatus", "0");
			}
			//??????????????????
			//cost =reimbAppliMng.findByRId(bean.getrId());
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
			model.addAttribute("userid", getUser().getId());
			List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"contract-1");
			model.addAttribute("Invoicelist", list);//??????
		} else if(type.equals("12")) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", abi.getgId());
			model.addAttribute("travelBean", travelBean);
			TravelAppliInfo reimTravelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "rId", bean.getrId());
			model.addAttribute("reimTravelBean", reimTravelBean);
			List<InvoiceCouponInfo> list1 = invoiceCouponMng.findByrID(bean.getrId(),"outsideAttend");
			model.addAttribute("Invoicelist1", list1);//???????????????
			List<InvoiceCouponInfo> list2 = invoiceCouponMng.findByrID(bean.getrId(),"hotelAttend");
			model.addAttribute("Invoicelist2", list2);//?????????
		}
		
		if(editType.equals("1")){
			//??????????????????????????????(????????????????????????????????????????????????????????????????????????????????????)
			model.addAttribute("operation", "edit");
			if(type.equals("1")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_comm";
			}else if(type.equals("2")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_meeting";
			}else if(type.equals("3")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_train";
			}else if(type.equals("4")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel";
			}else if(type.equals("5")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_reception";
			}else if(type.equals("6")){
				model.addAttribute("type", "detail");
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_car";
			}else if(type.equals("7")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_abroad";
			}else if(type.equals("8")){
				return "/WEB-INF/view/contract/enforcing/enforcing_add";
			}else if(type.equals("12")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_attend_train";
			}else if(type.equals("13")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_city";
			} else{
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_edit";
			}
			
		} else if(editType.equals("0")){
			//????????????????????????????????????
			model.addAttribute("detail", "1");
			model.addAttribute("detail2", "1");
			model.addAttribute("operation", "detail");
			if(type.equals("1")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_comm_detail";
			}else if(type.equals("2")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_meeting_detail";
			}else if(type.equals("3")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_train_detail";
			}else if(type.equals("4")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_detail";
			}else if(type.equals("5")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_reception_detail";
			}else if(type.equals("6")){
				model.addAttribute("type", "detail");
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_car_detail";
			}else if(type.equals("7")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_abroad_detail";
			}else if(type.equals("8")){
				return "/WEB-INF/view/contract/enforcing/enforcing_detail";
			}else if(type.equals("12")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_attend_train_detail";
			}else if(type.equals("13")){
				return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_travel_city_detail";
			}else 
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_detail";
		} else {
			return null;
		}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * ????????????,????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@RequestMapping("/edit1")
	public String edit1(Integer id, ModelMap model ,String editType) {
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(id);
		//?????????????????????
		User user = userMng.findById(bean.getUser());
		
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		model.addAttribute("bean", bean);
		
		//?????????????????????
		ReimbPayeeInfo payeeBean = reimbPayeeMng.getByRId(id).get(0);
		List<PaymentMethodInfo> infoList = paymentMethodInfoMng.findByPayeeId(user.getId());
		if(payeeBean==null&&infoList.size()>0) {
			payeeBean.setBank(infoList.get(0).getBank());//??????
			payeeBean.setBankAccount(infoList.get(0).getBankAccount());//????????????
			payeeBean.setZfbAccount(infoList.get(0).getZfbAccount());//???????????????
			payeeBean.setZfbQR(infoList.get(0).getZfbQR());//????????????????????????
			payeeBean.setWxAccount(infoList.get(0).getWxAccount());//????????????
			payeeBean.setWxQR(infoList.get(0).getWxQR());//?????????????????????
		}
		model.addAttribute("payee", payeeBean);
		
		//??????????????????
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"BXSQ", bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("BXSQ", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//?????????????????????????????????
		ApplicationBasicInfo abi = applicationBasicInfoMng.getByGCode(bean.getgCode());
		//??????????????????
		String type = abi.getType();
		if(type.equals("1")){
			
		} else if(type.equals("2")) {
			//??????????????????
			MeetingAppliInfo meetingBean = (MeetingAppliInfo) applyMng.getObject("MeetingAppliInfo", "gId", abi.getgId());
			model.addAttribute("meetingBean", meetingBean);
			
			
		} else if(type.equals("3")) {
			//??????????????????
			TrainingAppliInfo trainingBean = (TrainingAppliInfo) applyMng.getObject("TrainingAppliInfo", "gId", abi.getgId());
			model.addAttribute("trainingBean", trainingBean);
			
			
		} else if(type.equals("4")) {
			//??????????????????
			TravelAppliInfo travelBean = (TravelAppliInfo) applyMng.getObject("TravelAppliInfo", "gId", abi.getgId());
			model.addAttribute("travelBean", travelBean);
			/*//????????????????????????
			TravelPeopleInfo tPeopBean = (TravelPeopleInfo) applyMng.getObject("TravelPeopleInfo", "trId", travelBean.getTrId());
			model.addAttribute("tPeopBean", tPeopBean);*/
			
		} else if(type.equals("5")) {
			//??????????????????
			ReceptionAppliInfo receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", abi.getgId());
			model.addAttribute("receptionBean", receptionBean);
			
		} else if(type.equals("6")) {
			//????????????????????????
			OfficeCar officeBean = (OfficeCar) applyMng.getObject("OfficeCar", "abi.gId", id);
			model.addAttribute("officeCar", officeBean);
			
		} else if(type.equals("7")) {
			//????????????????????????
			AbroadAppliInfo abroadBean = (AbroadAppliInfo) applyMng.getObject("AbroadAppliInfo", "abi.gId", id);
			model.addAttribute("abroad", abroadBean);
			
		}
		
		if(editType.equals("1")){
			//??????????????????????????????(????????????????????????????????????????????????????????????????????????????????????)
			model.addAttribute("detail", "1");
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_add2";
			
		} else if(editType.equals("0")){
			//????????????????????????????????????
			model.addAttribute("detail", "1");
			model.addAttribute("detail2", "1");
			return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_detail1";
		} else {
			return null;
		}
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fId) {
		try {
			//????????????id?????????
			reimbAppliMng.delete(id,fId,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ??????????????????
	 * @param id
	 * @return
	 * @author wanping
	 * @createtime 2020???8???29???
	 * @updator wanping
	 * @updatetime 2020???8???29???
	 */
	@RequestMapping(value = "/deleteEnforcingList")
	@ResponseBody
	public Result deleteEnforcingList(Integer id) {
		try {
			//????????????id?????????
			reimbAppliMng.deleteEnforcingList(id,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ??????????????????(app)
	 * @param id
	 * @return
	 * @author shenfan 
	 * @createtime 2020???9???7???
	 */
	@RequestMapping(value = "/deleteEnforcingListApp")
	@ResponseBody
	public Result deleteEnforcingListApp(Integer id,String userId) {
		try {
			User user=userMng.findById(userId);
			//????????????id?????????
			reimbAppliMng.deleteEnforcingList(id,user);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(Integer rId) {
		Pagination p = new Pagination();
		List<ReimbDetail> li = reimbDetailMng.getMingxi(rId);
		p.setList(li);
		return getJsonPagination(p, 0);
	}
	
	
	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	@RequestMapping(value = "/mingxiTY")
	@ResponseBody
	public List<Object> mingxiTY(Integer rId) {
		List<Object> mingxiList = new ArrayList<Object>();
		if(rId != null) {	
			//??????????????????
			mingxiList = applyMng.getMingxi("ApplicationDetail", "rId", rId);
		}
		return mingxiList;
	}
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	/*@RequestMapping(value = "/invoice")
	@ResponseBody
	public JsonPagination invoice(Integer id) {
		Pagination p = new Pagination();
		List<InvoiceInfo> list = invoiceMng.findByRID("2", id);
		
		for (int i = 0; i < list.size(); i++) {
			List<InvoiceCouponInfo> couponList = invoiceCouponMng.findByIID(list.get(i).getiId());
			list.get(i).setCouponList(couponList);
		}
		
		p.setList(list);
		return getJsonPagination(p, 0);
	}*/
	
	/*
	 * ????????????AJAX
	 * @author ?????????
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 
	@RequestMapping(value = "/file")
	@ResponseBody
	public Result file(ModelMap model, @RequestParam(value="attFiles",required=false) MultipartFile[] attFiles){
		try {
			//????????????????????????
			String ids = attachmentMng.uploadAjax(attFiles,null,FileUpLoadUtil.getBXSQSavePath(),getUser());
			if (ids != null) {
				return getJsonResult(true,ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,e.getMessage());
		}
		return null;
	}*/
	
	/**
	 * ??????????????????
	 * @author ?????????
	 * @param model
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping("/export")
	public String export(ModelMap model, HttpServletResponse response, HttpServletRequest request,String applyString){
		OutputStream out = null;
		try {
			//?????????
			response.setHeader("Content-Disposition","attachment; filename="+new String("????????????".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\??????????????????.xls";
			//????????????
			String userId = getUser().getId();
			//????????????????????????
			List<DirectlyReimbAppliBasicInfo>  drLedgerData = directlyReimbMng.ledgerList(applyString,userId);
			
			//????????????????????????
			List<ReimbAppliBasicInfo> rLedgerData = reimbAppliMng.ledgerList(applyString,userId);
			
			//??????excel?????????
			HSSFWorkbook workbook = reimbAppliMng.exportLedger(drLedgerData, rLedgerData, filePath);
			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}  
			}
		}
		return null;
	}
	

	/**
	 * @Description: ????????????????????????
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author ?????????
	 * @date 2019???10???8???
	 */
	@RequestMapping(value = "/reimburseReCall")
	@ResponseBody
	public Result reimburseReCall(Integer id) {
		try {
			synchronized (this) {
				//????????????id?????????
				reimbAppliMng.reimburseReCall(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true,"???????????????");	
	}
	
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2020-05-20
	 * @updatetime 2020-05-20
	 */
	@RequestMapping(value = "/internationalTravelingExpense")
	@ResponseBody
	public JsonPagination internationalTravelingExpense(Integer rId, ModelMap model, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = 100;}
		Pagination p = new Pagination();
		List<InternationalTravelingExpense> list = internationalTravelingExpenseInfoMng.rfindbygId(rId);
		for (InternationalTravelingExpense expense : list) {
			List<Vehicle> Vehicle = vehicleMng.findByCode(expense.getVehicle());
			if(Vehicle!=null&&Vehicle.size()>0){
				Vehicle vh= Vehicle.get(0);
				expense.setVehicleText(vh.getName());
			}
		}
		p.setList(list);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 * @author ?????????
	 * @createtime 2020???5???24???
	 * @updator ?????????
	 * @updatetime 2020???5???24???
	 */
	@RequestMapping(value = "/miscellaneousFee")
	@ResponseBody
	public List<Object> miscellaneousFee(Integer rId) {
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("MiscellaneousFeeInfo", "rId", rId);
		}
		return list;
	}
	
	/*
	 * ???????????????????????????????????? (??????)
	 * @author ??????
	 * @createtime 2020-05-24
	 * @updatetime 2020-05-24
	 */
	@RequestMapping(value = "/abroadPlan")
	@ResponseBody
	public List<Object> abroadPlan(Integer rId) {
		List<Object> list = new ArrayList<Object>();
		if(rId != null) {
			//??????????????????
			list = applyMng.getObjectList("AbroadPlan", "rId", rId);
		}
		return list;
	}
	
	
	
	/**
	 * 
	 * @param list
	 * @return
	 * @author ?????????	
	 * @createtime 2020???5???27???
	 * @updator ?????????
	 * @updatetime 2020???5???27???
	 */
	@ResponseBody
	@RequestMapping("/getRepetition")
	public int getRepetition(String list){
		List<TravelAppliInfo> lists = JSON.parseObject(list,new TypeReference<List<TravelAppliInfo>>(){});
		int num =0;
		for (int i = 0; i < lists.size(); i++) {
			TravelAppliInfo bean  = new TravelAppliInfo();
			bean.setTravelAreaTime(lists.get(i).getTravelAreaTime());
			bean.setrId(lists.get(i).getrId());
			List<TravelAppliInfo> appliInfo = travelAppliInfoMng.travelPageRepetitionListReim(bean);
			for (int j = 0; j < appliInfo.size(); j++){
				if(appliInfo.get(j).getTravelAttendPeopId().equals(lists.get(i).getTravelAttendPeopId())){
					num =1;
				}
			}
		}
		return num;
	}
	
	/*
	 * ??????????????????
	 * @author ??????
	 * @createtime 2020-02-13
	 * @updatetime 2020-02-13
	 */
	@RequestMapping(value = "/meetPlan")
	@ResponseBody
	public List<Object> meetPlan(Integer id) {
		List<Object> list = new ArrayList<Object>();
		if(id != null) {
			//??????????????????
			list = applyMng.getObjectList("MeetingPlan", "rId", id);
		}
		return list;
	}
	/*
	 * ??????????????????
	 * @author ??????
	 * @createtime 2020-02-13
	 * @updatetime 2020-02-13
	 */
	@RequestMapping(value = "/reimbStudents")
	@ResponseBody
	public List<Object> reimbStudents(Integer id) {
		List<Object> list = new ArrayList<Object>();
		if(id != null) {
			//??????????????????
			list = applyMng.getObjectList("StudentsList", "rId", id);
		}
		return list;
	}
	
	/**
	 * ?????????????????????????????????
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author ?????????
	 * @createtime 2020???8???28???
	 * @updator ?????????
	 * @updatetime 2020???8???28???
	 */
	@ResponseBody
	@RequestMapping(value = "/payeelookupsJson")
	public List<ComboboxJson> payeelookupsJson(String parentCode,String selected,String blanked){
		List<Lookups> list = reimbPayeeMng.getpayeelookupsJson(parentCode, blanked,selected);
		return getComboboxJsonNoDefault(list,selected);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/findbypayeeId")
	public ReimbPayeeInfo findbypayeeId(String id){
		ReimbPayeeInfo bean = reimbPayeeMng.findById(Integer.valueOf(id));
		return bean;
	}
	
	/**
	 * 
	 * <p>Title: addCurrent</p>  
	 * <p>Description: ?????????????????????????????????</p>  
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???11???10???
	 * @updator ?????????
	 * @updatetime 2020???11???10???
	 */
	@RequestMapping(value="/addCurrent")
	public String addCurrent(ModelMap model){
		User user = getUser();
		ReimbAppliBasicInfo bean = new ReimbAppliBasicInfo();
		bean.setUser(user.getId());
		bean.setDept(user.getDpID());
		bean.setDeptName(user.getDepartName());
		bean.setUserName(user.getName());
		bean.setReimburseReqTime(new Date());
		bean.setType("9");
		bean.setgName(user.getName()+"-???????????????-"+DateUtil.formatDate(new Date()));
		model.addAttribute("bean", bean);
		model.addAttribute("index", 0);
		model.addAttribute("operation", "add");
		
		//??????type????????????
		String strType = tProcessCheckMng.JudgmentProcessOff(String.valueOf(bean.getType()));
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),strType, getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(strType, getUser().getDpID());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);	
		//??????????????????
		String historyNodes=tProcessCheckMng.getHistoryNodes(strType,getUser().getDpID(),bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);
	
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_current";
	}
	
	/**
	 * 
	 * <p>Title: editCurrent</p>  
	 * <p>Description: ??????????????????</p>  
	 * @param id ??????ID
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???11???12???
	 * @updator ?????????
	 * @updatetime 2020???11???12???
	 */
	@RequestMapping(value="/editCurrent")
	public String editCurrent(String id, ModelMap model){
		
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		model.addAttribute("bean", bean);
		model.addAttribute("operation", "edit");
		List<Attachment> attaList1 = attachmentMng.list(bean);
		model.addAttribute("attaList1", attaList1);
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKBX",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKBX", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("???????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		Integer x=0;
		//??????????????????
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
		model.addAttribute("userid", user.getId());
		List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"current");
		model.addAttribute("Invoicelist", list);//??????????????????
		return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_current";
	}
	
	
	@RequestMapping(value="/detailCurrent")
	public String detailCurrent(String id, ModelMap model){
		
		//????????????id?????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getUser());
		bean.setUserName(user.getName());
		bean.setDeptName(user.getDepartName());
		bean.setReqTime(bean.getReimburseReqTime());
		model.addAttribute("bean", bean);
		model.addAttribute("operation", "detail");
		List<Attachment> attaList1 = attachmentMng.list(bean);
		model.addAttribute("attaList1", attaList1);
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(),"WLKBX",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("WLKBX", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("???????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		Integer x=0;
		//??????????????????
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
		model.addAttribute("userid", user.getId());
		List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"current");
		model.addAttribute("Invoicelist", list);//??????????????????
		return "/WEB-INF/view/expend/reimburse/reimburse/reimburse_current_detail";
	}
	
	
	/**
	 * <p>Title: getProNameData</p>  
	 * <p>Description: ???????????????????????????????????????</p>  
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @throws Exception
	 * @author ?????????
	 * @createtime 2020???11???12???
	 * @updator ?????????
	 * @updatetime 2020???11???12???
	 */
	@ResponseBody
	@RequestMapping(value = "/getProNameData")
	public List<ComboboxJson> getProNameData(String parentCode,String selected,String blanked) throws Exception{
		User user = getUser();
		AccountsCurrent bean = new AccountsCurrent();
		bean.setUserId(user.getId());
		bean.setFlowStauts("9");
		Pagination p = accountsCurrentMng.pageList(bean, 1, 10000, user);
		List<AccountsCurrent> list = (List<AccountsCurrent>) p.getList();
		return getComboboxJson(list, selected);
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2020-11-16
	 * @updatetime 2020-11-16
	 */
	@RequestMapping(value = "/budgetMessageList")
	@ResponseBody
	public List<BudgetMessageList> budgetMessageList(BudgetMessageList bean, ModelMap model) {
		List<BudgetMessageList> list = new ArrayList<BudgetMessageList>();
		if(bean.getgId() != null || bean.getrId() != null) {
			//??????????????????
			list = applyMng.getBudgetMessageList(bean,getUser());
		}
		return list;
	}
	
	/*
	 * ????????????????????????????????????
	 * @author ?????????
	 * @createtime 2020-11-16
	 * @updatetime 2020-11-16
	 */
	@RequestMapping(value = "/receptionOthers")
	@ResponseBody
	public List<ReceptionOther> receptionOthers(ReceptionOther bean, ModelMap model) {
		List<ReceptionOther> list = new ArrayList<ReceptionOther>();
		if(bean.getgId() != null || bean.getrId() != null) {
			//??????????????????
			list = applyMng.getReceptionOther(bean,getUser());
		}
		return list;
	}
	
	
	/**
	 * ??????????????????????????????????????????
	 * @param model
	 * @param index
	 * @param editType
	 * @return
	 * @author ?????????
	 * @createtime 2020???4???20???
	 * @updatetime 2020???4???20???
	 */
	@RequestMapping("/chooseUserCityReim")
	public String chooseUserCityReim(ModelMap model){
		return "/WEB-INF/view/expend/reimburse/choose_userrole_city";
	}
}
