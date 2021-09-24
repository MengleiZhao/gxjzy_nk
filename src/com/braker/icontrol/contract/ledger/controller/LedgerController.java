package com.braker.icontrol.contract.ledger.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
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
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Ledger")
public class LedgerController extends BaseController{

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
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private ArchivingMng ArchivingMng;
	
	/**
	 * 台账列表页
	 * @param model
	 * @return
	 * @createtime 2018-07-03
	 * @author 陈睿超
	 */
	@RequestMapping("/list")
	public String list(ModelMap model,String proId){
		if(!StringUtil.isEmpty(proId)){
			TProBasicInfo tpbi=tProBasicInfoMng.findById(Integer.valueOf(proId));
			TBudgetIndexMgr bim = budgetIndexMgrMng.findByIndexCode(tpbi.getFProCode());
			
			model.addAttribute("fBudgetIndexCode", bim.getbId());
		}
		return "/WEB-INF/view/contract/ledger_list";
	}
	
	/**
	 * 加载台账数据
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = LedgerMng.findAllCBI(contractBasicInfo, true, getUser(), page, rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
		if (li != null && li.size() > 0) {
			int i = 0;
			for (ContractBasicInfo tb: li) {
				//签约方信息
				//SignInfo signInfoList = signInfoMng.findByProperty("fContId", tb.getFcId()).get(0);
				//tb.setfContractor(signInfoList.getfSignName());
				tb.setNumber(page * rows + i - 499);
				i++;
			}
		}
    	p.setList(li);
		return getJsonPagination(p, page);
		
	}
	
	/**
	 * 加载台账页面变更合同数据
	 * @param upt
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年12月21日
	 * @updator 赵孟雷
	 * @updatetime 2020年12月21日
	 */
	@RequestMapping("/ChangeJsonPagination")
	@ResponseBody
	public JsonPagination ChangeJsonPagination(Upt upt,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = LedgerMng.uptList(upt, getUser(), page, rows);
		List<Upt> li= (List<Upt>) p.getList();
		if (li != null && li.size() > 0) {
			int i = 0;
			for (Upt tb: li) {
				//签约方信息
				SignInfo signInfoList = signInfoMng.findByProperty("fContId", tb.getfContId_U()).get(0);
				tb.setfContractor(signInfoList.getfSignName());
				tb.setNumber(page * rows + i - 499);
				i++;
			}
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 查看
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detailContract/{id}")
	public String detail(@PathVariable String id,ModelMap model,String type){
		//合同信息
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		
		model.addAttribute("findById", contractBasicInfo);
		
		//查询归档信息
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//归档附件
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		
		Upt upt =new Upt();
		if("1".equals(contractBasicInfo.getfUpdateStatus())){
			upt =uptMng.findByFContId_U(id).get(0);
			
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			//对象编码
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
			model.addAttribute("uptShow", "0");
			//查询归档信息
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//归档附件
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}else{
			model.addAttribute("uptShow", "");
		}
		model.addAttribute("Upt", upt);

		//Dispute dispute = new Dispute();
		/*if("1".equals(contractBasicInfo.getfDisputeStatus())){
			dispute =disputeMng.findByContId(id).get(0);
			model.addAttribute("disputeShow", "0");
		}else{
			model.addAttribute("disputeShow", "");
		}*/
		//model.addAttribute("dispute", dispute);
		//合同纠纷附件
		/*if(dispute!=null){
			List<Attachment> disputeAtta = attachmentMng.list(dispute);
			model.addAttribute("disputeAttaList", disputeAtta);
		}*/
		//合同备案信息
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("findSign", sign);
		}
		//合同备案合同正本附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//查询归档信息
		if("1".equals(contractBasicInfo.getFgdStauts())){
			List<Archiving> findByContId = ArchivingMng.findByContId(id);
			if(findByContId.size()>0){
				Archiving archiving = findByContId.get(0);
				if(archiving.getFqdTime() == null){
					archiving.setFqdTime(new Date());
				}
				model.addAttribute("archiving", archiving);
				//归档附件
				List<Attachment> attaListgd = attachmentMng.list(archiving);
				model.addAttribute("archivingAttaList", attaListgd);
			}
		}
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//查询工作流
		/*List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		String dept[]=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId());
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(),dept[1], contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);*/
		//根据申请人得到申请部门id
		//得到工作流id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		return "/WEB-INF/view/contract/ledger/ledger_contract";
	}
	
	
	/**
	 * 查看
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detailUpt/{id}")
	public String detailUpt(@PathVariable String id,ModelMap model,String type){
		//合同变更信息
		Upt upt =uptMng.findById(Integer.valueOf(id));
		model.addAttribute("Upt", upt);
		ContractBasicInfo contractBasicInfo = formulationMng.findById(upt.getfContId_U());
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "Cdetail");
		//查询归档信息
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//归档附件
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//变更合同归档信息
		List<Archiving> uptContId = archivingMng.findByContId(id);
		if(uptContId!=null&&uptContId.size()>0){
			Archiving archivingUpt = uptContId.get(0);
			//归档附件
			List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
			model.addAttribute("archivingAttaListUpt", attaListgdUpt);
			model.addAttribute("archivingUpt", archivingUpt);
		}
		Dispute dispute = new Dispute();
		if("1".equals(contractBasicInfo.getfDisputeStatus())){
			dispute =disputeMng.findByContId(String.valueOf(contractBasicInfo.getFcId())).get(0);
			model.addAttribute("disputeShow", "0");
		}else{
			model.addAttribute("disputeShow", "");
		}
		model.addAttribute("dispute", dispute);
		
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
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//合同变更附件
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(upt.getUserId(),"HTBG", upt.getfDeptID(),upt.getBeanCode(),upt.getfNCode(), "T_CONTRACT_UPT", "F_UPT_CODE", upt.getfUptCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		String dept[]=departMng.findDeptByUserId(upt.getfOperatorID());
		Proposer proposer = new Proposer(upt.getfOperator(),dept[1], upt.getfReqTime());
		model.addAttribute("proposer", proposer);
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(upt.getfOperatorID())[0];

		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", departId);
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		//对象编码
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		
		//得到工作流id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//对象编码
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		//查询归档信息
		if("1".equals(upt.getFgdstatus())){
			List<Archiving> findByContId = ArchivingMng.findByContId(id);
			Archiving archiving = findByContId.get(0);
			if(findByContId!=null&&findByContId.size()>0){
				if(archiving.getFqdTime() == null){
					archiving.setFqdTime(new Date());
				}
				model.addAttribute("archiving", archiving);
				//归档附件
				List<Attachment> attaListgd = attachmentMng.list(archiving);
				model.addAttribute("archivingAttaList", attaListgd);
				//对象编码
			}
		}
		return "/WEB-INF/view/contract/ledger/ledger_change";
	}
	
	/**
	 * 导出
	 * @param model
	 * @param response
	 * @param request
	 * @param bean
	 * @param currentYear
	 * @return
	 */
	@RequestMapping("/export")
	public String export(ModelMap model, HttpServletResponse response, HttpServletRequest request, ContractBasicInfo cb,Upt upt, String currentYear,String type){
		OutputStream out = null;
		try {

			//生成excel并导出
			HSSFWorkbook workbook = null;
			if("0".equals(type)){
				//初始化
				response.setHeader("Content-Disposition","attachment; filename="+new String("合同台账".getBytes("gbk"), "iso8859-1")+".xls");   
				out = new BufferedOutputStream(response.getOutputStream());
				response.setContentType("application/octet-stream");   
				String path = request.getSession().getServletContext().getRealPath("/resource");
				String filePath=path+"\\download\\合同台账导出模板.xls";
				//台账数据
				List<ContractBasicInfo> ledgerData = LedgerMng.ledgerExport(cb,getUser());
				//生成excel并导出
				workbook = LedgerMng.exportExcel(ledgerData, filePath);
			}else{
				//初始化
				response.setHeader("Content-Disposition","attachment; filename="+new String("变更合同台账".getBytes("gbk"), "iso8859-1")+".xls");   
				out = new BufferedOutputStream(response.getOutputStream());   
				response.setContentType("application/octet-stream");   
				String path = request.getSession().getServletContext().getRealPath("/resource");
				String filePath=path+"\\download\\变更合同台账导出模板.xls";
				//台账数据
				List<Upt> ledgerData = LedgerMng.uptListExport(upt, getUser(), 1, 10);
				if (ledgerData != null && ledgerData.size() > 0) {
					for (Upt tb: ledgerData) {
						//签约方信息
						SignInfo signInfoList = signInfoMng.findByProperty("fContId", tb.getfContId_U()).get(0);
						tb.setfContractor(signInfoList.getfSignName());
					}
				}
				//生成excel并导出
				workbook = LedgerMng.exportExcelUpt(ledgerData, filePath);
			}


			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
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
	 * 合同情况统计表列表页
	 * @param model
	 * @param proId
	 * @return
	 */
	@RequestMapping("/statisticsList")
	public String statisticsList(ModelMap model,String proId){
		return "/WEB-INF/view/contract/statistics_list";
	}
	
	/**
	 * 加载台账数据
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/statisticsJsonPagination")
	@ResponseBody
	public List<Object[]> statisticsJsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		List<Object[]> obj = LedgerMng.findAllStatistics(contractBasicInfo, true, getUser(), page, 100);
		return obj;
		
	}
}
