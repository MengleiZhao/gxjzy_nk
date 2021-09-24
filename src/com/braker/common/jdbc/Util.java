package com.braker.common.jdbc;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {
	
	//日期转换格式[名称勿改]
	public static final SimpleDateFormat sdf1=new SimpleDateFormat("yyyy");
	public static final SimpleDateFormat sdf4=new SimpleDateFormat("yyyyMMdd");
	public static final SimpleDateFormat sdfAll=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	public static SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	public static SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat sdf5=new SimpleDateFormat("yyMMdd");
	public static SimpleDateFormat sdf6=new SimpleDateFormat("yyyyMMdd");
	public static SimpleDateFormat sdf7=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//String s = formatStr("abcdefghijklmn", 4, 2, 5);
		//System.out.println(s);
		//System.out.println(Util.DateParseString(new Date()));
		System.out.println(Util.fomat("000000", 1));
	}

	public static String  DateParseString(Date d){
		return sdf4.format(d);
	}
	
	/***
	 * 将日期转换为字符串
	 * @param d
	 * @return
	 * @author 许冠杰
	 * @update 张强
	 * @修改原因：因新wms支持OracleDB的需要，在转换日期为字符串的时，依据OracleDB规则
	 */
	public static String  DateParxeString(SimpleDateFormat sdf,Date d){
		String date="1900-01-01 00:00:00";
		if(d!=null)
		{
			try
			{
				date=sdf.format(d);
			}
			catch(Exception e)
			{
				System.out.print(d);
				e.printStackTrace();
			}
		}
		return date;
	}

	/**
	 * 将字符串转换为整数，如果不可以转换就返回0
	 * @param String 
	 * @return int
	 * @author 许冠杰
	 */
	public static Integer getNum(String s){
		String matches="[0-9]+";
		Integer num=0;
		if (s.matches(matches)) {
		   num=Integer.parseInt(s);
		}
		return num;
	}

	public static String formatStr(String str, int start, int end, int len) {
		int ret;
		String returnStr = "";
		// int lenth = str.length();
		String s = str.substring(start - 1, start + end - 1);
		try {
			ret = Integer.parseInt(s);
		} catch (Exception e) {
			ret = 0;
			e.printStackTrace();
		}
		String finalStr = (ret + 1) + "";
		if (finalStr.length() < len) {
			for (int i = 0; i < len - finalStr.length(); i++) {
				returnStr += "0";
			}
		}
		return returnStr + finalStr;
	}


	public static String formatStr(String str, int start, int end) {
		String returnStr = "";
		// int lenth = str.length();
		String s = str.substring(start - 1, start + end - 1);

		return s;
	}
	


	public static int strToInt(String str, int start, int length) {
		int intValue = 0;
		String t = str.substring(start - 1, start+length-1);
		try {
			intValue = Integer.parseInt(t);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return intValue;
		}
		return intValue;
	}
	

	public static String operateString(String str,String formatString,String orgId) {
		String returnString="";
		if (str==null||"".equals(str)) {
			returnString=formatString+"00001";
		}else{
			Long i=Long.parseLong(str);
			i=i+1;
			returnString=orgId+String.valueOf(i);
		}
		return returnString;
	}
	
	public static String operateStringpK(String str,String formatString,String orgId){
		String returnString="";
		if (str==null||"".equals(str)) {
			returnString=orgId+formatString+"00001";
		}else{
			Long i=Long.parseLong(str);
			i=i+1;
			returnString=String.valueOf(i);
		}
		return returnString;
	}

	public static String fomat(String pattern, int intValue) {
		String str = null;
		DecimalFormat df = new DecimalFormat(pattern);
		str = df.format(intValue);
		return str;
	}
	
	 /**
	  * @description 判断空串，若为空返回“”
	  * 
	  * @author 胡建全
	  * @date 2011-12-7 下午02:12:12
	  * 
	  */
	public static String isNull(String s){
		String str ="";
		if(s!=null &&! "".equals(s)&&!"null".equals(s)&&!" ".equals(s)){
			str=s;
		}
		return str;
	}
}
