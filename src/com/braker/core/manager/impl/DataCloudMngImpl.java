package com.braker.core.manager.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import jxl.write.DateFormat;

import org.springframework.stereotype.Service;

import com.braker.core.manager.DataCloudMng;

@Service
public class DataCloudMngImpl implements DataCloudMng {

	@Override
	public String doGet(String host, String path, String method,
			Map<String, String> headers, Map<String, String> querys) {
		
		InputStream is = null;
        BufferedReader br = null;
        String result = null;
        HttpURLConnection connection = null;
		
		try {
			//获取请求路径
			String url = host + path + "?";
			//获取请求参数
			for (Map.Entry<String, String> e : querys.entrySet()) {
				if (!"fpdm".equals(e.getKey())) {
					url = url + "&" + e.getKey() + "=" + e.getValue();
				} else {
					url = url + e.getKey() + "=" + e.getValue();
					
				}
			}
			//创建连接
			URL realUrl = new URL(url);
			connection = (HttpURLConnection) realUrl.openConnection();
			connection.setRequestMethod(method);
			//获取请求头
			for (Map.Entry<String, String> e : headers.entrySet()) {
	        	connection.setRequestProperty(e.getKey(),e.getValue());
			}
			//接入接口
			connection.connect();
			
			//获得并返回数据
			if (connection.getResponseCode() == 200) {
                is = connection.getInputStream();
                // 封装输入流is，并指定字符集
                br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                // 存放数据
                StringBuffer sbf = new StringBuffer();
                String temp = null;
                while ((temp = br.readLine()) != null) {
                    sbf.append(temp);
                    sbf.append("\r\n");
                }
                result = sbf.toString();
                /*System.out.println(connection.getResponseCode());
                System.out.println(result);*/
            } else {
            	System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) 
            			+ " 发票查询接口调用出错，错误码：" + connection.getResponseCode());
            }
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				connection.disconnect();
			}
		}
		
		return result;
	
	}

}
