package com.braker.icontrol.cgmanage.cgpay.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.Role;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgpay.manager.CgPayCheckMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 采购付款申请审批的控制层
 * @author 冉德茂
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
@Controller
@RequestMapping(value = "/cgpayforcheck")
public class CgPayCheckController extends BaseController{

	@Autowired
	private CgPayCheckMng cgcheckpayMng;
	
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	
	@Autowired
	private CgBidMng cgbidMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CgReceiveMng cgreceiveMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private AuditInfoMng auditInfoMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgpayfor/checkpayfor_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@RequestMapping(value = "/cgpayforcheckPage")
	@ResponseBody
	public JsonPagination loanPage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgcheckpayMng.pageList(bean, page, rows, getUser());
    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/*
	 * 跳转审批页面
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@RequestMapping(value ="/check")
	public String receiveledgedetail(String id,ModelMap model){
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//id是采購的fpid
		//查询基本信息
		model.addAttribute("bean",cgsqMng.findById(Integer.valueOf(id)));
		//通过fpid查询中标信息
		BidRegist bidregist = cgbidMng.getBidRegistByPId(Integer.valueOf(id));
		//根据中标登记表查询供应商的信息
		WinningBidder fwbean = cgselMng.findById(bidregist.getFwId());
		model.addAttribute("fwbean", fwbean);
		
		List<AcceptCheck> historyList=cgreceiveMng.checkHistory(Integer.valueOf(id));
		AcceptCheck historybean =new AcceptCheck();
		if(historyList!=null && historyList.size()>0){
			historybean=historyList.get(0);
			//查询验收的附件信息
			List<Attachment> hisattac =attachmentMng.list(historybean);
			model.addAttribute("hisattac", hisattac);
		}
		model.addAttribute("historybean", historybean);
		
		
		//查询采购附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("采购付款审批");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"CGPAY", bean.getfDeptId(),bean.getBeanCode(),bean.getnCode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFpCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGPAY", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgpayfor/check_payfor_detail";
	}

	
	/*
	 * 进行审核
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean, PurchaseApplyBasic bean,String spjlFile) {
		try {
			List<Role> roleli = userMng.getUserRole(getUser().getId());
			
			bean = purchaseApplyMng.findById(bean.getFpId());
			
			cgcheckpayMng.saveCheckInfo(checkBean, bean, getUser(), roleli.get(0),spjlFile);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	
}
