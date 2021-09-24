package com.braker.common.util;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * 
 * <p>Description: 读取配置文件信息</p>
 * @author:安达
 * @date： 2019年7月2日下午7:03:59
 */
public final class Config {

	private static Log log = LogFactory.getLog(Config.class);

	private Config() {

	}

	
	private static Properties props = new Properties();

	/**
	 * 静态方法块， 服务器启动就读取配置文件信息
	 */
	static  {
		try {
			String path = Config.class.getClassLoader().getResource("").getPath();
			props.load(new FileInputStream(path+"conf.properties"));
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}


	/**
	 * 
	* @author:安达
	* @Title: getBoolean 
	* @Description: 根据键返回布尔类型的值 
	* @param key
	* @return
	* @return boolean    返回类型 
	* @date： 2019年7月2日下午7:05:09 
	* @throws
	 */
	public static boolean getBoolean(String key) {
		String str = Config.getString(key);
		try {
			String tmp = str.toLowerCase();
			if (tmp.equals("true")) {
				return true;
			} else if (tmp.equals("false")) {
				return false;
			} else {
				throw new RuntimeException("class not matching.");
			}
		} catch (Exception e) {
			return false;
		}
	}


	/**
	 * 
	* @author:安达
	* @Title: getInt 
	* @Description: 根据键，返回int类型的值
	* @param key
	* @return
	* @return int    返回类型 
	* @date： 2019年7月2日下午7:06:45 
	* @throws
	 */
	public static int getInt(String key) {
		String str = Config.getString(key);
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 
	* @author:安达
	* @Title: getString 
	* @Description: 根据键，返回String类型的值
	* @param key
	* @param defaultValue
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:07:12 
	* @throws
	 */
	public static String getString(String key, String defaultValue) {

		String tmp = getString(key);
		if (tmp == null) {
			tmp = defaultValue;
		}
		log.debug(key + ": " + tmp);
		return tmp;
	}

	private static String getRealValue(String valueStr) {
		//修改了空指针异常
		if(valueStr!=null){
		String rtnValue = valueStr;
		while (valueStr.indexOf("${") >= 0 && valueStr.indexOf("}") >= 0) {
			String keyName = valueStr.substring(valueStr.indexOf("{") + 1, valueStr.indexOf("}"));
			rtnValue = getString(keyName, "") + valueStr.substring(valueStr.indexOf("}") + 1);
		}
		return rtnValue;
		}else return null;
	}

	public static String getString(String key) {
		String tmp = getRealValue(props.getProperty(key));
		log.debug(key + ": " + tmp);
		return tmp;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getMap 
	* @Description: 返回map集合
	* @return
	* @return Map<String,String>    返回类型 
	* @date： 2019年7月2日下午7:26:48 
	* @throws
	 */
	public static Map<String, String> getMap() {
		Map<String, String> map = new HashMap<String, String>();
		Set<Entry<Object, Object>> entrySet = props.entrySet();
		for (Entry<Object, Object> entry : entrySet) {
			map.put((String) entry.getKey(), (String) entry.getValue());
		}
		return map;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getSet 
	* @Description: 返回set集合 里面装的是key
	* @return
	* @return Set<String>    返回类型 
	* @date： 2019年7月2日下午7:29:34 
	* @throws
	 */
	public static Set<String> getSet(){
		Set<String> set = new HashSet<String>();
		Set<Entry<Object, Object>> entrySet = props.entrySet();
		for (Entry<Object, Object> entry : entrySet) {
			set.add((String) entry.getKey());
		}
		return set;
	}
	
}
