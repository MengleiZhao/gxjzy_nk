package com.braker.icontrol.assets.handle.manager.Impl;

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
import com.braker.icontrol.assets.handle.manager.HandleMng;
import com.braker.icontrol.assets.handle.manager.RegistrationMng;
import com.braker.icontrol.assets.handle.model.AssetRegistration;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetStock;

@Service
@Transactional
public class RegistrationMngImpl extends BaseManagerImpl<AssetRegistration> implements RegistrationMng{

	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private HandleMng handleMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private AssetFlowMng assetFlowMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	
	@Override
	public Pagination registrationList(AssetRegistration assetRegistration,String fAssType, User user,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM AssetRegistration WHERE fRegStauts='1' AND handle.fAssType='"+fAssType+"'");
		return super.find(finder, pageNo, pageSize);
	}

	/*@Override
	public void save(AssetRegistration assetRegistration, User user) {
		//保存处置登记信息
		if(StringUtil.isEmpty(String.valueOf(assetRegistration.getfRegId()))){
			assetRegistration.setCreateTime(new Date());
			assetRegistration.setCreator(user.getAccountNo());
			assetRegistration.setfRegUser(user.getAccountNo());
			assetRegistration.setfRegTime(new Date());
			assetRegistration.setfRegStauts("1");
		}else {
			assetRegistration.setUpdateTime(new Date());
			assetRegistration.setUpdator(user.getAccountNo());
		}
		super.saveOrUpdate(assetRegistration);
		
		//根据传过来的code
		Handle handle = handleMng.findbyCode(assetRegistration.getfAssHandleCode());
		
		//资产流水操作类型
		Lookups zclsczlx = lookupsMng.findByLookCode("ZCLSCZLX-04");
		//资产类型
		Lookups zclx = lookupsMng.findByLookCode("ZCLX-02");
		//资产状态
		Lookups zczt = lookupsMng.findByLookCode("ZCZT-03");
		//添加一条流水记录
		assetFlowMng.addFlow(user, zclsczlx, handle.getfAssHandleCode(), handle.getfAssCode(), handle.getfAssName(), zclx, handle.getfMeasUnit(), Integer.valueOf(handle.getfHandleNum()));
		//更改资产状态为“已处置”
		List<AssetBasicInfo> abi = assetBasicInfoMng.findbycode(handle.getfAssCode());
		abi.get(0).setfAssStauts(zczt);
		abi.get(0).setfUseNameID(null);
		abi.get(0).setfUseName(null);
		abi.get(0).setfUseDept(null);
		abi.get(0).setfUseDeptID(null);
		assetBasicInfoMng.merge(abi.get(0));
		
		
		//处置物资从库存表中减少
		Handle handle = handleMng.findbyCode(assetRegistration.getfAssHandleCode());
		List<AssetStock> stockList = assetStockMng.findbycode(handle.getfAssCode());
		AssetStock stock = stockList.get(0);
		stock.setfBeforeRestNum(stock.getfRestNum());//修改前库存数量
		if(stock.getfRestNum()-Integer.valueOf(handle.getfHandleNum())<=0){
			stock.setfRestNum(0);//现在的库存数量
		}else {
			stock.setfRestNum(stock.getfRestNum()-Integer.valueOf(handle.getfHandleNum()));//现在的库存数量
		}
		stock.setfAfterRestNum(stock.getfRestNum());//变更之后的库存数量
		assetStockMng.merge(stock);
		
	}*/

}
