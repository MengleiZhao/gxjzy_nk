package com.braker.icontrol.budget.manager.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.manager.entity.TIndexReleasePlan;

/**
 * 指标计划下达表的service抽象类
 * @author 叶崇晖
 * @createtime 2019-03-14
 * @updatetime 2019-03-14
 */
public interface IndexReleasePlanMng extends BaseManager<TIndexReleasePlan> {
	
	/**
	 * 根据指标编码查询相应指标的下达计划
	 * @param indexCode是指标编码
	 * @return List<TIndexReleasePlan>是指标下达计划的list
	 */
	public List<TIndexReleasePlan> findByIndexCode(String indexCode);
}
