package com.braker.icontrol.assets.handle.manager.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.assets.handle.manager.AssetLowRegMng;
import com.braker.icontrol.assets.handle.model.AssetLowRegistration;

@Service
public class AssetLowRegMngImpl extends BaseManagerImpl<AssetLowRegistration> implements AssetLowRegMng{

	@Override
	public List<AssetLowRegistration> findbyfId(Integer fId) {
		Finder finder =Finder.create("FROM AssetLowRegistration WHERE handle.fId="+fId);
		return super.find(finder);
	}

	
	
}
