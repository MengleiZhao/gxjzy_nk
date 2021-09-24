package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.BackupDatabase;
import com.braker.core.model.User;

/**
 * 数据库备份 service
 * @author: 焦广兴
 * @Date:2020年7月23日
 */
public interface BackupDatabaseService extends BaseManager<BackupDatabase>{
	
	/**
	 * 获取集合数据
	 * @author  焦广兴
	 * @param bean
	 * @param user
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws Exception
	 * @Date  2020年7月23日
	 */
	public Pagination findList(BackupDatabase bean, User user, String sort, String order, int pageNo, int pageSize) throws Exception;
	
	/**
	 * 备份/还原
	 * @author  焦广兴
	 * @param fileName 还原的文件名称
	 * @param msg 备份描述
	 * @param type 操作类型（BFSJ：备份数据、HYSJ：还原数据、XTBF：系统备份）
	 * @param year
	 * @param user
	 * @throws Exception
	 * @Date  2020年7月23日
	 */
	public void saveBackups(String fileName, String msg, String type, String year, User user) throws Exception;
	
}
