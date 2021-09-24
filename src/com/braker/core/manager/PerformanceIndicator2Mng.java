package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.PerformanceIndicator1;
import com.braker.core.model.PerformanceIndicator2;

import java.util.List;

public interface PerformanceIndicator2Mng extends BaseManager<PerformanceIndicator2>{

	/**
	 * 一级绩效指标List页数据
	 * @param bean 查询数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination List(PerformanceIndicator2 bean, Integer pageNo, Integer pageSize);
	
	/**
	 * 查询匹配一级的二级绩效指标
	 * @param pi1
	 * @return
	 */
	public java.util.List<PerformanceIndicator2> getList(Integer pi1);
	
	/**
	 * 根据集合删除集合里所有的数据
	 * @param bean
	 */
	void deleteAll(PerformanceIndicator1 bean);
}
