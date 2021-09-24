package com.braker.icontrol.budget.manager.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;

/**
 * 预算指标下达流水表的service抽象类
 * @author 叶崇晖
 * @createtime 2018-10-09
 * @updatetime 2018-10-09
 */
public interface BudgetIndexDetailMng extends BaseManager<TBudgetIndexDetail> {
	/*
	 * 流水查询
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	public List<TBudgetIndexDetail> getDetail(Integer bId);

	/**
	 * 分年度查询 
	 */
	public List<Object[]> groupByYear();
	
	/**
	 * 分月度查询某一年数据
	 */
	public List<Object[]> groupByMonth(String year);
}
