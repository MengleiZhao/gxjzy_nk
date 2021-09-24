package com.braker.icontrol.assets.storage.manager.Impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.assets.storage.manager.RegistMng;
import com.braker.icontrol.assets.storage.model.Regist;

@Service
@Transactional
public class RagistMngImpl extends BaseManagerImpl<Regist> implements RegistMng{

	@Override
	public Pagination findById(String fAssStorageCode_R,Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Regist WHERE fAssStorageCodeR='"+fAssStorageCode_R+"'");
		Pagination p = super.find(finder, pageNo, pageSize);
		List<Regist> regist = (List<Regist>) p.getList();
		for (int i = 0; i < regist.size(); i++) {
			regist.get(i).setfActionDateLIin(DateUtil.formatDate(regist.get(i).getfActionDate()));
		}
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public List<Regist> findByFAssStorageCode_R(String fAssStorageCode_R){
		Finder finder =Finder.create(" FROM Regist WHERE fAssStorageCodeR='"+fAssStorageCode_R+"'");
		return super.find(finder);
	}

	@Override
	public List<Regist> findByfListId(Regist regist) {
		Finder finder =Finder.create(" FROM Regist WHERE fListId="+regist.getfListId());
		return super.find(finder);
	}

	@Override
	public Pagination allRegist(Regist regist,Integer pageNo,Integer pageSize) {
		String sql = "select "
				+ "reg.* "
				+ "from "
				+ "T_ASSET_REGIST_LIST reg,T_ASSET_STORAGE sto "
				+ "where  "
				+ "sto.F_ASS_STORAGE_CODE=reg.F_ASS_STORAGE_CODE "
				+ "and "
				+ "sto.F_FLOW_STAUTS=9";
		
		if(!StringUtil.isEmpty(regist.getfAssCodeR())){
			sql+=" and reg.F_ASS_CODE like '%"+regist.getfAssCodeR()+"%'";
		}
		if(!StringUtil.isEmpty(regist.getfAssNameR())){
			sql+=" and reg.F_ASS_NAME like '%"+regist.getfAssNameR()+"%'";
		}
		//Query query = getSession().createSQLQuery(sql);
		Pagination p =super.findBySql(new Regist(), sql, pageNo, pageSize);
		//List<Object> list = query.list();
		//List<Regist> registList1 = new ArrayList<Regist>();
		/*for (int i = 0; i < list.size(); i++) {
			Regist newRegist =new Regist();
			newRegist.set
		}*/
		
		
		return p;
	}
}
