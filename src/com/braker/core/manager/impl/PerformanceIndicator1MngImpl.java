package com.braker.core.manager.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PerformanceIndicator1Mng;
import com.braker.core.manager.PerformanceIndicator2Mng;
import com.braker.core.model.PerformanceIndicator1;
import com.braker.core.model.PerformanceIndicator2;

import java.util.List;

@Service
@Transactional
public class PerformanceIndicator1MngImpl extends BaseManagerImpl<PerformanceIndicator1> implements PerformanceIndicator1Mng{

	@Autowired
	private PerformanceIndicator2Mng performanceIndicator2Mng;
	
	@Override
	public Pagination List(PerformanceIndicator1 bean, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM PerformanceIndicator1 WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getfPerCode1())){
			finder.append(" AND fPerCode1 LIKE :fPerCode1");
			finder.setParam("fPerCode1", "%"+bean.getfPerCode1()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfPerName1())){
			finder.append(" AND fPerName1 LIKE :fPerName1");
			finder.setParam("fPerName1", "%"+bean.getfPerName1()+"%");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public List<PerformanceIndicator1> getList() {
		Finder finder=Finder.create(" FROM PerformanceIndicator1 WHERE 1=1");
		return super.find(finder);
	}



	@Override
	public void delete(PerformanceIndicator1 bean) {
		super.delete(bean);
		performanceIndicator2Mng.deleteAll(bean);
	}

}
