package com.braker.icontrol.expend.cashier.manager;

import java.math.BigDecimal;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.cashier.model.CashierAcceptInfo;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 出纳受理的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-23
 * @updatetime 2018-08-23
 */
public interface CashierMng extends BaseManager<CashierAcceptInfo> {
	
	
	/*
	 * 保存合同付款单的出纳受理信息
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	public void saveContractCashierInfo(CashierAcceptInfo cashierBean,ContPay bean, ReceivPlan receivPlanBean, User user,TProcessCheck checkBean,String files,String bankAccountId,String economicCode);
	
	/*
	 * 保存采购付款单的出纳受理信息
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	public void savePurchaseCashierInfo(CashierAcceptInfo cashierBean, PurchaseApplyBasic purchaseBean, TProcessCheck checkBean, User user,String files);
	
	
	/**
	 * 根据借款单id查询相应的出纳受理记录
	 * @author 叶崇晖
	 * @param lId借款单id
	 * @param stauts状态
	 * @return
	 */
	public List<CashierAcceptInfo> findByLoanId(Integer lId, String stauts);
	
	/**
	 * 根据直接报销单id查询相应的出纳受理记录
	 * @author 叶崇晖
	 * @param drId直接报销单id
	 * @param stauts状态
	 * @return
	 */
	public List<CashierAcceptInfo> findByDrId(Integer drId, String stauts);
	
	/**
	 * 根据合同id查询相应的出纳受理记录
	 * @author 叶崇晖
	 * @param fcId合同单id
	 * @param stauts状态
	 * @return
	 */
	public List<CashierAcceptInfo> findByFcId(Integer fcId, String stauts);
	
	/**
	 * 根据申请报销单id查询相应的出纳受理记录
	 * @author 叶崇晖
	 * @param rId申请报销单id
	 * @param stauts状态
	 * @return
	 */
	public List<CashierAcceptInfo> findByRId(Integer rId, String stauts);
	
	/**
	 * 根据采购付款申请单id查询相应的出纳受理记录
	 * @author 叶崇晖
	 * @param pId采购付款申请单id
	 * @param stauts状态
	 * @return
	 */
	public List<CashierAcceptInfo> findByPId(Integer pId, String stauts);
	
	/**
	 * @ToDo 付讫之后保存信息生成凭证
	 * @param cashierBean
	 * @param drBean
	 * @param rBean
	 * @param user
	 * @author 陈睿超
	 * @createTime 2019年7月8日
	 */
	public void savePayRegister( ReimbAppliBasicInfo rBean,String economicCode , User user);
	
	/**
	 * 付讫之后保存信息不会生成凭证
	 * @param rBean
	 * @param economicCode
	 * @param registertype 保存类型0-直接报销，2-借款报销
	 * @param user
	 * @author 陈睿超
	 * @createTime 2019年8月15日
	 * @updateTime 2019年8月15日
	 */
	public void simplesavePayRegister(String id,String economicCode ,String registertype, User user);
	
	void withLoan(LoanBasicInfo loan,BigDecimal amount);
	
	void deleteDjAmount(Integer indexId,Integer proDetailId,BigDecimal amount,BigDecimal djAmount,String departId,String operatorId,String url,String beanCode,String type);
}
