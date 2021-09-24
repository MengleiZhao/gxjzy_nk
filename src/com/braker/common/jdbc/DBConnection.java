package com.braker.common.jdbc;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class DBConnection {

	//数据库驱动程序
	public String dateBaseDriver = "";
	//数据库连接字符串
	public String dbUrl = "";
	//用户名
	public String userName = "";
	//密码
	public String passWord = "";
	
}
