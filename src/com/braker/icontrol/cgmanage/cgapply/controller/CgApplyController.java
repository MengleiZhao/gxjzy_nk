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
 * 采购申请审批的控制层
 * 本模块用于采购申请的审批及查看
 * @author 冉德茂
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
	 * 跳转到列表页面
	 * @author 冉德茂
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
	 * 跳转到采购选择配置计划的list页面
	 * @author 冉德茂
	 * @createtime 2018-10-17
	 * @updatetime 2018-10-17
	 */
	@RequestMapping(value = "/checkedlist")
	public String checkedlist( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/purchase/conf_plan_checked_list";
	}
	
	/*
	 * 跳转到指标选择页面
	 * @author 冉德茂
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/purchase/cg_checkIndex";
		//return "/WEB-INF/view/";
	}
	
	/*
	 * 跳转到采购细目选择页面
	 * @author 沈帆
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
	 * 跳转到采购报销列表页面
	 * @author 沈帆
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@RequestMapping(value = "/reimbList")
	public String reimbList(ModelMap model) {
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 沈帆
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
				
	    		//序号设置	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	/*
	 * 采购报销分页数据获得
	 * @author 沈帆
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
	    		//序号设置	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * 采购报销审批分页数据获得
	 * @author 沈帆
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
	    		//序号设置	
	    		li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
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
			//设置合同id
    		try {
    			List<ContractBasicInfo> contractList=formulationMng.findByProperty("fPurchNo", li.get(x).getBeanId().toString());
    			if(contractList!=null && contractList.size()>0){
    				ContractBasicInfo contract=contractList.get(0);
            		li.get(x).setContractId(contract.getBeanId());
    			}
    			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
    		//序号设置	
    		li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/**
	 * 合同选取采购单时使用
	 */
	@RequestMapping(value = "/cgsqPageChoose")
	@ResponseBody
	public JsonPagination cgsqPageChoose(PurchaseApplyBasic bean, Integer page, Integer rows, String timea, String timeb, String amounta, String amountb){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgsqMng.pageList(bean, page, rows, getUser(), timea, timeb, amounta, amountb);
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	//中标金额
    	BigDecimal bidAmount = null;
    	for(int x=0; x<li.size(); x++) {
    		if("1".equals(li.get(x).getFbidStauts())){
    			BiddingRegist biddingRegist = processMng.getBiddingRegistByPId(li.get(x).getFpId());
        		//页面中显示标金额
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
    		//序号设置	
    		li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	
	
	
	/*
	 * 采购申请删除
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			cgsqMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/**
	 * 采购申请撤回
	 * @author 焦广兴
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
				return getJsonResult(false,"该申请已经被审批，不得撤回！");
			}else {*/
				cgsqMng.reCall(id);
				return getJsonResult(true, "操作成功");
			/*}*/
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	/*
	 * 根据采购批次id获取合同金额
	 * @author 李安达
	 * @createtime 2018-11-29
	 * @updatetime 2018-11-29
	 * /cgsqsp/getFpAmount?fpId=采购id
	 */
	@RequestMapping(value="getFpAmount")
	@ResponseBody
	String findFpAmountbyfpCode(String fpId){
		
		return cgsqMng.findFpAmountbyfpId(fpId);
		
	}
	
	/*
	 * 采购申请 修改
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		model.addAttribute("openType", "edit");
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询附件信息
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
		//查询工作流
			//货物和服务采购，设备安技处采购管理岗可见
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),type, bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			for (int i = 0; i < nodeConfList.size(); i++) {
				if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
					if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
							TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getIndexId());//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
							User user2 = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
							nodeConfList.get(i).setText(user2.getName()+"|管理部门负责人");
							nodeConfList.get(i).setUserId(user2.getId());
							nodeConfList.get(i).setUser(user2);
					}
				}
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes(type,bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
				
		return "/WEB-INF/view/purchase_manage/purchase/cggl_add";
	}
	
	/*
	 * 采购申请 查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,String openType,ModelMap model){
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
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
			//货物和服务采购，设备安技处采购管理岗可见
			nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),type, bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
			for (int i = 0; i < nodeConfList.size(); i++) {
				if(!"1".equals(nodeConfList.get(i).getStepType())&&!"4".equals(nodeConfList.get(i).getStepType())){
					if(StringUtil.isEmpty(nodeConfList.get(i).getText())){
							TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getIndexId());//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
							User user2 = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
							nodeConfList.get(i).setText(user2.getName()+"|管理部门负责人");
							nodeConfList.get(i).setUserId(user2.getId());
							nodeConfList.get(i).setUser(user2);
					}
				}
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(type, bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes(type,bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}else{
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nodeConfList=tProcessCheckMng.getNodeConfZCandCG(bean.getUserId(),"GCCGSQ",bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1",bean.getIndexId());
			}else {
				nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			}
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
		}
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//是否是合同跳转过来打开的
		model.addAttribute("openType",openType);
		return "/WEB-INF/view/purchase_manage/purchase/cggl_detail";
	}
	
	/*
	 * 采购报销 新增
	 * @author 沈帆
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@RequestMapping(value = "/addReimb")
	public String addReimb(String id,ModelMap model){
		model.addAttribute("openType", "add");
		ReimbAppliBasicInfo bean = new ReimbAppliBasicInfo();
		bean.setrCode(StringUtil.Random(""));
		bean.setType("10");
		
		//查询基本信息
		PurchaseApplyBasic purchase = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = getUser();
		purchase.setfUserName(user.getName());
		bean.setPurchaseId(purchase.getFpId());
		bean.setgName(purchase.getFpName());
		//查询四级指标信息
		Integer detailId = purchase.getProDetailId();
		Integer indexId = purchase.getIndexId();
		bean.setIndexId(indexId);
		bean.setProDetailId(detailId);
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("purchase",purchase);
		model.addAttribute("bean",bean);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(purchase);
		model.addAttribute("attac", attac);

		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"CGBX", user.getDepart().getId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getBeanCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), user.getDepart().getName(), null);
		model.addAttribute("proposer", proposer);
		//得到工作流id
		//历史审批节点
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
				
		return "/WEB-INF/view/purchase_manage/purchase/cgReimb_add";
	}
	
	/*
	 * 采购报销 查看和修改
	 * @author 沈帆
	 * @createtime 2020-12-16
	 * @updatetime 2020-12-16
	 */
	@RequestMapping(value = "/editReimb")
	public String addReimb(String id,ModelMap model,String editType){
		//查询基本信息
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		PurchaseApplyBasic purchase = cgsqMng.findById(bean.getPurchaseId());
		//查询申请人信息
		User user = userMng.findById(purchase.getfUser());
		purchase.setfUserName(user.getName());
		bean.setgName(purchase.getFpName());
		//查询四级指标信息
		Integer detailId = purchase.getProDetailId();
		Integer indexId = purchase.getIndexId();
		bean.setIndexId(indexId);
		bean.setProDetailId(detailId);
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("purchase",purchase);
		model.addAttribute("bean",bean);
		//查询收款人信息
		ReimbPayeeInfo payee =reimbPayeeMng.getByRId(bean.getrId()).get(0);
		model.addAttribute("payee",payee);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(purchase);
		model.addAttribute("attac", attac);
		List<Attachment> attaList =attachmentMng.list(bean);
		model.addAttribute("attaList", attaList);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"CGBX",bean.getDept(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getrCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(), bean.getDeptName(), bean.getReqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGBX", bean.getDept());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编号
		model.addAttribute("foCode",bean.getBeanCode());
		Integer x=0;
		//查询费用明细
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
		model.addAttribute("Invoicelist", list);//通用事项发票
		if("1".equals(editType)){
			model.addAttribute("openType", "edit");
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_add";
		}else{
			model.addAttribute("openType", "detail");
			return "/WEB-INF/view/purchase_manage/purchase/cgReimb_detail";
		}		
	}
	
	/**
	 * 采购申请 重新请求审批流
	 * @author 焦广兴
	 * @createtime 2019-05-24
	 * @updatetime 2019-05-24
	 */
	@RequestMapping("/refreshProcess")
	public String rerefreshProcess(PurchaseApplyBasic bean,String fpPype,String fpId,ModelMap model){
		if(fpPype.equals("A10")|| "A30".equals(fpPype)|| "A20".equals(fpPype)){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"HWCGSQ", getUser().getDpID(),null,bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(),null);
			model.addAttribute("proposer", proposer);
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}else{
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GCCGSQ", getUser().getDpID(),null,bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFpCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
			model.addAttribute("proposer", proposer);
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("GCCGSQ",bean.getfDeptId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}
	}
	
	/**
	 * 采购申请 添加按钮
	 * @author 冉德茂	
	 * 焦广兴修改
	 * @createtime 2018-07-12
	 * @updatetime 2019-05-24
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		model.addAttribute("openType", "add");
		User user = getUser();
		PurchaseApplyBasic bean = new PurchaseApplyBasic();
		//获取当前登录对象获得名称和所属部门
		bean.setfUserName(user.getName());
		bean.setfUser(user.getId());
		bean.setfDeptName(user.getDepartName());
		bean.setfDeptId(user.getDpID());
		bean.setfReqTime(new Date());
		
		//自动生成编号
		String str="CG";
		bean.setFpCode(StringUtil.Random(str));	
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购申请");
		model.addAttribute("cheterInfo", cheterInfo);

		model.addAttribute("bean", bean);
		model.addAttribute("isZc", "0");
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
		model.addAttribute("proposer", proposer);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"HWCGSQ", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//历史审批节点
		String historyNodes=tProcessCheckMng.getHistoryNodes("HWCGSQ",getUser().getDpID(),bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);
		return "/WEB-INF/view/purchase_manage/purchase/cggl_add";
	}
	
	
	/*
	 * 采购申请的保存
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(PurchaseApplyBasic bean, String cgqdfiles, String xqwjfiles, String lzbgfiles,String gclqdfiles, String mingxi, ModelMap model) {
		
		try {
			//保存
			//判断申请金额是否超过可用金额
			Boolean b=budgetIndexMgrMng.checkAmounts(String.valueOf(bean.getProDetailId()), bean.getFpAmount());
			if(b){
				cgsqMng.save(bean, cgqdfiles, xqwjfiles, lzbgfiles,gclqdfiles, mingxi, getUser());
			}else {
				return getJsonResult(false,"预算指标不足！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 附件上传AJAX
	 * @author 冉德茂
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
		
		//获取文件名
		String[] names = fileurl.split("\\\\");
		String name = names[names.length-1];
		//保存附件文件
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
	 * 查询采购品目明细
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(String id) {
		Pagination p = new Pagination();
		//查询采购清单信息
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
	 * 采购审批台账查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value ="/ledgerdetail")
	public String ledgerdetail(String id,ModelMap model){
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		//查询四级指标信息
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购审批");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询过程登记基本信息
		List<BiddingRegist> brList=processMng.findByProperty("fpId", Integer.valueOf(id));
		if(brList.size()>0) {
			BiddingRegist br = brList.get(0);
			model.addAttribute("br", br);
			//查询登记过程附件信息
			List<Attachment> brAttac = attachmentMng.list(br);
			model.addAttribute("brAttac", brAttac);
			//根据中标登记表查询供应商的信息
			List<WinningBidder> fwbean = cgselMng.findByWid(br.getFpId());
			model.addAttribute("fwbean", fwbean);
			model.addAttribute("bidStauts", 0);//登记显示  0显示
		}else {
			model.addAttribute("br", null);
		}
		//查询采购附件信息
		List<Attachment> attac1 = attachmentMng.list(bean);
		model.addAttribute("attac", attac1);
		//查询附件信息
		List<AcceptCheck> acptbeanList=reciveMng.findByProperty("fpId", Integer.valueOf(id));
		if(acptbeanList.size() > 0) {
			AcceptCheck acptbean = acptbeanList.get(0);
			model.addAttribute("acptbean", acptbean);
			//查询验收的附件信息
			List<Attachment> reciveattac=attachmentMng.list(acptbean);
			model.addAttribute("reciveattac", reciveattac);
			model.addAttribute("accStauts", 0);//登记显示  0显示
			//得到工作流id
			TProcessDefin tProcessDefinYS=tProcessDefinMng.getByBusiAndDpcode("HWCGYS", acptbean.getfDepartId());
			model.addAttribute("fpIdYS", tProcessDefinYS.getFPId());
			//对象编码
			model.addAttribute("foCodeYS",acptbean.getBeanCode());
		}else {
			model.addAttribute("acptbean", null);
		}
			

		//查询工作流
			//得到工作流id
			TProcessDefin tProcessDefinCG=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefinCG.getFPId());
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		
		return "/WEB-INF/view/purchase_manage/purchase/cggl_detail_base_tz";
	}
	
	
	/*
	 * 采购台账合同查看详情
	 * @author 方淳洲
	 * @createtime 2021-06-15
	 * @updatetime 2021-06-15
	 */
	@RequestMapping("/detailHT")
	public String detail(String id,ModelMap model,String type){
		//合同信息
		Integer cbiId = null;
		List<ContractBasicInfo> cbi = formulationMng.findbyPurchId(id);
		if(cbi.size() > 0) {
			cbiId = cbi.get(0).getFcId();
		}else {
			
		}
		
		
		
		ContractBasicInfo contractBasicInfo = formulationMng.findById(cbiId);
		
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
			upt =uptMng.findByFContId_U(Integer.toString(cbiId)).get(0);
			
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
			List<Archiving> findByContId = ArchivingMng.findByContId(Integer.toString(cbiId));
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
	
	
	
	
	
	
	/*
	 * 采购验收台账查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value ="/receiveledgedetail")
	public String receiveledgedetail(String id,ModelMap model){
	
		//查询采购基本信息				
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		Date reqTime = bean.getfReqTime();//采购申请时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("dealTime", dealTime);
		//查询采购附件信息
		List<Attachment> pattac = attachmentMng.list(bean);
		model.addAttribute("pattac", pattac);
		if("1".equals(bean.getFbidStauts())){
			//查询过程登记基本信息
			BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
			model.addAttribute("br", br);
			//查询登记过程附件信息
			List<Attachment> brAttac = attachmentMng.list(br);
			model.addAttribute("brAttac", brAttac);
			//根据中标登记表查询供应商的信息
			WinningBidder fwbean = cgselMng.findById(br.getFwId());
			model.addAttribute("fwbean", fwbean);
			model.addAttribute("bidStauts", 0);//登记显示  0显示
		}else{
			model.addAttribute("bidStauts", "");//登记显示  空不显示
		}
		/*//查询过程登记基本信息
		BiddingRegist br=processMng.findUniqueByProperty("fpId", Integer.valueOf(id));
		model.addAttribute("br", br);
		//查询登记过程附件信息
		List<Attachment> attac = attachmentMng.list(br);
		model.addAttribute("attac", attac);
		//根据过程登记表查询供应商的信息
		WinningBidder fwbean = cgselMng.findById(br.getFwId());
		model.addAttribute("fwbean", fwbean);*/
		
		/*//获取当前登录人给前台页面的验收人赋值
		model.addAttribute("receive_people", getUser().getName());*/

		
		//通过fpid查询验收信息
		List<AcceptCheck> historyList=cgreceiveMng.checkHistory(Integer.valueOf(id));
		AcceptCheck historybean = new AcceptCheck();
		if(historyList !=null && historyList.size()>0){
			historybean=historyList.get(0);
			//查询验收的附件信息
			List<Attachment> hisattac =attachmentMng.list(historybean);
			model.addAttribute("hisattac", hisattac);
		}
		model.addAttribute("historybean", historybean);
		
		
		//通过项目的pid查询此条信息的供应商评价信息
		List<SupplierEvaluaInfo> evalList=evalSupplierMng.findEvalSupplierbyFpid(Integer.valueOf(id));
		SupplierEvaluaInfo evalbean =new SupplierEvaluaInfo();
		if(evalList !=null && evalList.size()>0){
			evalbean=evalList.get(0);
		}
		model.addAttribute("evalbean", evalbean);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/purchase_manage/receive/receive_ledger_detail";
	}
	/*
	 * 询比价登记查看采购基本信息
	 * @author 冉德茂
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
			//序号设置	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 上传附件
	 * 
	 * @author 陈睿超
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
			// 保存附件到服务器
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
	 * <p>Description: 下载现代学院校内论证表单</p>  
	 * @param response
	 * @return
	 * @author 陈睿超
	 * @createtime 2021年2月23日
	 * @updator 陈睿超
	 * @updatetime 2021年2月23日
	 */
	@RequestMapping("/xnlzDownload")
	@ResponseBody
	public Result xnlzDownload(HttpServletResponse response) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\校内论证表单.xlsx";
			File file = new File(filePath);
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String("校内论证表单.xlsx".getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "文件不存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "下载失败！");
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
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * <p>Title: xwlzDownload</p>  
	 * <p>Description: 下载校外论证表单</p>  
	 * @param response
	 * @return
	 * @author 陈睿超
	 * @createtime 2021年2月23日
	 * @updator 陈睿超
	 * @updatetime 2021年2月23日
	 */
	@RequestMapping("/xwlzDownload")
	@ResponseBody
	public Result xwlzDownload(HttpServletResponse response) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\校外论证表单.xlsx";
			File file = new File(filePath);
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String("校外论证表单.xlsx".getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "文件不存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "下载失败！");
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
		return getJsonResult(true, "操作成功！");
	}
	
	
	@RequestMapping(value="/cgApplyExprint")
	public String cgApplyExprint(Integer id,ModelMap model){
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询申请人信息
		User user = userMng.findById(bean.getfUser());
		bean.setfUserName(user.getName());
		List<ProcurementPlanList> mingxiList = cgConPlanListMng.findbyIdAndTypes("fpId",String.valueOf(bean.getFpId()),"1");
		
		//查询工作流
		TBudgetIndexMgr budgetIndexMgr = indexMng.findById(bean.getIndexId());
		TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
		bean.setProDetailName(pro.getFProName());
		bean.setProCharger(pro.getFProHead());
		
		model.addAttribute("mingxiList", mingxiList);
		model.addAttribute("bean",bean);
		
		//审签信息
		List<TProcessPrintDetail> listTProcessChecks = tProcessPrintDetailMng.findbytab("PurchaseApplyBasic", "fpId", bean.getFpId());
		
		for (int i = 0; i < listTProcessChecks.size(); i++) {
			model.addAttribute("listTProcessChecks"+i, listTProcessChecks.get(i));
		}
		return "/WEB-INF/view/purchase_manage/exprint/cg_apply_exprint";
	}
	
	
	
}
