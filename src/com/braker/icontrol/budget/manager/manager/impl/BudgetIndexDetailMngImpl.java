package com.braker.icontrol.budget.manager.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;
import com.braker.icontrol.budget.manager.manager.BudgetIndexDetailMng;

/**
 * 预算指标下达流水表的service实现类
 * @author 叶崇晖
 * @createtime 2018-10-09
 * @updatetime 2018-10-09
 */
@Service
@Transactional
public class BudgetIndexDetailMngImpl extends BaseManagerImpl<TBudgetIndexDetail> implements BudgetIndexDetailMng {

	/*
	 * 流水查询
	 * @author 叶崇晖
	 * @createtime 2018-10-09 
	 * @updatetime 2018-10-09
	 */
	@Override 
	public List<TBudgetIndexDetail> getDetail(Integer bId) {
		Finder finder = Finder.create(" FROM TBudgetIndexDetail WHERE bId='"+bId+"'");
		return super.find(finder);
	}

	@Override
	public List<Object[]> groupByYear() {
		
		Finder finder = Finder.create(" select bId, year(releaseTime), sum(bcReleaseAmount) from TBudgetIndexDetail "
				+ " group by bId,year(releaseTime)  ");
		return super.find(finder);
	}

	@Override
	public List<Object[]> groupByMonth(String year) {
		
		Finder finder = Finder.create(" select indexCode, month(time), sum(amount) from TIndexDetail "
				+ " where year(time) = '" + year + "' "
				+ " group by indexCode,month(time)  ");
		return super.find(finder);
	}
}
