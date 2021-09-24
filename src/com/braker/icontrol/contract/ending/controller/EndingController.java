package com.braker.icontrol.contract.ending.controller;

import java.util.Date;
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
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.dispute.manager.DisputAttacMng;
import com.braker.icontrol.contract.dispute.manager.DisputeMng;
import com.braker.icontrol.contract.dispute.model.Dispute;
import com.braker.icontrol.contract.ending.manager.EndingMng;
import com.braker.icontrol.contract.ending.model.Ending;
import com.braker.icontrol.contract.enforcing.manager.ChangeMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionAttacMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionMng;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.contract.goldpay.manager.GoldPayMng;
import com.braker.icontrol.contract.goldpay.model.GoldPay;
import com.braker.icontrol.contract.ledger.manager.LedgerMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
import com.sun.org.apache.bcel.internal.generic.NEW;

@Controller
@RequestMapping("/ending")
public class EndingController extends BaseController{

	@Autowired
	private LedgerMng LedgerMng;
	@Autowired
	private SignInfoMng signInfoMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private DisputeMng disputeMng;
	@Autowired
	private ChangeMng changeMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UptClauseMng uptAttacMng;
	@Autowired
	private ConclusionMng conclusionMng;
	@Autowired
	private ConclusionAttacMng conclusionAttacMng;
	@Autowired
	private DisputAttacMng disputAttacMng;
	@Autowired
	private GoldPayMng goldPayMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private EndingMng endingMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/**
	 * 跳转到合同终止list页面
	 * @param model
	 * @return
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/contract/ending/ending_list";
		
	}
	
	/**
	 * 加载合同终止list页面的数据
	 * @param ending 搜索条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param mode
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(Ending ending,String sort,String order,Integer page,Integer rows,ModelMap mode){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = endingMng.list(ending, getUser(), page, rows);
		List<Ending> endingList = (List<Ending>) p.getList();
		for (int i = 0; i < endingList.size(); i++) {
			endingList.get(i).setNumber(i+1);
		}
		p.setList(endingList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到新增
	 * @param id
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/add")
	public String add(String id,ModelMap model){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
		model.addAttribute("openType", "Endadd");
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
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		
		User user = getUser();
		Ending end = new Ending();
		end.setContractBasicInfo(contractBasicInfo);
		end.setFcontId(contractBasicInfo.getFcId());
		end.setfEndUser(user.getName());
		end.setfEndTime(new Date());
		model.addAttribute("end", end );
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTZZ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//查询工作流
		List<TNodeData> nodeConfList =tProcessCheckMng.getNodeConf(user.getId(),"HTZZ",user.getDepart().getId(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode",end.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同终止");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/ending/ending_add";
	}
	
	/**
	 * 弹出合同列表页面让用户选择
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/endingContract")
	public String endingContract(ModelMap model){
		return "/WEB-INF/view/contract/ending/ending_add_contract";
	}
	
	/**
	 * 加载选择要终止合同的数据
	 * @param ContractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param mode
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/contractList")
	@ResponseBody
	public JsonPagination contractList(ContractBasicInfo ContractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap mode){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = formulationMng.find(ContractBasicInfo,getUser(), page, rows);
		List<ContractBasicInfo> cbi = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < cbi.size(); i++) {
			cbi.get(i).setNumber(i+1);
		}
		p.setList(cbi);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到修改页面
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		//终止信息
		Ending end = endingMng.findById(Integer.valueOf(id));
		//合同主键信息
		ContractBasicInfo contractBasicInfo = end.getContractBasicInfo();
		model.addAttribute("bean",contractBasicInfo);
		//List<Ending> li = endingMng.find1("contractBasicInfo.fcId", String.valueOf(contractBasicInfo.getFcId()), "1");
		//Ending end =new Ending();
		User user = getUser();
		//查询数据库是否有该合同的终止单，没有就新建一个
		/*if(li.size()>0){
			end = endingMng.findByfcId(String.valueOf(contractBasicInfo.getFcId()));	
			end.setFcontId(contractBasicInfo.getFcId());
			if(end.getStauts().equals("1")||end.getStauts().equals("9")){
				model.addAttribute("openType", "Enddetail");
			}else{
				model.addAttribute("openType", "Endedit");
			}
		}else{*/
			model.addAttribute("openType", "Endedit");
			end.setfEndUser(user.getName());
			end.setfEndDept(user.getDepartName());
			end.setfEndTime(new Date());
			end.setfEndUserId(user.getId());
			end.setFcontId(contractBasicInfo.getFcId());
			end.setEndStauts("1");
		//}
		model.addAttribute("end", end);
		//终止信息附件
		List<Attachment> endingattac = attachmentMng.list(end);
		model.addAttribute("endingAttaList", endingattac);
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
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		/*//合同结项的附件
		if(conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTZZ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",contractBasicInfo.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同终止");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(end.getUserId(),"HTZZ", departId,end.getBeanCode(),end.getfNextCode(), end.getJoinTable(), end.getBeanCodeField(), end.getfEndCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer=new Proposer(null, null, null);
		if(end!=null){
			//有end数据
			proposer = new Proposer(end.getfEndUser(), end.getfEndDept(), end.getfEndTime());
		}else {
			proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		}
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/contract/ending/ending_add";
	}
	
	/**
	 * 保存送审
	 * @param ending
	 * @param endingFiles
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Ending ending,String endingFiles,ModelMap model){
		try {
			if(StringUtil.isEmpty(ending.getfEndType())){
				return getJsonResult(false,"请选择终止类型！");
			}else if(StringUtil.isEmpty(ending.getfEndRemark())){
				return getJsonResult(false,"请填写终止类型！");
			}
			endingMng.save(ending, getUser(), endingFiles);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
	/**
	 * 跳转到合同终止审批list页面
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/applist")
	public String applist(ModelMap model){
		return "/WEB-INF/view/contract/ending/approval/ending_approval_list";
	}
	
	/**
	 * 加载合同终止审批list页面数据
	 * @param ending
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param mode
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/appjsonPagination")
	@ResponseBody
	public JsonPagination appjsonPagination(Ending ending,String sort,String order,Integer page,Integer rows,ModelMap mode){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = endingMng.appList(ending, getUser(), page, rows);
		List<Ending> endingList = (List<Ending>) p.getList();
		for (int i = 0; i < endingList.size(); i++) {
			endingList.get(i).setNumber(i+1);
		}
		p.setList(endingList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 弹出到审批页面
	 * @param id
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/approval/{id}")
	public String approval(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "Enapprove");
		//终止信息
		Ending end = endingMng.findById(Integer.valueOf(id));	
		model.addAttribute("end", end);
		//合同主键信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(end.getContractBasicInfo().getFcId()));
		model.addAttribute("bean",contractBasicInfo);
		//终止信息附件
		List<Attachment> endingattac = attachmentMng.list(end);
		model.addAttribute("endingAttaList", endingattac);
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
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		/*//合同结项的附件
		if(conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTZZ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",end.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同终止");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(end.getUserId(),"HTZZ", departId,end.getBeanCode(),end.getfNextCode(), end.getJoinTable(), end.getBeanCodeField(), end.getfEndCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer=new Proposer(null, null, null);
		//有end数据
		proposer = new Proposer(end.getfEndUser(), end.getfEndDept(), end.getfEndTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/contract/ending/approval/ending_approval_add";
	}
	
	/**
	 * 更新审批的状态
	 * @param stauts 审批意见
	 * @param Id 合同主键 
	 * @param checkInfo 审批记录信息
	 * @param model
	 * @return	 
	 * @createTime 2018-11-22
	 * @author 陈睿超
	 */
	@RequestMapping("/approve/{stauts}")
	@ResponseBody
	public Result approve(@PathVariable String stauts,String Id,String endingId,TProcessCheck checkBean,String spjlFile){
		try {
			checkBean = new TProcessCheck(stauts, "");
			endingMng.updateCheck(Id, checkBean, endingId, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	
	/**
	 * 查看
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "EndDeatil");
		//终止信息
		Ending end = endingMng.findById(Integer.valueOf(id));	
		model.addAttribute("end", end);
		//合同主键信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(end.getContractBasicInfo().getFcId()));
		model.addAttribute("bean",contractBasicInfo);
		//终止信息附件
		List<Attachment> endingattac = attachmentMng.list(end);
		model.addAttribute("endingAttaList", endingattac);
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
		//合同变更信息
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
		}
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		/*//合同结项的附件
		if(conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
		//查询归档信息
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//查询纠纷记录
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//合同纠纷附件
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//退还信息和附件
		GoldPay gold =new GoldPay();
		List<GoldPay> goldList = goldPayMng.findByContId(id);
		if(goldList!=null&&goldList.size()>0){
			gold = goldList.get(0);
			model.addAttribute("goldPay",gold);
		}
		List<Attachment> goldAttaList = attachmentMng.list(gold);
		model.addAttribute("goldAttaList", goldAttaList);
		//审批信息
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTZZ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",end.getBeanCode());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同终止");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(end.getUserId(),"HTZZ", departId,end.getBeanCode(),end.getfNextCode(), end.getJoinTable(), end.getBeanCodeField(), end.getfEndCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer=new Proposer(null, null, null);
		//有end数据
		proposer = new Proposer(end.getfEndUser(), end.getfEndDept(), end.getfEndTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/contract/ending/ending_detail";
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
			Ending bean = endingMng.findById(Integer.valueOf(id));
			Boolean tof = tProcessCheckMng.findbyCode(bean.getfEndCode(), "0");
			if(tof){
				return getJsonResult(false,"该申请已经被审批，不得撤回！");
			}else {
				endingMng.reCall(id);
				return getJsonResult(true,"操作成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
	}
}
