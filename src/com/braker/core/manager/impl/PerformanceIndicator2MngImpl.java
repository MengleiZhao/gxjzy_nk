package com.braker.core.manager.impl;

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
public class PerformanceIndicator2MngImpl extends BaseManagerImpl<PerformanceIndicator2> implements PerformanceIndicator2Mng{

	@Override
	public Pagination List(PerformanceIndicator2 bean, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM PerformanceIndicator2 WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getfPerCode2())){
			finder.append(" AND fPerCode2 LIKE :fPerCode2");
			finder.setParam("fPerCode2", "%"+bean.getfPerCode2()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfPerName2())){
			finder.append(" AND fPerName2 LIKE :fPerName2");
			finder.setParam("fPerName2", "%"+bean.getfPerName2()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getfP1()))){
			finder.append(" AND pi1.fPerId1 ="+bean.getfP1());
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void deleteAll(PerformanceIndicator1 bean) {
		Finder finder=Finder.create(" FROM PerformanceIndicator2 WHERE pi1.fPerId1="+bean.getfPerId1());
		List<PerformanceIndicator2> li = super.find(finder);
		for (int i = 0; i < li.size(); i++) {
			super.delete(li.get(i));
		}
		
	}
	
	

	
	@Override
	public java.util.List<PerformanceIndicator2> getList(Integer pi1) {
		Finder finder=Finder.create(" FROM PerformanceIndicator2 WHERE pi1.fPerId1='"+pi1+"'");
		return super.find(finder);
	}

	
}
