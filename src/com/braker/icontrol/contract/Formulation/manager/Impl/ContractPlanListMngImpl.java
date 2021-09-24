package com.braker.icontrol.contract.Formulation.manager.Impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.model.ContractPlanList;

/**
 * 合同管理模块中采购明细查询
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class ContractPlanListMngImpl extends BaseManagerImpl<ContractPlanList> implements ContractPlanListMng{

	@Override
	public List<ContractPlanList> findby(String name, String val) {
		Finder finder=Finder.create(" FROM ContractPlanList WHERE "+name+"="+val);
		return super.find(finder);
	}

	@Override
	public List<Object> findbyIdAndType(String name, String val,
			String type) {
		Finder finder=Finder.create(" FROM ContractPlanList WHERE "+name+"="+val+" and fType="+type);
		List<Object> objects =  super.find(finder);
		return objects;
	}

	@Override
	public List<ContractPlanList> findbyIdAndTypes(String name, String val,
			String type) {
		Finder finder=Finder.create(" FROM ContractPlanList WHERE "+name+"="+val+" and fType="+type);
		return super.find(finder);
	}

}
