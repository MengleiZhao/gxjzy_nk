package com.braker.common.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BaseDb {

	public static void main(String[] args) {
		
	}
	

	public static Connection getConnectionByJdbc()  {
		
		/*Connection conn = null;
		try {
			if (conn != null && !conn.isClosed()) {
				return conn;
			}
			// 装载驱动类
			Class.forName(Commons.wmsServerDriver);
			// 建立jdbc连接
			conn = DriverManager.getConnection(Commons.wmsServerDBUrl,
					Commons.wmsUserName, Commons.wmsPassWord);

		} catch (Exception e) {
			System.out.println("Connection datebase exception！");
			e.printStackTrace();
		}
		return conn;*/
		
    	return getConnectionByJNDI();
	}
	
	/**
	 * @return
	 * @date 2011-06-08
	 * @author shangws
	 * 使用数据库连接池改善应用服务器与数据库服务器交互瓶颈
	 * @throws SQLException 
	 */
	public static Connection getConnectionByJNDI()
	{
		Context ctx=null;
		DataSource ds=null;
		Connection conn = null;
		try
		{
//			if(poolconn!=null&&!poolconn.isClosed())
//			{
//				return poolconn;
//			}
			
			ctx=getInitalContext();
			//EOSDefaultDataSource,ProductDataSource,dsOracle10g
			ds=(DataSource)ctx.lookup("EOSDefaultDataSource");
			 conn =  ds.getConnection();
			//poolconn=ds.getConnection();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	/**
	 * @return
	 * @throws Exception
	 * @date 2011-06-08
	 * @author shangws
	 * 获取连接上下文
	 */
	public static Context getInitalContext() throws Exception
	{
		//String url="t3://192.168.224.10:7001/";
		//String url="t3://192.168.200.151:7008/";
		String url="t3://192.168.200.136:7001/";
		String user="system";
		String password="eosversion";
		Properties properties=null;
		
		try
		{
			properties=new Properties();
			properties.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
			properties.put(Context.PROVIDER_URL, url);
			if(user!=null)
			{
				properties.put(Context.SECURITY_PRINCIPAL, user);
				properties.put(Context.SECURITY_CREDENTIALS, password==null?"":password);
			}
			return new InitialContext(properties);
		}
		catch(Exception e)
		{
			throw e;
		}
	}

	public static Connection getSqlServerConnectionByJdbc() {

		Connection conn = null;
		try {
			// 装载驱动类
			Class.forName(Commons.sqlServerDriver);
			// 建立jdbc连接
			conn = DriverManager.getConnection(Commons.sqlServerDBUrl,
					Commons.sqlUserName, Commons.sqlPassWord);

		} catch (Exception e) {
			System.out.println("Connection datebase exception！");
			e.printStackTrace();
		}
		return conn;
	}
	
	 /**
	  * @description 获取ERP接口数据库sqlServer2008数据库连接
	  * 
	  * @author 胡建全
	  * @date 2011-10-14 下午09:59:57
	  * 
	  */
	public static Connection getSqlServer2008ConnectionByJdbc() {

		Connection conn = null;
		try {
			// 装载驱动类
			Class.forName(Commons.sql2008ServerDriver);
			// 建立jdbc连接
			conn = DriverManager.getConnection(Commons.sql2008ServerDBUrl,
					Commons.sql2008UserName, Commons.sql2008PassWord);

		} catch (Exception e) {
			System.out.println("Connection ERP_SqlServer2008_datebase exception！");
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
			    conn=null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if (stmt != null)
				stmt.close();
			    stmt=null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
			    rs=null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public static ResultSet excuteSqlRS(String strSql) throws SQLException {
		// TODO Auto-generated method stub
		if (strSql == null || strSql.trim() == "") {
			return null;
		} else {
			ResultSet rs;
			Connection conn = getConnectionByJdbc();
			Statement state;
			try {
				state = conn.createStatement();
				rs = state.executeQuery(strSql);
				return rs;
			} catch (SQLException ex) {
				ex.printStackTrace();
				return null;
			}
		}
	}


	public static Boolean executeSql(String strSql) throws SQLException {
		Connection conn = getConnectionByJdbc();
		Boolean bl = false;
		try {
			Statement stat = conn.createStatement();
			bl = stat.execute(strSql);
			return bl;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return bl;
		}
	}
	
	

}
