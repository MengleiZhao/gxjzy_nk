package com.braker.icontrol.budget.manager.manager.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.manager.entity.TIndexReleasePlan;
import com.braker.icontrol.budget.manager.manager.IndexReleasePlanMng;

/**
 * 指标计划下达表的service实现类
 * @author 叶崇晖
 * @createtime 2019-03-14
 * @updatetime 2019-03-14
 */
@Service
@Transactional
public class IndexReleasePlanMngImpl extends BaseManagerImpl<TIndexReleasePlan> implements IndexReleasePlanMng {

	/**
	 * 根据指标编码查询相应指标的下达计划
	 * @param indexCode是指标编码
	 * @return List<TIndexReleasePlan>是指标下达计划的list
	 */
	@Override
	public List<TIndexReleasePlan> findByIndexCode(String indexCode) {
		Finder finder = Finder.create(" FROM TIndexReleasePlan WHERE indexCode='"+indexCode+"'");
		return super.find(finder);
	}

}
