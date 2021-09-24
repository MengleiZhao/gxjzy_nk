package com.braker.icontrol.assets.rece.manager.Impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.icontrol.assets.rece.manager.ReceListMng;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.assets.rece.model.ReceList;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;

@Service
@Transactional
public class ReceListMngImpl extends BaseManagerImpl<ReceList> implements ReceListMng{


	@Override
	public Pagination findByfAssReceCode(String fAssReceCode,Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM ReceList WHERE fAssReceCode_RL='"+fAssReceCode+"'");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public List<ReceList> findAllById(String id) {
		Finder finder=Finder.create(" FROM ReceList WHERE fAssReceCode_RL='"+id+"'");
		return super.find(finder);
	}

	@Override
	public void save(Rece rece,List<ReceList> bean) {
		for (int i = 0; i < bean.size(); i++) {
			bean.get(i).setRece(rece);
			bean.get(i).setfAssReceCode_RL(rece.getfAssReceCode());
			super.merge(bean.get(i));
		}
		
	}
}
