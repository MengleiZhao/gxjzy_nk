package com.braker.icontrol.contract.dispute.controller;

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
import com.braker.core.model.CheterInfo;
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
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Dispute")
public class DisputeController extends BaseController{

	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private SignInfoMng SignInfoMng;
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
	private CheterMng cheterMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private ApplyMng applyMng;
	/**
	 * ???????????????
	 * @param model
	 * @return
	 * @createtime 2018-06-29
	 * @author crc
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/contract/dispute/dispute_list";
	}
	
	/**
	 * ??????????????????????????????
	 * @param contractBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2018-06-29
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p =disputeMng.list(contractBasicInfo,getUser(),page,rows);
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/popupht")
	public String endingContract(ModelMap model){
		return "/WEB-INF/view/contract/dispute/dispute_add_contract_jf";
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
		Pagination p = formulationMng.queryForChangejf(ContractBasicInfo,getUser(), page, rows);
		List<ContractBasicInfo> cbi = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < cbi.size(); i++) {
			cbi.get(i).setNumber(i+1);
		}
		p.setList(cbi);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ???????????????????????????
	 * @param model
	 * @param id
	 * @return
	 * @createtime 2018-06-29
	 * @author crc
	 */
	@RequestMapping("/add/{id}")
	public String add(ModelMap model,@PathVariable String id){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		//????????????
		model.addAttribute("bean",contractBasicInfo);
		
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
		List<Attachment> conAttaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", conAttaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		model.addAttribute("openType", "Dadd");
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
		//????????????
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		int n=1;
		//??????????????????
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
			n=n+2;
			
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			//????????????
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
			//??????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}
		model.addAttribute("textClassNum", n);
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		Dispute dis =new Dispute();
		dis.setfLawyer("0");
		model.addAttribute("dispute", dis);
		/*//?????????????????????
		if( conclusionAttacMng.findAllFile(id).size()>0){
			model.addAttribute("conclusionattac", conclusionAttacMng.findAllFile(id));
		}	*/
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/dispute/dispute_edit";
		
	}
	
	
	/**
	 * ??????
	 * @param dispute
	 * @param model
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Dispute dispute,ContractBasicInfo ContractBasicInfo,String fhtjffiles, ModelMap model,String fjfStauts){
		try {
			if(StringUtil.isEmpty(dispute.getfDisRemark())){
				return getJsonResult(false, "????????????????????????");
			}else if(StringUtil.isEmpty(dispute.getfDisResult())){
				return getJsonResult(false, "????????????????????????");
			}else if(StringUtil.isEmpty(dispute.getfLawyer())){
				return getJsonResult(false, "??????????????????????????????");
			}else{
				disputeMng.save(dispute,fhtjffiles, getUser(),ContractBasicInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
		return getJsonResult(true, "???????????????");
	}
	
	
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model,@PathVariable String id){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
		//??????????????????
		List<Attachment> conAttaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", conAttaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		model.addAttribute("openType", "Dedit");
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
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		int n=1;
		//??????????????????
		Upt upt =new Upt();
		List<Upt> uptList = uptMng.findByFContId_U(id);
		if(uptList!=null&&uptList.size()>0){
			upt = uptList.get(0);
			model.addAttribute("Upt", upt);
			n=n+2;
			
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			//????????????
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
			//??????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}
		model.addAttribute("textClassNum", n);
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
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
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/dispute/dispute_edit";
		
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model,@PathVariable String id){
		ContractBasicInfo contractBasicInfo = formulationMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",contractBasicInfo);
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
		List<Attachment> conAttaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", conAttaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		model.addAttribute("openType", "Ddetail");
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
		//????????????
		//model.addAttribute("CheckInfo", checkInfoMng.query(contractBasicInfo.getFcId()));
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		//??????????????????
		Upt upt =new Upt();
		if(uptMng.findByFContId_U(id).size()>0){
			upt = uptMng.findByFContId_U(id).get(0);
			model.addAttribute("Upt", upt);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HTBG", departId);
			model.addAttribute("fpIdBG", tProcessDefin.getFPId());
			//????????????
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
			//??????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
				List<Attachment> attaListgdUpt = attachmentMng.list(archivingUpt);
				model.addAttribute("archivingAttaListUpt", attaListgdUpt);
				model.addAttribute("archivingUpt", archivingUpt);
			}
		}
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
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
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/dispute/dispute_detail";
		
	}
	
	/**
	 * ????????????
	 * @param fileurl
	 * @return
	 *//*
	@RequestMapping("/disputeFile")
	@ResponseBody
	public boolean applyFile(String fileurl){
		try {
			fileurl = java.net.URLDecoder.decode(fileurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//???????????????
		String[] names = fileurl.split("\\\\");
		String name = names[names.length-1].trim();
		//??????????????????
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		boolean flag = false;
		try {
			String path = "HT/HTJF";
			String filename = name.trim();
			String input = fileurl.trim();
			flag=fu.upLoadFromProduction(url, port,username,password,path,filename,input);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	
	
	*//**
	 * ????????????
	 * @param filename
	 * @return
	 *//*
	@RequestMapping("/disputeFileDelete")
	@ResponseBody
	public boolean applyFileDelete(String filename){
		//??????????????????
		try {
			filename = java.net.URLDecoder.decode(filename,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String[] names = filename.split("\\\\");
		filename = names[names.length-1].trim();
		
		//??????????????????????????????????????????
		List<DisputAttac> li = disputAttacMng.findByName(filename);
		//??????????????????????????????????????????
		disputAttacMng.delete(li);
		
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		String path = "HT/HTJF";
		
		boolean flag = false;
		try {
			fu.delFile(url, port, username, password, path, filename);
			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}*/
	
	/**
	 * 
	 * @param id
	 * @param fId
	 * @return
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id,String fcId) {
		try {
			//????????????id?????????
			User user = getUser();
			disputeMng.deletejf(id,user,fcId);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
}
