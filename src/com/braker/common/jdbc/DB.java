package com.braker.common.jdbc;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;




public abstract class DB  implements IDB{
	
	private static Logger logger = Logger.getLogger(DB.class); 
	private DBConnection conn=new DBConnection();
	public java.sql.Connection connection=null;
	public Statement state=null;
	public DB(String dbname)
	{
		Document doc=DB.getdbinfo();
		
		XPath xpath = XPathFactory.newInstance().newXPath();
		
		String ppath="//db[@name='"+dbname+"']";
		String cpath;
		try {
			
			cpath=ppath+"/databasedriver";
			this.conn.dateBaseDriver=((Node)xpath.evaluate(cpath, doc, XPathConstants.NODE)).getTextContent();
			
			cpath=ppath+"/dburl";
			this.conn.dbUrl=((Node)xpath.evaluate(cpath, doc, XPathConstants.NODE)).getTextContent();
			
			cpath=ppath+"/username";
			this.conn.userName=((Node)xpath.evaluate(cpath, doc, XPathConstants.NODE)).getTextContent();
			
			cpath=ppath+"/password";
			this.conn.passWord=((Node)xpath.evaluate(cpath, doc, XPathConstants.NODE)).getTextContent();
		} catch (XPathExpressionException e) {
			e.printStackTrace();
		}
	}
	
	public static Document getdbinfo()
	{
//		String path = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/") ;
//		path = path + "WEB-INF\\classes\\com\\commons\\util\\db.xml";
		/*
		 * 因上两行代码有问题，因此做如下修改
		 * --------------------------start-------------------------------
		 */
		Commons cc = new Commons();
		StringBuilder sb = new StringBuilder();
		sb.append(cc.getClass().getResource("/").getPath());
		
		//去掉第一个“/”
		sb.deleteCharAt(0);
		String path = sb.toString();// 获取当前类的绝对路径
		
		path = path + "db.xml";
		/*
		 * --------------------------end---------------------------------
		 */
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		Document document=null;
		try {
		  DocumentBuilder db = dbf.newDocumentBuilder();
		  document = db.parse(new File(path));
		}
		catch(SAXException se) {
		  //解析过程错误
		  Exception e = se;
		  if (se.getException() != null){
		    e = se.getException();
		    e.printStackTrace();
		  }
		}
		catch(ParserConfigurationException pe) {
		  //解析器设置错误
		  pe.printStackTrace();
		}
		catch(IOException ie) {
		  //文件处理错误
		  ie.printStackTrace();
		}
		
		
		return document;
	}
	
	public Connection getConnectionByJdbc()
	{

		try {
			if (this.connection != null && !this.connection.isClosed()) {
				return this.connection;
			}
			// 装载驱动类
			Class.forName(this.conn.dateBaseDriver);
			// 建立jdbc连接
			this.connection = DriverManager.getConnection(this.conn.dbUrl,this.conn.userName, this.conn.passWord);

		} catch (Exception e) {
			System.out.println("Connection datebase exception！");
			e.printStackTrace();
		}
		return this.connection;

	}
	
	public Connection getConnectionByJNDI()
	{
		Context ctx=null;
		DataSource ds=null;
		Connection conn = null;
		try
		{
			
			ctx=getInitalContext();
			ds=(DataSource)ctx.lookup("EOSDefaultDataSource");
			conn =  ds.getConnection();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	public Context getInitalContext() throws Exception
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


	public void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void close(Statement stmt) {
		try {
			if (stmt != null)
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void close(ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ResultSet excuteSqlRS(String strSql) throws SQLException {
//		String classpath="";
//		classpath=this.getClass().getResource("").getPath(); 

		if (strSql == null || strSql.trim() == "") {
			return null;
		} else {
			ResultSet rs= null;
			Connection conn = getConnectionByJdbc();
			try {
				this.state = conn.createStatement();
				rs = this.state.executeQuery(strSql);
				return rs;
			} catch (SQLException ex) {
				logger.error("操作数据库异常："+strSql, ex);
				ex.printStackTrace();
				return null;
			}
			//update by hujq 关闭之后会在程序中出现关闭数据集的异常，修改为在程序中关闭
//			finally
//			{
////				close(this.state);
//			}
		}
	}

	public Boolean executeSql(String strSql) throws SQLException {
		Connection conn = getConnectionByJdbc();
		Boolean bl = false;
		Statement stat = null;
		try {
			stat = conn.createStatement();
			bl = stat.execute(strSql);
			bl=true;
		} catch (SQLException e) {
			bl=false;
			e.printStackTrace();
			throw e;
		}
		finally
		{
			close(stat);
		}
		return bl;
	}
	
	public Boolean executeSql(List<String> sqls) throws SQLException {
		Connection conn = getConnectionByJdbc();
		Boolean bl = false;
		Statement stat = null;
		try {
			stat = conn.createStatement();
			for(String s:sqls)
			{
				if(s!=null)
					bl = stat.execute(s);
			}
			stat.executeBatch();
			conn.commit(); 
			bl=true;
		} catch (SQLException e) {
			bl=false;
			e.printStackTrace();
			throw e;
		}
		finally
		{
			close(stat);
		}
		return bl;
	}
}
