package com.braker.icontrol.assets.storage.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
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
import com.braker.common.ftp.FileUpload;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Lookups;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.manager.AssetsAttacMng;
import com.braker.icontrol.assets.storage.manager.RegistMng;
import com.braker.icontrol.assets.storage.manager.StorageMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetsAttac;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.PurcMaterialMng;
import com.braker.icontrol.cgmanage.cgcheck.model.PurcMaterialList;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.dispute.model.DisputAttac;
import com.braker.icontrol.contract.filing.model.Attac;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/Storage")
public class StorageController extends BaseController{

	@Autowired
	private StorageMng storageMng;
	@Autowired
	private RegistMng registMng;
	@Autowired
	private AssetsAttacMng assetsAttacMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private SupplierMng supplierMng;
	@Autowired
	private CgApplysqMng cgApplysqMng;
	@Autowired
	private PurcMaterialMng purcMaterialMng;
	@Autowired
	private CgConPlanMng cgConPlanMng;
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	@Autowired
	private CgBidMng cgBidMng;
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	
	
	/**
	 * ??????????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-06
	 */
	@RequestMapping("/lowlist")
	public String list_Low(ModelMap model){
		return "/WEB-INF/view/assets/storage/storage_low_list";
	}
	
	/**
	 * ??????????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/cgd")
	public String cgd(String type,ModelMap model){
		if(type.equals("ZCLX-01")){
			model.addAttribute("zctype", "ZCLX-01");
		}else if(type.equals("ZCLX-02")){
			model.addAttribute("zctype", "ZCLX-02");
		}
		return "/WEB-INF/view/assets/storage/storage_add_cgd";
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-06
	 *//*
	@RequestMapping("/lowadd")
	public String lowAdd(String forgtype,String fpCode,ModelMap model){
		Storage s=new Storage();
		s.setfPurchaseDate(new Date());
		s.setfOperator(getUser().getAccountNo());
		s.setfAssType("ZCLX-01");
		Lookups lookup = lookupsMng.findByLookCode(forgtype);
		s.setfBuyType(lookup);
		model.addAttribute("bean", s);
		model.addAttribute("openType","add");
		model.addAttribute("detailType", "detail");
		//??????????????????
		model.addAttribute("fpCode", fpCode);
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/storage/storage_low_add";
	}*/
	
	/**
	 * ???????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-06
	 */
	@RequestMapping("/fixedlist")
	public String list_fixed(ModelMap model){
		
		return "/WEB-INF/view/assets/storage/storage_fixed_list";
	}
	
	/**
	 * ??????????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-06
	 */
	@RequestMapping("/intangiblelist")
	public String list_Intangible(ModelMap model){
		return "/WEB-INF/view/assets/storage/storage_intangible_list";
	}
	/**
	 * ???????????????????????????????????????
	 * @param storage
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-06
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(Storage storage,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = storageMng.list(storage, getUser(), page, rows);
		List<Storage> li= (List<Storage>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	
	@RequestMapping("/allJsonPagination")
	@ResponseBody
	public JsonPagination allJsonPagination(Regist regist,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = registMng.allRegist(regist,page,rows);
		
		List<Regist> li= (List<Regist>) p.getList();
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
	 * @createtime 2018-07-07
	 */
	@RequestMapping("/fixedadd")
	public String fixedadd(String forgtype,String fpCode,ModelMap model){
		model.addAttribute("openType","add");
		model.addAttribute("detailType", "detail");
		User user = getUser();
		Storage storage=new Storage();
		storage.setfAssStorageCode(StringUtil.Random("ZCRK"));
		storage.setfOperator(user.getName());
		storage.setfOperatorID(user.getId());
		storage.setfDeptName(user.getDepartName());
		storage.setfDeptID(user.getDpID());
		model.addAttribute("bean",storage);
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"GDZCZJ", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/assets/storage/storage_fixed_add";
	}
	
	/**
	 * ????????????????????????????????????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-24
	 *//*
	@RequestMapping("/intangibleadd")
	public String intangibleadd(ModelMap model){
		model.addAttribute("openType","add");
		model.addAttribute("detailType", "detail");
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/storage/storage_intangible_add";
	}*/
	
