package com.braker.icontrol.assets.storage.manager.Impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
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
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetFlow;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.assets.storage.model.Regist;
import com.braker.icontrol.assets.storage.model.Storage;

@Service
@Transactional
public class AssetBasicInfoMngImpl extends BaseManagerImpl<AssetBasicInfo> implements AssetBasicInfoMng{

	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private AssetFlowMng assetFlowMng; 
	
	
	@Override
	public void save(Regist regist,Storage storage, User user) {
			/*List<AssetBasicInfo> li=new ArrayList<AssetBasicInfo>();
			if(regist!=null){
				if(storage.getfAssType().equals("ZCLX-01")){
					li=findby2Condition("fAssName", regist.getfAssName_R(), "fSPModel", regist.getFmSpecif());
				}else if(storage.getfAssType().equals("ZCLX-02")){
					li=findbycode(regist.getfAssCode_R());
				}
			}else {
				li=findbycode(storage.getfAssCode());
			}
			if(li.size()>0){
				//物资品目表里有这个物资，添加数量
				List<AssetStock> as=assetStockMng.findByfAssCode(li);
				if(as.size()>0){
					if(storage.getfAssType().equals("ZCLX-01")){
						//低值易耗品
						as.get(0).setfBeforeRestNum(as.get(0).getfRestNum());
						as.get(0).setfRestNum(as.get(0).getfRestNum()+Integer.valueOf(regist.getfInsNum_R()));
						as.get(0).setfAfterRestNum(as.get(0).getfRestNum());
						as.get(0).setfUpdateTime(new Date());
						as.get(0).setfUpadteUser(user.getAccountNo());
						super.merge(as.get(0));
					}else if(storage.getfAssType().equals("ZCLX-02")){
						//固定资产
						as.get(0).setfBeforeRestNum(as.get(0).getfRestNum());
						as.get(0).setfRestNum(as.get(0).getfRestNum()+1);
						as.get(0).setfAfterRestNum(as.get(0).getfRestNum());
						as.get(0).setfUpdateTime(new Date());
						as.get(0).setfUpadteUser(user.getAccountNo());
						super.merge(as.get(0));
					}else if(storage.getfAssType().equals("ZCLX-03")){
						//无形资产
						as.get(0).setfBeforeRestNum(as.get(0).getfRestNum());
						as.get(0).setfRestNum(as.get(0).getfRestNum()+1);
						as.get(0).setfAfterRestNum(as.get(0).getfRestNum());
						as.get(0).setfUpdateTime(new Date());
						as.get(0).setfUpadteUser(user.getAccountNo());
						super.merge(as.get(0));
					}
				}else {
					if(storage.getfAssType().equals("ZCLX-01")){
						//低值易耗品
						AssetStock aStock=new AssetStock();
						aStock.setfAssCode(regist.getfAssCode_R());
						aStock.setfBeforeRestNum(0);
						aStock.setfRestNum(Integer.valueOf(regist.getfInsNum_R()));
						aStock.setfAfterRestNum(aStock.getfRestNum());
						aStock.setfUpdateTime(new Date());
						aStock.setfUpadteUser(user.getAccountNo());
						super.merge(aStock);
					}else if(storage.getfAssType().equals("ZCLX-02")){
						//固定资产
						AssetStock aStock=new AssetStock();
						aStock.setfAssCode(regist.getfAssCode_R());
						aStock.setfBeforeRestNum(0);
						aStock.setfRestNum(Integer.valueOf(regist.getfInsNum_R()));
						aStock.setfAfterRestNum(aStock.getfRestNum());
						aStock.setfUpdateTime(new Date());
						aStock.setfUpadteUser(user.getAccountNo());
						super.merge(aStock);
					}else if(storage.getfAssType().equals("ZCLX-03")){
						//无形资产
						AssetStock aStock=new AssetStock();
						aStock.setfAssCode(regist.getfAssCode_R());
						aStock.setfBeforeRestNum(0);
						aStock.setfRestNum(Integer.valueOf(regist.getfInsNum_R()));
						aStock.setfAfterRestNum(aStock.getfRestNum());
						aStock.setfUpdateTime(new Date());
						aStock.setfUpadteUser(user.getAccountNo());
						super.merge(aStock);
					}
				}
			}else if(li.size()<=0){
				//物资品目表里没有这个东西，需要新增一个品目
				if(storage.getfAssType().equals("ZCLX-01")){
					//低值易耗品
					AssetBasicInfo abi=new AssetBasicInfo();
					abi.setfAssCode(String.valueOf(StringUtil.random8()));//物资编号
					abi.setfAssName(regist.getfAssName_R());//物资名称
					abi.setfMeasUnit(regist.getfMeasUnit_R());//计量单位
					abi.setfSPModel(regist.getFmSpecif());
					abi.setfAssType("ZCLX-01");
					abi.setCreateTime(new Date());
					abi.setCreator(user.getAccountNo());
					//资产类型
					Lookups zclsczlx = lookupsMng.findByLookCode("ZCLSCZLX-01");
					Lookups zclx = lookupsMng.findByLookCode("ZCLX-01");
					//添加一条流水记录
					assetFlowMng.addFlow(user, zclsczlx, storage.getfAssStorageCode(), regist.getfAssCode_R(), regist.getfAssName_R(), zclx, regist.getfMeasUnit_R(), Integer.valueOf(regist.getfInsNum_R()));
					AssetStock as=new AssetStock();
					as.setfAssCode(abi.getfAssCode());
					as.setfRestNum(Integer.valueOf(regist.getfInsNum_R()));
					as.setfBeforeRestNum(0);
					as.setfAfterRestNum(Integer.valueOf(regist.getfInsNum_R()));
					as.setfUpadteUser(user.getAccountNo());
					as.setfUpdateTime(new Date());
					super.merge(abi);
					super.merge(as);
					
				}else if(storage.getfAssType().equals("ZCLX-02")){
					
					//固定资产
					AssetBasicInfo abi=new AssetBasicInfo();
					abi.setfAssCode(regist.getfAssCode_R());//物资编号
					abi.setfAssName(regist.getfAssName_R());//物资名称
					abi.setfAssType("ZCLX-02");//物资类型
					abi.setfSPModel(regist.getFmSpecif());
					abi.setfMeasUnit(regist.getfMeasUnit_R());
					abi.setfRemark_ABI(regist.getfRemark_R());
					abi.setCreateTime(new Date());
					abi.setCreator(user.getAccountNo());
					abi.setfOldAmount(Double.valueOf(storage.getfStorageValue()));
					abi.setfAcquisitionDate(storage.getfAcquisitionDate());
					abi.setfWxTime(storage.getFwxTime());
					abi.setfUseName(null);
					//固定资产入库时需要设定一个资产的状态
					Lookups fixeLookup = lookupsMng.findByLookCode("ZCZT-01");
					abi.setfAssStauts(fixeLookup);
					abi.setfUseNameID(null);
					abi.setfUseName(null);
					abi.setfUseDept(null);
					abi.setfUseDeptID(null);
					Lookups zclsczlx = lookupsMng.findByLookCode("ZCLSCZLX-01");
					Lookups	zclx = lookupsMng.findByLookCode("ZCLX-02");
					//添加一条流水记录
					assetFlowMng.addFlow(user, zclsczlx, storage.getfAssStorageCode(), regist.getfAssCode_R(), regist.getfAssName_R(), zclx, regist.getfMeasUnit_R(), Integer.valueOf(regist.getfInsNum_R()));
					AssetStock as=new AssetStock();
					as.setfAssCode(regist.getfAssCode_R());
					as.setfBeforeRestNum(0);
					as.setfRestNum(Integer.valueOf(regist.getfInsNum_R()));
					as.setfAfterRestNum(as.getfRestNum());
					as.setfUpdateTime(new Date());
					as.setfUpadteUser(user.getAccountNo());
					super.merge(abi);
					super.merge(as);
				}else if(storage.getfAssType().equals("ZCLX-03")){
					
					//无形资产
					AssetBasicInfo abi=new AssetBasicInfo();
					abi.setfAssCode(storage.getfAssCode());//物资编号
					abi.setfAssName(storage.getfStorageName());//物资名称
					abi.setfAssType("ZCLX-03");//物资类型
					abi.setfSPModel(storage.getfSpecificationModel());
					abi.setfMeasUnit(storage.getfStorageUnit());
					abi.setfRemark_ABI(storage.getfRemark_S());
					abi.setCreateTime(new Date());
					abi.setCreator(user.getAccountNo());
					abi.setfOldAmount(Double.valueOf(storage.getfStorageValue()));
					abi.setfAcquisitionDate(storage.getfAcquisitionDate());
					abi.setfWxTime(storage.getFwxTime());
					abi.setfUseName(null);
					//设定一个资产的状态
					Lookups iLookup = lookupsMng.findByLookCode("ZCZT-01");
					abi.setfAssStauts(iLookup);
					abi.setfUseNameID(null);
					abi.setfUseDept(null);
					abi.setfUseDeptID(null);
					Lookups zclsczlx = lookupsMng.findByLookCode("ZCLSCZLX-01");
					Lookups	zclx = lookupsMng.findByLookCode("ZCLX-03");
					//添加一条流水记录
					assetFlowMng.addFlow(user, zclsczlx, storage.getfAssStorageCode(), regist.getfAssCode_R(), regist.getfAssName_R(), zclx, regist.getfMeasUnit_R(), Integer.valueOf(regist.getfInsNum_R()));
					
					AssetStock as=new AssetStock();
					as.setfAssCode(storage.getfAssCode());
					as.setfBeforeRestNum(0);
					as.setfRestNum(1);
					as.setfAfterRestNum(as.getfRestNum());
					as.setfUpdateTime(new Date());
					as.setfUpadteUser(user.getAccountNo());
					super.merge(abi);
					super.merge(as);
				}
			}*/
	}


