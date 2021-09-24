package com.braker.icontrol.assets.allcoa.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.assets.allcoa.model.Alloca;
import com.braker.icontrol.assets.allcoa.model.AllocaList;

public interface AllocaListMng extends BaseManager<AllocaList>{

	/**
	 * 根据资产调拨单号去查询
	 * @param allocaCode
	 * @return
	 */
	List<AllocaList> findbyAllocaCode(String allocaCode);
	
	/**
	 * 保存调拨资产清单
	 * @param allocaList
	 */
	void saveList(Alloca alloca,List<AllocaList> allocaList);
	
	/**
	 * 根据资产调拨单删除
	 * @param code
	 */
	void deletebyCode(String code);
}
