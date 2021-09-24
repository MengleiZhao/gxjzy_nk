package com.braker.icontrol.expend.voucher.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.voucher.entity.Voucher;
import com.braker.icontrol.expend.voucher.entity.VoucherList;

public interface VoucherListMng extends BaseManager<VoucherList>{

	/**
	 * 根据凭证号进行查询
	 * @param voucherList 查询数据
	 * @return
	 */
	List<VoucherList> findbyListVoucher(VoucherList voucherList);
	
	/**
	 * 
	* @author:安达
	* @Title: addVoucherList 
	* @Description: 添加凭证清单
	* @param beanCode   各种申请单编码
	* @param fSummary  摘要
	* @param fDeptName  部门Id
	* @param fDeptName  部门名称
	* @param fProjectName 项目名称
	* @param fEconomicName  预算指标体系的最末级指标
	* @param amount   发生金额
	* @param sourcesfunds  根据预算指标选取到的资金来源
	* @param bankText  出纳受理后选取的对应银行进行付款
	* @param lineNum   第几行    总共有 4行 
	* @return
	* @return String    返回类型 
	* @date： 2019年7月1日下午9:34:25 
	* @throws
	 */
	public VoucherList addVoucherList(String fSummary,String fDeptId,String fDeptName,String fProjectName,
			String fEconomicName,Double amount,String sourcesfunds,String bankText,int lineNum,Voucher voucher );
	
	
}
