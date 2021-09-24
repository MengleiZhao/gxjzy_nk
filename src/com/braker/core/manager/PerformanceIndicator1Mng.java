package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import java.util.List;
import com.braker.core.model.PerformanceIndicator1;
import com.braker.core.model.PerformanceIndicator2;

import java.util.List;

public interface PerformanceIndicator1Mng extends BaseManager<PerformanceIndicator1>{

	/**
	 * 一级绩效指标List页数据
	 * @param bean 查询数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination List(PerformanceIndicator1 bean, Integer pageNo, Integer pageSize);
	
	/**
	 * 查询全部一级绩效指标
	 * @return
	 */
	public List<PerformanceIndicator1> getList();
	
	void delete(PerformanceIndicator1 bean);
	
}
