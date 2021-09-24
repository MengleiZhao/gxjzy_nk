package com.braker.icontrol.budget.control.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.braker.icontrol.budget.control.entity.TProExpend;

public interface TProExpendMng extends BaseManager<TProExpend> {

	/**
	 * 保存项目支出科目
	 * @param user 用户
	 * @param outcomeList 支出科目列表
	 * @param type 类型 1-今年项目 2-去年项目
	 */
	public void saveProOuts(User user, List<TProExpend> outcomeList);

	/**
	 * 获得控制数下的当年项目支出
	 * @param numId 
	 * @param departName 
	 */
	public List<TProExpend> getYearProOuts(Integer numId, String departName);
	
	/**
	 * 获得控制数下的当年项目支出
	 * @param numId 
	 * @param departName 
	 */
	public List<TProExpend> getLeastProOuts(Integer numId, String departName);
}
