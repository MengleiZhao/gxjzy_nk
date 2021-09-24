package com.braker.icontrol.budget.project.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicRenameHistory;

public interface TProBasicRenameHistoryMng  extends BaseManager<TProBasicRenameHistory>{
	/**
	 * 
	* @author:安达
	* @Title: saveHistory 
	* @Description: 新增复核历史记录
	* @param bean
	* @param newName
	* @param user
	* @return void    返回类型 
	* @date： 2019年5月29日下午4:48:56 
	* @throws
	 */
	void saveHistory(TProBasicInfo bean,String newName,User user);
	
	/**
	 * 
	* @author:安达
	* @Title: pageList 
	* @Description: 查询复核历史记录
	* @param bean
	* @param user
	* @param pageNo
	* @param pageSize
	* @return
	* @return Pagination    返回类型 
	* @date： 2019年5月29日下午8:54:39 
	* @throws
	 */
	Pagination pageList(TProBasicRenameHistory bean,User user,  int pageNo, int pageSize);
}
