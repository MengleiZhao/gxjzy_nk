package com.braker.common.util.redis;


/**
 * 记录redis所有的key，所有的rediskey全部都要这里备案，请大家描述每个key用来存储什么对象信息
 * @author 安达
 * @createtime 2018-11-07
 * @updatetime 2018-11-07
 */
public class RedisConstantsKeys {
	public static String HGET_KEY="HGET_";  //测试的key， 获取map集合 ,以hget开头的，存入的是map
	public static String GET_KEY="GET_";  //测试的key，获取string字符。以get开头的，存入的是一个值
	public static String GET_USER_KEY="GET_USER_";  //用户对象的key
	public static String GET_USER_FUNCTION_LIST_KEY="GET_USER_FUNCTION_LIST_";  //用户的权限的集合
}
