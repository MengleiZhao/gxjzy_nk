package com.braker.common.jdbc;

public class Commons {

	//数据库驱动程序
	public static final String dateBaseDriver = "oracle.jdbc.driver.OracleDriver";
	//数据库连接字符串
	//public static final String oracleUrl = "jdbc:oracle:thin:@192.168.224.10:1521:orcl";
	//public static final String oracleUrl = "jdbc:oracle:thin:@192.168.200.12:1521:orcl";
	public static final String oracleUrl = "jdbc:oracle:thin:@192.168.200.136:1521/wms";
	//用户名
	public static final String userName = "orawms";
	//密码
	public static final String passWord = "orawms";
	
	
	
	public static final String sqlServerDriver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
	
	public static final String sqlServerDBUrl = "jdbc:sqlserver://192.168.11.1:1433; DatabaseName=wmsinterface;SelectMethod=cursor;";
	
	public static final String sqlUserName = "sa";
	
	public static final String sqlPassWord ="dxynt"; 
	
	public static final String sql2008ServerDriver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	
	public static final String sql2008ServerDBUrl = "jdbc:sqlserver://192.168.224.200:1433; DatabaseName=wms_his;SelectMethod=cursor;";
	
	public static final String sql2008UserName = "sa";
	
	public static final String sql2008PassWord = "sys++--2011";
	
	public static final String wmsServerDriver = "oracle.jdbc.driver.OracleDriver";
	
	public static final String wmsServerDBUrl = "jdbc:oracle:thin:@192.168.200.136:1521/wms";
	//public static final String wmsServerDBUrl = "jdbc:oracle:thin:@192.168.224.20:1521:orcl";
	//public static final String wmsServerDBUrl = "jdbc:oracle:thin:@192.168.200.151:1521:orawms";
	
	public static final String wmsUserName = "orawms";
	
	public static final String wmsPassWord = "orawms";
	
    /*public static final String wmsServerDBUrl = "jdbc:oracle:thin:@192.168.226.184:1521:hrlnwms";
	
	public static final String wmsUserName = "ORAWMS";
	
	public static final String wmsPassWord = "ORAWMS";*/

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	}

}
