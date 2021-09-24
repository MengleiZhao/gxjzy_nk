package com.braker.icontrol.contract.enforcing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 合同付款申请的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-21
 * @updatetime 2018-08-21
 */
public interface ContPayMng extends BaseManager<ContPay> {
	/*
	 * 合同报销列表查询
	 * @author 叶崇晖
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	public Pagination contractCheckPageList(ContPay bean, int pageNo,int pageSize, User user, String checkType);
	
	/*
	 * 保存合同报销的审批信息
	 * @author 叶崇晖
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	public void saveContractCheckInfo(TProcessCheck checkBean, ContPay bean, ReceivPlan receivPlanBean, User user,String files)  throws Exception;
	
	/*
	 * 出纳受理合同报销列表查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public Pagination cashierPageList(ContPay bean, int pageNo,int pageSize, User user);
	
	
	/**
	 * 根据付款计划id查询相应的申请
	 * @author 叶崇晖
	 * @param id
	 * @return
	 */
	public List<ContPay> findByFPlanid(Integer id);
}
