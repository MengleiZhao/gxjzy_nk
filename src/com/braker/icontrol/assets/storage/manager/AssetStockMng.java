package com.braker.icontrol.assets.storage.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;

public interface AssetStockMng extends BaseManager<AssetStock>{

	/**
	 * 根据编码查询是否有货
	 * @param storage
	 * @return
	 */
	List<AssetStock> findbycode(Storage storage);
	
	/**
	 * 根据编码查询是否有货
	 * @param storage
	 * @return
	 */
	List<AssetStock> findbycode(String code);

	/**
	 * 修改时减少数据库数据（入库）
	 * @param storage
	 */
	void updateByCode(Regist regist,User user);
	
	/**
	 * 根据物资编码去查询
	 * @param li
	 * @return
	 */
	List<AssetStock> findByfAssCode(List<AssetBasicInfo> li);
	
	/**
	 * 修改时减少库存数据（领用）
	 * @param ReceList
	 * @param user
	 */
	void updateByCode(ReceList ReceList,User user);
	
	/**
	 * 修改时减少库存数据（领用）
	 * @param rece
	 * @param user
	 */
	void updateByCode(Rece rece,User user);
	
	/**
	 * 根据2个条件去查询
	 * @param condition1 条件1
	 * @param val1  条件1的值
	 * @param condition2 条件2 
	 * @param val2  条件2的值
	 * @return
	 */
	List<AssetStock> find2Condition(String condition1,String val1,String condition2,String val2);
	
	/**
	 * 查询库存表中所有物资编码，是否有重复的，
	 * @param ListCode 需要确认是否重复的编码
	 * @return Regist 重复的那个项
	 */
	Regist repeatStock(List<Regist> ListCode);
}
