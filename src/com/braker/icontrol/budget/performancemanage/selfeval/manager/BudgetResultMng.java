package com.braker.icontrol.budget.performancemanage.selfeval.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResult;



/**
 *预算执行评价的实现
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
public interface BudgetResultMng extends BaseManager<BudgetResult>{

	
	/*
	 * 根据fcid查询映射信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public List<BudgetResult> getBudgetResultbypid(Integer id);

	
	
	
	
	
}
