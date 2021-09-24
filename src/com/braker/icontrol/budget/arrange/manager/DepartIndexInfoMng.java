package com.braker.icontrol.budget.arrange.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.budget.arrange.entity.DepartIndexInfo;

public interface DepartIndexInfoMng extends BaseManager<DepartIndexInfo> {

	/**
	 * 列表查询
	 */
	public Pagination pageList(DepartIndexInfo bean, Integer pageNo, Integer pageSize);

	/**
	 * 下达部门指标
	 * @param infoId 指标id
	 * @param money 下达金额
	 */
	public void releaseById(String infoId, double money);
}
