package com.braker.icontrol.contract.archiving.controller;


import java.util.Date;
import java.util.List;

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
import com.braker.icontrol.contract.enforcing.manager.ChangeMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionAttacMng;
import com.braker.icontrol.contract.enforcing.manager.ConclusionMng;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.enforcing.model.UptClause;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Archiving")
public class ArchivingController extends BaseController{

	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private SignInfoMng SignInfoMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private ArchivingMng ArchivingMng;
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
	private CheterMng cheterMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private UserMng userMng;
	
	/**
	 * ???????????????(??????)
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/contract/Archiving/archiving_list";
	}
	
	
	/**
	 * ????????????(??????)
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/htgdsp")
	public String htgdsp(ModelMap model){
		
		return "/WEB-INF/view/contract/Archiving/archiving_list_sp";
	}
	
	
	/**
	 * ????????????????????????(?????????)
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/JsonPaginationsp")
	@ResponseBody
	public JsonPagination jsonPaginationsp(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = archivingMng.query_CBIspcb(contractBasicInfo,getUser(),page,rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ????????????????????????(?????????)
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = archivingMng.query_CBI(contractBasicInfo, getUser(),page,rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
			/*List<Archiving> findByContId = ArchivingMng.findByContId(String.valueOf(li.get(i).getFcId()));*/
			/*if (findByContId != null && findByContId.size()>0) {
				li.get(i).setGdspstatus(findByContId.get(0).getCheckStauts());
			}else{
				li.get(i).setGdspstatus("0");
			}*/
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * ????????????????????????(????????????)
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/htgdsps")
	@ResponseBody
	public JsonPagination jsonPaginationbgsp(Upt upt,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = archivingMng.query_CBIuptsp(upt, getUser(), page, rows);
		List<Upt> li= (List<Upt>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	/**
	 * ????????????????????????(????????????)
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	@RequestMapping("/JsonPaginationbg")
	@ResponseBody
	public JsonPagination jsonPaginationbg(Upt upt,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = archivingMng.query_CBIupt(upt, getUser(), page, rows);
		List<Upt> li= (List<Upt>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
			List<Archiving> findByContId = ArchivingMng.findByContId(String.valueOf(li.get(i).getfId_U()));
			if (findByContId != null && findByContId.size()>0) {
				li.get(i).setGdbgspstatus(findByContId.get(0).getCheckStauts());
			}else{
				li.get(i).setGdbgspstatus("0");
			}
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}

	/**
	 * ??????id????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/detailbg/{id}")
	public String detail(@PathVariable String id,ModelMap model,HttpServletRequest request){
		//??????????????????
		Upt upt =uptMng.findById(Integer.valueOf(id));
		model.addAttribute("Upt", upt);
		ContractBasicInfo contractBasicInfo = formulationMng.findById(upt.getfContId_U());
		contractBasicInfo=formulationMng.findById(Integer.valueOf(upt.getfContId_U()));
		model.addAttribute("Upt", upt);
		model.addAttribute("bean", contractBasicInfo);
		
		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		//???????????????id
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		
		model.addAttribute("openType", "");
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		Archiving archiving = findByContId.get(0);
		if(findByContId!=null&&findByContId.size()>0){
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
			//????????????
			List<Attachment> attaListgd = attachmentMng.list(archiving);
			model.addAttribute("archivingAttaList", attaListgd);
			//????????????
		}
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//????????????????????????
		List<Archiving> uptContId = archivingMng.findByContId(id);
		if(uptContId!=null&&uptContId.size()>0){
			Archiving archivingUpt = uptContId.get(0);
			//????????????
			List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
			model.addAttribute("archivingAttaListUpt", attaListgdUpt);
			model.addAttribute("archivingUpt", archivingUpt);
		}
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(archiving.getFUserId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(archiving.getUserId(),"HTGD", departId,archiving.getBeanCode(),archiving.getFNextCheckKey(), "T_CONTRACT_TOFILE", "F_TO_CODE", archiving.getfToCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", departId);
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(archiving.getFBeforeUser(), archiving.getFBeforeDepart(), archiving.getFBeforeTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//return "/WEB-INF/view/contract/change/change_detail";
		return "/WEB-INF/view/contract/Archiving/archiving_detail_bg";
	}
	
	/**
	 * ?????????????????????????????????
	 * @author crc
	 * @createtime 2018-06-22
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/editbg/{id}")
	public String edit(@PathVariable String id, ModelMap model){
		//??????????????????
		Upt upt =uptMng.findById(Integer.valueOf(id));
		model.addAttribute("Upt", upt);
		ContractBasicInfo contractBasicInfo = formulationMng.findById(upt.getfContId_U());
		model.addAttribute("bean",contractBasicInfo);
		
		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		//???????????????id
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		
		Archiving archiving = new Archiving();
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		if(findByContId.size()>0){
			archiving = findByContId.get(0);
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
			//????????????
			List<Attachment> attaListgd = attachmentMng.list(archiving);
			model.addAttribute("archivingAttaList", attaListgd);
			//????????????
		}
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//????????????????????????
		List<Archiving> uptContId = archivingMng.findByContId(id);
		if(uptContId!=null&&uptContId.size()>0){
			Archiving archivingUpt = uptContId.get(0);
			//????????????
			List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
			model.addAttribute("archivingAttaListUpt", attaListgdUpt);
			model.addAttribute("archivingUpt", archivingUpt);
		}
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		User user=getUser();
		//?????????????????????????????????
		/*if("1".equals(upt.getfUptFlowStauts())||"9".equals(upt.getfUptFlowStauts())){
			model.addAttribute("openType", "Cdetail");
		}else {
			model.addAttribute("openType", "Cedit");
		}*/
		model.addAttribute("openType", "Aedit");
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//?????????????????????????????????id
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HTGD", user.getDepart().getId(),null,archiving.getFNextCheckKey(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", user.getDepart().getId());
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/Archiving/archiving_edit_bg";
	}
	
	
	/**
	 * ?????????????????????????????????
	 * @author crc
	 * @createtime 2018-06-22
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/editbgsp/{id}")
	public String editsp(@PathVariable String id, ModelMap model){
		//??????????????????
		Upt upt =uptMng.findById(Integer.valueOf(id));
		model.addAttribute("Upt", upt);
		ContractBasicInfo contractBasicInfo = formulationMng.findById(upt.getfContId_U());
		model.addAttribute("bean",contractBasicInfo);
		
		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		//???????????????id
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		
		model.addAttribute("openType", "Aedit");
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(upt.getfId_U().toString());
		Archiving archiving = findByContId.get(0);
		if(findByContId.size()>0){
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
		}
		//????????????
		List<Attachment> attaListgd = attachmentMng.list(archiving);
		model.addAttribute("archivingAttaList", attaListgd);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//????????????????????????
		List<Archiving> uptContId = archivingMng.findByContId(id);
		if(uptContId!=null&&uptContId.size()>0){
			Archiving archivingUpt = uptContId.get(0);
			//????????????
			List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
			model.addAttribute("archivingAttaListUpt", attaListgdUpt);
			model.addAttribute("archivingUpt", archivingUpt);
		}
		
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		User user=getUser();
		//?????????????????????????????????
		if("1".equals(upt.getfUptFlowStauts())||"9".equals(upt.getfUptFlowStauts())){
			model.addAttribute("openType", "Cdetail");
		}else {
			model.addAttribute("openType", "Cedit");
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(archiving.getFUserId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(archiving.getUserId(),"HTGD", departId,archiving.getBeanCode(),archiving.getFNextCheckKey(), "T_CONTRACT_TOFILE", "F_TO_CODE", archiving.getfToCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", departId);
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		//????????????
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(archiving.getFBeforeUser(), archiving.getFBeforeDepart(), archiving.getFBeforeTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/Archiving/archiving_edit_bg_sp";
	}
	
	
	/**
	 * ??????id??????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-22
	 */
	@RequestMapping("/detailbgsp/{id}")
	public String detailsp(@PathVariable String id,ModelMap model,HttpServletRequest request){
		//??????????????????
		Upt upt =uptMng.findById(Integer.valueOf(id));
		model.addAttribute("Upt", upt);
		ContractBasicInfo contractBasicInfo = formulationMng.findById(upt.getfContId_U());
		contractBasicInfo=formulationMng.findById(Integer.valueOf(upt.getfContId_U()));
		model.addAttribute("Upt", upt);
		model.addAttribute("bean", contractBasicInfo);
		
		TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		//???????????????id
		model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
		model.addAttribute("foCodeBG",upt.getBeanCode());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		
		model.addAttribute("openType", "Cdetail");
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		Archiving archiving = findByContId.get(0);
		if(findByContId.size()>0){
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
		}
		//????????????
		List<Attachment> attaListgd = attachmentMng.list(archiving);
		model.addAttribute("archivingAttaList", attaListgd);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//????????????????????????
		List<Archiving> uptContId = archivingMng.findByContId(id);
		if(uptContId!=null&&uptContId.size()>0){
			Archiving archivingUpt = uptContId.get(0);
			//????????????
			List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
			model.addAttribute("archivingAttaListUpt", attaListgdUpt);
			model.addAttribute("archivingUpt", archivingUpt);
		}
		
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(archiving.getFUserId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(archiving.getUserId(),"HTGD", departId,archiving.getBeanCode(),archiving.getFNextCheckKey(), "T_CONTRACT_TOFILE", "F_TO_CODE", archiving.getfToCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", departId);
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		//????????????
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(archiving.getFBeforeUser(), archiving.getFBeforeDepart(), archiving.getFBeforeTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/contract/Archiving/archiving_detail_bg_sp";
	}
	/**
	 * ?????????????????????
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/detailsp/{id}")
	public String detailsp(ModelMap model,@PathVariable String id){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//Archiving findById = ArchivingMng.findById(Integer.valueOf(id));
		model.addAttribute("openType", "");
		//model.addAttribute("findById", findById);
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		Archiving archiving = findByContId.get(0);
		if(findByContId.size()>0){
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
		}
		//????????????
		List<Attachment> attaListgd = attachmentMng.list(archiving);
		model.addAttribute("archivingAttaList", attaListgd);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		
		//??????????????????
		if (null != contractBasicInfo) {
			model.addAttribute("bean",contractBasicInfo);
			SignInfo sign=new SignInfo();
			List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
			if(signInfoList!=null&&signInfoList.size()>0){
				sign = signInfoList.get(0);
				model.addAttribute("signInfo", sign);
			}
			//??????????????????????????????
			if(sign!=null){
				List<Attachment> signattac = attachmentMng.list(sign);
				model.addAttribute("filingattac", signattac);
			}
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
			
		//??????????????????
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
			//???????????????id
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			model.addAttribute("foCodeBG",upt.getBeanCode());
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//??????????????????
		List<Archiving> archivingList = archivingMng.findByContId(id);
		if(archivingList!=null&&archivingList.size()>0){
			model.addAttribute("archiving", archivingList.get(0));
		}
		//??????????????????
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//??????????????????
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//????????????
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(archiving.getFUserId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(archiving.getUserId(),"HTGD", departId,archiving.getBeanCode(),archiving.getFNextCheckKey(), "T_CONTRACT_TOFILE", "F_TO_CODE", archiving.getfToCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", departId);
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		//????????????
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(archiving.getFBeforeUser(), archiving.getFBeforeDepart(), archiving.getFBeforeTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????????????????
		//model.addAttribute("splc", "1");
		}else {
			Upt upt = null;
			List<Upt> uptList = uptMng.findByFContId_U(id);
			if(uptList!=null&&uptList.size()>0){
				upt = uptList.get(0);
				model.addAttribute("upt", upt);
			}
			ContractBasicInfo contractBasicInfo1 = formulationMng.findById(Integer.valueOf(upt.getfContId_U()));
			//Archiving archiving = findByContId.get(0);
			model.addAttribute("bean",contractBasicInfo1);
			//??????????????????
			List<Attachment> uptAttaList = attachmentMng.list(upt);
			model.addAttribute("changeAttaList", uptAttaList);
		}
		return "/WEB-INF/view/contract/Archiving/archiving_detail_sp";
	}
	
	/**
	 * ???????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-28
	 */
	@RequestMapping("/editsp/{id}")
	public String archivingsp(@PathVariable String id,ModelMap model){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//List<Archiving> findByContId = ArchivingMng.findByContId(id);
		//model.addAttribute("findById", findByContId.get(0));
		model.addAttribute("bean",contractBasicInfo);
		//?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", contractBasicInfo.getfDeptId());
		
		//???????????????id
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
			
		model.addAttribute("openType", "Aedit");
		//??????????????????
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		Archiving archiving = findByContId.get(0);
		if(findByContId.size()>0){
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
		}
		//????????????
		List<Attachment> attaListgd = attachmentMng.list(archiving);
		model.addAttribute("archivingAttaList", attaListgd);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		//??????????????????????????????
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//??????????????????
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
				
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			//???????????????id
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		/*//?????????????????????
		if( conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
		//??????????????????
		Dispute dis =new Dispute();
		List<Dispute> disList = disputeMng.findByContId(id);
		if(disList!=null&&disList.size()>0){
			dis = disList.get(0);
			model.addAttribute("dispute",dis);
		}
		//??????????????????
		List<Attachment> disputeAttaList = attachmentMng.list(dis);
		model.addAttribute("disputeAttaList", disputeAttaList);
		//????????????
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(archiving.getFUserId())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(archiving.getUserId(),"HTGD", departId,archiving.getBeanCode(),archiving.getFNextCheckKey(), "T_CONTRACT_TOFILE", "F_TO_CODE", archiving.getfToCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//???????????????id
		TProcessDefin tProcessDefinGD=tProcessDefinMng.getByBusiAndDpcode("HTGD", departId);
		model.addAttribute("fpIdGD", tProcessDefinGD.getFPId());
		//????????????
		model.addAttribute("foCodeGD",archiving.getBeanCode());
		//?????????????????????????????????
		Proposer proposer = new Proposer(archiving.getFBeforeUser(), archiving.getFBeforeDepart(), archiving.getFBeforeTime());
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????????????????
		//model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/Archiving/archiving_edit_sp";
	}
	
	/**
	 * ???????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-28
	 */
	@RequestMapping("/edit/{id}")
	public String archiving(@PathVariable String id,ModelMap model){
		model.addAttribute("openType", "Aedit");
		model.addAttribute("detailType", "detail");
		Archiving archiving = new Archiving();
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		if(findByContId.size()>0){
			archiving = findByContId.get(0);
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
			//????????????
			List<Attachment> attaListgd = attachmentMng.list(archiving);
			model.addAttribute("archivingAttaList", attaListgd);
		}
		
		//??????????????????
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//???????????????
		ContractBasicInfo findById = formulationMng.findById(Integer.valueOf(id));
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
		return "/WEB-INF/view/contract/Archiving/archiving_edit";
	}
	
	@RequestMapping("/Save")
	@ResponseBody
	public Result save(ContractBasicInfo contractBasicInfo,User user,Archiving archiving,String files){
		try {
			if(StringUtil.isEmpty(archiving.getFqdTime().toString())){
				return getJsonResult(false, "????????????????????????");
			}else {
				ArchivingMng.save(contractBasicInfo, archiving, getUser(),files);
				return getJsonResult(true, "???????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
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
	@RequestMapping("/Savebg")
	@ResponseBody
	public Result savebg(ContractBasicInfo contractBasicInfo,String uptplanJson,String planJson,UptClause uptAttac,Upt upt,String htbgfiles,Archiving archiving,String files){
		try {
			if(StringUtil.isEmpty(archiving.getFqdTime().toString())){
				return getJsonResult(false, "????????????????????????");
			}else{
				ArchivingMng.savebg(contractBasicInfo, archiving, getUser(),upt,files);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model,@PathVariable String id){
		model.addAttribute("openType", "Adetail");
		//??????????????????
		Archiving archiving = new Archiving();
		List<Archiving> findByContId = ArchivingMng.findByContId(id);
		if(findByContId.size()>0){
			archiving = findByContId.get(0);
			if(archiving.getFqdTime() == null){
				archiving.setFqdTime(new Date());
			}
			model.addAttribute("archiving", archiving);
			//????????????
			List<Attachment> attaListgd = attachmentMng.list(archiving);
			model.addAttribute("archivingAttaList", attaListgd);
		}
		
		//??????????????????
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//???????????????
		ContractBasicInfo findById = formulationMng.findById(Integer.valueOf(id));
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
		return "/WEB-INF/view/contract/Archiving/archiving_detail";
	}
	
	
	/**
	 * ??????????????????????????????????????????????????????
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/fProCodejsonPagination")
	@ResponseBody
	public JsonPagination fProCodejsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = ArchivingMng.query_CBI_Archiving(contractBasicInfo, getUser(), page, rows);
		return getJsonPagination(p, page);	
	}
	
	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	@RequestMapping(value = "/checkResult/{stauts}")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,Archiving bean,String fremark,String files,@PathVariable String stauts) {
		try {
			if(stauts.equals("0")&&StringUtil.isEmpty(stauts)){
				return getJsonResult(false, "?????????????????????????????????");
			}
			fremark = checkBean.getFcheckRemake();
			checkBean =new TProcessCheck(stauts,fremark);
			ArchivingMng.saveCheckInfobg(checkBean, bean, getUser(), files,stauts);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/*
	 * ???????????????
	 * @author ?????????
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	@RequestMapping(value = "/checkResultbg/{stauts}")
	@ResponseBody
	public Result checkResultbg(TProcessCheck checkBean,Archiving bean,String fremark,String files,@PathVariable String stauts) {
		try {
			if(stauts.equals("0")&&StringUtil.isEmpty(stauts)){
				return getJsonResult(false, "?????????????????????????????????");
			}
			fremark = checkBean.getFcheckRemake();
			checkBean =new TProcessCheck(stauts,fremark);
			ArchivingMng.saveCheckInfo(checkBean, bean, getUser(),files,stauts,"upt");
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * ???????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			ArchivingMng.delete_CBI(id,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
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
			ArchivingMng.reCall(id);
			return getJsonResult(true,"???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
	}
}
