package com.braker.icontrol.budget.performancemanage.selfrule.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfProRef;


/**
 * 自评表和规避项目清单列表
 * @author 冉德茂
 * @createtime 2018-08-17
 * @updatetime 2018-08-17
 */
public interface SelfProRefMng extends BaseManager<SelfProRef>{

	
	
	/*
	 * 根据fcid查询映射信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	public List<SelfProRef> getRef(Integer id);
	
	

}
