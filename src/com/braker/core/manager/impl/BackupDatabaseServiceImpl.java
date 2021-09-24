package com.braker.core.manager.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.io.Resources;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Decoder;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.jdbc.BackupDatabaseUtil;
import com.braker.common.page.Pagination;
import com.braker.core.manager.BackupDatabaseService;
import com.braker.core.manager.BackupDownloadRecordService;
import com.braker.core.model.BackupDatabase;
import com.braker.core.model.BackupDownloadRecord;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;

@Service
@Transactional
public class BackupDatabaseServiceImpl  extends BaseManagerImpl<BackupDatabase> implements BackupDatabaseService{
	@Autowired
	BackupDownloadRecordService backupDownloadRecordService;
	
	@Override
	public Pagination findList(BackupDatabase bean, User user, String sort, String order, int pageNo, int pageSize) throws Exception {
		Finder finder = Finder.create("FROM BackupDatabase where 1=1");
		if(StringUtils.isNotEmpty(sort)){
			finder.append(" order by "+sort+" "+order+"");
		}else{
			finder.append(" order by fName desc");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void saveBackups(String fileName, String msg, String type, String year, User user) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		Properties props = Resources.getResourceAsProperties("jdbc.properties");
		String url = props.getProperty("jdbc.url");
//		String driver = props.getProperty("jdbc.driverClassName");
		String username = props.getProperty("jdbc.username");
		String password = props.getProperty("jdbc.password");
		BASE64Decoder decoder = new BASE64Decoder();
		password = new String(decoder.decodeBuffer(password));
		
		String[] arr = url.split("\\/");
		String port = arr[2].split("\\:")[0];
		String database = arr[3].split("\\?")[0];
//		Class.forName(driver).newInstance();
//		Connection con = DriverManager.getConnection(url, username, password);
//		DatabaseMetaData md = con.getMetaData();
//		String[] str = md.getUserName().split("@");
		Date date = new Date();
		String sqlName = sdf.format(date);
		if("BFSJ".equals(type) || "XTBF".equals(type)){
			
			BackupDatabase db = new BackupDatabase();
			db.setfCreateTime(date);
			if(user != null){
				db.setfCreateUserId(user.getId());
				db.setfCreateUser(user.getName());
				db.setfYear(year);
			}
			
			db.setfName(sqlName);
			if("XTBF".equals(type)){
				db.setfType("定时备份");
			}else{
				db.setfType("手动备份");
			}
			db.setfDescribe(msg);
			db = (BackupDatabase) super.saveOrUpdate(db);
			
			//备份
			String path = BackupDatabaseUtil.dataBaseDump(port, username, password, database, sqlName);
			if(StringUtils.isNotEmpty(path)){
				File file = new File(path);
				db.setfPath(path);
				String size = BackupDatabaseUtil.getFileSize(file.length());
				db.setfSize(size);
				super.updateDefault(db);
				
			}else{
				throw new ServiceException("备份失败，请联系管理员。");
			}
		}else if("HYSJ".equals(type)){
			// 还原前自动备份一次
			BackupDatabaseUtil.dataBaseDump(port, username, password, database, sqlName+"_hyqbf");
			
			//还原
			BackupDatabaseUtil.backup(port, username, password, database, fileName);
			
			// 保存记录
			BackupDownloadRecord record = new BackupDownloadRecord();
			record.setfName(fileName);
			record.setfType("restore");
			record.setfCreateTime(date);
			record.setfCreateUserId(user.getId());
			record.setfCreateUser(user.getName());
			backupDownloadRecordService.save(record);
			
		}
		
	}
	
}
