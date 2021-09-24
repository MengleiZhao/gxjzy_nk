package com.braker.common.jdbc;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.braker.exception.ServiceException;

/**
 * 数据库备份、还原
 * @author: 焦广兴
 * @Date:2020年6月28日
 */
public class BackupDatabaseUtil {
	 
	/**
	 * 数据库备份
	 * @author  焦广兴
	 * @param port 端口地址（localhost）
	 * @param username 用户
	 * @param password 密码
	 * @param databasename 数据库名
	 * @param sqlname 备份文件名称
	 * @throws Exception
	 * @Date  2020年6月28日
	 */
	public static String dataBaseDump(String port, String username, String password, String databasename, String sqlname) throws Exception {
		// mysqldump -h端口号 -u用户 -p密码 数据库 > d:/test.sql --备份D盘
	    File file = new File("D:\\WhxhSql\\");
	    if ( !file.exists() ){
	        file.mkdir();
	    }
	    File datafile = new File(file+File.separator+sqlname+".sql");
	    if( datafile.exists() ){
	        throw new ServiceException("文件名已存在，");
	    }
	    String sql = "cmd /c mysqldump -h"+port+" -u "+username+" -p"+password+" "+databasename+" > "+datafile;
	    System.out.println("------"+sql);
	    //拼接cmd命令
	    Process exec = Runtime.getRuntime().exec(sql);
	    if( exec.waitFor() == 0){
	        System.out.println("数据库备份成功,备份路径为："+datafile);
	        return datafile.toString();
	    }
	    return null;
	}
	
	/**
	 * 数据库还原
	 * @author  焦广兴
	 * @param port 端口地址（localhost）
	 * @param username 用户
	 * @param password 密码
	 * @param databasename 数据库名
	 * @param sqlname 备份文件名称
	 * @throws Exception
	 * @Date  2020年6月28日
	 */
    public static void backup(String port, String username, String password, String databasename, String sqlname) throws Exception {
    	// mysql -h端口号 -u用户 -p密码 数据库 < d:/test.sql 恢复到数据库中
        File datafile = new File("D:\\WhxhSql\\"+sqlname+".sql");
        if( !datafile.exists() ){
            throw new ServiceException(sqlname+"文件不存在。");
        }
        //拼接cmd命令
        Process exec = Runtime.getRuntime().exec("cmd /c mysql -h"+port+" -u "+username+" -p"+password+" "+databasename+" < "+datafile);
        if( exec.waitFor() == 0){
            System.out.println("数据库还原成功，还原的文件为："+datafile);
        }
    }
	
    public static String getFileSize(long fileSize){
		double size=0.0;
		String sizeStr="0";
		String unit="字节";
		if(fileSize>=1024){
			size=fileSize/1024;
			if(size<1024){
				unit="KB";
			}
			if(size>=1024){
				size=size/1024;
				unit="MB";
			}
			if(size>=1024){
				size=size/1024;
				unit="GB";
			}
			DecimalFormat df=new DecimalFormat("#.0");
			sizeStr=df.format(size);
		}else{
			sizeStr=String.valueOf(fileSize);
		}
		return sizeStr+" "+unit;
	}
    
    
	public static void main(String[] args) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
//		String port = "111.202.125.165";
		String port = "172.16.5.35";
		String username = "root";
		String password = "tzzj@001";
//		String databasename = "nkglpt_whxh_shengchan";
		String databasename = "gxjzy_db_dep";
		String sqlname = databasename+sdf.format(new Date());
		try {
			dataBaseDump(port, username, password, databasename, sqlname);
//			backup(port, username, password, databasename, "whxh_kfcs20200710171449");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}




