package com.braker.icontrol.expend.apply.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;

/**
 * 城内交通费service层
 * @author 赵孟雷
 *
 */
public interface InCityTrafficInfoMng extends BaseManager<InCityTrafficInfo>{

	/**
	 * 事前市内交通费查询
	 */
	public Pagination inCityInfoPageList(int pageNo, int pageSize,InCityTrafficInfo bean);
	/**
	 * 事后市内交通费查询
	 */
	public Pagination rinCityInfoPageList(int pageNo, int pageSize,InCityTrafficInfo bean);
}
