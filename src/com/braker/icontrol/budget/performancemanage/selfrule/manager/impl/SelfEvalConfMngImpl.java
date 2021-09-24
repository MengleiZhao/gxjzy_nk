package com.braker.icontrol.budget.performancemanage.selfrule.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalConfMng;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;


/**
 *自评配置表的service实现类
 * @author 冉德茂
 * @createtime 2018-08-17
 * @updatetime 2018-08-17
 */
@Service
@Transactional
public class SelfEvalConfMngImpl extends BaseManagerImpl<SelfEvalConf> implements SelfEvalConfMng {
	
	
	/**
	 *根据ftid  查询配置信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@Override
	public SelfEvalConf getConfByFtId(Integer id) {
		Finder finder = Finder.create(" FROM SelfEvalConf WHERE ftId='"+id+"'");
		List<SelfEvalConf> li =  super.find(finder);
		return li.get(0);
	}






}	
	


























	

	



