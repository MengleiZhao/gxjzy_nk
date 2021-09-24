package com.braker.icontrol.budget.performancemanage.selfrule.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;


/**
 * 自评配置表的service
 * @author 冉德茂
 * @createtime 2018-08-17
 * @updatetime 2018-08-17
 */
public interface SelfEvalConfMng extends BaseManager<SelfEvalConf>{

	/**
	 *根据ftid  查询配置信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	public SelfEvalConf getConfByFtId(Integer id);
	

}
