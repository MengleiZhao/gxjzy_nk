package com.braker.icontrol.budget.performancemanage.selfrule.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfProRefMng;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfProRef;


/**
 *自评表和规避项目清单列表的service实现类
 * @author 冉德茂
 * @createtime 2018-08-17
 * @updatetime 2018-08-17
 */
@Service
@Transactional
public class SelfProRefMngImpl extends BaseManagerImpl<SelfProRef> implements SelfProRefMng {
	/*
	 * 根据fcid查询映射信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@Override
	public List<SelfProRef> getRef(Integer id) {
		Finder finder = Finder.create(" FROM SelfProRef WHERE fcId='"+id+"'");
		return super.find(finder);
	}
	
	








}	
	


























	

	



