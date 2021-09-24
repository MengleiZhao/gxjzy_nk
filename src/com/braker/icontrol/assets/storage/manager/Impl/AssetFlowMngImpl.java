package com.braker.icontrol.assets.storage.manager.Impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetFlow;

@Service
@Transactional
public class AssetFlowMngImpl extends BaseManagerImpl<AssetFlow> implements AssetFlowMng{

	@Override
	public void addFlow(User user,Lookups fOptType, String flowCode,
			String flowStockCode, String flowAssName, Lookups flowAssType,
			String flowMeasUnit, Integer flowNum) {
		AssetFlow assetFlow=new AssetFlow();
		assetFlow.setfAssetListCode(StringUtil.Random("ZCLS"));
		assetFlow.setfOptType(fOptType);
		assetFlow.setFlowCode(flowCode);
		assetFlow.setFlowStockCode(flowStockCode);;
		assetFlow.setFlowAssName(flowAssName);
		assetFlow.setFlowAssType(flowAssType);
		assetFlow.setFlowMeasUnit(flowMeasUnit);
		assetFlow.setFlowNum(flowNum);
		assetFlow.setFlowTime_F(new Date());
		assetFlow.setFlowDeptName(user.getDepartName());
		assetFlow.setFlowDeptID(user.getDepart().getId());
		assetFlow.setFlowUser(user.getName());
		assetFlow.setFlowUserID(user.getId());
		assetFlow.setCreateTime(new Date());
		assetFlow.setCreator(user.getName());
		save(assetFlow);
	}

	@Override
	public List<AssetFlow> findbyStockCode(String code, String fOptTypeCode) {
		Finder finder=Finder.create("FROM AssetFlow WHERE ");
		finder.append(" flowStockCode = :flowStockCode");
		finder.setParam("flowStockCode", code);
		finder.append(" AND fOptType.code = :fOptType");
		finder.setParam("fOptType", fOptTypeCode);
		return super.find(finder);
	}

	@Override
	public Pagination fixedFlow(AssetFlow assetFlow,AssetBasicInfo assetBasicInfo, User user,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM AssetFlow WHERE flowStockCode='"+assetFlow.getFlowStockCode()+"'");
		if(!StringUtil.isEmpty(assetFlow.getFlowCode())){
			finder.append(" AND flowCode LIKE :flowCode");
			finder.setParam("flowCode", "%"+assetFlow.getFlowCode()+"%");
		}
		if(!StringUtil.isEmpty(assetFlow.getFlowDeptName())){
			finder.append(" AND flowDeptName LIKE :flowDeptName");
			finder.setParam("flowDeptName", "%"+assetFlow.getFlowDeptName()+"%");
		}
		if(!StringUtil.isEmpty(assetFlow.getOptType())){
			finder.append(" AND fOptType.code = :getOptType");
			finder.setParam("getOptType",assetFlow.getOptType());
		}
		finder.append(" ORDER BY flowTime");
		return super.find(finder, pageNo, pageSize);
	}

	
}