	@Override
	public List<AssetBasicInfo> findbycode(String code) {
		Finder finder =Finder.create(" From AssetBasicInfo where fAssCode='"+code+"'");
		return super.find(finder);
	}


	@Override
	public List<AssetBasicInfo> allAssName(String type) {
		Finder finder =Finder.create(" FROM AssetBasicInfo WHERE 1=1");
		if(!StringUtil.isEmpty(type)){
			finder.append(" AND fAssType=:fAssType");
			finder.setParam("fAssType", type);
		}
		List<AssetBasicInfo> infoList = super.find(finder);
		String codeNumSql="select s.F_ASS_CODE , s.F_RESI_NUM from t_asset_stock s,t_asset_basic_info abi  where s.F_ASS_CODE=abi.F_ASS_CODE group by s.F_ASS_CODE";
		Map<Object,Object> codeNumMap=super.getObjectMap(codeNumSql);
		for (int i = 0; i < infoList.size(); i++) {
			Object stockNum=codeNumMap.get(infoList.get(i).getfAssCode());
			if(stockNum!=null){
				infoList.get(i).setStockNum(Integer.parseInt(stockNum.toString()));
			}else{
				infoList.get(i).setStockNum(0);
			}
		}
		return infoList;
	}
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,SIGNED)");
		return super.find(hql);
	}


	@Override
	public void saveABI(AssetBasicInfo assetBasicInfo,User user) {
		if(StringUtil.isEmpty(String.valueOf(assetBasicInfo.getfAssId()))){
			assetBasicInfo.setCreateTime(new Date());
			assetBasicInfo.setCreator(user.getAccountNo());
		}else{
			assetBasicInfo.setUpdateTime(new Date());
			assetBasicInfo.setCreator(user.getAccountNo());
		}
		super.saveOrUpdate(assetBasicInfo);
	}


	@Override
	public Pagination allStork(AssetBasicInfo ABI, Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM AssetBasicInfo WHERE 1=1 and fAssStauts.code <>'ZCZT-03'");
		if(!StringUtil.isEmpty(ABI.getfAssCode())){
			finder.append(" AND fAssCode LIKE:fAssCode");
			finder.setParam("fAssCode", "%"+ABI.getfAssCode()+"%");
		}
		if(!StringUtil.isEmpty(ABI.getfAssName())){
			finder.append(" AND fAssName LIKE:fAssName");
			finder.setParam("fAssName", "%"+ABI.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(ABI.getfAssType())){
			finder.append(" AND fAssType LIKE:fAssType");
			finder.setParam("fAssType", ABI.getfAssType());
		}
		Pagination p=super.find(finder, pageNo, pageSize);
		List<AssetBasicInfo> li = (List<AssetBasicInfo>) p.getList();
		for (int i = li.size()-1; i >= 0; i--) {
			Finder f =Finder.create(" FROM AssetStock WHERE fAssCode='"+li.get(i).getfAssCode()+"'");
			List<AssetStock> stock = super.find(f);
			if(stock.size()<=0){
				li.remove(i);
			}
		}
		return p;
	}


	@Override
	public Pagination allAss(AssetBasicInfo assetBasicInfo,Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM AssetBasicInfo WHERE 1=1");
		if(!StringUtil.isEmpty(assetBasicInfo.getfAssCode())){
			finder.append(" AND fAssCode LIKE :fAssCode");
			finder.setParam("fAssCode", "%"+assetBasicInfo.getfAssCode()+"%");
		}
		if(!StringUtil.isEmpty(assetBasicInfo.getfAssName())){
			finder.append(" AND fAssName LIKE :fAssName");
			finder.setParam("fAssName", "%"+assetBasicInfo.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(assetBasicInfo.getfAssType())){
			finder.append(" AND fAssType LIKE :fAssType");
			finder.setParam("fAssType", "%"+assetBasicInfo.getfAssType()+"%");
		}
		if(!StringUtil.isEmpty(assetBasicInfo.getfSPModel())){
			finder.append(" AND fSPModel LIKE :fSPModel");
			finder.setParam("fSPModel", "%"+assetBasicInfo.getfSPModel()+"%");
		}
		if(!StringUtil.isEmpty(assetBasicInfo.getfComptySort())){
			finder.append(" AND fComptySort LIKE :fComptySort");
			finder.setParam("fComptySort", "%"+assetBasicInfo.getfComptySort()+"%");
		}
		
		finder.append(" ORDER BY updateTime desc");
		Pagination p=super.find(finder, pageNo, pageSize);
		List<AssetBasicInfo> li=(List<AssetBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			List<AssetStock> stock = assetStockMng.findbycode(li.get(i).getfAssCode());
			li.get(i).setStockNum(stock.get(0).getfRestNum());
		}
		p.setList(li);
		return p;
	}


	@Override
	public List<AssetBasicInfo> findby2Condition(String condition1,String val1, String condition2, String val2) {
		Finder finder =Finder.create(" from AssetBasicInfo where "+condition1+"='"+val1+"' and "+condition2+"='"+val2+"'");
		return super.find(finder);
	}


	@Override
	public Pagination allAllcoa(AssetBasicInfo abi, Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM AssetBasicInfo WHERE 1=1 and fAssStauts.code ='ZCZT-02'");
		if(!StringUtil.isEmpty(abi.getfAssCode())){
			finder.append(" AND fAssCode LIKE:fAssCode");
			finder.setParam("fAssCode", "%"+abi.getfAssCode()+"%");
		}
		if(!StringUtil.isEmpty(abi.getfAssName())){
			finder.append(" AND fAssName LIKE:fAssName");
			finder.setParam("fAssName", "%"+abi.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(abi.getfAssType())){
			finder.append(" AND fAssType LIKE:fAssType");
			finder.setParam("fAssType", abi.getfAssType());
		}
		if(!StringUtil.isEmpty(abi.getfUseNameID())){
			finder.append(" AND fUseNameID LIKE:fUseNameID");
			finder.setParam("fUseNameID", abi.getfUseNameID());
		}
		if(!StringUtil.isEmpty(abi.getAssStauts())){
			finder.append(" AND fAssStauts LIKE:fAssStauts");
			finder.setParam("fAssStauts", abi.getAssStauts());
		}
		Pagination p=super.find(finder, pageNo, pageSize);
		List<AssetBasicInfo> li = (List<AssetBasicInfo>) p.getList();
		for (int i = li.size()-1; i >= 0; i--) {
			Finder f =Finder.create(" FROM AssetStock WHERE fAssCode='"+li.get(i).getfAssCode()+"'");
			List<AssetStock> stock = super.find(f);
			//li.get(i).setStockNum(stock.get(0).getfRestNum());
			List<AssetFlow> assetFlow = assetFlowMng.findbyStockCode(li.get(i).getfAssCode(), "ZCLSCZLX-02");
			if(assetFlow.size()<=0){
				li.remove(i);
			}else {
				li.get(i).setStockNum(assetFlow.get(0).getFlowNum());
			}
		}
		p.setList(li);
		return p;
		
	}


	@Override
	public Pagination maintainchoose(AssetBasicInfo abi, Integer pageNo,Integer pageSize) {
		Finder finder =Finder.create(" FROM AssetBasicInfo WHERE 1=1 and fAssType='ZCLX-02'");
		if(!StringUtil.isEmpty(abi.getfAssCode())){
			finder.append(" AND fAssCode LIKE:fAssCode");
			finder.setParam("fAssCode", "%"+abi.getfAssCode()+"%");
		}
		if(!StringUtil.isEmpty(abi.getfAssName())){
			finder.append(" AND fAssName LIKE:fAssName");
			finder.setParam("fAssName", "%"+abi.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(abi.getfUseNameID())){
			finder.append(" AND fUseNameID LIKE:fUseNameID");
			finder.setParam("fUseNameID", abi.getfUseNameID());
		}
		if(!StringUtil.isEmpty(abi.getAssStauts())){
			finder.append(" AND fAssStauts.code LIKE:fAssStauts");
			finder.setParam("fAssStauts", abi.getAssStauts());
		}
		Pagination p=super.find(finder, pageNo, pageSize);
		return p;
	}
	
	
	

}
