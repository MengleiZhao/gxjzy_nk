package com.braker.common.security;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import com.braker.common.util.StringUtil;

/**
 * GW IDEAL
 * @FileName    CodeHelper.java
 * @Author      Wang Hai
 * @Date        2008-11-11
 * @Description 编码帮助类
 */
public class CodeHelper {
	
	private static final String DEF_SEED="wtms";
	/**
	 * 重置密码为"123456"
	 */
	public static final String RESET_PWD="123456";
	
	/**
	 * 重置密码
	 * @return
	 */
	public static String reSetPwd(){
		return encryptPassword(RESET_PWD);
	}
	
	/**
	 * 包装编码
	 * @param source
	 * @return
	 * @throws RuntimeException
	 */
	public static String wrapCode(String source) throws RuntimeException{
		return wrapCode(source,DEF_SEED);
	}
	/**
	 * 包装编码
	 * @param source 要包装的字符串
	 * @param seed 包装时用到的种子，解包时会用到
	 * @return
	 * @throws RuntimeException
	 */
	public static String wrapCode(String source,String seed) throws RuntimeException{
		if(StringUtil.isEmpty(source) || StringUtil.isEmpty(seed))
			throw new RuntimeException("Warp code source is null!");
		
		try {
			return IOHelper.toBase64(IOHelper.xor(IOHelper.zip(source.getBytes("utf-8")),seed));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 解包编码
	 * @param code
	 * @return
	 * @throws RuntimeException
	 */
	public static String parseCode(String code) throws RuntimeException{
		return parseCode(code,DEF_SEED);
	}
	/**
	 * 解包编码
	 * @param code 要解包的编码
	 * @param seed 包装时用到的种子
	 * @return
	 * @throws RuntimeException
	 */
	public static String parseCode(String code,String seed) throws RuntimeException{
		if(StringUtil.isEmpty(code) || StringUtil.isEmpty(seed))
			throw new RuntimeException("Parse code is null!");

		try {
			return new String(IOHelper.unzip(IOHelper.xor(IOHelper.fromBase64(code), seed)),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 对密码进行加密处理，先MD5再Base64
	 * @param password
	 * @return
	 * @throws RuntimeException
	 */
	public static String encryptPassword(String password)throws RuntimeException{
		if(StringUtil.isEmpty(password))
			throw new RuntimeException("Encrypt Password is null!");
		return IOHelper.toBase64Misc(IOHelper.getMD5(password));
	}
	
}
