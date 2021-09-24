package com.braker.core.manager.impl;

import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.manager.BackupDownloadRecordService;
import com.braker.core.model.BackupDatabase;
import com.braker.core.model.BackupDownloadRecord;
import com.braker.core.model.User;

@Service
@Transactional
public class BackupDowloadRecordServiceImpl  extends BaseManagerImpl<BackupDownloadRecord> implements BackupDownloadRecordService{
	
	public Pagination findList(BackupDownloadRecord bean, User user, String sort, String order, int pageNo, int pageSize) throws Exception {
		Finder finder = Finder.create("FROM BackupDownloadRecord where 1=1");
		finder.append(" order by fCreateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	@Override
	public void saveBackupsRecord(BackupDatabase bean, User user) throws Exception{
		// 保存记录
		BackupDownloadRecord record = new BackupDownloadRecord();
		record.setfName(bean.getfName());
		record.setfType("download");
		record.setfCreateTime(new Date());
		record.setfCreateUserId(user.getId());
		record.setfCreateUser(user.getName());
		super.save(record);
	}
}
