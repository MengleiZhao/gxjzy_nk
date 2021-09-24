package com.braker.icontrol.contract.filing.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.entity.DataEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Filing")
public class FilingController extends BaseController{

	@Autowired
	private FilingMng filingMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private UptClauseMng uptAttacMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	/**
	 * 跳转到主list页面
	 * @param model
	 * @return
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/contract/filing/filing_list";
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
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ContractBasicInfo contractBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p= filingMng.list(contractBasicInfo, getUser(),page,rows); 
		List<ContractBasicInfo> li= (List<ContractBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到备案页面
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/edit/{id}")
	public String edit_list(@PathVariable String id,ModelMap model){
		//合同主体信息
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "Fedit");
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
		}else{
			sign.setfSignName(contractBasicInfo.getfContractor());
		}
		model.addAttribute("signInfo", sign);
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//合同备案附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("合同备案");
		model.addAttribute("cheterInfo", cheterInfo);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/filing/filing_edit";
	}
	
	/**
	 * 备案保存相关信息
	 * @param contractBasicInfo
	 * @param signInfo
	 * @param planJson
	 * @param model
	 * @return
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/otherSave")
	@ResponseBody
	public Result othersave(ContractBasicInfo contractBasicInfo,SignInfo signInfo,String htwbfiles,String htwbfiles2,String planJson,ModelMap model){
		try {
			filingMng.otherSave(contractBasicInfo, getUser(), planJson, htwbfiles2, signInfo);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}  
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 根据id把合同状态改为0
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,String fId,ModelMap model){
		try {
			User user = getUser();
			ContractBasicInfo CBI=filingMng.findById(Integer.valueOf(id));
			CBI.setfContStauts("99");
			CBI.setUpdator(user.getAccountNo());
			CBI.setUpdateTime(new Date());
			filingMng.update(CBI);
			personalWorkMng.deleteById(Integer.valueOf(fId));
			personalWorkMng.sendMessageToUser(user.getId(), 0);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 显示付款计划的页面
	 * @param FcId
	 * @return
	 * @createtime 2018-06-19
	 * @author crc
	 */
	@RequestMapping("/finderReceivPlan")
	@ResponseBody
	public JsonPagination finderReceivPlan(String FcId,String sort,String order,Integer page, Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	ContractBasicInfo findById = formulationMng.findById(Integer.valueOf(FcId));
		Pagination p=filingMng.find_ReceivPlan(FcId,page,rows);
		List<DataEntity> DE=new ArrayList<DataEntity>();
		if (findById.getIskjht() != 1) {
			List<ReceivPlan> RP=(List<ReceivPlan>) p.getList();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
			for (int i = 0; i < RP.size(); i++) {
				DataEntity dataEntity=new DataEntity();
				dataEntity.setCol1(RP.get(i).getfReceProperty());
				dataEntity.setCol2(RP.get(i).getfRecStage());
				dataEntity.setCol3(RP.get(i).getfReceCondition());
				dataEntity.setCol4(format.format(RP.get(i).getfRecePlanTime()));
				dataEntity.setCol5(String.valueOf(RP.get(i).getfRecePlanAmount()));
				if(RP.get(i).getfReceTime()!=null){
					dataEntity.setCol6(format.format(RP.get(i).getfReceTime()));
				}
				if(!StringUtil.isEmpty(String.valueOf(RP.get(i).getfReceAmount()))){
					dataEntity.setCol7(String.valueOf(RP.get(i).getfReceAmount()));
				}
				dataEntity.setCol8(String.valueOf(RP.get(i).getfPlanId()));
				DE.add(dataEntity);
			}
		}
		p.setList(DE);
		return getJsonPagination(p , page);
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", contractBasicInfo);
		model.addAttribute("openType", "Fdetail");
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("signInfo", sign);
		}
		// 合同拟定的附件
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		if(Double.valueOf(contractBasicInfo.getFcAmount())>=100000&&contractBasicInfo.getStandard()==0){
			model.addAttribute("fsyjsFile", "0");
		}else{
			model.addAttribute("fsyjsFile", "");
		}
		//合同备案附件
		if(sign!=null){
			List<Attachment> signattac = attachmentMng.list(sign);
			model.addAttribute("filingattac", signattac);
		}
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/contract/filing/filing_detail";
		
	}
	
	
/*	*//**
	 * 合同文本附件添加
	 * @param fileurl1
	 * @return
	 *//*
	@RequestMapping("/filingFile")
	@ResponseBody
	public boolean applyFile(String filingfileurl){
		try {
			filingfileurl = java.net.URLDecoder.decode(filingfileurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		//获取文件名
		String[] names = filingfileurl.split("\\\\");
		String name = names[names.length-1].trim();
		//保存附件文件
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		boolean flag = false;
		try {
			String path = "HT/HTBA";
			String filename = name.trim();
			String input = filingfileurl.trim();
			flag=fu.upLoadFromProduction(url, port,username,password,path,filename,input);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	*//**
	 * 附件删除
	 * @param filename1
	 * @return
	 *//*
	@RequestMapping("/filingFileDelete")
	@ResponseBody
	public boolean applyFileDelete(String filename1){
		//保存附件文件
		try {
			filename1 = java.net.URLDecoder.decode(filename1,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String[] names = filename1.split("\\\\");
		filename1 = names[names.length-1].trim();
		
		//查询是否在数据库中存在该附件
		List<Attac> li = formulationMng.findAttacByName(filename1);
		//删除已存在数据库中的附件信息
		formulationMng.deleteAttac(li);
		
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		String path = "HT/HTBA";
		
		boolean flag = false;
		try {
			fu.delFile(url, port, username, password, path, filename1);
			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}*/
	
	/*
	 * 上传附件
	 * 
	 * @author zhangxun
	 * 
	 * @createtime 2018-10-31
	 * 
	 * @updatetime 2018-11-13
	 */
	@RequestMapping("/uploadAtt")
	@ResponseBody
	public Result uploadAtt(
			ModelMap model,
			String serviceType,
			@RequestParam(value = "attFiles", required = false) MultipartFile[] attFiles) {

		try {
			// 保存附件到服务器
			String ids = attachmentMng.uploadAjax(attFiles, serviceType,
					FileUpLoadUtil.getHTGLSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}
}
