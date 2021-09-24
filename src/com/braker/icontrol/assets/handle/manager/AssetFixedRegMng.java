package com.braker.icontrol.assets.handle.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.assets.handle.model.AssetRegistration;

public interface AssetFixedRegMng extends BaseManager<AssetRegistration> {

	/**
	 * 
	 * @param fId
	 * @return
	 */
	List<AssetRegistration> findbyfId(Integer fId);
	
}
