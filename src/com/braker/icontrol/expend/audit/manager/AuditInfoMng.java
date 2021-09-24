package com.braker.icontrol.expend.audit.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.audit.model.AuditInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 财务审定的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
public interface AuditInfoMng extends BaseManager<AuditInfo> {
	
	/*
	 * 保存报销审定信息
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public void saveReimburseAuditInfo(AuditInfo auditBean, DirectlyReimbAppliBasicInfo drBean, ReimbAppliBasicInfo rBean, User user, Role role);
	
	/*
	 * 查询历史审定记录
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public List<AuditInfo> auditHistory(Integer id, String auditType, String stauts);
	
	/*
	 * 保存合同支付审定信息
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public void saveContractAuditInfo(AuditInfo auditBean, ContPay bean, ReceivPlan receivPlanBean, User user, String result);
}
