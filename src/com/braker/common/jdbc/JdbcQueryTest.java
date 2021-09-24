package com.braker.common.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

/**
 * 该类用于测试jdbc连接池
 * @author 张强
 */
public class JdbcQueryTest {
	/*
	 * 新增
	 */
	public boolean insertInfo(ApplicationDB db) {
		boolean bool = false;
		
		String sql = ("insert into T_JDBC_TSET values(3,'XX','女','20') ");

		Connection con = null;
		try {

			con = db.getConnectionByJdbc();
			Statement st = con.createStatement();

			st.execute(sql);
			bool = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			db.close(db.state);
			db.close(db.connection);
		}
		return bool;
	}

	/*
	 * 修改
	 */
	public boolean updateInfo(ApplicationDB db) {
		boolean bool = false;
		String sql = ("update T_JDBC_TSET set f_age = '3' where f_id = 2 ");

		Connection con = null;
		try {

			con = db.getConnectionByJdbc();
			Statement st = con.createStatement();

			st.execute(sql);
			bool = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			db.close(db.state);
			db.close(db.connection);
		}
		return bool;
	}

	/*
	 * 删除
	 */
	public boolean deleteInfo(ApplicationDB db) {
		boolean bool = false;
		String sql = ("delete T_JDBC_TSET where f_id = 3 ");

		Connection con = null;
		try {

			con = db.getConnectionByJdbc();
			Statement st = con.createStatement();

			st.execute(sql);
			bool = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			db.close(db.state);
			db.close(db.connection);
		}
		return bool;
	}


	/*
	 * 查询
	 */
	public List selectInfo(ApplicationDB db, String f_dept_code) {
		List list = new ArrayList();
		String f_index = "";
		String sql = "select sms_id from test_yc";
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			con = db.getConnectionByJdbc();
			st = con.createStatement();
			rs = db.excuteSqlRS(sql);
			while (rs.next()) {
				// 获取用户的名称
				f_index = rs.getString("sms_id");
				list.add(f_index);
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			db.close(rs);
			db.close(db.state);
			db.close(db.connection);
		}
		return list;
	}

	/*
	 * 调用测试类
	 */
	public static void main(String[] args) {
		JdbcQueryTest qt = new JdbcQueryTest();
		// 获取数据源
		ApplicationDB db = new ApplicationDB("dh");
		
//		qt.insertInfo(db);
//		qt.updateInfo(db);
//		qt.deleteInfo(db);
		
		List list = new ArrayList();
		list = qt.selectInfo(db, "7220");
		System.out.println(list.get(0));
	}
}
