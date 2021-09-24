package com.braker.icontrol.assets.allcoa.manager.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.icontrol.assets.allcoa.manager.AllocaListMng;
import com.braker.icontrol.assets.allcoa.manager.AllocaMng;
import com.braker.icontrol.assets.allcoa.model.Alloca;
import com.braker.icontrol.assets.allcoa.model.AllocaList;

@Service
public class AllocaListMngImpl extends BaseManagerImpl<AllocaList> implements AllocaListMng{

	@Autowired
	private AllocaMng allocaMng;
	
	@Override
	public List<AllocaList> findbyAllocaCode(String allocaCode) {
		Finder finder=Finder.create(" FROM AllocaList WHERE fAssAllocaCode='"+allocaCode+"'");
		return super.find(finder);
	}

	@Override
	public void saveList(Alloca alloca, List<AllocaList> allocaList) {
		alloca=allocaMng.findById(alloca.getfId_A());
		deletebyCode(alloca.getfAssAllcoaCode());
		for (int i = 0; i < allocaList.size(); i++) {
			allocaList.get(i).setAlloca(alloca);
			allocaList.get(i).setfAssAllocaCode(alloca.getfAssAllcoaCode());
			super.saveOrUpdate(allocaList.get(i));
		}
		
	}

	@Override
	public void deletebyCode(String code) {
		String str="DELETE FROM T_ASSET_ALLOCA_LIST where F_ASS_ALLOCA_CODE='"+code+"'";
		getSession().createSQLQuery(str).executeUpdate();
	}

	
	
}
