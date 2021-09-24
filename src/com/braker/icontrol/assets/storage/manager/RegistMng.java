package com.braker.icontrol.assets.storage.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.assets.storage.model.Regist;

public interface RegistMng extends BaseManager<Regist>{

	/**
	 * 根据id去查低值易耗品的清单表
	 * @param id
	 * @return
	 */
	Pagination findById(String id,Integer pageNo,Integer pageSize);
	
	/**
	 * 根据入库单号查询所有的清单记录
	 * @param fAssStorageCode_R
	 * @return
	 */
	List<Regist> findByFAssStorageCode_R(String fAssStorageCode_R);
	
	/**
	 * 根据详情单的主键去查询
	 * @param regist
	 * @return
	 */
	List<Regist> findByfListId(Regist regist);
	
	/**
	 * 查询所有的信息
	 * @param regist
	 * @return
	 */
	Pagination allRegist(Regist regist,Integer pageNo,Integer pageSize);
	
}
