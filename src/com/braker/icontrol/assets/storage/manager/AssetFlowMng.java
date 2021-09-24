package com.braker.icontrol.assets.storage.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetFlow;

public interface AssetFlowMng extends BaseManager<AssetFlow>{

	/**
	 * 添加一条资产的流水记录
	 * @param user 用户
	 * @param fOptType 操作类型
	 * @param flowCode 相关操作单编号
	 * @param flowStockCode 资产编码
	 * @param flowAssName 资产名称
	 * @param flowAssType 资产类型
	 * @param flowMeasUnit 计量单位
	 * @param flowNum 数量
	 */
	void addFlow(User user,Lookups fOptType,String flowCode,String flowStockCode,String flowAssName,Lookups flowAssType,String flowMeasUnit,Integer flowNum);
	
	/**
	 * 根据物资编码和操作类型查询
	 * @param code 物资编码
	 * @param fOptTypecode 操作类型
	 * @return
	 */
	List<AssetFlow> findbyStockCode(String code,String fOptTypeCode);
	
	/**
	 * 加载搜索固定资产台账
	 * @param assetBasicInfo 搜索信息
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination fixedFlow(AssetFlow assetFlow,AssetBasicInfo assetBasicInfo, User user, Integer pageNo,Integer pageSize);
}
