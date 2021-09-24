package com.braker.icontrol.budget.performancemanage.selfeval.manager.impl;


import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.BudgetResultMng;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResult;



/**
 *预算自评表的信息
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
@Service
@Transactional
public class BudgetResultMngImpl extends BaseManagerImpl<BudgetResult> implements BudgetResultMng {
	
	/*
	 * 通过fpoid查询预算执行表信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public List<BudgetResult> getBudgetResultbypid(Integer id) {
		Finder finder = Finder.create(" FROM BudgetResult WHERE fproId="+id+" ");
		return super.find(finder);
	}






}	
	


























	

	



