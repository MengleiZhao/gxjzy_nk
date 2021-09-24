package com.braker.icontrol.budget.release.manager;

import java.util.List;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;

/**
 * 基本支出预算指标下达明细service
 * @author 叶崇晖
 * @createtime 2018-07-13
 * @updatetime 2018-07-13
 */
public interface TBasicItfMng extends BaseManager<TBudgetaryIndicBasicItf>{
	/*
	 * 获得基本支出列表
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param type  类型：收入9/支出1
	 * @param parentId  父节点id
	 * @param year  年度
	 * @param depart 部门名称
	 */
	public List<Object[]> getIndexTree(String basicType, String type, String parentId, String year, String depart);
	/**
	 * 保存
	 */
	public TBudgetaryIndicBasicItf save(TBudgetaryIndicBasicItf bean, User user);
	/**
	 * 批量保存 
	 */
	public void save(List<TBudgetaryIndicBasicItf> list, User user);
	/**
	 * 查询
	 */
	public Pagination pageList(TBudgetaryIndicBasicItf bean, User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 查询下达的基本支出
	 * @param id 上级节点id
	 * @param type 类型 1-人员 2-公用
	 * @param user 操作人
	 * @return
	 */
	public List<TreeEntity> getTreeList(String parentId, String type, User user);
	
}
