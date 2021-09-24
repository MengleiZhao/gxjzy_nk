package com.braker.common.web;

/**
 * web常量
 */
public abstract class Constants {
	/**
	 * 路径分隔符
	 */
	public static final String SPT = "/";
	/**
	 * 索引页
	 */
	public static final String INDEX = "index";
	/**
	 * 默认模板
	 */
	public static final String DEFAULT = "default";
	/**
	 * UTF-8编码
	 */
	public static final String UTF8 = "UTF-8";
	/**
	 * 提示信息
	 */
	public static final String MESSAGE = "message";
	/**
	 * cookie中的JSESSIONID名称
	 */
	public static final String JSESSION_COOKIE = "JSESSIONID";
	/**
	 * url中的jsessionid名称
	 */
	public static final String JSESSION_URL = "jsessionid";
	/**
	 * HTTP POST请求
	 */
	public static final String POST = "POST";
	/**
	 * HTTP GET请求
	 */
	public static final String GET = "GET";
	/**
	 * 前台用户session名称
	 */
	public static final String GW_USER="gw_user";
	
	/**
	 * 保存前台用户类别 0产废方 1处置方 2利废方 3第三方
	 */
	public static final String GW_USER_LOGIN_TYPE="LOGIN_TYPE";
	
	/**
	 * 用户审核状态  0false 1true
	 */
	public static final String GW_USER_CHECK_STATUS="CHECK_STATUS";
	
}
