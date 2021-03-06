package com.braker.icontrol.cgmanage.cgapply.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.manager.EvalSupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierEvaluaInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.purchase.apply.manager.PurchaseItemsMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.icontrol.purchase.apply.model.PurchaseItemsDetail;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.entity.TProcessPrintDetail;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;
/**
 * ??????????????????????????????
 * ?????????????????????????????????????????????
 * @author ?????????
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
@Controller
@RequestMapping(value = "/cgsqsp")
public class CgApplyController extends BaseController{
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private CgBidMng cgbidMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private CgReceiveMng cgreceiveMng;

	@Autowired
	private CgCheckMng cgcheckMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private EvalSupplierMng evalSupplierMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private CgProcessMng processMng;
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private TProExpendDetailMng detailMng;
	@Autowired
	private BudgetIndexMgrMng indexMng;
	@Autowired
	private PurchaseItemsMng purchaseItemsMng;
	@Autowired
	private CgReceiveMng reciveMng;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private ReimbPayeeMng reimbPayeeMng;
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	@Autowired
	private ArchivingMng ArchivingMng;
	@Autowired
	private ArchivingMng archivingMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private FilingMng filingMng;
	/*
	 * 
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model, String proId, String sign) {
		if(!StringUtil.isEmpty(proId)){
			if("0".equals(sign)){
				TBudgetIndexMgr bim = budgetIndexMgrMng.findByIndexCode(proId);
				model.addAttribute("indexCode", bim.getIndexCode());
				model.addAttribute("proId", proId);
				return "/WEB-INF/view/purchase_manage/purchase/cgsq_indexcode_list_zxk";
			}else{
				TProBasicInfo tpbi=tProBasicInfoMng.findById(Integer.valueOf(proId));
				TBudgetIndexMgr bim = budgetIndexMgrMng.findByIndexCode(tpbi.getFProCode());
				model.addAttribute("indexCode", bim.getbId());
				return "/WEB-INF/view/purchase_manage/purchase/cgsq_indexcode_list";
			}
			
		}else{
			return "/WEB-INF/view/purchase_manage/purchase/cgsq_list";
		}
	}
	
	/*
	 * ????????????????????????????????????list??????
	 * @author ?????????
	 * @createtime 2018-10-17
	 * @updatetime 2018-10-17
	 */
	@RequestMapping(value = "/checkedlist")
	public String checkedlist( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/purchase/conf_plan_checked_list";
	}
	
	/*
	 * ???????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/purchase/cg_checkIndex";
		//return "/WEB-INF/view/";
	}
	
	/*
	 * ?????????????????????????????????
	 * @author ??????
	 * @createtime 2020-12-10
	 * @updatetime 2020-12-10
	 */
	@RequestMapping(value = "/chooseItems")
	public String chooseItems(ModelMap model,String item) {
		model.addAttribute("item", item);
		return "/WEB-INF/view/purchase_manage/purchase/choose_Items";
	}
	
	/*
	 * 
	 * ?????????????????????????????????
	 * @author ??????
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@RequestMapping(value = "/reimbList")
	public String reimbList(ModelMap model) {
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_list";
	}
	
	/*
	 * ??????????????????
	 * @author ??????
	 * @createtime 2020-12-11
	 * @updatetime 2020-12-11
	 */
	@RequestMapping(value = "/jsonPaginationItems")
	@ResponseBody
	public JsonPagination jsonPaginationItems(PurchaseItemsDetail purchaseItemsDetail,Integer page, Integer rows,String item){
		try {
			if(page == null){page = 1;}
	    	if(rows == null){rows = 1000;}
	    	Pagination p = purchaseItemsMng.ItemsPageList(purchaseItemsDetail,page, rows, item, getUser());
	    	List<PurchaseItemsDetail> li = (List<PurchaseItemsDetail>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
				
	    		//????????????	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	/*
	 * ??????????????????????????????
	 * @author ??????
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@RequestMapping(value = "/reimbJsonPagination")
	@ResponseBody
	public JsonPagination reimbJsonPagination( Integer page, Integer rows,PurchaseApplyBasic bean){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			User user = getUser();
	    	Pagination p = cgsqMng.reimbPageList(page, rows,bean,user );
	    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
				if(li.get(x).getrId()!=null){
					ReimbAppliBasicInfo reimb =reimbAppliMng.findById(li.get(x).getrId());
					li.get(x).setReimbStatus(reimb.getCheckStauts());
					li.get(x).setPayAmount(reimb.getAmount());
				}
	    		//????????????	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * ????????????????????????????????????
	 * @author ??????
	 * @createtime 2020-12-17
	 * @updatetime 2020-12-17
	 */
	@RequestMapping(value = "/reimbCheckJsonPagination")
	@ResponseBody
	public JsonPagination reimbCheckJsonPagination( Integer page, Integer rows,PurchaseApplyBasic bean){
		try {
			if(page == null){page = 1;}
			if(rows == null){rows = SimplePage.DEF_COUNT;}
			User user = getUser();
	    	Pagination p = cgsqMng.reimbCheckPageList(page, rows,bean,user );
	    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
				if(li.get(x).getrId()!=null){
					ReimbAppliBasicInfo reimb =reimbAppliMng.findById(li.get(x).getrId());
					li.get(x).setReimbStatus(reimb.getCheckStauts());
					li.get(x).setPayAmount(reimb.getAmount());
				}
	    		//????????????	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@RequestMapping(value = "/cgsqPage")
	@ResponseBody
	public JsonPagination loanPage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows,String timea,String timeb,String amounta,String amountb){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgsqMng.pageList(bean, page, rows, getUser(), timea, timeb, amounta, amountb);
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//????????????id
    		try {
    			List<ContractBasicInfo> contractList=formulationMng.findByProperty("fPurchNo", li.get(x).getBeanId().toString());
    			if(contractList!=null && contractList.size()>0){
    				ContractBasicInfo contract=contractList.get(0);
            		li.get(x).setContractId(contract.getBeanId());
    			}
    			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
    		//????????????	
    		li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/**
	 * ??????????????????????????????
	 */
	@RequestMapping(value = "/cgsqPageChoose")
	@ResponseBody
	public JsonPagination cgsqPageChoose(PurchaseApplyBasic bean, Integer page, Integer rows, String timea, String timeb, String amounta, String amountb){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgsqMng.pageList(bean, page, rows, getUser(), timea, timeb, amounta, amountb);
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	//????????????
    	BigDecimal bidAmount = null;
    	for(int x=0; x<li.size(); x++) {
    		if("1".equals(li.get(x).getFbidStauts())){
    			BiddingRegist biddingRegist = processMng.getBiddingRegistByPId(li.get(x).getFpId());
        		//????????????????????????
        		if(biddingRegist==null){
        			bidAmount = BigDecimal.ZERO;
        		}else{
        			bidAmount = biddingRegist.getFbidAmount();
        		}
        		if(!StringUtil.isEmpty(String.valueOf(bidAmount))){
        			li.get(x).setFbidAmount(bidAmount);
        		}else{
        			li.get(x).setFbidAmount(null);
        		}
    		}else{
    			li.get(x).setFbidAmount(li.get(x).getFpAmount());
    		}
    		//????????????	
    		li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	
	
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//????????????id?????????
			cgsqMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");	
	}
	
	/**
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2019-10-08
	 * @updatetime 2019-10-08
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
			/*Boolean tof = tProcessCheckMng.findbyCode(bean.getFplCode(), "0");
			if(tof){
				return getJsonResult(false,"??????????????????????????????????????????");
			}else {*/
				cgsqMng.reCall(id);
				return getJsonResult(true, "????????????");
			/*}*/
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	/*
	 * ??????????????????id??????????????????
	 * @author ?????????
	 * @createtime 2018-11-29
	 * @updatetime 2018-11-29
	 * /cgsqsp/getFpAmount?fpId=??????id
	 */
	@RequestMapping(value="getFpAmount")
	@ResponseBody
	String findFpAmountbyfpCode(String fpId){
		
		return cgsqMng.findFpAmountbyfpId(fpId);
		
	}
	
	/*
	 * ???????????? ??????
	 * @author ?????????
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		model.addAttribute("openType", "edit");
		//??????????????????
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//????????????????????????
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//??????????????????
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		String[] itemIds =bean.getfItemsDetailIds().split(",");
		String isZc ="0";
		for (String itemId : itemIds) {
			PurchaseItemsDetail detail =purchaseItemsMng.findById(Integer.valueOf(itemId));
			if(!StringUtil.isEmpty(detail.getfCode())){
				isZc="1";
			}
		}
		model.addAttribute("isZc", isZc);
		
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		List<TNodeData> nodeConfList= new ArrayList<TNodeData>();
		String type = null;
		if (pro.getFProAppliDepart().equals(bean.getfDeptName())) {
			type= "HWCGSQ";
		}else {
			type= "HWCGSQF";
		}
		//???????????????
			//????????????????????????????????????????????????????????????
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),type, bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			for (int i = 0; i < nodeConfList.size(); i++) {
				if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
					if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
							TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getIndexId());//??????????????????????????????????????????????????????id???????????????????????????????????????
							User user2 = userMng.getUserByRoleNameAndDepartName("???????????????", basicInfo.getFProAppliDepart());
							nodeConfList.get(i).setText(user2.getName()+"|?????????????????????");
							nodeConfList.get(i).setUserId(user2.getId());
							nodeConfList.get(i).setUser(user2);
					}
				}
			}
			model.addAttribute("nodeConf", nodeConfList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes(type,bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
				
		return "/WEB-INF/view/purchase_manage/purchase/cggl_add";
	}
	
	/*
	 * ???????????? ????????????
	 * @author ?????????
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,String openType,ModelMap model){
		//??????????????????
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//????????????????????????
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//??????????????????
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//???????????????
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		List<TNodeData> nodeConfList= new ArrayList<TNodeData>();
		String type = null;
		if (pro.getFProAppliDepart().equals(bean.getfDeptName())) {
			type= "HWCGSQ";
		}else {
			type= "HWCGSQF";
		}
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//????????????????????????????????????????????????????????????
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),type, bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			for (int i = 0; i < nodeConfList.size(); i++) {
				if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
					if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
							TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getIndexId());//??????????????????????????????????????????????????????id???????????????????????????????????????
							User user2 = userMng.getUserByRoleNameAndDepartName("???????????????", basicInfo.getFProAppliDepart());
							nodeConfList.get(i).setText(user2.getName()+"|?????????????????????");
							nodeConfList.get(i).setUserId(user2.getId());
							nodeConfList.get(i).setUser(user2);
					}
				}
			}
			model.addAttribute("nodeConf", nodeConfList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes(type,bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}else{
			if(1==pro.getFProOrBasic()){//?????????????????????????????????
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"GCCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//?????????????????????????????????
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		//????????????????????????????????????
		model.addAttribute("openType",openType);
		return "/WEB-INF/view/purchase_manage/purchase/cggl_detail";
	}
	
	/*
	 * ???????????? ??????
	 * @author ??????
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@RequestMapping(value = "/addReimb")
	public String addReimb(String id,ModelMap model){
		model.addAttribute("openType", "add");
		ReimbAppliBasicInfo bean = new ReimbAppliBasicInfo();
		bean.setrCode(StringUtil.Random(""));
		bean.setType("10");
		
		//??????????????????
		PurchaseApplyBasic purchase = cgsqMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = getUser();
		purchase.setfUserName(user.getName());
		bean.setPurchaseId(purchase.getFpId());
		bean.setgName(purchase.getFpName());
		//????????????????????????
		Integer detailId = purchase.getProDetailId();
		Integer indexId = purchase.getIndexId();
		bean.setIndexId(indexId);
		bean.setProDetailId(detailId);
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("purchase",purchase);
		model.addAttribute("bean",bean);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//??????????????????
		List<Attachment> attac =attachmentMng.list(purchase);
		model.addAttribute("attac", attac);

		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"CGBX", user.getDepart().getId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//???????????????id
		//??????????????????
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
				
		return "/WEB-INF/view/purchase_manage/purchase/cgReimb_add";
	}
	
	/*
	 * ???????????? ???????????????
	 * @author ??????
	 * @createtime 2020-12-16
	 * @updatetime 2020-12-16
	 */
	@RequestMapping(value = "/editReimb")
	public String addReimb(String id,ModelMap model,String editType){
		//??????????????????
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		PurchaseApplyBasic purchase = cgsqMng.findById(bean.getPurchaseId());
		//?????????????????????
		User user = userMng.findById(purchase.getfUser());
		purchase.setfUserName(user.getName());
		bean.setgName(purchase.getFpName());
		//????????????????????????
		Integer detailId = purchase.getProDetailId();
		Integer indexId = purchase.getIndexId();
		bean.setIndexId(indexId);
		bean.setProDetailId(detailId);
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("purchase",purchase);
		model.addAttribute("bean",bean);
		//?????????????????????
		ReimbPayeeInfo payee =reimbPayeeMng.getByRId(bean.getrId()).get(0);
		model.addAttribute("payee",payee);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//??????????????????
		List<Attachment> attac =attachmentMng.list(purchase);
		model.addAttribute("attac", attac);
		List<Attachment> attaList =attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"CGBX",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGBX", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",bean.getBeanCode());
		Integer x=0;
		//??????????????????
		List<CostDetailInfo> cost =reimbAppliMng.findByRId(bean.getrId());
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
		List<InvoiceCouponInfo> list = invoiceCouponMng.findByrID(bean.getrId(),"purchase");
		model.addAttribute("Invoicelist", list);//??????????????????
		if("1".equals(editType)){
			model.addAttribute("openType", "edit");
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_add";
		}else{
			model.addAttribute("openType", "detail");
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_detail";
		}		
	}
	
	/**
	 * ???????????? ?????????????????????
	 * @author ?????????
	 * @createtime 2019-05-24
	 * @updatetime 2019-05-24
	 */
	@RequestMapping("/refreshProcess")
	public String rerefreshProcess(PurchaseApplyBasic bean,String fpPype,String fpId,ModelMap model){
		if(fpPype.equals("A10")|| "A30".equals(fpPype)|| "A20".equals(fpPype)){
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HWCGSQ", getUser().getDpID(),null,bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//?????????????????????????????????
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(),null);
			model.addAttribute("proposer", proposer);
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}else{
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", getUser().getDpID(),null,bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFpCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//???????????????id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//?????????????????????????????????
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
			model.addAttribute("proposer", proposer);
			//??????????????????
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}
	}
	
	/**
	 * ???????????? ????????????
	 * @author ?????????	
	 * ???????????????
	 * @createtime 2018-07-12
	 * @updatetime 2019-05-24
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		model.addAttribute("openType", "add");
		User user = getUser();
		PurchaseApplyBasic bean = new PurchaseApplyBasic();
		//???????????????????????????????????????????????????
		bean.setfUserName(user.getName());
		bean.setfUser(user.getId());
		bean.setfDeptName(user.getDepartName());
		bean.setfDeptId(user.getDpID());
		bean.setfReqTime(new Date());
		
		//??????????????????
		String str="CG";
		bean.setFpCode(StringUtil.Random(str));	
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);

		model.addAttribute("bean", bean);
		model.addAttribute("isZc", "0");
		// ?????????????????????????????????
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
		model.addAttribute("proposer", proposer);
		//???????????????
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HWCGSQ", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//??????????????????
		String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",getUser().getDpID(),bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);
		return "/WEB-INF/view/purchase_manage/purchase/cggl_add";
	}
	
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(PurchaseApplyBasic bean, String cgqdfiles, String xqwjfiles, String lzbgfiles,String gclqdfiles, String mingxi, ModelMap model) {
		
		try {
			//??????
			//??????????????????????????????????????????
			Boolean b=budgetIndexMgrMng.checkAmounts(String.valueOf(bean.getProDetailId()), bean.getFpAmount());
			if(b){
				cgsqMng.save(bean, cgqdfiles, xqwjfiles, lzbgfiles,gclqdfiles, mingxi, getUser());
			}else {
				return getJsonResult(false,"?????????????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	/*
	 * ????????????AJAX
	 * @author ?????????
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	@RequestMapping(value = "/applyFile")
	@ResponseBody
	public boolean applyFile(String fileurl){
		try {
			fileurl = java.net.URLDecoder.decode(fileurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//???????????????
		String[] names = fileurl.split("\\\\");
		String name = names[names.length-1];
		//??????????????????
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		boolean flag = false;
		try {
			String path = "CG/CGSQ";
			String filename = name.trim();
			String input = fileurl.trim();
			flag=fu.upLoadFromProduction(url, port,username,password,path,filename,input);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(String id) {
		Pagination p = new Pagination();
		//????????????????????????
		PurchaseApplyBasic purchaseApplyBasic2 = cgsqMng.findById(Integer.valueOf(id));
		List<Object> mingxiList = reciveMng.mingxi(purchaseApplyBasic2,"1");
		for(int i=0;i<mingxiList.size();i++){
			ProcurementPlanList bean = (ProcurementPlanList)mingxiList.get(i);
			bean.setNum(i+1);
		}
		
		p.setList(mingxiList);
		p.setPageSize(mingxiList.size());
		p.setPageSize(100);
		p.setTotalCount(mingxiList.size());
		p.setPageNo(1);
		return getJsonPagination(p, 1);
	}
	
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value ="/ledgerdetail")
	public String ledgerdetail(String id,ModelMap model){
		//??????????????????
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//????????????????????????
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//????????????
				bean.setIndexName(index.getIndexName()+"??? "+detail.getSubName()+" ???");
				//????????????
				bean.setPfAmount(detail.getOutAmount());		
				//????????????
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//????????????
				bean.setPfDepartName(index.getDeptName());			
				//????????????
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//????????????
			bean.setIndexName(index.getIndexName()+"??? "+index.getIndexCode()+" ???");
			//????????????
			bean.setPfAmount(index.getPfAmount());		
			//????????????
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//????????????
			bean.setPfDepartName(index.getDeptName());			
			//????????????
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//??????????????????
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//??????????????????????????????
		List<BiddingRegist> brList=processMng.findByProperty("fpId", Integer.valueOf(id));
		if(brList.size()>0) {
			BiddingRegist br = brList.get(0);
			model.addAttribute("br", br);
			//??????????????????????????????
			List<Attachment> brAttac = attachmentMng.list(br);
			model.addAttribute("brAttac", brAttac);
			//?????????????????????????????????????????????
			List<WinningBidder> fwbean = cgselMng.findByWid(br.getFpId());
			model.addAttribute("fwbean", fwbean);
			model.addAttribute("bidStauts", 0);//????????????  0??????
		}else {
			model.addAttribute("br", null);
		}
		//????????????????????????
		List<Attachment> attac1 = attachmentMng.list(bean);
		model.addAttribute("attac", attac1);
		//??????????????????
		List<AcceptCheck> acptbeanList=reciveMng.findByProperty("fpId", Integer.valueOf(id));
		if(acptbeanList.size() > 0) {
			AcceptCheck acptbean = acptbeanList.get(0);
			model.addAttribute("acptbean", acptbean);
			//???????????????????????????
			List<Attachment> reciveattac=attachmentMng.list(acptbean);
			model.addAttribute("reciveattac", reciveattac);
			model.addAttribute("accStauts", 0);//????????????  0??????
			//???????????????id
			TProcessDefin tProcessDefinYS=tProcessDefinMng.getByBusiAndDpcode("HWCGYS", acptbean.getfDepartId());
			model.addAttribute("fpIdYS", tProcessDefinYS.getFPId());
			//????????????
			model.addAttribute("foCodeYS",acptbean.getBeanCode());
		}else {
			model.addAttribute("acptbean", null);
		}
			

		//???????????????
			//???????????????id
			TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//????????????
		model.addAttribute("foCodeCG",bean.getBeanCode());
		
		return "/WEB-INF/view/purchase_manage/purchase/cggl_detail_base_tz";
	}
	
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2021-06-15
	 * @updatetime 2021-06-15
	 */
	@RequestMapping("/detailHT")
	public String detail(String id,ModelMap model,String type){
		//????????????
		Integer cbiId = null;
		List<ContractBasicInfo> cbi = formulationMng.findbyPurchId(id);
		if(cbi.size() > 0) {
			cbiId = cbi.get(0).getFcId();
		}else {
			
		}
		
		
		
		ContractBasicInfo contractBasicInfo = formulationMng.findById(cbiId);
		
		model.addAttribute("findById", contractBasicInfo);
		
		//??????????????????
		List<Archiving> contOriginal = archivingMng.findByContId(String.valueOf(contractBasicInfo.getFcId()));
		if(contOriginal!=null&&contOriginal.size()>0){
			Archiving archivingOriginal = contOriginal.get(0);
			//????????????
			List<Attachment> attaListOriginal = attachmentMng.list(archivingOriginal);
			model.addAttribute("archivingAttaListOriginal", attaListOriginal);
			model.addAttribute("archivingOriginal", archivingOriginal);
		}
		
		Upt upt =new Upt();
		if("1".equals(contractBasicInfo.getfUpdateStatus())){
			upt =uptMng.findByFContId_U(Integer.toString(cbiId)).get(0);
			
			TProcessDefin tProcessDefinBG=tProcessDefinMng.getByBusiAndDpcode("HTBG", upt.getfDeptID());
			model.addAttribute("fpIdBG", tProcessDefinBG.getFPId());
			//????????????
			model.addAttribute("foCodeBG",upt.getBeanCode());
			
			model.addAttribute("uptShow", "0");
			//??????????????????
			List<Archiving> uptContId = archivingMng.findByContId(String.valueOf(upt.getfId_U()));
			if(uptContId!=null&&uptContId.size()>0){
				Archiving archivingUpt = uptContId.get(0);
				//????????????
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
		//??????????????????
		/*if(dispute!=null){
			List<Attachment> disputeAtta = attachmentMng.list(dispute);
			model.addAttribute("disputeAttaList", disputeAtta);
		}*/
		//??????????????????
		SignInfo sign=new SignInfo();
		List<SignInfo> signInfoList=filingMng.find_Sign(contractBasicInfo);
		if(signInfoList!=null&&signInfoList.size()>0){
			sign = signInfoList.get(0);
			model.addAttribute("findSign", sign);
		}
		//??????????????????????????????
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
		// ?????????????????????
		List<Attachment> attaList = attachmentMng.list(contractBasicInfo);
		model.addAttribute("formulationAttaList", attaList);
		//??????????????????
		List<Attachment> uptAttaList = attachmentMng.list(upt);
		model.addAttribute("changeAttaList", uptAttaList);
		//??????????????????
		if("1".equals(contractBasicInfo.getFgdStauts())){
			List<Archiving> findByContId = ArchivingMng.findByContId(Integer.toString(cbiId));
			if(findByContId.size()>0){
				Archiving archiving = findByContId.get(0);
				if(archiving.getFqdTime() == null){
					archiving.setFqdTime(new Date());
				}
				model.addAttribute("archiving", archiving);
				//????????????
				List<Attachment> attaListgd = attachmentMng.list(archiving);
				model.addAttribute("archivingAttaList", attaListgd);
			}
		}
		String departId=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId())[0];
		//???????????????
		/*List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(contractBasicInfo.getUserId(),"HTND", departId,contractBasicInfo.getBeanCode(),contractBasicInfo.getfNCode(), "T_CONTRACT_BASIC_INFO", "F_CONT_CODE", contractBasicInfo.getFcCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		String dept[]=departMng.findDeptByUserId(contractBasicInfo.getfOperatorId());
		Proposer proposer = new Proposer(contractBasicInfo.getfOperator(),dept[1], contractBasicInfo.getfReqtIME());
		model.addAttribute("proposer", proposer);*/
		//?????????????????????????????????id
		//???????????????id
		TProcessDefin tProcessDefinCON=tProcessDefinMng.getByBusiAndDpcode("HTND", departId);
		model.addAttribute("fpIdCON", tProcessDefinCON.getFPId());
		//????????????
		model.addAttribute("foCodeCON",contractBasicInfo.getBeanCode());
		return "/WEB-INF/view/contract/ledger/ledger_contract";
	}
	
	
	
	
	
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value ="/receiveledgedetail")
	public String receiveledgedetail(String id,ModelMap model){
	
		//????????????????????????				
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		Date reqTime = bean.getfReqTime();//??????????????????
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("dealTime", dealTime);
		//????????????????????????
		List<Attachment> pattac = attachmentMng.list(bean);
		model.addAttribute("pattac", pattac);
		if("1".equals(bean.getFbidStauts())){
			//??????????????????????????????
			BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
			model.addAttribute("br", br);
			//??????????????????????????????
			List<Attachment> brAttac = attachmentMng.list(br);
			model.addAttribute("brAttac", brAttac);
			//?????????????????????????????????????????????
			WinningBidder fwbean = cgselMng.findById(br.getFwId());
			model.addAttribute("fwbean", fwbean);
			model.addAttribute("bidStauts", 0);//????????????  0??????
		}else{
			model.addAttribute("bidStauts", "");//????????????  ????????????
		}
		/*//??????????????????????????????
		BiddingRegist br=processMng.findUniqueByProperty("fpId", Integer.valueOf(id));
		model.addAttribute("br", br);
		//??????????????????????????????
		List<Attachment> attac = attachmentMng.list(br);
		model.addAttribute("attac", attac);
		//?????????????????????????????????????????????
		WinningBidder fwbean = cgselMng.findById(br.getFwId());
		model.addAttribute("fwbean", fwbean);*/
		
		/*//??????????????????????????????????????????????????????
		model.addAttribute("receive_people", getUser().getName());*/

		
		//??????fpid??????????????????
		List<AcceptCheck> historyList=cgreceiveMng.checkHistory(Integer.valueOf(id));
		AcceptCheck historybean = new AcceptCheck();
		if(historyList !=null && historyList.size()>0){
			historybean=historyList.get(0);
			//???????????????????????????
			List<Attachment> hisattac =attachmentMng.list(historybean);
			model.addAttribute("hisattac", hisattac);
		}
		model.addAttribute("historybean", historybean);
		
		
		//???????????????pid??????????????????????????????????????????
		List<SupplierEvaluaInfo> evalList=evalSupplierMng.findEvalSupplierbyFpid(Integer.valueOf(id));
		SupplierEvaluaInfo evalbean =new SupplierEvaluaInfo();
		if(evalList !=null && evalList.size()>0){
			evalbean=evalList.get(0);
		}
		model.addAttribute("evalbean", evalbean);
		//????????????????????????
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/purchase_manage/receive/receive_ledger_detail";
	}
	/*
	 * ???????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@RequestMapping(value = "/cginquiriesPage")
	@ResponseBody
	public JsonPagination loanPage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgsqMng.qingdanpageList(bean, page, rows, getUser());;
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//????????????	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * ????????????
	 * 
	 * @author ?????????
	 * 
	 * @createtime 2018-11-15
	 * 
	 * @updatetime 2018-11-15
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
					FileUpLoadUtil.getPZJHSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}
	
	
	
	/**
	 * <p>Title: xnlzDownload</p>  
	 * <p>Description: ????????????????????????????????????</p>  
	 * @param response
	 * @return
	 * @author ?????????
	 * @createtime 2021???2???23???
	 * @updator ?????????
	 * @updatetime 2021???2???23???
	 */
	@RequestMapping("/xnlzDownload")
	@ResponseBody
	public Result xnlzDownload(HttpServletResponse response) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\??????????????????.xlsx";
			File file = new File(filePath);
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String("??????????????????.xlsx".getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "??????????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "???????????????");
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true, "???????????????");
	}
	
	/**
	 * <p>Title: xwlzDownload</p>  
	 * <p>Description: ????????????????????????</p>  
	 * @param response
	 * @return
	 * @author ?????????
	 * @createtime 2021???2???23???
	 * @updator ?????????
	 * @updatetime 2021???2???23???
	 */
	@RequestMapping("/xwlzDownload")
	@ResponseBody
	public Result xwlzDownload(HttpServletResponse response) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\??????????????????.xlsx";
			File file = new File(filePath);
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String("??????????????????.xlsx".getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "??????????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "???????????????");
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true, "???????????????");
	}
	
	
	@RequestMapping(value="/cgApplyExprint")
	public String cgApplyExprint(Integer id,ModelMap model){
		//??????????????????
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//?????????????????????
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		List<ProcurementPlanList> mingxiList = cgConPlanListMng.findbyIdAndTypes("fpId",String.valueOf(bean.getFpId()),"1");
		
		//???????????????
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		bean.setProDetailName(pro.getFProName());
		bean.setProCharger(pro.getFProHead());
		
		model.addAttribute("mingxiList", mingxiList);
		model.addAttribute("bean",bean);
		
		//????????????
		List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("PurchaseApplyBasic", "fpId", bean.getFpId());
		
		for (int i = 0; i < listTProcessChecks.size(); i++) {
			model.addAttribute("listTProcessChecks"+i, listTProcessChecks.get(i));
		}
		return "/WEB-INF/view/purchase_manage/exprint/cg_apply_exprint";
	}
	
	
	
}
