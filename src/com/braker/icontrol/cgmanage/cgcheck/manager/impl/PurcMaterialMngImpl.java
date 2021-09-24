package com.braker.icontrol.cgmanage.cgcheck.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgcheck.manager.PurcMaterialMng;
import com.braker.icontrol.cgmanage.cgcheck.model.PurcMaterialList;

@Service
@Transactional
public class PurcMaterialMngImpl extends BaseManagerImpl<PurcMaterialList> implements PurcMaterialMng{

	@Override
	public Pagination findbyfpId(Integer fpId ,Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" from PurcMaterialList where fpId="+fpId);
		return super.find(finder, pageNo, pageSize);
	}

}
