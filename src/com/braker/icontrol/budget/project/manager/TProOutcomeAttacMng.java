package com.braker.icontrol.budget.project.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProOutcomeAttac;

public interface TProOutcomeAttacMng extends BaseManager<TProOutcomeAttac> {

	/**
	 * 保存支出科目附件
	 * @param files 本地文件列表
	 * @param user 用户
	 * @param project 项目
	 */
	public void saveTProOutcomeAttac(String file, User user, TProBudget budget);
	/**
	 * 保存支出科目附件
	 * @param files 本地文件列表
	 * @param user 用户
	 * @param project 项目
	 */
	public void saveTProOutcomeAttac(String filesStr);
}
