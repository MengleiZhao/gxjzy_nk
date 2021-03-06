package com.braker.icontrol.contract.enforcing.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
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
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.EnforcingMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ?????????
 * ????????????
 *
 */
@Controller
@RequestMapping("/Enforcing")
public class EnforcingController extends BaseController{

	@Autowired
	private FormulationMng FormulationMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private EnforcingMng enforcingMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private AuditInfoMng auditInfoMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private ContPayMng contPayMng;
	@Autowired
	private CashierMng cashierMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private ReimbPayeeMng reimbPayeeMng;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	/**
	 * ??????????????????
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/list")
	public String list(ModelMap model ){
		return "/WEB-INF/view/contract/enforcing/enforcing_list";
	}
	
	/**
	 * ?????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows, ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = enforcingMng.queryList_E(contractBasicInfo, getUser(), page, rows);
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
	 * ??????????????????
	 * @return
	 * 
	 */
	@RequestMapping("/plan/{id}")
	public String pay(@PathVariable String id,ModelMap model){
		model.addAttribute("id", id);
		ContractBasicInfo findById = formulationMng.findById(Integer.valueOf(id));
		if (findById.getIskjht() != 1) {
			return "/WEB-INF/view/contract/enforcing/enforcing_plan_list";
		}else {
			return "/WEB-INF/view/contract/enforcing/enforcing_plan_list_enf";
		}
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
	 */
	@RequestMapping("/planJsonPagination/{id}")
	@ResponseBody
	public JsonPagination planJsonPagination(@PathVariable String id,ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows, ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = receivPlanMng.allPlan(Integer.valueOf(id), page, rows);
		return getJsonPagination(p,page);
	}
	
	/**
	 * ????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ych
	 * @createtime 2018-08-20
	 */
	@RequestMapping(value = "/add")
	public String check(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
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
		ReceivPlan payBean = receivPlanMng.findById(fPlanId);
		model.addAttribute("payBean", payBean);
		//????????????????????????
		ContPay contPay=new ContPay();
		List<ContPay> contPayList = contPayMng.findByFPlanid(payBean.getfPlanId());
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
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTFKSQ", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTFKSQ", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
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
		return "/WEB-INF/view/contract/enforcing/enforcing_add";
	}
	
	
	/**
	 * ????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ych
	 * @createtime 2018-08-20
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		PurchaseApplyBasic cgsq = cgsqMng.findById(Integer.valueOf(contractBasicInfo.getfPurchNo()));
		TProBasicInfo pro = projectMng.findById(cgsq.getIndexId());
		String type = null;
		if (("JJ").equals(pro.getProUseType())) {
			type = "HTFKSQJJ";
		}else if (("WX").equals(pro.getProUseType())){
			type = "HTFKSQ";
		}else {
			type = "HYBX";
		}
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
		ReceivPlan payBean = receivPlanMng.findById(fPlanId);
		model.addAttribute("payBean", payBean);
		//????????????????????????
		ContPay contPay=new ContPay();
		if(!StringUtil.isEmpty(String.valueOf(payBean.getPayId()))){
			contPay = contPayMng.findById(payBean.getPayId());
		}
		model.addAttribute("contBean", contPay);
		ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
		model.addAttribute("payee", payee);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
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
		model.addAttribute("Invoicelist", list);//??????????????????
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),type, departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		Proposer proposer =null;
		proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		return "/WEB-INF/view/contract/enforcing/enforcing_add";
	}
	
	@RequestMapping(value = "/insertenf")
	public String insertEnf(String id,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		PurchaseApplyBasic cgsq = cgsqMng.findById(Integer.valueOf(contractBasicInfo.getfPurchNo()));
		TProBasicInfo pro = projectMng.findById(cgsq.getIndexId());
		String type = null;
		if (("JJ").equals(pro.getProUseType())) {
			type = "HTFKSQJJ";
		}else if (("WX").equals(pro.getProUseType())){
			type = "HTFKSQ";
		}else {
			type = "HYBX";
		}
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
		ContPay contPay=new ContPay();
		model.addAttribute("contBean", contPay);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		Integer x=0;
		//??????????????????
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
		model.addAttribute("Invoicelist", list);//??????????????????
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),type, departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		Proposer proposer =null;
		proposer = new Proposer(user.getName(), user.getDepart().getName(),null);
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		return "/WEB-INF/view/contract/enforcing/enforcing_add_enf";
	}
	
	/**
	 * ??????????????????????????????
	 * @param contractBasicInfo
	 * @param model
	 * @return
	 * @author ??????
	 * @createtime 2020-12-18
	 */
	@RequestMapping(value = "/detailPay")
	public String detailPay(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("findById", contractBasicInfo);
		//???????????????id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		model.addAttribute("openType", "edit");
		//Upt upt= new Upt();
		/*if(contractBasicInfo.getfUpdateStatus().equals("1")){
			upt=uptMng.findByFContId_U(id).get(0);
			//??????????????????
			List<Attachment> uptAttaList = attachmentMng.list(upt);
			model.addAttribute("changeAttaList", uptAttaList);
			model.addAttribute("Upt", upt);

			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			//????????????
			model.addAttribute("foCodeBG",upt.getBeanCode());
		}*/
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(id));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		/*if(!StringUtil.isEmpty(String.valueOf(upt.getfId_U()))){
			//????????????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}*/
		
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("findSign", sign);
		}
		//????????????????????????
		ReceivPlan payBean = receivPlanMng.findById(fPlanId);
		model.addAttribute("payBean", payBean);
		//????????????????????????
		ContPay contPay=new ContPay();
		if(payBean.getPayId()!=null){
			contPay = contPayMng.findById(payBean.getPayId());
			model.addAttribute("contBean", contPay);
		}
		ReimbPayeeInfo payee =reimbPayeeMng.getByContId(contPay.getPayId()).get(0);
		model.addAttribute("payee", payee);
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("attaList", contPayattaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		Integer x=0;
		//??????????????????
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
		model.addAttribute("Invoicelist", list);//??????????????????
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTFKSQ", contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTFKSQ", departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(), contPay.getBeanCodeField(), contPay.getPayCode(), "1");
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
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTFKSQ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contPay.getBeanCode());
		return "/WEB-INF/view/contract/enforcing/enforcing_detail_new";
	}
	/**
	 * ????????????????????????????????????
	 * @author ych
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(ContPay bean, ReceivPlan receivPlanBean,Integer id,Integer fPlanId,String fhtzxFiles, String fReceAmount,ReimbPayeeInfo payee,String form1) {
		try {
			//????????????????????????
			bean.setfReceAmount(BigDecimal.valueOf(Double.valueOf(fReceAmount)));
			ReceivPlan findById;
			//??????????????????
			if (null == fPlanId) {
				findById = new ReceivPlan();
				ContractBasicInfo cbi = formulationMng.findById(id);
				findById.setfReceProperty(receivPlanBean.getfReceProperty());
				findById.setfReceCondition(receivPlanBean.getfReceCondition());
				findById.setDataType(Integer.valueOf(cbi.getFhttype()));
				findById.setfRecePlanAmount(receivPlanBean.getfReceAmount());
				findById.setfRecePlanTime(receivPlanBean.getfRecePlanTime());
			}else {
				 findById = receivPlanMng.findById(fPlanId);
			}
			findById.setfContId_R(payee.getContId());
			enforcingMng.save(bean, findById, getUser(),fhtzxFiles,payee,form1);
			return getJsonResult(true,"???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
	}
	
	/**
	 * ?????????????????????
	 * @param id
	 * @param fPlanId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/detail")
	public String detail(String id, Integer fPlanId,ModelMap model) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		User user = userMng.findById(contractBasicInfo.getfOperatorId());	//???????????????????????????
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "detail");
		//??????????????????
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(id));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		if(!StringUtil.isEmpty(String.valueOf(upt.getfId_U()))){
			//????????????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}
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
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//??????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//????????????????????????
		ReceivPlan payBean = receivPlanMng.findById(fPlanId);
		model.addAttribute("payBean", payBean);
		//????????????????????????
		ContPay contPay=new ContPay();
		List<ContPay> contPayList = contPayMng.findByFPlanid(payBean.getfPlanId());
		if(contPayList!=null&&contPayList.size()!=0) {
			contPay = contPayList.get(0);
			model.addAttribute("contBean", contPay);
		}
		//????????????????????????
		List<Attachment> contPayattaList = attachmentMng.list(contPay);
		model.addAttribute("enforciongAttaList", contPayattaList);
		if(!StringUtil.isEmpty(contPay.getDepateID())){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTFKSQ",contPay.getDepateID(),contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(),  contPay.getBeanCodeField(), contPay.getPayCode(), "1");
			model.addAttribute("nodeConf", nodeConfList);
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contPay.getUserId(),"HTFKSQ",departId,contPay.getBeanCode(),contPay.getnCode(), contPay.getJoinTable(),  contPay.getBeanCodeField(), contPay.getPayCode(), "1");
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
		
		return "/WEB-INF/view/contract/enforcing/enforcing_detail";
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
	@RequestMapping(value = "/contractReCall")
	@ResponseBody
	public Result applyReCall(Integer id) {
		try {
			//????????????id?????????
			enforcingMng.contractReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * @Description: ??????????????????????????????????????????
	 * @param @param id
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author ??????
	 * @date 2020???12???21???
	 */
	@RequestMapping(value = "/getUptStatus")
	@ResponseBody
	public String getUptStatus(Integer id) {
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		if("1".equals(contractBasicInfo.getfUpdateStatus())){
			//Upt upt=uptMng.findByFContId_U(contractBasicInfo.getFcId().toString()).get(0);
			if(!"1".equals(contractBasicInfo.getFsealedStatus())){
				return "2";
			}
			return "0";
		}
		return "0";
	}
}
