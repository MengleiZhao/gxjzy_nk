package com.braker.icontrol.contract.filing.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.EnforcingMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
@Controller
@RequestMapping("/proceedsPlan")
public class ProceedsPlanController extends BaseController{
	
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private ContPayMng contPayMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private EnforcingMng enforcingMng;
	@Autowired
	private FormulationMng formulationMng;
	/**
	 * ????????????list??????
	 * @param model
	 * @return
	 * @createtime 2020-12-22
	 * @author ?????????
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/income_manage/contractRevenue/contractRevenueRegisterList";
	}
	
	/**
	 * ????????????list??????
	 * @param model
	 * @return
	 * @createtime 2020-12-22
	 * @author ?????????
	 */
	@RequestMapping("/listcheck")
	public String listCheck(ModelMap model){
		return "/WEB-INF/view/income_manage/contractRevenue/contractRevenueRegisterListCheck";
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param ProceedsPlan
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2020-12-23
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,ProceedsPlan bean,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=proceedsPlanMng.pagelist(contractBasicInfo,bean, page, rows, getUser());
    	List<ContractBasicInfo> li=(List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			//List<Upt> upt = uptMng.findByFContId_U(li.get(i).getFcId().toString());
			/*if (upt.size()>0) {
				for(int z = 0;z<upt.size();z++){
					if (upt.get(z).getfUptFlowStauts().equals("9")) {
						li.get(i).setFcAmount(upt.get(z).getfAmount().toString());
					}
				}
			}*/
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p,page);
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param ProceedsPlan
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2020-12-23
	 * @author crc
	 */
	@RequestMapping("/JsonPaginationCheck")
	@ResponseBody
	public JsonPagination jsonPaginationCheck(ContractBasicInfo contractBasicInfo,ProceedsPlan bean,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=proceedsPlanMng.pagelistCkeck(contractBasicInfo,bean, page, rows, getUser());
    	List<ContractBasicInfo> li=(List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			//List<Upt> upt = uptMng.findByFContId_U(li.get(i).getFcId().toString());
			/*if (upt.size()>0) {
				for(int z = 0;z<upt.size();z++){
					if (upt.get(z).getfUptFlowStauts().equals("9")) {
						li.get(i).setFcAmount(upt.get(z).getfAmount().toString());
					}
				}
			}*/
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model,String cId,String type){
		model.addAttribute("id", id);
		model.addAttribute("cId", cId);
		model.addAttribute("type", type);
		if (getUser().getRoleName().contains("?????????")) {
			model.addAttribute("show", "1");
		}else {
			model.addAttribute("show", "0");
		}
		ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(id));
		if (cbi.getIskjht() == 1) {
			return "/WEB-INF/view/income_manage/contractRevenue/contra_plan_list_add";
		}else {
			return "/WEB-INF/view/income_manage/contractRevenue/contra_plan_list";
		}
	}
	
	/**
	 * ???????????????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/editCheck/{id}")
	public String editCheck(@PathVariable String id,ModelMap model,String cId,String type){
		model.addAttribute("id", id);
		model.addAttribute("cId", cId);
		model.addAttribute("type", type);
		return "/WEB-INF/view/income_manage/contractRevenue/contra_plan_list_check";
	}
	
	/**
	 * ????????????????????????
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/planJsonPagination/{id}")
	@ResponseBody
	public JsonPagination planJsonPagination(@PathVariable String id,ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows, ModelMap model) throws ParseException{
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = proceedsPlanMng.allProceedsPlan(Integer.valueOf(id), page, rows);
		List<ProceedsPlan> li=(List<ProceedsPlan>) p.getList();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 0; i < li.size(); i++) {
	        Date parse = sdf.parse(sdf.format(new Date()));
	        Date parse2 = sdf.parse(sdf.format(li.get(i).getfProceedsTime()));
	        Calendar cal = Calendar.getInstance();  
	        cal.setTime(parse);  
	        long time1 = cal.getTimeInMillis();               
	        cal.setTime(parse2);  
	        long time2 = cal.getTimeInMillis();       
	        long between_days=(time2-time1)/(1000*3600*24);
	        int a = (int)between_days;
	        String status = null;
			if (between_days>15) {
				status = "0";
			}else if (a<=15) {
				if (a>=0) {
					status = "1";
				}else {
					status = "2";
				}
			}
			li.get(i).setFcqyj(status);
		}
    	p.setList(li);
		return getJsonPagination(p,page);
	}
	
	
	/**
	 * @Description: ??????????????????????????????????????????
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author ?????????
	 * @date 2020???12???21???
	 */
	@RequestMapping(value = "/getUptStatus")
	@ResponseBody
	public String getUptStatus(Integer id) {
		ProceedsPlan findById = proceedsPlanMng.findById(Integer.valueOf(id));
		ContractBasicInfo contractBasicInfo=filingMng.findById(findById.getfContId());
		if("1".equals(contractBasicInfo.getfUpdateStatus())){
			//Upt upt=uptMng.findByFContId_U(contractBasicInfo.getFcId().toString()).get(0);
			if(!"1".equals(contractBasicInfo.getFsealedStatus())){
				return "2";
			}
		}
		return contractBasicInfo.getfUpdateStatus();
	}
	
	/**
	 * ???????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ych
	 * @createtime 2018-08-20
	 */
	@RequestMapping(value = "/add")
	public String check(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(fPlanId);
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "add");
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		ReimbPayeeInfo payee =new ReimbPayeeInfo();
		payee.setPayeeName(sign.getfSignName());
		payee.setBank(sign.getfBankName());
		payee.setBankAccount(sign.getfCardNo());
		model.addAttribute("payee", payee);
		//????????????????????????
		ProceedsPlan findById = proceedsPlanMng.findById(Integer.valueOf(id));
		model.addAttribute("payBean", findById);
		//????????????????????????
		ContPay contPay=new ContPay();
		List<ContPay> contPayList = contPayMng.findByFPlanid(findById.getfPId());
		if(contPayList!=null&&contPayList.size()!=0) {
			contPay = contPayList.get(0);
			contPay.setIsSame("1");
			model.addAttribute("contBean", contPay);
		}
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTSR", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTSR", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}
		
