package com.braker.icontrol.assets.storage.manager.Impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;

@Service
@Transactional
public class AssetStockMngImpl extends BaseManagerImpl<AssetStock> implements AssetStockMng{

	@Override
	public List<AssetStock> findbycode(Storage storage) {
		return null;
		
		/*Finder finder =Finder.create(" From AssetStock where fAssCode='"+storage.getfAssCode()+"'");
		return super.find(finder);*/
	}

	@Override
	public void updateByCode(Regist regist,User user) {
		/*String sql="update T_ASSET_STOCK set F_RESI_NUM=F_RESI_NUM-"+regist.getfInsNum_R()+", F_BEFORE_RESI_NUM=F_BEFORE_RESI_NUM-"+regist.getfInsNum_R()+", F_AFTER_RESI_NUM=F_AFTER_RESI_NUM-"+regist.getfInsNum_R()+" where F_ASS_CODE="+Integer.valueOf(regist.getfAssCode_R());
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();*/
		List<AssetStock> stock = findbycode(regist.getfAssCodeR());
		stock.get(0).setfBeforeRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfRestNum(stock.get(0).getfRestNum()-Integer.valueOf(regist.getfInsNumR()));;
		stock.get(0).setfAfterRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfUpadteUser(user.getAccountNo());
		stock.get(0).setfUpdateTime(new Date());
		super.saveOrUpdate(stock.get(0));
	}

	@Override
	public List<AssetStock> findByfAssCode(List<AssetBasicInfo> li) {
		Finder finder =Finder.create(" FROM AssetStock WHERE fAssCode='"+li.get(0).getfAssCode().trim()+"'");
		return super.find(finder);
	}

	@Override
	public List<AssetStock> findbycode(String code) {
		Finder finder =Finder.create(" From AssetStock where fAssCode='"+code+"'");
		return super.find(finder);
	}

	@Override
	public void updateByCode(ReceList ReceList,User user) {
		List<AssetStock> stock = findbycode(ReceList.getfAssCode_RL());
		stock.get(0).setfBeforeRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfRestNum(stock.get(0).getfRestNum()-Integer.valueOf(ReceList.getfReceNum_RL()));
		stock.get(0).setfAfterRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfUpadteUser(user.getAccountNo());
		stock.get(0).setfUpdateTime(new Date());
		super.saveOrUpdate(stock.get(0));
		
	}

	@Override
	public void updateByCode(Rece rece, User user) {
		/*List<AssetStock> stock = findbycode(rece.getfAssCode_R());
		stock.get(0).setfBeforeRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfRestNum(stock.get(0).getfRestNum()-Integer.valueOf(rece.getfReceNum()));
		stock.get(0).setfAfterRestNum(stock.get(0).getfRestNum());
		stock.get(0).setfUpadteUser(user.getAccountNo());
		stock.get(0).setfUpdateTime(new Date());
		super.saveOrUpdate(stock.get(0));*/
		
	}

	@Override
	public List<AssetStock> find2Condition(String condition1, String val1,String condition2, String val2) {
		Finder finder =Finder.create(" from AssetStock where "+condition1+"='"+val1+"' and "+condition2+"='"+val2+"'");
		return super.find(finder);
	}

	@Override
	public Regist repeatStock(List<Regist> ListCode) {
		//查询物资品目表和库存数量表里的编码
		String sql="select F_ASS_CODE from T_ASSET_STOCK UNION select F_ASS_CODE from T_ASSET_BASIC_INFO ";
		SQLQuery query = getSession().createSQLQuery(sql);
		List<String> StockList = query.list();
		//输入的编码与库存表里的编码进行比较
		for (int i = 0; i < StockList.size(); i++) {
			for (int j = 0; j < ListCode.size(); j++) {
				if(StockList.get(i).equals(ListCode.get(j).getfAssCodeR())){
					return ListCode.get(j);
				}
			}
		}
		return null;
	}



}