	/**
	 * ?????????????????????
	 * @param storage
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-07
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Result save(String planJson,Storage storage,String files,String storageFiles,ModelMap model){
		try {
			List<Regist> pj = JSONArray.toList(JSONArray.fromObject(planJson), Regist.class);
			//???????????????????????????????????????????????????????????????
			storageMng.save_fixed(pj,storage, getUser(), storageFiles);
			return getJsonResult(true, "???????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
	}
	
	/**
	 * ???????????????99???
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-07
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			storageMng.delete(id, getUser());
			return getJsonResult(true, "????????????????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "?????????????????????????????????");
		}
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-07
	 */
	@RequestMapping("/edit/{id}")
	public String fixededit(@PathVariable String id,ModelMap model){
		Storage storage=storageMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", storage);
		//model.addAttribute("attac", assetsAttacMng.findAttac(storage));
		model.addAttribute("openType","edit");
		model.addAttribute("detailType", "detail");
		//??????????????????
		List<Attachment> storageAttaList = attachmentMng.list(storage);
		model.addAttribute("StorageAttaList", storageAttaList);
		
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(storage.getfOperatorID())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(storage.getUserId(),"GDZCZJ", departId,storage.getBeanCode(),storage.getfNextCode(), storage.getJoinTable(), storage.getBeanCodeField(), storage.getfAssStorageCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(storage.getfOperator(), storage.getfDeptName(), storage.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCZJ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",storage.getBeanCode());
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????
		model.addAttribute("checkinfo", "1");
		return "/WEB-INF/view/assets/storage/storage_fixed_add";
	}
	
	/**
	 * ????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-09
	 */
	@RequestMapping("/lowedit/{fId_S}")
	public String lowEdit(@PathVariable String fId_S,ModelMap model){
		Storage storage=storageMng.findById(Integer.valueOf(fId_S));
		model.addAttribute("bean", storage);
		//model.addAttribute("attac", assetsAttacMng.findAttac(storage));
		model.addAttribute("openType","edit");
		model.addAttribute("detailType", "detail");
		//?????????????????????
		List<Attachment> storageAttaList = attachmentMng.list(storage);
		model.addAttribute("StorageAttaList", storageAttaList);
		return "/WEB-INF/view/assets/storage/storage_low_add";
	}
	
	/**
	 * ????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/intangibleedit/{id}")
	public String intangibleedit(@PathVariable String id,ModelMap model){
		Storage storage=storageMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", storage);
		//model.addAttribute("attac", assetsAttacMng.findAttac(storage));
		model.addAttribute("openType","edit");
		model.addAttribute("detailType", "detail");
		//??????????????????
		List<Attachment> storageAttaList = attachmentMng.list(storage);
		model.addAttribute("StorageAttaList", storageAttaList);
		return "/WEB-INF/view/assets/storage/storage_intangible_add";
	}
	
	/**
	 * ??????????????????????????????????????????
	 * @param fAssStorageCode
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-10
	 */
	@RequestMapping("/lowJsonPagination")
	@ResponseBody
	public JsonPagination lowJsonPagination(String fAssStorageCode,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = registMng.findById(fAssStorageCode, page, rows);
		return getJsonPagination(p , page);
	}
	
	/**
	 * ???????????????????????????????????????
	 * @param id
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2018-07-07
	 */
	@RequestMapping("/approvel/{id}")
	public String approvel(@PathVariable String id,ModelMap model){
		Storage storage=storageMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", storage);
		//model.addAttribute("attac", assetsAttacMng.findAttac(storage));
		model.addAttribute("openType","edit");
		model.addAttribute("detailType", "detail");
		//??????????????????
		List<Attachment> storageAttaList = attachmentMng.list(storage);
		model.addAttribute("StorageAttaList", storageAttaList);
		
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(storage.getfOperatorID())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(storage.getUserId(),"GDZCZJ", departId,storage.getBeanCode(),storage.getfNextCode(), storage.getJoinTable(),  storage.getBeanCodeField(), storage.getfAssStorageCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(storage.getfOperator(), storage.getfDeptName(), storage.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCZJ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",storage.getBeanCode());
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????
		model.addAttribute("checkinfo", "1");
		return "/WEB-INF/view/assets/storage/approval/storage_fixed_approval";
	}
	
	/**
	 * ????????????????????????????????????list??????
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-30
	 */
	@RequestMapping("/approvalList")
	public String approvalList(ModelMap model){
		return "/WEB-INF/view/assets/storage/approval/storage_fixed_approval_list";
	}
	
	/**
	 * ?????????????????????????????????list????????????
	 * @param storage ????????????
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author ?????????
	 * @createtime 2019-05-30
	 */
	@ResponseBody
	@RequestMapping("/approvalJson")
	public JsonPagination approvalJson(Storage storage,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = storageMng.approvalList(storage, getUser(), page, rows);
		List<Storage> li= (List<Storage>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * ??????????????????
	 * @param stauts ????????????
	 * @param id storage??????
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approvalStorage/{stauts}")
	public Result approvalStorage(@PathVariable String stauts,String fId_S,String spjlFile,TProcessCheck checkBean,String planJson,ModelMap model){
		try {
			storageMng.updateStatus(stauts, fId_S, spjlFile, checkBean, planJson, getUser());
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	
	/**
	 * ????????????????????????
	 * @param selected
	 * @return
	 */
	@RequestMapping("/lookupsJsonAssName")
	@ResponseBody
	public List<AssetBasicInfo> assName(String selected){
		List<AssetBasicInfo> list=assetBasicInfoMng.allAssName(null);
		AssetBasicInfo abi=new AssetBasicInfo();
		abi.setfAssName("??????");
		list.add(abi);
		return list;
	}
	
	/**
	 * ???????????????????????????
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = assetBasicInfoMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
	/**
	 * ???????????????
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model,String ledger){
		Storage storage=new Storage();
		if("detailLedger".equals(ledger)){
			storage=storageMng.findbyCondition("fAssStorageCode",id);
			model.addAttribute("detailType", "ledger");
		}else{
			storage=storageMng.findById(Integer.valueOf(id));
			model.addAttribute("detailType", "detail");
		}
		model.addAttribute("bean", storage);
		//model.addAttribute("attac", assetsAttacMng.findAttac(storage));
		//??????????????????
		List<Attachment> storageAttaList = attachmentMng.list(storage);
		model.addAttribute("StorageAttaList", storageAttaList);
		model.addAttribute("openType", "SFdetail");
		//?????????????????????????????????id
		String departId=departMng.findDeptByUserId(storage.getfOperatorID())[0];
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(storage.getUserId(),"GDZCZJ", departId,storage.getBeanCode(),storage.getfNextCode(), storage.getJoinTable(), storage.getBeanCodeField(), storage.getfAssStorageCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(storage.getfOperator(), storage.getfDeptName(), storage.getfReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCZJ", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",storage.getBeanCode());
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//????????????
		model.addAttribute("checkinfo", "1");
		return "/WEB-INF/view/assets/storage/storage_fixed_detail";
	}
	
	/**
	 * ???????????????????????????
	 * @param model
	 * @return
	 */
	@RequestMapping("/fwCode")
	public String fwCode(ModelMap model){
		return "/WEB-INF/view/assets/storage/storage_fixed_add_fwCode";
	}
	
	/**
	 * ???????????????
	 * @param bean
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/codeJsonPagination")
	@ResponseBody
	public JsonPagination codeJsonPagination(WinningBidder bean,String amounta,String amountb,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = supplierMng.whitepageList(bean,amounta, amountb,page, rows);
		return getJsonPagination(p , page);
	}
	
	/**
	 * ???????????????
	 * @param bean
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/cgdJsonPagination")
	@ResponseBody
	public JsonPagination cgdJsonPagination(PurchaseApplyBasic bean,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = cgApplysqMng.receiveledgerPageList(bean,null,null, page, rows, getUser());
		return getJsonPagination(p , page);
	}
	
	/**
	 * ??????????????????
	 * @param bean
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 */
	@RequestMapping("/cgpmJsonPagination")
	@ResponseBody
	public JsonPagination cgpmJsonPagination(String fAssType,String fpCode,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
		if(rows==null){rows=100;}
		Pagination p=new Pagination();
		p.setPageNo(page);
		p.setPageSize(rows);
		PurchaseApplyBasic pab = cgApplysqMng.findbyfpCode(fpCode);
		ProcurementPlan cp = cgConPlanMng.findById(pab.getFplId());
		List<ProcurementPlanList> pm = cgConPlanListMng.findby("fplId",String.valueOf(cp.getFplId()));
		List<Regist> r=new ArrayList<Regist>();
		if(fAssType.equals("ZCLX-02")){
			for (int i = 0; i < pm.size(); i++) {
			Regist regist=new Regist();
			regist.setfAssNameR(pm.get(i).getFpurName());
			regist.setfMeasUnitR(pm.get(i).getFmeasureUnit());
			regist.setFmSpecif(pm.get(i).getFpurBrand()+"  "+pm.get(i).getFspec());
			regist.setfInsNumR("1");
			regist.setfAmount(Double.valueOf(pm.get(i).getFsumMoney()));
			regist.setfSignPrice(Double.valueOf(pm.get(i).getFunitPrice()));
			for (int j = 0; j < Integer.valueOf(pm.get(i).getFnum()); j++) {
				r.add(regist);
			}
		}
		}else if(fAssType.equals("ZCLX-01")){
			for (int i = 0; i < pm.size(); i++) {
				Regist regist=new Regist();
				List<AssetBasicInfo> ab = assetBasicInfoMng.findby2Condition("fAssName", pm.get(i).getFpurName(), "fSPModel", (pm.get(i).getFpurBrand()+"  "+pm.get(i).getFspec()));
				if(ab.size()>0){
					regist.setfAssCodeR(ab.get(0).getfAssCode());
				}else {
					regist.setfAssCodeR(String.valueOf(StringUtil.random8()));
				}
				regist.setfAssNameR(pm.get(i).getFpurName());
				regist.setfMeasUnitR(pm.get(i).getFmeasureUnit());
				regist.setFmSpecif(pm.get(i).getFpurBrand()+"  "+pm.get(i).getFspec());
				regist.setfInsNumR(String.valueOf(pm.get(i).getFnum()));
				regist.setfAmount(Double.valueOf(pm.get(i).getFsumMoney()));
				regist.setfSignPrice(Double.valueOf(pm.get(i).getFunitPrice()));
				r.add(regist);
			}
		}
		p.setList(r);
		p.setTotalCount(r.size());
		return getJsonPagination(p , page);
	}
	
	/*
	 * ????????????
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
			// ????????????????????????
			String ids = attachmentMng.uploadAjax(attFiles, serviceType,
					FileUpLoadUtil.getZCAGKSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}
	
	/*
	 * ????????????????????????
	 * @author 
	 * @createtime 2019-09-23
	 * @updatetime 2019-09-23
	 */
	@RequestMapping(value = "/imput")
	public String imput(ModelMap model) {
		return "/WEB-INF/view/assets/storage/storage_imput";
	}
	
	/*
	 * ???????????????????????????
	 * @author 
	 * @createtime 2019-09-23
	 * @updatetime 2019-09-23
	 */
	@RequestMapping(value = "/collect")
	@ResponseBody
	public Result collect(MultipartFile xlsx) {
		InputStream ins =null;
		OutputStream os =null;
		try {
			File f = null;
			if(xlsx.equals("")||xlsx.getSize()<=0){
				xlsx = null;
			}else{
				ins = xlsx.getInputStream();
			    f=new File(xlsx.getOriginalFilename());
			    os = new FileOutputStream(f);
				int bytesRead = 0;
				byte[] buffer = new byte[8192];
				while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
					os.write(buffer, 0, bytesRead);
				}
				File file = new File(f.toURI());
				storageMng.saveFile(file, getUser());
			}
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}finally{
			if(os!=null){
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ins!=null){
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
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
			Storage bean = storageMng.findById(Integer.valueOf(id));
			Boolean tof = tProcessCheckMng.findbyCode(bean.getfAssStorageCode(), "0");
			if(tof){
				return getJsonResult(false,"??????????????????????????????????????????");
			}else {
				storageMng.reCall(id);
				return getJsonResult(true,"???????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"?????????????????????????????????");
		}
	}
	 
}
