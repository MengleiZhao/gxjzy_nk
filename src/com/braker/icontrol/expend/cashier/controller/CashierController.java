package com.braker.icontrol.expend.cashier.controller;

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
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgpay.manager.CgPayCheckMng;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.cashier.model.CashierAcceptInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.ContractReimburseInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 出纳受理的控制层
 * @author 叶崇晖
 * @createtime 2018-08-20
 * @updatetime 2018-08-20
 */
@Controller
@RequestMapping(value = "/cashier")
public class CashierController extends BaseController {
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private CgPayCheckMng cgcheckpayMng;
	
	@Autowired
	private ContPayMng contPayMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private CashierMng cashierMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private ApplicationBasicInfoMng applicationBasicInfoMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/cashier/cashier_list";
	}
	
	/*
	 * 报销单分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@ResponseBody
	@RequestMapping(value = "/reimbursePage")
	public JsonPagination reimbursePage(DirectlyReimbAppliBasicInfo drBean, ReimbAppliBasicInfo rBean, String reimburseType,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = null;
    	User user = getUser();
    	//0位直接报销1到7位申请报销
    	if(reimburseType.equals("0")) {
    		//0位直接报销
    		if(user.getRoleName().contains("出纳岗")){
    			p = directlyReimbMng.cashierPageList(drBean, page, rows, user);
        		List<DirectlyReimbAppliBasicInfo> li = (List<DirectlyReimbAppliBasicInfo>) p.getList();
        		for(int x=0; x<li.size(); x++) {
        			//序号设置	
        			li.get(x).setNum((x+1)+(page-1)*rows);
        			//设置申请人姓名（id查姓名）,申请人所属部门
        			User user1 = userMng.findById(li.get(x).getUser());
        			li.get(x).setUserName(user1.getName());
        		}
    		}else{
    			p = new Pagination();
    		}

    	} else {
    		//申请报销
    		if(user.getRoleName().contains("出纳岗")){
    			p = reimbAppliMng.cashierPageList(rBean, page, rows, getUser());
        		List<ReimbAppliBasicInfo> li = (List<ReimbAppliBasicInfo>) p.getList();
        		for(int x=0; x<li.size(); x++) {
        			//序号设置	
        			li.get(x).setNum((x+1)+(page-1)*rows);
        			User user1 = userMng.findById(li.get(x).getUser());
        			li.get(x).setUserName(user1.getName());
        			if(!"9".equals(li.get(x).getType())){
        				String reason=applicationBasicInfoMng.getByGCode(li.get(x).getgCode()).getReason();
        				li.get(x).setReimburseReason(reason);
        			}
        		}
    		}else{
    			p = new Pagination();
    		}
    		
    	}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 借款申请单分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/loanPage")
	@ResponseBody
	public JsonPagination loanPage(LoanBasicInfo bean,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = null;
    	User user = getUser();
    	if(user.getRoleName().contains("出纳岗")){
        	p = loanMng.cashierPageList(bean, page, rows, getUser());;
        	List<LoanBasicInfo> li = (List<LoanBasicInfo>) p.getList();
        	for(int x=0; x<li.size(); x++) {
    			//序号设置	
    			li.get(x).setNum((x+1)+(page-1)*rows);	
    			//设置申请人姓名（id查姓名）,申请人所属部门
    			User user1 = userMng.findById(li.get(x).getUser());
    			li.get(x).setUserName(user1.getName());
    		}
		}else{
			p = new Pagination();
		}
    	
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 采购支付单分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/purchasePage")
	@ResponseBody
	public JsonPagination purchasePage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	
    	Pagination p = null;
    	User user = getUser();
    	if(user.getRoleName().contains("出纳岗")){
		 p = cgcheckpayMng.cashierPageList(bean, page, rows, getUser(),"cashier");
	    	List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
	    		ReimbAppliBasicInfo reimb =reimbAppliMng.findById(li.get(x).getrId());
				li.get(x).setReimbStatus(reimb.getCheckStauts());
				li.get(x).setPayAmount(reimb.getAmount());
				li.get(x).setCashierType(reimb.getCashierType());
				//序号设置	
				li.get(x).setNumber((x+1)+(page-1)*rows);	
			}
		}else{
			p = new Pagination();
		}
    	
    	
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 合同报销单分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/contractPage")
	@ResponseBody
	public JsonPagination contractPage(ContPay payBean, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = null;
    	User user = getUser();
    	if(user.getRoleName().contains("出纳岗")){
		p = contPayMng.cashierPageList(payBean, page, rows, getUser());//0为checkType(0位合同审批，1位财务审定)
		List<ContractReimburseInfo> li = (List<ContractReimburseInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		}else{
			p = new Pagination();
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 合同报销单台账数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@RequestMapping(value = "/contractLegerPage")
	@ResponseBody
	public JsonPagination contractLegerPage(ContPay payBean, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = null;
    	User user = getUser();
		p = contPayMng.cashierPageList(payBean, page, rows, getUser());//0为checkType(0位合同审批，1位财务审定)
		List<ContractReimburseInfo> li = (List<ContractReimburseInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 保存合同支付单出纳受理结果
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@RequestMapping(value = "/contractCashierResult")
	@ResponseBody
	public Result loanCashierResult(CashierAcceptInfo cashierBean,ContPay bean, ReceivPlan receivPlanBean,String spjlFile, Integer payId,TProcessCheck checkBean,String bankAccountId,String economicCode) {
		try {
			bean= contPayMng.findById(payId);
			receivPlanBean = receivPlanMng.findById(receivPlanBean.getfPlanId());//合同付款计划
			
			cashierMng.saveContractCashierInfo(cashierBean, bean, receivPlanBean, getUser(), checkBean,spjlFile,bankAccountId, economicCode);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 保存采购支付单出纳受理结果
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@RequestMapping(value = "/purchaseCashierResult")
	@ResponseBody
	public Result purchaseCashierResult(CashierAcceptInfo cashierBean, PurchaseApplyBasic purchaseBean,String spjlFile, TProcessCheck checkBean) {
		try {
			//查询基本信息
			purchaseBean = cgsqMng.findById(Integer.valueOf(purchaseBean.getFpId()));
			//当前为了支出模块代码不报错先注释了，目前该方法有问题，可以取消注解后进到方法里看，
			//cashierMng.savePurchaseCashierInfo(cashierBean, purchaseBean, checkBean, getUser(),spjlFile);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * @ToDo 跳转到付款确认付讫页面 
	 * @param id ReimbAppliBasicInfo的主键
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月8日
	 */
	@RequestMapping("/fundCheck/{id}")
	public String fundCheck(@PathVariable String id,String openType,ModelMap model){
		model.addAttribute("ID", id);
		//申请报销
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(Integer.valueOf(id));
		if(!"9".equals(bean.getType()) && !"4".equals(bean.getType()) && !"10".equals(bean.getType())){
			ApplicationBasicInfo applicationBasicInfo = applicationBasicInfoMng.getByGCode(bean.getgCode());
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(applicationBasicInfo.getProDetailId());
			model.addAttribute("indexCode", expendDetail.getSubCode());
		}else if("10".equals(bean.getType())){
			PurchaseApplyBasic purchase = cgsqMng.findById(bean.getPurchaseId());
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(purchase.getProDetailId());
			model.addAttribute("indexCode", expendDetail.getSubCode());
		}else {
			
			model.addAttribute("indexCode", null);
		}
		return "/WEB-INF/view/expend/cashier/cashier_pay_register";
		
	}
	
	/**
	 * @ToDo 保存登记付讫信息、并生成凭证
	 * @param bean 
	 * @param economicCode 经济科目主键 
	 * @param model
	 * @return 
	 * @author 陈睿超
	 * @createTime 2019年7月8日
	 */
	@ResponseBody
	@RequestMapping("/payRegister")
	public Result payRegister(ReimbAppliBasicInfo bean,String economicCode,ModelMap model){
		try {
			cashierMng.savePayRegister(bean,economicCode, getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	/**
	 * 保存登记付讫信息 不带凭证
	 * @param bean
	 * @param economicCode
	 * @param registertype 保存类型0-直接报销，2-借款报销
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年8月15日
	 * @updateTime 2019年8月15日
	 */
	@ResponseBody
	@RequestMapping("/simplePayRegister")
	public Result simplePayRegister(String id,String economicCode,String registertype,ModelMap model){
		try {
			cashierMng.simplesavePayRegister(id,economicCode,registertype, getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
}
