package com.braker.icontrol.assets.rece.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import net.sf.json.JSONArray;
import oracle.net.aso.r;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.doc2html.Word2Html;
import com.braker.common.ftp.FileUpload;
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
import com.braker.icontrol.assets.rece.manager.ReceListMng;
import com.braker.icontrol.assets.rece.manager.ReceMng;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Rece")
public class ReceController extends BaseController{
	
	@Autowired
	private ReceMng receMng;
	@Autowired
	private ReceListMng receListMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired 
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private AttachmentMng attachmentMng;
	/**
	 * ?????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/lowlist")
	public String jump(ModelMap model){
		return "WEB-INF/view/assets/rece/rece_low_list";
	}
	/**
	 * ????????????????????????
	 * @param path
	 * @param model
	 * @return
	 * @throws ParserConfigurationException 
	 * @throws IOException 
	 * @throws TransformerException 
	 */
	@RequestMapping("/office")
	@ResponseBody
	public String office(String path,ModelMap model) throws TransformerException, IOException, ParserConfigurationException{
		try {
			path = java.net.URLDecoder.decode(path,"UTF-8");
			path=path.trim();
			String[] p=path.split("/");
			String filename=null;
			if((p[p.length-1].substring(p[p.length-1].length()-1)).equals("x")){
				filename = p[p.length-1].substring(0, p[p.length-1].length()-5);
			}else if((p[p.length-1].substring(p[p.length-1].length()-1)).equals("c")){
				filename = p[p.length-1].substring(0, p[p.length-1].length()-4);
			}
			String name =StringUtil.Random("")+".html";
			FileUpload fu = new FileUpload();
			String url = fu.getFtpConfig("url");
			String webport = fu.getFtpConfig("webport");
			String filepath = fu.getFtpConfig("filepath");
			String basepath = fu.getFtpConfig("basepath");
			//word????????????
			String officePath=basepath+filepath+path;
			//?????????html???????????????
			String outPutFile=p[0]+"/"+p[1]+"/"+name;
			//?????????html?????????????????????
			String fileUrl=basepath+filepath+outPutFile;
			String wordUrl="http://"+url+":"+webport+filepath+outPutFile;
			//??????????????????
			String images=basepath+filepath+p[0]+"/"+p[1]+"/images/";
			Word2Html w=new Word2Html();
			w.wordToHtml(officePath, fileUrl, images);
			return wordUrl;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	
	@RequestMapping("/doc")
	public String doc(@PathVariable String filurl,ModelMap model){
		System.out.println("dada");
		try {
			filurl = java.net.URLDecoder.decode(filurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return filurl;
	}
	
	/**
	 * ?????????????????????????????????
	 * @param rece
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-06
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPaginationLow(Rece rece,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = receMng.list(rece, getUser(), page, rows);
		List<Rece> li=(List<Rece>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ??????????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-06
	 */
	@RequestMapping("/addlow")
	public String addlow(ModelMap model){
		Rece rece=new Rece();
		rece.setfAssReceCode(StringUtil.Random("LY"));
		User user=getUser();
		rece.setfReqDept(user.getDepartName());
		rece.setfReqDeptID(user.getDpID());
		rece.setfReqUser(user.getName());
		rece.setfReqUserid(user.getId());
		rece.setfReceDeptID(user.getDpID());
		rece.setfReceDept(user.getDepartName());
		rece.setfReceUser(user.getName());
		rece.setfSumAmount(0.00);
		rece.setfReceUserid(user.getId());
		rece.setfAssType("ZCLX-01");
		model.addAttribute("bean", rece);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"DZYHPLY", user.getDpID(),null,rece.getfNextCode(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/assets/rece/rece_base_add";
	}
	
	/**
	 * ??????????????????
	 * @param rece	???????????????
	 * @param planJson ????????????
	 * @param user
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-07
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(String stauts,String receFlies,Rece rece,String planJson,User user,ModelMap model){
		try {
			List<ReceList> receList=JSONArray.toList(JSONArray.fromObject(planJson), ReceList.class);
			receMng.save(rece,receFlies ,receList, getUser());
			return getJsonResult(true,"????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
		
	}
	
	/**
	 * ?????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model,String ledger,String tarlCode){
		Rece bean = receMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//??????????????????
		List<Attachment> handleAttaList = attachmentMng.list(bean);
		model.addAttribute("ReceFilesList", handleAttaList);
		model.addAttribute("openType", "detail");
		model.addAttribute("detailType", "detail");
		//??????????????????
		model.addAttribute("checkinfo", "1");
		String str=null;
		if("ZCLX-01".equals(bean.getfAssType())){
			str="DZYHPLY";
		}else if("ZCLX-02".equals(bean.getfAssType())){
			str="GDZCLY";
		}
		//???????????????id????????????
		String departName=departMng.findDeptByUserId(bean.getfReqUserid())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),str, departName,bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getfAssReceCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getfReceDept(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(str,departName);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		return "/WEB-INF/view/assets/rece/rece_base_detail";
	}
	/**
	 * ?????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/detail1/{id}")
	public String detail1(@PathVariable String id,ModelMap model,String ledger,String tarlCode){
		Rece bean = new Rece();
		if("0".equals(id)){
			bean = receMng.finFId(tarlCode);
			id = bean.getfId_R().toString();
		}
		if("detailLedger".equals(ledger)){
			bean = receMng.findbyCondition("fAssReceCode",id);
			model.addAttribute("detailType", "ledger");
		}else {
			bean = receMng.findById(Integer.valueOf(id));
			model.addAttribute("detailType", "detail");
		}
		//??????????????????
		List<Attachment> handleAttaList = attachmentMng.list(bean);
		model.addAttribute("ReceFilesList", handleAttaList);
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "detail");
		//??????????????????
		model.addAttribute("checkinfo", "1");
		//???????????????id????????????
		String departName=departMng.findDeptByUserId(bean.getfReqUserid())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZCLY", departName,bean.getBeanCode(),bean.getfNextCode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getfAssReceCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getfReceDept(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZCLY",departName);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		if(bean.getfAssType().equals("ZCLX-01")){
			return "/WEB-INF/view/assets/rece/rece_low_add";
		}else{
			/*//????????????????????????
			model.addAttribute("splc", "1");*/
			return "/WEB-INF/view/assets/rece/rece_fixed_add1";
		}
	}
	
	/**
	 * ?????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		Rece bean = receMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//??????????????????
		List<Attachment> handleAttaList = attachmentMng.list(bean);
		model.addAttribute("ReceFilesList", handleAttaList);
		model.addAttribute("openType", "edit");
		model.addAttribute("detailType", "detail");
		//??????????????????
		model.addAttribute("checkinfo", "1");
		String str=null;
		if("ZCLX-01".equals(bean.getfAssType())){
			str="DZYHPLY";
		}else if("ZCLX-02".equals(bean.getfAssType())){
			str="GDZCLY";
		}
		//???????????????id????????????
		String departName=departMng.findDeptByUserId(bean.getfReqUserid())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),str, departName,bean.getBeanCode(),bean.getfNextCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getfAssReceCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getfReceDept(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(str,departName);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		return "/WEB-INF/view/assets/rece/rece_base_add";
		
	}
	
	/**
	 * ??????????????????
	 * @param fAssReceCode ??????????????????????????????
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/lowJsonPagination")
	@ResponseBody
	public JsonPagination lowJsonPagination(String fAssReceCode,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=receListMng.findByfAssReceCode(fAssReceCode,page,rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ???????????????id????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			receMng.delete(id, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/**
	 * ????????????????????????
	 * @param selected
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-07
	 */
	@RequestMapping("/lookupsJsonAssName")
	@ResponseBody
	public List<AssetBasicInfo> assName(String selected,String type){
		List<AssetBasicInfo> list=assetBasicInfoMng.allAssName(type);
		return list;
	}
	
	/**
	 * ????????????????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/approvalList")
	public String approvallowList(String fAssType,ModelMap model){
		if(fAssType.equals("ZCLX-01")){
			model.addAttribute("fAssType", "ZCLX-01");
		}else if(fAssType.equals("ZCLX-02")){
			model.addAttribute("fAssType", "ZCLX-02");
		}
		return "/WEB-INF/view/assets/rece/approval/rece_base_approval_list";
	}
	
	/**
	 * ?????????????????????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/approvalfixedList")
	public String approvalfixedList(ModelMap model){
		return "/WEB-INF/view/assets/rece/approval/rece_fixed_approval_list";
	}
	
	/**
	 * ?????????????????????????????????????????????
	 * @param rece
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/approvalLow")
	@ResponseBody
	public JsonPagination approvalLow(Rece rece,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = receMng.approvalList(rece, getUser(), page, rows);
		List<Rece> li=(List<Rece>) p.getList();
		for (int i = 0; i < li.size(); i++) {
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
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/approvaldetail/{id}")
	public String approvaldetail(@PathVariable String id,ModelMap model){
		Rece bean = receMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "detail");
		//??????????????????
		model.addAttribute("checkinfo", "1");
		//???????????????id????????????
		String departName=departMng.findDeptByUserId(bean.getfReqUserid())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZCLY", departName,bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(),  bean.getfAssReceCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getfReceDept(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZCLY",departName);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		if(bean.getfAssType().equals("ZCLX-01")){
			return "/WEB-INF/view/assets/rece/approval/rece_low_approval_edit";
		}else if(bean.getfAssType().equals("ZCLX-02")){
			return "/WEB-INF/view/assets/rece/approval/rece_fixed_approval_edit";
		}
		return null;
	}
	
	/**
	 * ?????????????????????list??????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-08
	 */
	@RequestMapping("/fixedlist")
	public String fixedlist(ModelMap model){
		return "/WEB-INF/view/assets/rece/rece_fixed_list";
	}
	/**
	 * ???????????????????????????list??????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-05-03
	 */
	@RequestMapping("/fixedlist1")
	public String fixedlist1(ModelMap model){
		return "/WEB-INF/view/assets/rece/rece_fixed_list1";
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-09
	 */
	@RequestMapping("/addFixed")
	public String addFixed(ModelMap model){
		User user=getUser();
		Rece rece=new Rece();
		rece.setfAssReceCode(StringUtil.Random("LY"));
		rece.setfReqDept(user.getDepartName());
		rece.setfReqDeptID(user.getDpID());
		rece.setfReqUser(user.getName());
		rece.setfReqUserid(user.getId());
		rece.setfReceDeptID(user.getDpID());
		rece.setfReceDept(user.getDepartName());
		rece.setfReceUser(user.getName());
		rece.setfReceUserid(user.getId());
		rece.setfSumAmount(0.00);
		rece.setfAssType("ZCLX-02");
		model.addAttribute("bean", rece);
		model.addAttribute("openType", "add");
		model.addAttribute("detailType", "detail");
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"GDZCLY", user.getDepart().getId(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepartName(),null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/assets/rece/rece_base_add";
	}
	
	/**
	 * ??????????????????
	 * @param id
	 * @param rece
	 * @param assetCheckInfo
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-09
	 */
	@RequestMapping("/approvalRece/{id}")
	public String approvalRece(@PathVariable String id,ModelMap model){
		Rece bean = receMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		model.addAttribute("openType", "app");
		//??????????????????
		List<Attachment> storageAttaList = attachmentMng.list(bean);
		model.addAttribute("ReceFilesList", storageAttaList);		
		String str=null;
		if("ZCLX-01".equals(bean.getfAssType())){
			str="DZYHPLY";
		}else if("ZCLX-02".equals(bean.getfAssType())){
			str="GDZCLY";
		}
		//??????????????????
		model.addAttribute("checkinfo", "1");
		//???????????????id????????????
		String departName=departMng.findDeptByUserId(bean.getfReqUserid())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),str, departName,bean.getBeanCode(),bean.getfNextCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getfAssReceCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(bean.getfReqUser(), bean.getfReceDept(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(str,departName);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		return "/WEB-INF/view/assets/rece/approval/rece_base_approval_add";
	}
	
	/**
	 * ????????????????????? 
	 * @param stauts
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-10
	 */
	@RequestMapping("/approvel/{stauts}")
	@ResponseBody
	public Result approvel(@PathVariable String stauts,Rece rece,TProcessCheck checkBean,String spjlFile,ModelMap model){
		try {
			receMng.updateStauts(getUser(), rece, checkBean, spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * ?????????????????????????????????list????????????
	 * @param rece ????????????
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-14
	 */
	@RequestMapping("/allocaList")
	@ResponseBody
	public JsonPagination allcoaList(Rece rece,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = receMng.allocalist(rece, getUser(), page, rows);
		List<Rece> li=(List<Rece>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ??????????????????????????????
	 * @return
	 * @author ?????????
	 * @createtime 2018-08-14
	 */
	@RequestMapping("/receCodeList")
	public String receCodeList(ModelMap model){
		return "/WEB-INF/view/assets/rece/rece_add_nameAndDept";
	}
	
	
}
