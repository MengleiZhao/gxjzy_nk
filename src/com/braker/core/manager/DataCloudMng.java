package com.braker.core.manager;

import java.util.Map;

/**
 * 云数据接口
 * @author 张迅
 * @createtime 2019-03-22
 */
public interface DataCloudMng {

	/**
	 * 调用接口方法
	 * @param host 域名
	 * @param path 路径
	 * @param method get/post方法
	 * @param headers 请求头
	 * @param querys 请求参数
	 * @return json字符串
	 */
	public String doGet(String host, String path, String method, Map<String, String> headers, 
			Map<String, String> querys);
}
