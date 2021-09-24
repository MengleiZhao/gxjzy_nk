package com.braker.icontrol.assets.storage.manager.Impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.assets.storage.manager.AssetListMng;
import com.braker.icontrol.assets.storage.model.AssetList;

@Service
@Transactional
public class AssetListMngImpl extends BaseManagerImpl<AssetList> implements AssetListMng{

}
