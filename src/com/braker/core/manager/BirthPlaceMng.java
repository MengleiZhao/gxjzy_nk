package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.BirthPlace;
import com.braker.core.model.User;

public interface BirthPlaceMng extends BaseManager<BirthPlace>{

	/**
	 * 分页
	 * @param unit 参数
	 * @param page 第几页
	 * @param rows 一页几条
	 * @param sort 排序字段
	 * @param order 排序类型（acs/desc）
	 * @return
	 */
	Pagination list(BirthPlace bean, String sort, String order, Integer pageIndex,
			Integer pageSize, boolean hasRole, boolean streetRole, User user);
	
	BirthPlace saveBirthPlace(BirthPlace bean, User user);

}
