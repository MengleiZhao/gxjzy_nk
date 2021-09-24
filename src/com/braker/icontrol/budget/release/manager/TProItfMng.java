package com.braker.icontrol.budget.release.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicProItf;

/**
 * 项目支出预算指标下达明细service
 * @author 叶崇晖
 * @createtime 2018-07-13
 * @updatetime 2018-07-13
 */
public interface TProItfMng extends BaseManager<TBudgetaryIndicProItf>{
	/*
	 * 获得项目支出列表
	 * @author 叶崇晖
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param type  类型：收入9/支出1
	 * @param parentId  父节点id
	 * @param year  年度
	 * @param depart 部门名称
	 */
	public List<Object[]> getIndexTree(String basicType, String type, String parentId, String year, String depart);
	
	public TBudgetaryIndicProItf save(TBudgetaryIndicProItf bean, User user);
}
