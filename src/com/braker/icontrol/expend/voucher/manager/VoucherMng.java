package com.braker.icontrol.expend.voucher.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.voucher.entity.Voucher;

public interface VoucherMng extends BaseManager<Voucher>{

	/**
	 * 查询list页面数据
	 * @param voucher
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(Voucher voucher,User user, Integer pageNo, Integer pageSize);
	
	
	/**
	 * 
	* @author:安达
	* @Title: addVoucher 
	* @Description: 添加凭证库
	* @param beanCode   各种申请单编码
	* @param fSummary  摘要
	* @param fDeptName  部门Id
	* @param fDeptName  部门名称
	* @param fProjectName 项目名称
	* @param fEconomicName  预算指标体系的最末级指标
	* @param amount   发生金额
	* @param contPayTotal   合同付款总金额。  如果为0，说明是直接报销
	* @param sourcesfunds  根据预算指标选取到的资金来源
	* @param bankText  出纳受理后选取的对应银行进行付款
	* @return
	* @return String    返回类型 
	* @date： 2019年7月1日下午9:34:25 
	* @throws
	 */
	public String addVoucher(String beanCode,String fSummary,String fDeptId,String fDeptName,String fProjectName,
			String fEconomicName,Double amount,Double contPayTotal,String sourcesfunds,String bankText );
	
	/**
	 * 
	 * @author:安达
	 * @Title: addVoucher 
	 * @Description: 这里用一句话描述这个方法的作用 
	 * @param beanCode   各种申请单编码
	 * @param fSummary  摘要
	 * @param amount  发生金额
	 * @return
	 * @return Voucher    返回类型 
	 * @date： 2019年7月2日下午4:30:18 
	 * @throws
	 */
	Voucher addVoucher(String beanCode, String fSummary,Double amount);
	
	/**
	 * @ToDo 根据条件查找
	 * @param name 查找条件
	 * @param val 查找值
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月8日
	 */
	Voucher findbyproperties(String name,String val);
	
	
}
