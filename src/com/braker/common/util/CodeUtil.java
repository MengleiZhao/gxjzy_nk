package com.braker.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 自动生成编码工具类
 * @author 张迅
 *
 */
public class CodeUtil {
	
	
	private static Integer codeNow = null;
	
	public static String getApplyCode(Integer param){
		//项目重启时
		if (codeNow == null) {
			codeNow = param + 1;
		} else {
			codeNow++; 
		}
		//拼接
		String codeStr = String.valueOf(codeNow);
		while (codeStr.length() < 6) {
			codeStr = "0" + codeStr;
		}
		return "SQ" + new SimpleDateFormat("yyyy").format(new Date()) + codeStr;
	}
	
}
