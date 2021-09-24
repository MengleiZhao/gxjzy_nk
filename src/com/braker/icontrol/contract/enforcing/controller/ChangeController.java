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
	 * 跳转主页面
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
	 * 显示主页面信息
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
	 * 弹出合同列表页面让用户选择
	 * @param model
	 * @return	 
	 * @createTime 2019-05-28
	 * @author 陈睿超
	 */
	@RequestMapping("/contract")
	public String endingContract(ModelMap model){
		return "/WEB-INF/view/contract/change/change_add_contract";
	}
	
	/**
	 * 加载选择要变更合同的数据
	 * @param ContractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param mode
	 * @return	 
	 * @createTime 2019-05-28
	 * @author 陈睿超
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
	 * 新增跳转页面
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
		//合同备案信息
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
		//合同备案合同正本附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//合同变更信息
		Upt upt =new Upt();
		upt.setfOperatorID(user.getId());
		upt.setfOperator(user.getName());
		upt.setfDeptID(user.getDepart().getId());
		upt.setfDeptName(user.getDepartName());
		upt.setfContNameOld(contractBasicInfo.getFcTitle());
		upt.setfContCodeOld(contractBasicInfo.getFcCode());
		upt.setfContUptType(contractBasicInfo.getFcType());//合同类型
		String fcUptCode =uptMng.getFcUptCode();
		upt.setfUptCode(fcUptCode);
		upt.setfContCode(StringUtil.Random("BG"));
		model.addAttribute("Upt", upt);
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		
		//查询归档信息
		List<Archiving> contOriginal = archivingMng.findByContId(id);
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//归档附件
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		
		String dept[]=departMng.findDeptByUserId(upt.getfOperatorID());
		//查询工作流
		List<TNodeData> nodeConfList =tProcessCheckMng.getNodeConf(user.getId(),"HTBG", upt.getfDeptID(),upt.getBeanCode(),upt.getfNCode(), null, null, null, "1");
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), upt.getfReqTime());
		model.addAttribute("nodeConf", nodeConfList);
		model.addAttribute("proposer", proposer);
		
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTBG", dept[0]);
		model.addAttribute("fpIdBG", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		return "/WEB-INF/view/contract/change/change_edit";
	}
	
	
	/**
	 * 跳转到修改页面
	 * @author crc
	 * @createtime 2018-06-22
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id, ModelMap model){
		//合同变更信息
		model.addAttribute("openType", "edit");
		
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		//原合同
		ContractBasicInfo findById = formulationMng.findById(contractBasicInfo.getFyhtid());
		model.addAttribute("findById", findById);
		//合同拟定的附件
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
		
		//签约方信息
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
		//原合同
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", findById.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",findById.getBeanCode());
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
		return "/WEB-INF/view/contract/change/change_edit";
	}
	
	/**
	 * 保存变更的内容
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
			if(StringUtil.isEmpty(upt.getfUptReason())){
				return getJsonResult(false, "请填写变更原因！");
			}else{
				upt.setfContId_U(contractBasicInfo.getFcId());
				uptMng.saveUptAndUptAttac(contractBasicInfo, upt, getUser(),htbgfiles,null,uptplanJson,proceedsPlanJson,uptcgconfigJson,htbgOtherfiles);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 在打开查询时判断有没有变更信息
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
			//有流程
			return getJsonResult(true, "have");
		}else {
			//无流程
			return getJsonResult(true, "nohave");
		}
		
	}
	
	/**
	 * 根据id查看
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
		
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//原合同信息
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
		//合同拟定的附件
		List<Attachment> changeAttaList = attachmentMng.list(contractBasicInfo);
		List<Attachment> attaList = attachmentMng.list(findById);
		model.addAttribute("formulationAttaList", attaList);
		model.addAttribute("changeAttaList", changeAttaList);
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
		//原合同
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", findById.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",findById.getBeanCode());
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
		return "/WEB-INF/view/contract/change/change_detail";
		
	}

	/**
	 * 加载已有变更记录数据
	 * @param id
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
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
	 * 跳转到合同变更审批页面
	 * @param models
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-24
	 */
	@RequestMapping("/approvalList")
	public String approvalList(ModelMap models){
		return "/WEB-INF/view/contract/change/approval/change_approval_list";
	}
	
	/**
	 * 加载审批list页面数据
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
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
	 * 跳转到合同变更审批的页面
	 * @param id 合同变更主键
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-27
	 */
	@RequestMapping("/approvalChange/{id}")
	public String approvalChange(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		
		//合同拟定信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//原合同信息
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
		//合同拟定的附件
		List<Attachment> changeAttaList = attachmentMng.list(contractBasicInfo);
		List<Attachment> attaList = attachmentMng.list(findById);
		model.addAttribute("formulationAttaList", attaList);
		model.addAttribute("changeAttaList", changeAttaList);
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
		return "/WEB-INF/view/contract/change/approval/change_approval_edit";
	}
	
	/**
	 * 审批变更信息
	 * @param status 审批意见
	 * @param upt 
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-05-27
	 */
	@ResponseBody
	@RequestMapping("/approve/{status}")
	public Result approve(@PathVariable String status,String Id,String fremark,String spjlFile,TProcessCheck checkBean,String fsyjsfiles){
		try {
			if(status.equals("0")&&StringUtil.isEmpty(status)){
				return getJsonResult(false, "不通过请填写审批意见！");
			}
			fremark = checkBean.getFcheckRemake();
			checkBean =new TProcessCheck(status,fremark);
			approvalMng.updatefFlowStautsbg(Id, checkBean, getUser(), Id, spjlFile,fsyjsfiles);
		} catch (ServiceException es) {
			return getJsonResult(false, getException(es));
		}catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
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
			uptMng.reCall(id);
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
	
	/**
	 * 查询数据变更的付款计划
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年2月14日
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
	 * <p>Description: 查询变更采购数据</p>  
	 * @param id
	 * @param type
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月20日
	 * @updator 陈睿超
	 * @updatetime 2020年12月20日
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
	 * <p>Description: 查询收款计划数据</p>  
	 * @param id upt主键
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月22日
	 * @updator 陈睿超
	 * @updatetime 2020年12月22日
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
	 * 根据ID删除
	 * @param id 主键
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月20日
	 * @updator 陈睿超
	 * @updatetime 2020年12月20日
	 */
	@ResponseBody
	@RequestMapping("/delete/{id}")
	public Result delete(@PathVariable String id ,ModelMap model){
		try {
			//合同变更信息
			Upt upt = uptMng.findById(Integer.valueOf(id));
			//删除
			uptMng.deletebyfId(upt);
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}
	
	
	/**
	 * 获取合同送审中的付款计划
	 * @param payId
	 * @return
	 * @author wanping
	 * @createtime 2020年9月8日
	 * @updator wanping
	 * @updatetime 2020年9月8日
	 */
	@RequestMapping("/getReceivplanid")
	@ResponseBody
	private String getReceivplanid (String payId) {
		//已发起审批的付款计划
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
	 * <p>Description:根据付款计划id查询该付款计划中的条目是否被送审或者已付款 </p>  
	 * @param id 付款计划主键id
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月22日
	 * @updator 陈睿超
	 * @updatetime 2020年12月22日
	 */
	@ResponseBody
	@RequestMapping(value="/verifyReceivPlan")
	public Result verifyReceivPlan(Integer id){
		String info = null;
		if(id!=null){
			ReceivPlan receivplan = receivPlanMng.findById(id);
			//如果付款计划处于送审或者审批完成的状态下不允许修改
			if(("0".equals(receivplan.getfStauts_R())||StringUtil.isEmpty(receivplan.getfStauts_R()))&&("1".equals(receivplan.getPayStauts())||"9".equals(receivplan.getPayStauts()))){
				info = "该付款条目正在付款或已完成付款，不允许编辑。";
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
	 * <p>Description: 如果收款计划处于已收款的状态下不允许修改</p>  
	 * @param id
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月22日
	 * @updator 陈睿超
	 * @updatetime 2020年12月22日
	 */
	@ResponseBody
	@RequestMapping(value="/verifyProceedsPlan")
	public Result verifyProceedsPlan(Integer id){
		String info = null;
		if(id!=null){
			ProceedsPlan proceedsPlan = proceedsPlanMng.findById(id);
			//如果收款计划处于已收款的状态下不允许修改
			if("1".equals(proceedsPlan.getfStauts())){
				info = "该收款计划已收款，不允许编辑";
				return getJsonResult(false, info);
			}else{
				return getJsonResult(true, info);
			}
		}else {
			return getJsonResult(true, info);
		}
	}
	
	
}
