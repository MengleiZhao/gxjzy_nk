package com.braker.icontrol.assets.storage.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;

public interface AssetBasicInfoMng extends BaseManager<AssetBasicInfo>{

	/**
	 * 保存更新库存数量
	 * @param storage
	 * @param assetBasicInfo
	 * @param user
	 */
	void save(Regist regist,Storage storage,User user);
	
	/**
	 * 根据编码查询是否有货
	 * @param storage
	 * @return
	 */
	List<AssetBasicInfo> findbycode(String code);
	
	/**
	 * 查询数据库有多少品目
	 * @param type 资产类型
	 * @return
	 */
	List<AssetBasicInfo> allAssName(String type);
	
	/**
	 * 查询字典里资产类型
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked);
	
	/**
	 * 保存物资品目表
	 * @param assetBasicInfo
	 */
	void saveABI(AssetBasicInfo assetBasicInfo,User user);
	
	/**
	 * 显示所有物资信息供用户选择（资产处置用）
	 * @param assetStock
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination allStork(AssetBasicInfo ABI,Integer pageNo, Integer pageSize);
	/**
	 * 显示物资信息供用户选择（资产维修用）
	 * @param assetStock
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination maintainchoose(AssetBasicInfo ABI,Integer pageNo, Integer pageSize);
	
	/**
	 * 查询数据库所有资产
	 * @return
	 */
	Pagination allAss(AssetBasicInfo assetBasicInfo,Integer pageNo,Integer pageSize);
	
	/**
	 * 两个条件查询
	 * @param condition1 条件1
	 * @param val1  条件1的值
	 * @param condition2 条件2 
	 * @param val2  条件2的值
	 * @return
	 */
	List<AssetBasicInfo> findby2Condition(String condition1,String val1,String condition2,String val2);
	
	/**
	 * 查询在使用中的固定资产
	 * @param abi
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination allAllcoa(AssetBasicInfo abi,Integer pageNo, Integer pageSize);
	
	
	
}