		Proposer proposer =null;
		if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
			//?????????????????????????????????
			proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		}
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/contract/enforcing/Proceeds_add";
	}
	
	/**
	 * ????????????????????????????????????
	 * @author ych
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@RequestMapping(value = "/savesk")
	@ResponseBody
	public Result savesk(ContPay bean, ProceedsPlan receivPlanBean,Integer id,Integer fPlanId,String fhtzxFiles, String fReceAmount,ReimbPayeeInfo payee,String form1) {
		try {
			//????????????????????????
			bean.setfReAmount(bean.getfReAmount());
			//??????????????????
			ProceedsPlan findById;
			if (null == fPlanId) {
				findById = new ProceedsPlan();
				ContractBasicInfo cbi = formulationMng.findById(id);
				findById.setfContId(id);
				findById.setfProceedsCondition(receivPlanBean.getfProceedsCondition());
				findById.setfProceedsTime(receivPlanBean.getfProceedsTime());
				findById.setDataType(Integer.valueOf(cbi.getFhttype()));
				findById.setfProceedsProperty(receivPlanBean.getfProceedsProperty());
			}else {
				 findById = proceedsPlanMng.findById(fPlanId);
			}
			//findById.setfContId(payee.getContId());
			proceedsPlanMng.savesk(bean, findById, getUser(),fhtzxFiles,payee,form1);
			return getJsonResult(true,"???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
	}
	
	/**
	 * ????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ych
	 * @createtime 2018-08-20
	 */
	@RequestMapping(value = "/insert")
	public String InsertPro(String id,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "edit");
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//????????????????????????
		ContPay contPay=new ContPay();
		model.addAttribute("contBean", contPay);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
		List<CostDetailInfo> cost =new ArrayList<CostDetailInfo>();
		Integer index =cost.size();
		model.addAttribute("x", x);
		model.addAttribute("index", index);
		model.addAttribute("cost", cost);
		model.addAttribute("userid", getUser().getId());
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTSR", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTSR", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}
		
		Proposer proposer =null;
		if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
			//?????????????????????????????????
			proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		}
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTSR", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		return "/WEB-INF/view/contract/enforcing/Proceeds_add_pro";
	}
	
	/**
	 * ????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ych
	 * @createtime 2018-08-20
	 */
	@RequestMapping(value = "/edits")
	public String edits(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "edit");
		//Upt upt=uptMng.findByFContId_U(id).get(0);
		//model.addAttribute("Upt", upt);
		//model.addAttribute("UptAttac", uptAttacMng.findByfId_U_AU(upt.getfId_U()).get(0));
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//????????????????????????
		ProceedsPlan findById = proceedsPlanMng.findById(fPlanId);
		model.addAttribute("payBean", findById);
		//????????????????????????
		ContPay contPay=new ContPay();
		if(!StringUtil.isEmpty(String.valueOf(findById.getProId()))){
			contPay = contPayMng.findById(findById.getProId());
		}
		model.addAttribute("contBean", contPay);
		//ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
		//model.addAttribute("payee", payee);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
		List<CostDetailInfo> cost =new ArrayList<CostDetailInfo>();
		/*for(int i = 0;i <cost.size();i++){
			List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
			for(int j = 0;j <fp.size();j++){
				x=x+1;
				fp.get(j).setNum(x);
			}
			cost.get(i).setCouponList(fp);
			cost.get(i).setNum(x);
		}*/
		Integer index =cost.size();
		model.addAttribute("x", x);
		model.addAttribute("index", index);
		model.addAttribute("cost", cost);
		model.addAttribute("userid", getUser().getId());
		//List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(contPay.getPayId(),"contract");
		//model.addAttribute("Invoicelist", list);//??????????????????
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTSR", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTSR", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}
		
		Proposer proposer =null;
		if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
			//?????????????????????????????????
			proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		}
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTSR", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		if (contractBasicInfo.getIskjht() != 1) {
			return "/WEB-INF/view/contract/enforcing/Proceeds_add";
		}else {
			return "/WEB-INF/view/contract/enforcing/Proceeds_edit_pro";
		}
	}
	
	/**
	 * ??????????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020-12-18
	 */
	@RequestMapping(value = "/detailPro")
	public String detailPay(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "edit");
		//Upt upt=uptMng.findByFContId_U(id).get(0);
		//model.addAttribute("Upt", upt);
		//model.addAttribute("UptAttac", uptAttacMng.findByfId_U_AU(upt.getfId_U()).get(0));
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//????????????????????????
		ProceedsPlan findById = proceedsPlanMng.findById(fPlanId);
		model.addAttribute("payBean", findById);
		//????????????????????????
		ContPay contPay=new ContPay();
		if(!StringUtil.isEmpty(String.valueOf(findById.getProId()))){
			contPay = contPayMng.findById(findById.getProId());
		}
		model.addAttribute("contBean", contPay);
		//ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
		//model.addAttribute("payee", payee);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
		List<CostDetailInfo> cost =new ArrayList<CostDetailInfo>();
		/*for(int i = 0;i <cost.size();i++){
			List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
			for(int j = 0;j <fp.size();j++){
				x=x+1;
				fp.get(j).setNum(x);
			}
			cost.get(i).setCouponList(fp);
			cost.get(i).setNum(x);
		}*/
		Integer index =cost.size();
		model.addAttribute("x", x);
		model.addAttribute("index", index);
		model.addAttribute("cost", cost);
		model.addAttribute("userid", getUser().getId());
		//List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(contPay.getPayId(),"contract");
		//model.addAttribute("Invoicelist", list);//??????????????????
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTSR", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTSR", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}
		
		Proposer proposer =null;
		if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
			//?????????????????????????????????
			proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		}
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTSR", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		if (contractBasicInfo.getIskjht() != 1) {
			return "/WEB-INF/view/contract/enforcing/Proceeds_add_detail";
		}else {
			return "/WEB-INF/view/contract/enforcing/Proceeds_add_detail_pro";

		}
	}
	
	/**
	 * ??????????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020-12-18
	 */
	@RequestMapping(value = "/checkPro")
	public String checkPro(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "edit");
		//Upt upt=uptMng.findByFContId_U(id).get(0);
		//model.addAttribute("Upt", upt);
		//model.addAttribute("UptAttac", uptAttacMng.findByfId_U_AU(upt.getfId_U()).get(0));
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//????????????????????????
		ProceedsPlan findById = proceedsPlanMng.findById(fPlanId);
		model.addAttribute("payBean", findById);
		//????????????????????????
		ContPay contPay=new ContPay();
		if(!StringUtil.isEmpty(String.valueOf(findById.getProId()))){
			contPay = contPayMng.findById(findById.getProId());
		}
		model.addAttribute("contBean", contPay);
		//ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
		//model.addAttribute("payee", payee);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
		List<CostDetailInfo> cost =new ArrayList<CostDetailInfo>();
		/*for(int i = 0;i <cost.size();i++){
			List<InvoiceCouponInfo> fp=reimbAppliMng.findfp(cost.get(i).getcId());
			for(int j = 0;j <fp.size();j++){
				x=x+1;
				fp.get(j).setNum(x);
			}
			cost.get(i).setCouponList(fp);
			cost.get(i).setNum(x);
		}*/
		Integer index =cost.size();
		model.addAttribute("x", x);
		model.addAttribute("index", index);
		model.addAttribute("cost", cost);
		model.addAttribute("userid", getUser().getId());
		//List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(contPay.getPayId(),"contract");
		//model.addAttribute("Invoicelist", list);//??????????????????
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTSR", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTSR", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}
		
		Proposer proposer =null;
		if(!StringUtil.isEmpty(String.valueOf(contPay.getPayId()))){
			//?????????????????????????????????
			proposer = new Proposer(contPay.getUserName(),contPay.getDepateName(), contPay.getReqTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		}
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTSR", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		if (contractBasicInfo.getIskjht() != 1) {
			return "/WEB-INF/view/contract/enforcing/Proceeds_check_detail";
		}else {
			return "/WEB-INF/view/contract/enforcing/Proceeds_check_detail_pro";
		}
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
	@RequestMapping(value = "/ReCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			//????????????id?????????
			proceedsPlanMng.reCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ProceedsPlan bean,ModelMap model){
		try {
			proceedsPlanMng.editAffirm(bean);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (ServiceException es) {
			es.printStackTrace();
			return getJsonResult(false,es.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 
	 * @updatetime 
	 */
	@RequestMapping(value = "/proCheckResult")
	@ResponseBody
	public Result proCheckResult(TProcessCheck checkBean,ContPay bean, ProceedsPlan proceedsPlan, Integer payId,String spjlFile) {
		try {
			//TODO??????????????????
			proceedsPlanMng.saveProCheckInfo(checkBean, bean, proceedsPlan, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
}
