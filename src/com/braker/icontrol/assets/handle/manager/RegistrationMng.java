package com.braker.icontrol.assets.handle.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.assets.handle.model.AssetRegistration;
import com.braker.icontrol.assets.handle.model.Handle;

public interface RegistrationMng extends BaseManager<AssetRegistration>{

	/**
	 * 资产处置登记的list页面数据查询
	 * @param handle
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination registrationList(AssetRegistration assetRegistration,String fAssType,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存更新
	 * @param assetRegistration
	 * @param user
	 *//*
	void save(AssetRegistration assetRegistration,User user);*/
}
