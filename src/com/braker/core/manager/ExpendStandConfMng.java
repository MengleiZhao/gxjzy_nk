package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.ExpendStandConf;
import com.braker.core.model.User;

public interface ExpendStandConfMng extends BaseManager<ExpendStandConf>{

	/**
	 * 显示主页面数据（包括查询）
	 * @param expendStandConf
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(ExpendStandConf expendStandConf,String sort,String order,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存功能
	 * @param expendStandConf
	 * @param user
	 */
	void save(ExpendStandConf expendStandConf,User user);
	
	/**
	 * 根据id删除
	 * @param id
	 */
	void delete(String id); 
}
