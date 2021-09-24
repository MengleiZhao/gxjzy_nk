package com.braker.icontrol.cgmanage.cgconfplan.mananger.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

@Service
@Transactional
public class CgConPlanListMngImpl extends BaseManagerImpl<ProcurementPlanList> implements CgConPlanListMng{

	@Override
	public List<ProcurementPlanList> findby(String name, String val) {
		Finder finder=Finder.create(" FROM ProcurementPlanList WHERE "+name+"="+val);
		return super.find(finder);
	}

	@Override
	public List<Object> findbyIdAndType(String name, String val,
			String type) {
		Finder finder=Finder.create(" FROM ProcurementPlanList WHERE "+name+"="+val+" and fType="+type);
		List<Object> object = super.find(finder);
		return object;
	}

	@Override
	public List<ProcurementPlanList> findbyIdAndTypes(String name, String val,
			String type) {
		Finder finder=Finder.create(" FROM ProcurementPlanList WHERE "+name+"="+val+" and fIsContract="+type);
		return super.find(finder);
	}

	@Override
	public List<PurchaseApplyBasic> findbyIdPurchase(String id) {
		Finder finder=Finder.create(" FROM PurchaseApplyBasic WHERE fpId = '"+id+"'");
		return super.find(finder);
	}
}
