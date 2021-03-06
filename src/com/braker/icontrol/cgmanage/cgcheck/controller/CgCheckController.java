package com.braker.icontrol.cgmanage.cgcheck.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgapply.manager.PurchaseUpdateMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.icontrol.purchase.apply.manager.PurchaseItemsMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.icontrol.purchase.apply.model.PurchaseItemsDetail;
import com.braker.icontrol.purchase.apply.model.PurchaseUpdateInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
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
@RequestMapping(value = "/cgcheck")
public class CgCheckController extends BaseController{
	
	@Autowired
	private CgCheckMng cgcheckMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng itfMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TProExpendDetailMng detailMng;
	
	@Autowired
	private BudgetIndexMgrMng indexMng;
	
	@Autowired
	private PurchaseItemsMng purchaseItemsMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	@Autowired
	private PurchaseUpdateMng purchaseUpdateMng;
	
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/check/purchase_check_list";
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@RequestMapping(value = "/cgcheckPage")
	@ResponseBody
	public JsonPagination loanPage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows,String timea,String timeb,String amounta,String amountb){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgcheckMng.pageList(bean, page, rows, getUser(), timea, timeb, amounta, amountb);
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//????????????	
			li.get(x).setNumber(x+1);	
		}
    	return getJsonPagination(p, page);
	}	
	

	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07???16
	 * @updatetime 2018-07???16
	 */
	@RequestMapping(value = "/check")
	public String check(String id ,ModelMap model) {
		//????????????id????????? fpid
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
		if(getUser().getRoleName().contains("???????????????")) {
			model.addAttribute("CGGS", "CGGS");	
		}
		model.addAttribute("bean", bean);		
		//??????????????????
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		//???????????????????????????????????????????????????????????????????????????????????????????????????????????????
		String roleName=getUser().getRoleName();
		String deptId =getUser().getDpID();
		if(roleName.contains("???????????????")&&((deptId.equals("14")&&(bean.getfItems().equals("A10") || "A30".equals(bean.getfItems()) || "A20".equals(bean.getfItems())))
				||(deptId.equals("35"))&&"A40".equals(bean.getfItems()))){
			String[] itemIds =bean.getfItemsDetailIds().split(",");
			String isZc =null;
			for (String itemId : itemIds) {
				PurchaseItemsDetail detail =purchaseItemsMng.findById(Integer.valueOf(itemId));
				if(!StringUtil.isEmpty(detail.getfCode())){
					isZc="zc";
				}
			}
			model.addAttribute("isZc", isZc);
			model.addAttribute("setfpMethod", roleName);
		}
		
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
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),type, bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			for (int i = 0; i < nodeConfList.size(); i++) {
				if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
					if(StringUtils.isEmpty(nodeConfList.get(i).getText())){
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
		if(getUser().getRoleName().contains("????????????????????????????????????")){
			if (bean.getFpAmount().compareTo(BigDecimal.valueOf(50000))>-1) {
				model.addAttribute("xzbgsFile", "xzbgsFile");
			}
		}
		if(getUser().getRoleName().contains("??????????????????????????????")){
			if (bean.getFpAmount().compareTo(BigDecimal.valueOf(100000))>-1) {
				model.addAttribute("dwhFile", "dwhFile");
			}
		}
		return "/WEB-INF/view/purchase_manage/check/check_cgapply";
	}

	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@RequestMapping(value = "/history")
	@ResponseBody
	public JsonPagination checkHistory(String id) {
		Pagination p = new Pagination();
		if(id != null) {
			p.setList(cgcheckMng.checkHistory(Integer.valueOf(id),null));
		}
		return getJsonPagination(p, 0);
	}
	
	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,PurchaseApplyBasic bean,String spjlFile,String xzbgsfiles,String dwhfiles) {
		try {
			PurchaseApplyBasic oldbean = cgcheckMng.findById(bean.getFpId());
			oldbean.setMeetingSummaryTime1(bean.getMeetingSummaryTime1());
			oldbean.setMeetingSummaryTime2(bean.getMeetingSummaryTime2());
			oldbean.setMeetingSummaryYear1(bean.getMeetingSummaryYear1());
			oldbean.setMeetingSummaryYear2(bean.getMeetingSummaryYear2());
			
			if(!oldbean.getFpMethod().equals(bean.getFpMethod()) || !oldbean.getOrgType().equals(bean.getOrgType())) {
				PurchaseUpdateInfo update = new PurchaseUpdateInfo();
				update.setFpId(bean.getFpId());
				update.setProjectName(oldbean.getFpName());
				update.setfUpdateDate(new Date());
				update.setUpdateUserId(getUser().getId());
				update.setUpdateUserName(getUser().getName());
				update.setMethod(oldbean.getFpMethod());
				update.setOrgType(oldbean.getOrgType());
				if(!StringUtil.isEmpty(bean.getFpMethod())) {
					update.setUpdateMethod(bean.getFpMethod());
				}else {
					update.setUpdateMethod(oldbean.getFpMethod());
				}
				if(!StringUtil.isEmpty(bean.getOrgType())) {
					update.setUpdateOrgType(bean.getOrgType());
				}else {
					update.setUpdateOrgType(oldbean.getOrgType());
				}
				purchaseUpdateMng.saveOrUpdate(update);
			}
			//attachmentMng.joinEntity(oldbean,xzbgsfiles);
			//attachmentMng.joinEntity(oldbean,dwhfiles);
			//List<Role> roleli = userMng.getUserRole(getUser().getId());
			cgcheckMng.saveCheckInfo(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "???????????????");
	}
	
	/*
	 * ?????????????????????????????????
	 * @author ?????????
	 * @createtime 2021-06???07
	 * @updatetime 2021-06???07
	 */
	@RequestMapping(value = "/UpdateDetail")
	public String UpdateDetail(String id ,ModelMap model) {
		PurchaseApplyBasic bean = cgcheckMng.findById(Integer.parseInt(id));
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/purchase_manage/check/check_cgUpdate";
	}
	
	/*
	 * ????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@RequestMapping(value = "/updatePage")
	@ResponseBody
	public JsonPagination updatePage(PurchaseApplyBasic bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgcheckMng.updatePageList(bean, page, rows, getUser());
    	List<PurchaseUpdateInfo> li = (List<PurchaseUpdateInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//????????????	
			li.get(x).setNum(x+1);	
		}
    	return getJsonPagination(p, page);
	}	
}
