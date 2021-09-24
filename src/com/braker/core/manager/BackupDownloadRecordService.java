package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.BackupDatabase;
import com.braker.core.model.BackupDownloadRecord;
import com.braker.core.model.User;

/**
 * 数据库下载、还原记录 service
 * @author: 焦广兴
 * @Date:2020年7月23日
 */
public interface BackupDownloadRecordService extends BaseManager<BackupDownloadRecord>{
	
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
	public Pagination findList(BackupDownloadRecord bean, User user, String sort, String order, int pageNo, int pageSize) throws Exception;
	
	/**
	 * 保存下载记录
	 * @author  焦广兴
	 * @param bean
	 * @param user
	 * @throws Exception
	 * @Date  2020年7月24日
	 */
	public void saveBackupsRecord(BackupDatabase bean, User user) throws Exception;
	
}
