package com.braker.common.entity;
/**
 * GW IDEAL
 * @FileName    Constant.java
 * @Author      Wang Hai
 * @Date        2008-11-10
 * @Description 常量 
 */
public class Constants {
	/**存储在Session中用户的键值*/
	public static final String CON_SESSION_USER="currentUser";
	
	/**上传文件目录**/
	public static final String UPLOADED_DIR="/uploaded_files/";
	
	/**存储在Session中访问控制管理者的键值*/
	public static final String CON_SESSION_AccessController="ac";
	
	/**全局登录Result**/
	public static final String CON_GLOBAL_LOGIN="login";
	
	/**外网首页**/
	public static final String CON_GLOBAL_WEB_INDEX="webIndex";
	
	/**USBkey登录随机数**/
	public static final String CON_GLOBAL_LOGIN_RNDDATA="randomData";
	
	/**引导树**/
	public static final String CON_TREETYPE_GUIDE="guideTree";
	
	/**参照树**/
	public static final String CON_TREETYPE_REF="refTree";
	
	/**编辑树**/
	public static final String CON_TREETYPE_EDIT="editTree";
	
	/**数据源机构**/
	public static final String BM_DATASOURCE_ORGNO = "001";
	
	/**操作日志动作值在ValueStack中的Key**/
	public static final String ACTIONLOG_PARNAME="actionLogMethod";
	
	/**操作日志动作值-登录**/
	public static final String ACTIONLOG_METHOD_LOGIN = "登录";
	
	/**操作日志动作值-新增**/
	public static final String ACTIONLOG_METHOD_NEW = "新增";
	
	/**操作日志动作值-修改**/
	public static final String ACTIONLOG_METHOD_EDIT = "修改";
	
	/**操作日志动作值-逻辑删除**/
	public static final String ACTIONLOG_METHOD_LOGICDELETE = "逻辑删除";
	
	/**操作日志动作值-物理删除**/
	public static final String ACTIONLOG_METHOD_DELETE = "物理删除";
	
	/**操作日志动作值-消息发送**/
	public static final String ACTIONLOG_METHOD_SEND = "发送";
	
	/**数据库中常量表——常量类型-操作记录**/
	public static final String CONSTANT_TYPE_ACTIONLOG="actionLog";

}

