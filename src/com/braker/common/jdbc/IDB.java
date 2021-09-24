package com.braker.common.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;

public interface IDB {

	public Connection getConnectionByJdbc() throws Exception;
	
	public Connection getConnectionByJNDI() throws Exception;

	public Context getInitalContext() throws Exception;
	
	public void close(Connection conn) throws Exception;
	
	public void close(Statement stmt) throws Exception;

	public void close(ResultSet rs) throws Exception;

	public ResultSet excuteSqlRS(String strSql) throws Exception;

	public Boolean executeSql(String strSql) throws Exception;
}
