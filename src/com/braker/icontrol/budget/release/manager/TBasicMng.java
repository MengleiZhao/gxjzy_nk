package com.braker.icontrol.budget.release.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;


/**
 * 基本支出预算指标下达（二下）service
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
public interface TBasicMng extends BaseManager<TBudgetaryIndicBasic>{
	/*
	 * 通过明细ID查找
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 * @param bId 明细主键
	 */
	public TBudgetaryIndicBasic findByBId(Integer bId);
	
	/**
	 * 保存
	 */
	public TBudgetaryIndicBasic save(TBudgetaryIndicBasic bean, User user);

	public float save(String saveType, TBudgetaryIndicBasic bean, User user, String personData, String commData) throws Exception;
}
