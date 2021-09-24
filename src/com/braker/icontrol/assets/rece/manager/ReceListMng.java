package com.braker.icontrol.assets.rece.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;

public interface ReceListMng extends BaseManager<ReceList>{

	/**
	 * 根据fAssReceCode去查该领用单号下详细的低值易耗品领用清单
	 * @param fAssReceCode 领用单的资产领用单号（流水号）
	 * @return
	 */
	Pagination findByfAssReceCode(String fAssReceCode,Integer pageNo,Integer pageSize);
	
	/**
	 * 根据主键id来查询
	 * @param id
	 * @return
	 */
	List<ReceList> findAllById(String id);
	
	/**
	 * 保存资产领用清单
	 * @param bean 领用清单集合
	 */
	void save(Rece rece,List<ReceList> bean);
}
