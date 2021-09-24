package com.braker.icontrol.expend.voucher.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.voucher.entity.FinancalToBudget;

public interface FinancalToBudgetMng extends BaseManager<FinancalToBudget> {

	/**
	 * 
	 * @ToDo 选取对应预算会计科目
	 * @param financal 财务会计科目编号
	 * @return 预算会计科目编号和名称
	 * @author 陈睿超
	 * @createTime 2019年7月2日
	 */
	String toBudget(String financal);
	
	/**
	 * 
	 * @ToDo 根据条件查询
	 * @param financalToBudget 查询条件
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月2日
	 */
	List<FinancalToBudget> findbyAll(FinancalToBudget financalToBudget);
	
	
	/**
	 * @ToDo 
	 * @param financalToBudget
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月2日
	 */
	FinancalToBudget findbyFinancialCode(FinancalToBudget financalToBudget);
	
	/**
	 *
	 * @ToDo 根据条件查询
	 * @param properties 查询条件名称
	 * @param val 查询条件值
	 * @return 类
	 * @author 陈睿超
	 * @createTime 2019年7月3日
	 */
	FinancalToBudget findbyproperties(String properties,String val);
}
