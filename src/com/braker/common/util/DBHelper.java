package com.braker.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * jdbc连接数据库帮助类
 *
 */
public class DBHelper {
	
	private static final Logger log = LoggerFactory.getLogger(DBHelper.class);
	
	private final static ResourceBundle res = ResourceBundle.getBundle("other_jdbc");
	
	public static Connection getDzzfConn(){
		Connection conn=null;
		try{
			Class.forName(res.getString("dzzf.driverClassName"));
			DriverManager.setLoginTimeout(5);
			conn=DriverManager.getConnection(res.getString("dzzf.url"),res.getString("dzzf.username"),res.getString("dzzf.password"));
		}catch(Exception e){
			log.error("打开电子走访日志数据库失败", e);
			log.error("打开电子走访日志数据库失败。。。");
			System.out.println(e.getMessage());
			System.out.println("打开电子走访日志数据库失败。。。");
		}
		return conn;
	}
	
	public static Connection getDzxcConn(){
		Connection conn=null;
		try{
			Class.forName(res.getString("dzxc.driverClassName"));
			DriverManager.setLoginTimeout(5);
			conn=DriverManager.getConnection(res.getString("dzxc.url"),res.getString("dzxc.username"),res.getString("dzxc.password"));
		}catch(Exception e){
			log.error("打开电子巡查日志数据库失败", e);
			log.error("打开电子巡查日志数据库失败。。。");
			System.out.println(e.getMessage());
			System.out.println("打开电子巡查日志数据库失败。。。");
		}
		return conn;
	}
	
	public static Connection getSftjConn(){
		Connection conn=null;
		try{
			Class.forName(res.getString("sftj.driverClassName"));
			DriverManager.setLoginTimeout(5);
			conn=DriverManager.getConnection(res.getString("sftj.url"),res.getString("sftj.username"),res.getString("sftj.password"));
		}catch(Exception e){
			log.error("打开人民调解数据库失败", e);
			log.error("打开人民调解数据库失败。。。");
			System.out.println(e.getMessage());
			System.out.println("打开人民调解数据库失败。。。");
		}
		return conn;
	}
	
	public static Connection getGridConn(){
		Connection conn=null;
		try{
			Class.forName(res.getString("grid.driverClassName"));
			DriverManager.setLoginTimeout(5);
			conn=DriverManager.getConnection(res.getString("grid.url"),res.getString("grid.username"),res.getString("grid.password"));
		}catch(Exception e){
			log.error("打开网格化数据库失败", e);
			log.error("打开网格化数据库失败。。。");
			System.out.println(e.getMessage());
			System.out.println("打开网格化数据库失败。。。");
		}
		return conn;
	}
	
	public static void closeAll(Connection conn,PreparedStatement pstmt,ResultSet rs){
		if(rs!=null){
			try {
				rs.close(); rs=null;
			} catch (SQLException e) {
				log.error("closeAll", e);
			}
		}
		if(pstmt!=null){
			try {
				pstmt.close();pstmt=null;
			} catch (SQLException e) {
				log.error("closeAll", e);
			}
		}
		if(conn!=null){
			try {
				conn.close(); conn=null;
			} catch (SQLException e) {
				log.error("closeAll", e);
			}
		}
	}
}
