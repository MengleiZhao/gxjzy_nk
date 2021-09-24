package com.braker.icontrol.expend.apply.manager;

import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.MyAssetsModel;
import com.braker.core.model.RecentlyApplyVoIn;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;

public interface RecentlyApplyMng extends BaseManager<DirectlyReimbAppliBasicInfo>{

	
	//报销最近8笔数据查询
	public List<RecentlyApplyVoIn> getRecentlyApply(ModelMap model,String user,String dName);
	//报销总笔数和总金额查询
	public List<RecentlyApplyVoIn> getCountAndSumApply(ModelMap model,String user,String dName);
	//查询我的资产
	public List<MyAssetsModel> finMyAssets(ModelMap model,String user);
	
	public List<AssetBasicInfo> finRecipientsOfAssets(ModelMap model, String user,String fAssStauts,String fAssCode);
	
	//查询资产个数
	public List<MyAssetsModel> finMyAssetsNumber(ModelMap model, String user);
}
