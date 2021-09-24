package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicPlanAttac;

public interface TProBasicPlanAttacMng extends BaseManager<TProBasicPlanAttac>{

	/**
	 * 保存实施方案附件,并上传到ftp服务器
	 * @param filesStr 本地文件列表
	 * @param user 用户
	 * @param project 项目
	 */
	public void saveTProBasicPlanAttac(String filesStr, User user, TProBasicInfo project);
	
	/**
	 * 批量删除附件信息
	 * @param list 要删除的附件信息列表
	 */
	public void batchDelete(List<TProBasicPlanAttac> list);
	
}
