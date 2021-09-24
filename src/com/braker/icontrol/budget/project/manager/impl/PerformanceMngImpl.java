package com.braker.icontrol.budget.project.manager.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.manager.PerformanceIndicatorModelMng;

/**
 * 项目申报 绩效指标实现类
 * @author 焦广兴
 *
 */

@Service
@Transactional
public class PerformanceMngImpl extends BaseManagerImpl<PerformanceIndicatorModel> implements PerformanceIndicatorModelMng{

	@Override
	public int save(Integer fProId, List<PerformanceIndicatorModel> list) throws Exception {
		//先删除老的绩效
		deleteByProId(fProId);
		//新增新的绩效
		for(PerformanceIndicatorModel bean:list){
			bean.setfProId(fProId);
			this.save(bean);
		}
		return 0;
	}

	/**
	 * 根据项目id删除绩效指标
	 * @param proId
	 */
	private void deleteByProId(Integer proId){
		Query query=getSession().createSQLQuery(" delete from T_PERFORMANCE_INDICATOR where F_PRO_ID="+proId);
		query.executeUpdate();
	}

	@Override
	public List<PerformanceIndicatorModel> getByProId(Integer fProId) {
		Finder finder = Finder.create(" FROM PerformanceIndicatorModel WHERE fProId='"+fProId+"'");
		return super.find(finder);
	}
}
