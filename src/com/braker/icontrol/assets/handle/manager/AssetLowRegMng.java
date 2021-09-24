package com.braker.icontrol.assets.handle.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.assets.handle.model.AssetLowRegistration;

public interface AssetLowRegMng extends BaseManager<AssetLowRegistration>{

	/**
	 * 根据处置单主键查询
	 * @param fId 处置单主键
	 * @return
	 */
	List<AssetLowRegistration> findbyfId(Integer fId);
}
