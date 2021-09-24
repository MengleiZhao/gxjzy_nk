package com.braker.icontrol.cgmanage.cgcheck.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgcheck.model.PurcMaterialList;

public interface PurcMaterialMng extends BaseManager<PurcMaterialList>{

	/**
	 * 根据外键查询
	 * @param fpId
	 * @return
	 */
	Pagination findbyfpId(Integer fpId, Integer pageNo,Integer pageSize);
}
