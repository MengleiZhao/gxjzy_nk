package com.braker.icontrol.contract.enforcing.controller;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

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
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.manager.ChangeMng;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.enforcing.model.UptClause;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Change")
public class ChangeController extends BaseController{

	@Autowired
	private ChangeMng changeMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private UptClauseMng uptClauseMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private ContractPlanListMng contractPlanListMng;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	@Autowired
	private ContPayMng contPayMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private ApprovalMng approvalMng;
	/**
	 * ???????????????
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/List")
	public String list(ModelMap model ){
		return "/WEB-INF/view/contract/change/change_list";
	}
	
	/**
	 * ?????????????????????
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=formulationMng.queryListbg(contractBasicInfo,getUser(),page,rows);
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
	 * ???????????????????????????????????????
	 * @param model
	 * @return	 
	 * @createTime 2019-05-28
	 * @author ?????????
	 */
	@RequestMapping("/contract")
	public String endingContract(ModelMap model){
		return "/WEB-INF/view/contract/change/change_add_contract";
	}
	
	/**
	 * ????????????????????????????????????
	 * @param ContractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param mode
	 * @return	 
	 * @createTime 2019-05-28
	 * @author ?????????
	 */
	@RequestMapping("/contractList")
	@ResponseBody
	public JsonPagination contractList(ContractBasicInfo ContractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap mode){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = formulationMng.queryForChange(ContractBasicInfo,getUser(), page, rows);
		List<ContractBasicInfo> cbi = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < cbi.size(); i++) {
			cbi.get(i).setNumber(i+1);
		}
		p.setList(cbi);
		return getJsonPagination(p, page);
	}
	
	
	
	/**
	 * ??????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/add/{id}")
	public String add(@PathVariable String id, ModelMap model){
		User user=getUser();
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		ContractBasicInfo findById = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("openType", "Cadd");
		model.addAttribute("bean",contractBasicInfo);
		model.addAttribute("findById",findById);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//??????????????????
		SignInfo sign=new SignInfo();
		SignInfo findSign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		List<SignInfo> find_Sign = filingMng.find_Sign(findById);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		if(find_Sign!=null&&find_Sign.size()>0){
			findSign = find_Sign.get(0);
			model.addAttribute("findSign", findSign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//??????????????????
		Upt upt =new Upt();
		upt.setfOperatorID(user.getId());
		upt.setfOperator(user.getName());
		upt.setfDeptID(user.getDepart().getId());
		upt.setfDeptName(user.getDepartName());
		upt.setfContNameOld(contractBasicInfo.getFcTitle());
		upt.setfContCodeOld(contractBasicInfo.getFcCode());
		upt.setfContUptType(contractBasicInfo.getFcType());//????????????
		String fcUptCode =uptMng.getFcUptCode();
		upt.setfUptCode(fcUptCode);
		upt.setfContCode(StringUtil.Random("BG"));
		model.addAttribute("Upt", upt);
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(id);
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		
		String dept[]=departMng.findDeptByUserId(upt.getfOperatorID());
		//???????????????
		List<TNodeData> nodeConfList =tProcessCheckMng.getNodeConf(user.getId(),"HTBG", upt.getfDeptID(),upt.getBeanCode(),upt.getfNCode(), null, null, null, "1");
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), upt.getfReqTime());
		model.addAttribute("nodeConf", nodeConfList);
		model.addAttribute("proposer", proposer);
		
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTBG", dept[0]);
		model.addAttribute("fpIdBG", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		return "/WEB-INF/view/contract/change/change_edit";
	}
	
	
	/**
	 * ?????????????????????
	 * @author crc
	 * @createtime 2018-06-22
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id, ModelMap model){
		//??????????????????
		model.addAttribute("openType", "edit");
		
		//??????????????????
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		//?????????
		ContractBasicInfo findById = formulationMng.findById(contractBasicInfo.getFyhtid());
		model.addAttribute("findById", findById);
		//?????????????????????
		List<Attachment> attaList = attachmentMng.list(findById);
		List<Attachment> changeAttaList = attachmentMng.list(contractBasicInfo);
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
		
		model.addAttribute("changeAttaList", changeAttaList);
		
		//???????????????
		SignInfo signInfo = new SignInfo();
		SignInfo findSign = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		List<SignInfo> find_Sign = filingMng.find_Sign(findById);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		if(find_Sign != null && find_Sign.size() > 0){
			findSign = find_Sign.get(0);
		}
		model.addAttribute("findSign", findSign);
		model.addAttribute("signInfo", signInfo);
		/*//????????????????????????
		List<Attachment> signattac = attachmentMng.list(signInfo);
		model.addAttribute("filingattac", signattac);*/
		
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), contractBasicInfo.getJoinTable(), contractBasicInfo.getBeanCodeField(), contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//?????????
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", findById.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",findById.getBeanCode());
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????
		model.addAttribute("CheckInfoHave", "1");
		//????????????????????????
		Integer detailId = contractBasicInfo.getProDetailId();
		Integer indexId = contractBasicInfo.getfBudgetIndexCode();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				contractBasicInfo.setfAvailableAmount(detail.getSyAmount().multiply(BigDecimal.valueOf(10000))+"");
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			contractBasicInfo.setfAvailableAmount(index.getSyAmount()+"");
		}
		return "/WEB-INF/view/contract/change/change_edit";
	}
	
	/**
	 * ?????????????????????
	 * @param contractBasicInfo
	 * @param uptAttac
	 * @param upt
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/Save")
	@ResponseBody
	public Result save(ContractBasicInfo contractBasicInfo,String uptplanJson,String proceedsPlanJson,String uptcgconfigJson,String planJson,UptClause uptAttac,Upt upt,String htbgfiles,String htbgOtherfiles){
		try {
			if(("HTFL-01").equals(contractBasicInfo.getFcType())){//??????????????????????????????
				List<ReceivPlan> queryMoney1 = receivPlanMng.findByProperty("fContId_R", contractBasicInfo.getFcId());
				List<ContPay> findByFPlanid = contPayMng.findByFPlanid(queryMoney1.get(0).getfPlanId());
				if (findByFPlanid.size()>0) {
					if (findByFPlanid.get(0).getFlowStauts().equals("1")) {
						return getJsonResult(false, "????????????????????????????????????");
					}
					if (findByFPlanid.get(0).getCashierType().equals("1")) {
						return getJsonResult(false, "????????????????????????????????????");
					}
				}
			}
			if(StringUtil.isEmpty(upt.getfUptReason())){
				return getJsonResult(false, "????????????????????????");
			}else{
				upt.setfContId_U(contractBasicInfo.getFcId());
				uptMng.saveUptAndUptAttac(contractBasicInfo, upt, getUser(),htbgfiles,null,uptplanJson,proceedsPlanJson,uptcgconfigJson,htbgOtherfiles);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * ?????????????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/newOrDetail/{id}")
	public Result newOrDetail(@PathVariable String id ,ModelMap model){
		ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(id));
		List<Upt> uptList = uptMng.findByFContId_U(String.valueOf(cbi.getFcId()));
		if(uptList!=null&&uptList.size()>0){
			//?????????
			return getJsonResult(true, "have");
		}else {
			//?????????
			return getJsonResult(true, "nohave");
		}
		
	}
	
	/**
	 * ??????id??????
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model,HttpServletRequest request){
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		
		//??????????????????
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//???????????????
		ContractBasicInfo findById = formulationMng.findById(contractBasicInfo.getFyhtid());
		model.addAttribute("bean",contractBasicInfo);
		model.addAttribute("findById",findById);
		String fcAmount = contractBasicInfo.getFcAmount();
		if("".equals(fcAmount)) {
			fcAmount = "0";
		}
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//?????????????????????
		List<Attachment> changeAttaList = attachmentMng.list(contractBasicInfo);
		List<Attachment> attaList = attachmentMng.list(findById);
		model.addAttribute("formulationAttaList", attaList);
		model.addAttribute("changeAttaList", changeAttaList);
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(id);
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//???????????????
		SignInfo signInfo = new SignInfo();
		SignInfo findSign = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		List<SignInfo> find_Sign = filingMng.find_Sign(findById);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		if(find_Sign != null && find_Sign.size() > 0){
			findSign = find_Sign.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		model.addAttribute("findSign", findSign);
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//?????????
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", findById.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",findById.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//????????????
		if(contractBasicInfo.getFcId()!=null){
			model.addAttribute("CheckInfoHave", "1");
		}
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/change/change_detail";
		
	}

	/**
	 * ??????????????????????????????
	 * @param id
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-24
	 */
	@ResponseBody
	@RequestMapping("/clauseList")
	public JsonPagination clauseList(String id ,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		Pagination p = new Pagination();
		List<UptClause> li= uptClauseMng.findByfId_U_AU(Integer.valueOf(id));
    	p.setList(li);
    	p.setPageSize(li.size());
    	p.setPageNo(1);
    	p.setTotalCount(li.size());
		return getJsonPagination(p, page);	
	}

	/**
	 * ?????????????????????????????????
	 * @param models
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-24
	 */
	@RequestMapping("/approvalList")
	public String approvalList(ModelMap models){
		return "/WEB-INF/view/contract/change/approval/change_approval_list";
	}
	
	/**
	 * ????????????list????????????
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-24
	 */
	@ResponseBody
	@RequestMapping("/approvalJson")
	public JsonPagination approvalJson(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = uptMng.queryList(contractBasicInfo, getUser(), page, rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);	
	}
	
	/**
	 * ????????????????????????????????????
	 * @param id ??????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-27
	 */
	@RequestMapping("/approvalChange/{id}")
	public String approvalChange(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		
		//??????????????????
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//???????????????
		ContractBasicInfo findById = formulationMng.findById(contractBasicInfo.getFyhtid());
		model.addAttribute("bean",contractBasicInfo);
		model.addAttribute("findById",findById);
		String fcAmount = contractBasicInfo.getFcAmount();
		if("".equals(fcAmount)) {
			fcAmount = "0";
		}
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//?????????????????????
		List<Attachment> changeAttaList = attachmentMng.list(contractBasicInfo);
		List<Attachment> attaList = attachmentMng.list(findById);
		model.addAttribute("formulationAttaList", attaList);
		model.addAttribute("changeAttaList", changeAttaList);
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(id);
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//???????????????
		SignInfo signInfo = new SignInfo();
		SignInfo findSign = new SignInfo();
		List<SignInfo> signInfoList = filingMng.find_Sign(contractBasicInfo);
		List<SignInfo> find_Sign = filingMng.find_Sign(findById);
		if(signInfoList != null && signInfoList.size() > 0){
			signInfo = signInfoList.get(0);
		}
		if(find_Sign != null && find_Sign.size() > 0){
			findSign = find_Sign.get(0);
		}
		model.addAttribute("signInfo", signInfo);
		model.addAttribute("findSign", findSign);
		if(Double.valueOf(fcAmount)>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(), contractBasicInfo.getfDeptName(), contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);
		//????????????
		if(contractBasicInfo.getFcId()!=null){
			model.addAttribute("CheckInfoHave", "1");
		}
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/change/approval/change_approval_edit";
	}
	
	/**
	 * ??????????????????
	 * @param status ????????????
	 * @param upt 
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-27
	 */
	@ResponseBody
	@RequestMapping("/approve/{status}")
	public Result approve(@PathVariable String status,String Id,String fremark,String spjlFile,TProcessCheck checkBean,String fsyjsfiles){
		try {
			if(status.equals("0")&&StringUtil.isEmpty(status)){
				return getJsonResult(false, "?????????????????????????????????");
			}
			fremark = checkBean.getFcheckRemake();
			checkBean =new TProcessCheck(status,fremark);
			approvalMng.updatefFlowStautsbg(Id, checkBean, getUser(), Id, spjlFile,fsyjsfiles);
		} catch (ServiceException es) {
			return getJsonResult(false, getException(es));
		}catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * ??????
	 * @param id ??????id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-10-08
	 * @updatetime 2018-10-08
	 */
	@ResponseBody
	@RequestMapping("/reCall")
	public Result reCall(String id,ModelMap model){
		try {
			uptMng.reCall(id);
			return getJsonResult(true,"???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
	}
	
	/**
	 * ?????????????????????????????????
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???2???14???
	 */
	@ResponseBody
	@RequestMapping("/uptPlanJson")
	public JsonPagination uptPlanJson(Upt upt,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Upt findById = uptMng.findById(upt.getfId_U());
    	List<ReceivPlan> li = receivPlanMng.findbyUptId(findById.getfId_U());
    	Pagination p = new Pagination();
    	p.setList(li);
    	p.setPageNo(1);
    	p.setPageSize(li.size());
    	p.setTotalCount(li.size());
		return getJsonPagination(p, page);	
	}
	
	/**
	 * 
	 * <p>Title: mingxi</p>  
	 * <p>Description: ????????????????????????</p>  
	 * @param id
	 * @param type
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???20???
	 * @updator ?????????
	 * @updatetime 2020???12???20???
	 */
	@ResponseBody
	@RequestMapping(value = "/mingxi")
	public List<Object> mingxi(String id,String type) {
		List<Object> p = contractPlanListMng.findbyIdAndType("fId_U",id,type);
		return p;
	}
	
	/**
	 * 
	 * <p>Title: mingxi</p>  
	 * <p>Description: ????????????????????????</p>  
	 * @param id upt??????
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???22???
	 * @updator ?????????
	 * @updatetime 2020???12???22???
	 */
	@ResponseBody
	@RequestMapping(value = "/proceedsmingxi")
	public List<ProceedsPlan> mingxi(Integer id) {
		List<ProceedsPlan> proceedsPlan = proceedsPlanMng.findbyUptId(id);
		return proceedsPlan;
	}
	
	@RequestMapping("/finderReceivPlan")
	@ResponseBody
	public JsonPagination finderReceivPlan(String FcId,String sort,String order,Integer page, Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=filingMng.find_ReceivPlan(FcId,page,rows);
		return getJsonPagination(p , page);
	}
	
	/**
	 * ??????ID??????
	 * @param id ??????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???20???
	 * @updator ?????????
	 * @updatetime 2020???12???20???
	 */
	@ResponseBody
	@RequestMapping("/delete/{id}")
	public Result delete(@PathVariable String id ,ModelMap model){
		try {
			//??????????????????
			Upt upt = uptMng.findById(Integer.valueOf(id));
			//??????
			uptMng.deletebyfId(upt);
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}
	
	
	/**
	 * ????????????????????????????????????
	 * @param payId
	 * @return
	 * @author wanping
	 * @createtime 2020???9???8???
	 * @updator wanping
	 * @updatetime 2020???9???8???
	 */
	@RequestMapping("/getReceivplanid")
	@ResponseBody
	private String getReceivplanid (String payId) {
		//??????????????????????????????
		List<ReimbAppliBasicInfo> reimbList = reimbAppliMng.findByProperty("payId", payId);
		Set<String> set = new HashSet<String>();
		if (reimbList != null && !reimbList.isEmpty()) {
			for (ReimbAppliBasicInfo reimbAppliBasicInfo : reimbList) {
				if (!"-1".equals(reimbAppliBasicInfo.getFlowStauts()) && !"0".equals(reimbAppliBasicInfo.getFlowStauts())
						&& !"-4".equals(reimbAppliBasicInfo.getFlowStauts()) && !"9".equals(reimbAppliBasicInfo.getFlowStauts()) && "8".equals(reimbAppliBasicInfo.getType())) {
					if (!StringUtil.isEmpty(reimbAppliBasicInfo.getReceivplanid())) {
						String[] str = reimbAppliBasicInfo.getReceivplanid().split(",");
						for (int i = 0; i < str.length; i++) {
							set.add(str[i]);
						}
					}
				}
			}
		}
		
		if (set.size() > 0) {
			return "true";
		} else {
			return "false";
		}
	}
	
	/**
	 * 
	 * <p>Title: verifyReceivPlan</p>  
	 * <p>Description:??????????????????id??????????????????????????????????????????????????????????????? </p>  
	 * @param id ??????????????????id
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???22???
	 * @updator ?????????
	 * @updatetime 2020???12???22???
	 */
	@ResponseBody
	@RequestMapping(value="/verifyReceivPlan")
	public Result verifyReceivPlan(Integer id){
		String info = null;
		if(id!=null){
			ReceivPlan receivplan = receivPlanMng.findById(id);
			//???????????????????????????????????????????????????????????????????????????
			if(("0".equals(receivplan.getfStauts_R())||StringUtil.isEmpty(receivplan.getfStauts_R()))&&("1".equals(receivplan.getPayStauts())||"9".equals(receivplan.getPayStauts()))){
				info = "??????????????????????????????????????????????????????????????????";
				return getJsonResult(false, info);
			}else{
				return getJsonResult(true, info);
			}
		}else {
			return getJsonResult(true, info);
		}
	}
	
	/**
	 * 
	 * <p>Title: verifyProceedsPlan</p>  
	 * <p>Description: ????????????????????????????????????????????????????????????</p>  
	 * @param id
	 * @return
	 * @author ?????????
	 * @createtime 2020???12???22???
	 * @updator ?????????
	 * @updatetime 2020???12???22???
	 */
	@ResponseBody
	@RequestMapping(value="/verifyProceedsPlan")
	public Result verifyProceedsPlan(Integer id){
		String info = null;
		if(id!=null){
			ProceedsPlan proceedsPlan = proceedsPlanMng.findById(id);
			//????????????????????????????????????????????????????????????
			if("1".equals(proceedsPlan.getfStauts())){
				info = "??????????????????????????????????????????";
				return getJsonResult(false, info);
			}else{
				return getJsonResult(true, info);
			}
		}else {
			return getJsonResult(true, info);
		}
	}
	
	
}
