package com.braker.common.util;
/**
 * StringUtil - String utility class
 */

/* ToDo
 * ====
 * replace(String, String, String) method
 *  Explore indexing the replaces and allocating a buffer of exactly the right size.
 *  Explore using String.substring rather than String.toCharArray() if
 *   a small number of large sections are being replaced.
 * Search
 *  Simple wildcarded search...
 * Replace
 *  replace(String, char, char) 
 *  replace(String, char[], char[]) 
 *  replace(String, String[], String[])
 *  Simple wildcarded search and replace (# and *)...
 * Stripping
 *  stripTrailingWhitespace
 *  stripLeadingWhitespace
 *  stripSurroundingingWhitespace
 *  stripAllSpaces
 * Padding
 *  padLeft(java.lang.String s, int length)
 *  padRight(java.lang.String s, int length)
 *  center(java.lang.String s, int length)
 * Misc
 *  repeat(String s, int n)
 *  reverse(String)
 *  rot13(String)
 *  boolean isValidEmail(String email_address)
 *  concat(Object[] objects, String separator)
 *  String split(String list, String separator) - version of the JDK method that allows null strings...
 *  distance(String, String) - calculates hamming distance
 *  count(String string, String search)
 *
 * Notes
 * =====
 * This class amy contain some "junk" methods.
 * I use an automated tool that rips out any unused
 *  methods, so this is not a concern to me.
 * Use of new StringBuffer(string) wastes 16 bytes - use StringBuffer(String, int) instead when it arrives...
 *
 */

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

public class StringUtil {
	
	/**
	 * 删除文件夹
	 * @return
	 */
	public static void deleteDirectory(File file) {
		if(!file.exists()) return;
		
		if(file.isFile() || file.list()==null) {
			file.delete();
		}else {
			File[] files = file.listFiles();
			for(File a:files) {
				deleteDirectory(a);					
			}
			file.delete();
		}
		
	}
	
	/**
	 * 转换编码格式
	 * @return
	 */
	public static String setUTF8(String s){
		try {
			if (s != null) {
				s=new String(s.getBytes("ISO-8859-1"),"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			return s;
		}
    
	/**
	 * 随机生成8位数
	 * @return
	 */
	public static Integer random8(){
		SimpleDateFormat format = new SimpleDateFormat("HHmmss"); 
		long date = new Date().getTime();
		String r=String.valueOf((Math.random()*9+1)*10);
		String r1=r.substring(0, 2);
		String number =format.format(date)+r1;
		Integer num=Integer.valueOf(number);
		return num;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getSelfIdByUUId 
	* @Description: 生成编码
	* @return
	* @return String    返回类型 
	* @date： 2019年6月17日上午9:22:05 
	* @throws
	 */
	public static String getSelfIdByUUId() {
		int hashCodeV = UUID.randomUUID().toString().hashCode();
		if(hashCodeV < 0) {//有可能是负数
		hashCodeV = - hashCodeV;
		}
		return  String.format("%08d", hashCodeV);
	}
	
	/**
	 * 生成一个格式：（输入+年月日时分秒+随机4位数）的编码
	 * @param str
	 * @return
	 */
	public static String Random(String str){
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss"); 
		long date = new Date().getTime();
		String r=String.valueOf((Math.random()*9+1)*1000);
		String r1=r.substring(0, 4);
		String data =str+format.format(date)+r1;
		return data;
	}
	
	/**
	 * 取YYYYMMDD格式日期字符串
	 * @param date
	 * @return
	 */
	public static String getYYYYMMDDDate(String date){
		if(!StringUtil.isEmpty(date)){
			date=date.replace("-", "");
			date=date.replace("/", "");
			date=date.replace(".", "");
		}
		return date;
	}
	
	/**
	 * 生成一个java的UUID,长度为32没有中划线
	 * @return
	 */
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-","").toUpperCase();
	}
	
	/**
	 * X轴-list转string(只显示月份)
	 * @param list
	 * @return
	 */
	public static String listToStringXaxis(List<String> list){
		StringBuffer s=new StringBuffer();
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				s.append("'"+list.get(i).substring(5,list.get(i).length())+"'");
				if(i!=t-1){
					s.append(",");
				}
			}
		}
		return s.toString();
	}
	/**
	 * X轴-list转string(显示年度、月份)
	 * @param list
	 * @return
	 */
	public static String listToStringXaxisWithYear(List<String> list){
		StringBuffer s=new StringBuffer();
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				s.append("'"+list.get(i)+"'");
				if(i!=t-1){
					s.append(",");
				}
			}
		}
		return s.toString();
	}
	
	/**
	 * list转string
	 * @param list
	 * @return
	 */
	public static String listToString(List<String> list){
		StringBuffer s=new StringBuffer();
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				s.append("'"+list.get(i)+"'");
				if(i!=t-1){
					s.append(",");
				}
			}
		}
		return s.toString();
	}
	
	/**
	 * 格式化银行帐号
	 * @param bankNo 帐号
	 * @param divide 按几位分割
	 * @param divideSymbol 分割符号
	 * @return
	 */
	public static String formatBankNo(String bankNo,int divide,String divideSymbol){
		StringBuffer s=new StringBuffer("");
		if(!isEmpty(bankNo)){
			if(divide>bankNo.length()){
				return bankNo;
			}
			int t=bankNo.length()/divide;
			int m=bankNo.length()%divide;//取模
			if(m>0){t=t+1;}//大于0说明需要多循环一次
			for (int i=1;i<=t;i++) {
				if(i==1){
					s.append(bankNo.substring((i-1)*divide,i*divide));
				}else{
					if(i==t){
						s.append(divideSymbol+bankNo.substring((i-1)*divide,bankNo.length()));
					}else{
						s.append(divideSymbol+bankNo.substring((i-1)*divide,i*divide));
					}
				}
			}
		}
		return s.toString();
	}
	
    /**
     * 判断类型为start-end的字符串，是否有start字符�?

     * 没有start字符串：-08/11/23
     * 主要用于ECTable中日期Filter的格式判�?

     * @param str 08/11/22-08/11/23
     * @return
     */
    public static boolean hasStart(String str)
    {
    	if(isEmpty(str))
    		return false;
    	else
    	{
    		String[] within = str.split("-");
    		if(within.length > 0 && !isEmpty(within[0]))
    			return true;
    		else
    			return false;
    	}	
    }
    
    /**
     * 判断类型为start-end的字符串，是否有end字符�?

     * 没有end字符串：08/11/22-,08/11/22
     * 主要用于ECTable中日期Filter的格式判�?

     * @param str 08/11/22-08/11/23
     * @return
     */
    public static boolean hasEnd(String str)
    {
    	if(isEmpty(str))
    		return false;
    	else
    	{
    		String[] within = str.split("-");
    		if(within.length > 1 && !isEmpty(within[1]))
    			return true;
    		else
    			return false;
    	}	
    }
    
//  字符串如果是null则转化成空字符串，�?�不是空指针
    public static String toStr(String str)
    {  
   	 if(str==null)
   	 {
   		str="";
   	 }
   	 return str;
    }
 //判断字符串是否为�?
    
    public static boolean isEmpty(String str)
    {  
   	 if(toStr(str).replace(" ", "").equals("") || "null".equalsIgnoreCase(str))
   	 {
   		 return true;
   	 }else
   		 return false;
    }
    
    public static int stringToInt(String str){
    	int t=0;
    	if(!isEmpty(str)){
    		try {
    			t=Integer.valueOf(str);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
    	}
    	return t;
    }
    
    //将绝对�?�小�?1的数字型字符串输出成0.**的形�?

     public static String   stringValue(String str)
     {  
    	 if(StringUtil.ifNum(str))
         {  if(!StringUtil.ifInt(str)&&new Double(str).doubleValue()<1&&new Double(str).doubleValue()>-1)
             {
         		str=StringUtil.doubleValue(new Double(str).doubleValue());
             }
 	        else
 	        {
 	        	//System.out.println("整数==="+str);
 	        }
         }else 
         {
         	//System.out.println("非数�?");
         }
    	 return str;
     }
     //判断�?个字符串是否是数�?

    public static boolean ifNum(String str)
    {
    	boolean bool=false;
    	try
    	{
    		new Integer(str).intValue();
    		return true;
    	}catch(NumberFormatException e)
    	{
    		return false;
    	}
    }
//  判断�?个字符串是否是整�?

    public static boolean ifInt(String str)
    {
    	boolean bool=false;
    	if(StringUtil.ifNum(str))
    	{
    		String[] strs=StringUtil.split(str,".");
    		//System.out.println("strs.length=="+strs.length);
    		if(strs.length==2)
    		{
    			bool=false;
    		}else if(strs.length==1)
    		{
    			strs=StringUtil.split("+"+str,".");
    			if(strs.length==2)
        		{
        			bool=false;
        		}else
        		{
        			bool=true;
        		}
    		}else
    		{
    			bool=true;
    		}
    	}
    	return bool;
    }
    
    //将小数的小数位只保留�?�?

    public static String doubleValue(double d)
    {
    	String changedstr="";
    	String formatStr="#0.";
    	String tempStr=d+"";
    	
    	for(int i=0;i<getDecimalLenth(tempStr);i++)
    	{
    		formatStr+="0";
    	}
    	
    	//System.out.println("formatStr=="+formatStr);
    	java.text.DecimalFormat   df   =   new   java.text.DecimalFormat(formatStr); 
    	changedstr=df.format(d);
    	return changedstr;
    }
    
    //得到小数的位�?

    public static int getDecimalLenth(String str)
    {
    	int length=0;
    	String[] strs=StringUtil.split(str,".");
    	//System.out.println("getDecimalLenth=String[]="+strs.length);
    	if(strs.length==2)
    	{
    		length=strs[1].length();
    	}
    	return length;
    }
    public static String encodeHtml(String original) {
        StringBuffer sb = new StringBuffer();
        int len = original.length();
        for (int i = 0; i < len; i++) {
            char c = original.charAt(i);
            switch (c) {
                default :
                    sb.append(c);
                    break;
                case '<' :
                    sb.append("&lt;");
                    break;
                case '>' :
                    sb.append("&gt;");
                    break;
                case '&' :
                    sb.append("&amp;");
                    break;
                case '"' :
                    sb.append("&quot;");
                    break;
                case '\'' :
                    sb.append("&apos;");
                    break;
            }
        }
        return sb.toString();
    }
    public static String xmlStringFilter(String str) throws Exception {
        StringBuffer sb = new StringBuffer();
        int len = str.length();
        for (int i = 0; i < len; i++) {
            char c = str.charAt(i);
            switch (c) {
                default :
                    sb.append(c);
                    break;
                case '<' :
                    sb.append("&lt;");
                    break;
                case '>' :
                    sb.append("&gt;");
                    break;
                case '&' :
                    sb.append("&amp;");
                    break;
                case '"' :
                    sb.append("&quot;");
                    break;
                case '\'' :
                    sb.append("&apos;");
                    break;
            }
        }
        return sb.toString();
    }
    /**
     * Return a String with all occurrences of the "from" String
     * within "original" replaced with the "to" String.
     * If the "original" string contains no occurrences of "from",
     * "original" is itself returned, rather than a copy.
     *
     * @param original the original String
     * @param from the String to replace within "original"
     * @param to the String to replace "from" with
     *
     * @returns a version of "original" with all occurrences of
     * the "from" parameter being replaced with the "to" parameter.
     */
    public static String replace(String original, String from, String to) {
        return replace(original, from, to, Integer.MAX_VALUE);
    }
    public static String replace(String original, String from, String to, int times) {
        return replace(original, from, to, times, 0);
    }
    public static String replace(String original, String from, String to, int times, int startpos) {
        int from_length = from.length();

        if (from_length != to.length()) {
            if (from_length == 0) {
                if (to.length() != 0) {
                    throw new IllegalArgumentException("Replacing the empty string with something was attempted");
                }
            }

            int start = original.indexOf(from, startpos);

            if (start == -1) {
                return original;
            }

            char[] original_chars = original.toCharArray();

            StringBuffer buffer = new StringBuffer(original.length());

            int copy_from = 0;
            int reptimes = 0;
            int usertypeoffset = 0; //if string:update aa set aa='$',$->null then update aa set aa=null '$'->null
            while (start != -1 && reptimes < times) {
                if (from.equals("$")
                    && to.equals("null")
                    && original_chars[start - 1] == '\''
                    && original_chars[start + 1] == '\'')
                    usertypeoffset = 1;
                buffer.append(original_chars, copy_from, start - copy_from - usertypeoffset);
                buffer.append(to);
                copy_from = start + usertypeoffset + from_length;
                start = original.indexOf(from, copy_from);
                reptimes++;
            }

            buffer.append(original_chars, copy_from, original_chars.length - copy_from);

            return buffer.toString();
        } else {
            if (from.equals(to)) {
                return original;
            }

            int start = original.indexOf(from, startpos);

            if (start == -1) {
                return original;
            }

            StringBuffer buffer = new StringBuffer(original);

            // Use of the following Java 2 code is desirable on performance grounds...

            /* 
            // Start of Java >= 1.2 code...
               while (start != -1) {
                  buffer.replace(start, start + from_length, to);
                  start = original.indexOf(from, start + from_length);
               }
            // End of Java >= 1.2 code...
            */

            // The *ALTERNATIVE* code that follows is included for backwards compatibility with Java 1.0.2...

            // Start of Java 1.0.2-compatible code...
            char[] to_chars = to.toCharArray();
            int reptimes = 0;
            while (start != -1 && reptimes < times) {
                for (int i = 0; i < from_length; i++) {
                    buffer.setCharAt(start + i, to_chars[i]);
                }

                start = original.indexOf(from, start + from_length);
                reptimes++;
            }
            // End of Java 1.0.2-compatible code...

            return buffer.toString();
        }
    }

    /**
     * Return a String with all occurrences of the "search" String
     * within "original" removed.
     * If the "original" string contains no occurrences of "search",
     * "original" is itself returned, rather than a copy.
     *
     * @param original the original String
     * @param search the String to be removed
     *
     * @returns a version of "original" with all occurrences of
     * the "from" parameter removed.
     */
    public static String remove(String original, String search) {
        return replace(original, search, "");
    }

    /**
     * Return the first String found sandwiched between
     * "leading" and "trailing" in "string", or null if
     * no such string is found.
     *
     * @param string the original String
     * @param leading the String to replace within "original"
     * @param trailing the String to replace "from" with
     *
     * @returns the first String sandwiched between
     * "leading" and "trailing" in "string" - or null if
     * no such string is found.
     */
    public static String getSandwichedString(String string, String leading, String trailing) {
        int i_start = string.indexOf(leading);

        if (i_start < 0) {
            return null;
        }

        i_start += leading.length();

        int i_end = string.indexOf(trailing, i_start);

        if (i_end < 0) {
            return null;
        }

        return string.substring(i_start, i_end);
    }

    /**
     * Takes a list of objects and concatenates the toString()
     * representation of each object and returns the result.
     *
     * @param objects an array of objects
     *
     * @returns a string formed by concatenating string
     * representations of the objects in the array.
     */
    static public String objArraytoString(Object[] objects) {
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < objects.length; i++) {
            buffer.append(objects[i].toString());
        }

        return buffer.toString();
    }

    /**
     * Creates a string of length "length" composed of the character "c",
     * or the null string if c <= 0.
     *
     * @param length the length of the returned string
     * @param c the character is solely consists of
     *
     * @returns a string of length "length" composed of the character "c".
     */
    public static String fill(char c, int length) {
        if (length <= 0) {
            return "";
        }

        char[] chars = new char[length];
        for (int i = 0; i < length; i++) {
            chars[i] = c;
        }

        return new String(chars);
    }

    /**
      * Return true if  "string" contains "find".
      *
      * @param string the string whose contents are searched
      * @param find the string to be located as a substring
      *
      * @returns true if  "string" contains "find".
      */
    public static boolean contains(String string, String find) {

        return (string.indexOf(find) >= 0);
    }

    /**
     * Return reversed version of "string".
     *
     * @param string the string to be reversed
     * @param find the string to be located as a substring
     *
     * @returns reversed version of "string"
     */
    public static String reverse(String string) {
        return new StringBuffer(string).reverse().toString();
    }

    /**
     * if str is null return ""
     * else return str
     * Method convertNulltoEmpty.
     * @param str the orginal string
     * @return String 
     */
    public static String convertNulltoEmpty(String str) {
        if (str == null)
            return "";
        else
            return str;
    }
    /**
     * �?测是否是�?个有效的字符，即不为null也不�?""
     * @param str
     * @return
     */
    public static boolean isValid(String str) {
        if (str == null)
            return false;
        else if ("".equals(str))
            return false;
        else
            return true;
    }

    /**
     * 用于替代jdk1.4以下的版本中的string.split方法
     * @return
     */
    public static String[] split(String orgstr) {

        StringTokenizer tokenizer = new StringTokenizer(orgstr, ",");
        String[] retstr = new String[tokenizer.countTokens()];
        int i = 0;
        while (tokenizer.hasMoreElements()) {
            retstr[i] = tokenizer.nextToken();
            i++;
        }
        return retstr;
    }
    public static String[] split(String orgstr,String opera) {

        StringTokenizer tokenizer = new StringTokenizer(orgstr, opera);
        String[] retstr = new String[tokenizer.countTokens()];
        int i = 0;
        while (tokenizer.hasMoreElements()) {
            retstr[i] = tokenizer.nextToken();
            i++;
        }
        return retstr;
    }
    /**
     * �?测是否是�?个有效的字符，即不为null也不�?""
     * @param str
     * @return
     */
    public static boolean isValid(String[] str) {
        if (str == null)
            return false;
        for (int i = 0; i < str.length; i++) {

            if (isValid(str[i]))
                return true;
        }
        return false;
    }
    /**
     * Method transcode.
     * convert String svalue to Language encode
     * @param svalue orginal string
     * @param encode language encode
     * @return String
     */
    public static String transcode(String svalue, String encode) {

        if (svalue.length() == 0) {
            throw new IllegalArgumentException("Replacing the empty string with something was attempted");
        }
        String stemp = svalue;
        try {
            byte[] temp_t = stemp.getBytes(encode);
            stemp = new String(temp_t);
        } catch (UnsupportedEncodingException e) {
            System.out.println("Encoding unsupported:" + encode);
        }
        return stemp;
    }

    /**
     * Method transcode.
     * convert String svalue to ISO8859_1
     * @param svalue
     * @return String
     */
    public static String transcode(String svalue) {
        if (svalue.length() == 0) {
            throw new IllegalArgumentException("Replacing the empty string with something was attempted");
        }
        return transcode(svalue, "ISO8859_1");
    }
    
    /**
     * 将数组连接为�?,”分隔的字符�?

     * @param strs
     * @return
     */
    public static String join(String[] strs)
    {
    	String returnStr="";
    	if(strs!=null && strs.length > 0)
    	{
    		for(int i=0;i<strs.length;i++)
    		{
    			if(!isEmpty(returnStr))
    			{
    				returnStr+=",";
    			}
    			returnStr+=strs[i];
    		}
    	}
    	return returnStr;
    }
    
    /**
	 * 简体转繁体
	 * @param simple
	 * @return
	 */
	public static String simpleToCompl(String simple){
		String str="";
		int length=simple.length();
		int charLen=4000;
		int mod=length/charLen;
		for(int n=0;n<mod;n++){
			String temp=simple.substring(n*charLen,(n+1)*charLen);
			str+=simpleToBig5(temp);
		}
	    if(length%charLen!=0){
	    	str+=simpleToBig5(simple.substring(mod*charLen));
		}
        return str;
    }
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StringUtil stru=new StringUtil();
		System.out.println(getSelfIdByUUId());

	}
	
	public static String simpleToBig5(String simple){
		String str="";
        int k=0;
        for(int i=0;i<simple.length();i++){
        	char ch=simple.charAt(i);
            if((k=simple_str.indexOf(ch))!=-1)
                str+=big5_str.charAt(k);
            else
                str+=ch;
        }
        return str;
    }
	/**
	 * 验证身份证号码
	 */
	public static char getVerifyCode(String idCardNumber) throws Exception{  
        if(idCardNumber == null || idCardNumber.length() < 17) {  
            throw new Exception("不合法的身份证号码");  
        }  
        char[] Ai = idCardNumber.toCharArray();  
        int[] Wi = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};  
        char[] verifyCode = {'1','0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};  
        int S = 0;  
        int Y;  
        for(int i = 0; i < Wi.length; i++){  
            S += (Ai[i] - '0') * Wi[i];  
        }  
        Y = S % 11;  
        return verifyCode[Y];  
    }
	public static String simple_str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+-={}|:<>?,./;'[]（）——【】《》？啊阿埃挨哎唉哀皑癌蔼矮艾碍爱隘鞍氨安俺按暗岸胺案肮昂盎凹敖熬翱袄傲奥懊澳芭捌扒叭吧笆八疤巴拔跋靶把耙坝霸罢爸白柏百摆佰败拜稗斑班搬扳般颁板版扮拌伴瓣半办绊邦帮梆榜膀绑棒磅蚌镑傍谤苞胞包褒剥薄雹保堡饱宝抱报暴豹鲍爆杯碑悲卑北辈背贝钡倍狈备惫焙被奔苯本笨崩绷甭泵蹦迸逼鼻比鄙笔彼碧蓖蔽毕毙毖币庇痹闭敝弊必辟壁臂避陛鞭边编贬扁便变卞辨辩辫遍标彪膘表鳖憋别瘪彬斌濒滨宾摈兵冰柄丙秉饼炳病并玻菠播拨钵波博勃搏铂箔伯帛舶脖膊渤泊驳捕卜哺补埠不布步簿部怖擦猜裁材才财睬踩采彩菜蔡餐参蚕残惭惨灿苍舱仓沧藏操糙槽曹草厕策侧册测层蹭插叉茬茶查碴搽察岔差诧拆柴豺搀掺蝉馋谗缠铲产阐颤昌猖场尝常长偿肠厂敞畅唱倡超抄钞朝嘲潮巢吵炒车扯撤掣彻澈郴臣辰尘晨忱沉陈趁衬撑称城橙成呈乘程惩澄诚承逞骋秤吃痴持匙池迟弛驰耻齿侈尺赤翅斥炽充冲虫崇宠抽酬畴踌稠愁筹仇绸瞅丑臭初出橱厨躇锄雏滁除楚础储矗搐触处揣川穿椽传船喘串疮窗幢床闯创吹炊捶锤垂春椿醇唇淳纯蠢戳绰疵茨磁雌辞慈瓷词此刺赐次聪葱囱匆从丛凑粗醋簇促蹿篡窜摧崔催脆瘁粹淬翠村存寸磋撮搓措挫错搭达答瘩打大呆歹傣戴带殆代贷袋待逮怠耽担丹单郸掸胆旦氮但惮淡诞弹蛋当挡党荡档刀捣蹈倒岛祷导到稻悼道盗德得的蹬灯登等瞪凳邓堤低滴迪敌笛狄涤翟嫡抵底地蒂第帝弟递缔颠掂滇碘点典靛垫电佃甸店惦奠淀殿碉叼雕凋刁掉吊钓调跌爹碟蝶迭谍叠丁盯叮钉顶鼎锭定订丢东冬董懂动栋侗恫冻洞兜抖斗陡豆逗痘都督毒犊独读堵睹赌杜镀肚度渡妒端短锻段断缎堆兑队对墩吨蹲敦顿囤钝盾遁掇哆多夺垛躲朵跺舵剁惰堕蛾峨鹅俄额讹娥恶厄扼遏鄂饿恩而儿耳尔饵洱二贰发罚筏伐乏阀法珐藩帆番翻樊矾钒繁凡烦反返范贩犯饭泛坊芳方肪房防妨仿访纺放菲非啡飞肥匪诽吠肺废沸费芬酚吩氛分纷坟焚汾粉奋份忿愤粪丰封枫蜂峰锋风疯烽逢冯缝讽奉凤佛否夫敷肤孵扶拂辐幅氟符伏俘服浮涪福袱弗甫抚辅俯釜斧脯腑府腐赴副覆赋复傅付阜父腹负富讣附妇缚咐噶嘎该改概钙盖溉干甘杆柑竿肝赶感秆敢赣冈刚钢缸肛纲岗港杠篙皋高膏羔糕搞镐稿告哥歌搁戈鸽胳疙割革葛格蛤阁隔铬个各给根跟耕更庚羹埂耿梗工攻功恭龚供躬公宫弓巩汞拱贡共钩勾沟苟狗垢构购够辜菇咕箍估沽孤姑鼓古蛊骨谷股故顾固雇刮瓜剐寡挂褂乖拐怪棺关官冠观管馆罐惯灌贯光广逛瑰规圭硅归龟闺轨鬼诡癸桂柜跪贵刽辊滚棍锅郭国果裹过哈骸孩海氦亥害骇酣憨邯韩含涵寒函喊罕翰撼捍旱憾悍焊汗汉夯杭航壕嚎豪毫郝好耗号浩呵喝荷菏核禾和何合盒貉阂河涸赫褐鹤贺嘿黑痕很狠恨哼亨横衡恒轰哄烘虹鸿洪宏弘红喉侯猴吼厚候后呼乎忽瑚壶葫胡蝴狐糊湖弧虎唬护互沪户花哗华猾滑画划化话槐徊怀淮坏欢环桓还缓换患唤痪豢焕涣宦幻荒慌黄磺蝗簧皇凰惶煌晃幌恍谎灰挥辉徽恢蛔回毁悔慧卉惠晦贿秽会烩汇讳诲绘荤昏婚魂浑混豁活伙火获或惑霍货祸击圾基机畸稽积箕肌饥迹激讥鸡姬绩缉吉极棘辑籍集及急疾汲即嫉级挤几脊己蓟技冀季伎祭剂悸济寄寂计记既忌际妓继纪嘉枷夹佳家加荚颊贾甲钾假稼价架驾嫁歼监坚尖笺间煎兼肩艰奸缄茧检柬碱硷拣捡简俭剪减荐槛鉴践贱见键箭件健舰剑饯渐溅涧建僵姜将浆江疆蒋桨奖讲匠酱降蕉椒礁焦胶交郊浇骄娇嚼搅铰矫侥脚狡角饺缴绞剿教酵轿较叫窖揭接皆秸街阶截劫节桔杰捷睫竭洁结解姐戒藉芥界借介疥诫届巾筋斤金今津襟紧锦仅谨进靳晋禁近烬浸尽劲荆兢茎睛晶鲸京惊精粳经井警景颈静境敬镜径痉靖竟竞净炯窘揪究纠玖韭久灸九酒厩救旧臼舅咎就疚鞠拘狙疽居驹菊局咀矩举沮聚拒据巨具距踞锯俱句惧炬剧捐鹃娟倦眷卷绢撅攫抉掘倔爵觉决诀绝均菌钧军君峻俊竣浚郡骏喀咖卡咯开揩楷凯慨刊堪勘坎砍看康慷糠扛抗亢炕考拷烤靠坷苛柯棵磕颗科壳咳可渴克刻客课肯啃垦恳坑吭空恐孔控抠口扣寇枯哭窟苦酷库裤夸垮挎跨胯块筷侩快宽款匡筐狂框矿眶旷况亏盔岿窥葵奎魁傀馈愧溃坤昆捆困括扩廓阔垃拉喇蜡腊辣啦莱来赖蓝婪栏拦篮阑兰澜谰揽览懒缆烂滥琅榔狼廊郎朗浪捞劳牢老佬姥酪烙涝勒乐雷镭蕾磊累儡垒擂肋类泪棱楞冷厘梨犁黎篱狸离漓理李里鲤礼莉荔吏栗丽厉励砾历利例俐痢立粒沥隶力璃哩俩联莲连镰廉怜涟帘敛脸链恋炼练粮凉梁粱良两辆量晾亮谅撩聊僚疗燎寥辽潦了撂镣廖料列裂烈劣猎琳林磷霖临邻鳞淋凛赁吝拎玲菱零龄铃伶羚凌灵陵岭领另令溜琉榴硫馏留刘瘤流柳六龙聋咙笼窿隆垄拢陇楼娄搂篓漏陋芦卢颅庐炉掳卤虏鲁麓碌露路赂鹿潞禄录陆戮驴吕铝侣旅履屡缕虑氯律率滤绿峦挛孪滦卵乱掠略抡轮伦仑沦纶论萝螺罗逻锣箩骡裸落洛骆络妈麻玛码蚂马骂嘛吗埋买麦卖迈脉瞒馒蛮满蔓曼慢漫谩芒茫盲氓忙莽猫茅锚毛矛铆卯茂冒帽貌贸么玫枚梅霉煤没眉媒镁每美昧寐妹媚门闷们萌蒙檬盟锰猛梦孟眯醚靡糜迷谜弥米秘觅泌蜜密幂棉眠绵冕免勉娩缅面苗描瞄藐秒渺庙妙蔑灭民抿皿敏悯闽明螟鸣铭名命谬摸摹蘑模膜磨摩魔抹末莫墨默沫漠寞陌谋牟某拇牡亩姆母墓暮幕募慕木目睦牧穆拿哪呐钠那娜纳氖乃奶耐奈南男难囊挠脑恼闹淖呢馁内嫩能妮霓倪泥尼拟你匿腻逆溺蔫拈年碾撵捻念娘酿鸟尿捏聂孽啮镊镍涅您柠狞凝宁拧泞牛扭钮纽脓浓农弄奴努怒女暖虐疟挪懦糯诺哦欧鸥殴藕呕偶沤啪趴爬帕怕琶拍排牌徘湃派攀潘盘磐盼畔判叛乓庞旁耪胖抛咆刨炮袍跑泡呸胚培裴赔陪配佩沛喷盆砰抨烹澎彭蓬棚硼篷膨朋鹏捧碰坯砒霹批披劈琵毗啤脾疲皮匹痞僻屁譬篇偏片骗飘漂瓢票撇瞥拼频贫品聘乒坪苹萍平凭瓶评屏坡泼颇婆破魄迫粕剖扑铺仆莆葡菩蒲埔朴圃普浦谱曝瀑期欺栖戚妻七凄漆柒沏其棋奇歧畦崎脐齐旗祈祁骑起岂乞企启契砌器气迄弃汽泣讫掐恰洽牵扦铅千迁签仟谦乾黔钱钳前潜遣浅谴堑嵌欠歉枪呛腔羌墙蔷强抢橇锹敲悄桥瞧乔侨巧鞘撬翘峭俏窍切茄且怯窃钦侵亲秦琴勤芹擒禽寝沁青轻氢倾卿清擎晴氰情顷请庆琼穷秋丘邱球求囚酋泅趋区蛆曲躯屈驱渠取娶龋趣去圈颧权醛泉全痊拳犬券劝缺炔瘸却鹊榷确雀裙群然燃冉染瓤壤攘嚷让饶扰绕惹热壬仁人忍韧任认刃妊纫扔仍日戎茸蓉荣融熔溶容绒冗揉柔肉茹蠕儒孺如辱乳汝入褥软阮蕊瑞锐闰润若弱撒洒萨腮鳃塞赛叁三伞散桑嗓丧搔骚扫嫂瑟色涩森僧莎砂杀刹沙纱傻啥煞筛晒珊苫杉山删煽衫闪陕擅赡膳善汕扇缮伤商赏晌上尚裳梢捎稍烧芍勺韶少哨邵绍奢赊蛇舌舍赦摄射慑涉社设砷申呻伸身深娠绅神沈审婶甚肾慎渗声生甥牲升绳省盛剩胜圣师失狮施湿诗尸虱十石拾时什食蚀实识史矢使屎驶始式示士世柿事拭誓逝势是嗜噬适仕侍释饰氏市恃室视试收手首守寿授售受瘦兽蔬枢梳殊抒输叔舒淑疏书赎孰熟薯暑曙署蜀黍鼠属术述树束戍竖墅庶数漱恕刷耍摔衰甩帅栓拴霜双爽谁水睡税吮瞬顺舜说硕朔烁斯撕嘶思私司丝死肆寺嗣四伺似饲巳松耸怂颂送宋讼诵搜艘擞嗽苏酥俗素速粟僳塑溯宿诉肃酸蒜算虽隋随绥髓碎岁穗遂隧祟孙损笋蓑梭唆缩琐索锁所塌他它她塔獭挞蹋踏胎苔抬台泰太态汰坍摊贪瘫滩坛檀痰潭谭谈坦毯袒碳探叹炭汤塘搪堂棠膛唐糖倘躺淌趟烫掏涛滔绦萄桃逃淘陶讨套特藤腾疼誊梯剔踢锑提题蹄啼体替嚏惕涕剃屉天添填田甜恬舔腆挑条迢眺跳贴铁帖厅听烃汀廷停亭庭挺艇通桐酮瞳同铜彤童桶捅筒统痛偷投头透凸秃突图徒途涂屠土吐兔湍团推颓腿蜕褪退吞屯臀拖托脱鸵陀驮驼椭妥拓唾挖哇蛙洼娃瓦袜歪外豌弯湾玩顽丸烷完碗挽晚皖惋宛婉万腕汪王亡枉网往旺望忘妄威巍微危韦违桅围唯惟为潍维苇萎委伟伪尾纬未蔚味畏胃喂魏位渭谓尉慰卫瘟温蚊文闻纹吻稳紊问嗡翁瓮挝蜗涡窝我斡卧握沃巫呜钨乌污诬屋无芜梧吾吴毋武五捂午舞伍侮坞戊雾晤物勿务悟误昔熙析西硒矽晰嘻吸锡牺稀息希悉膝夕惜熄烯溪汐犀檄袭席习媳喜铣洗系隙戏细瞎虾匣霞辖暇峡侠狭下厦夏吓掀先仙鲜纤咸贤衔舷闲涎弦嫌显险现献县腺馅羡宪陷限线相厢镶香箱襄湘乡翔祥详想响享项巷橡像向象萧硝霄削哮嚣销消宵淆晓小孝校肖啸笑效楔些歇蝎鞋协挟携邪斜胁谐写械卸蟹懈泄泻谢屑薪芯锌欣辛新忻心信衅星腥猩惺兴刑型形邢行醒幸杏性姓兄凶胸匈汹雄熊休修羞朽嗅锈秀袖绣墟戌需虚嘘须徐许蓄酗叙旭序畜恤絮婿绪续轩喧宣悬旋玄选癣眩绚靴薛学穴雪血勋熏循旬询寻驯巡殉汛训讯逊迅压押鸦鸭呀丫芽牙蚜崖衙涯雅哑亚讶焉咽阉烟淹盐严研蜒岩延言颜阎炎沿奄掩眼衍演艳堰燕厌砚雁唁彦焰宴谚验殃央鸯秧杨扬佯疡羊洋阳氧仰痒养样漾邀腰妖瑶摇尧遥窑谣姚咬舀药要耀椰噎耶爷野冶也页掖业叶曳腋夜液一壹医揖铱依伊衣颐夷遗移仪胰疑沂宜姨彝椅蚁倚已乙矣以艺抑易邑屹亿役臆逸肄疫亦裔意毅忆义益溢诣议谊译异翼翌绎茵荫因殷音阴姻吟银淫寅饮尹引隐印英樱婴鹰应缨莹萤营荧蝇迎赢盈影颖硬映哟拥佣臃痈庸雍踊蛹咏泳涌永恿勇用幽优悠忧尤由邮铀犹油游酉有友右佑釉诱又幼迂淤于盂榆虞愚舆余俞逾鱼愉渝渔隅予娱雨与屿禹宇语羽玉域芋郁吁遇喻峪御愈欲狱育誉浴寓裕预豫驭鸳渊冤元垣袁原援辕园员圆猿源缘远苑愿怨院曰约越跃钥岳粤月悦阅耘云郧匀陨允运蕴酝晕韵孕匝砸杂栽哉灾宰载再在咱攒暂赞赃脏葬遭糟凿藻枣早澡蚤躁噪造皂灶燥责择则泽贼怎增憎曾赠扎喳渣札轧铡闸眨栅榨咋乍炸诈摘斋宅窄债寨瞻毡詹粘沾盏斩辗崭展蘸栈占战站湛绽樟章彰漳张掌涨杖丈帐账仗胀瘴障招昭找沼赵照罩兆肇召遮折哲蛰辙者锗蔗这浙珍斟真甄砧臻贞针侦枕疹诊震振镇阵蒸挣睁征狰争怔整拯正政帧症郑证芝枝支吱蜘知肢脂汁之织职直植殖执值侄址指止趾只旨纸志挚掷至致置帜峙制智秩稚质炙痔滞治窒中盅忠钟衷终种肿重仲众舟周州洲诌粥轴肘帚咒皱宙昼骤珠株蛛朱猪诸诛逐竹烛煮拄瞩嘱主著柱助蛀贮铸筑住注祝驻抓爪拽专砖转撰赚篆桩庄装妆撞壮状椎锥追赘坠缀谆准捉拙卓桌琢茁酌啄着灼浊兹咨资姿滋淄孜紫仔籽滓子自渍字鬃棕踪宗综总纵邹走奏揍租足卒族祖诅阻组钻纂嘴醉最罪尊遵昨左佐柞做作坐座亍丌兀丐廿卅丕亘丞鬲孬噩禺匕乇夭爻卮氐囟胤馗毓睾亟鼐乜乩亓芈孛啬嘏仄厍厝厣厥靥赝匚叵匦匮匾赜卦卣刈刎刭刳刿剀剌剞剡剜蒯剽劂劁劓罔仃仉仂仨仡仞伛仳伢佤仵伥伧伉伫佞佧攸佚佝佟佗伽佶佴侑侉侃侏佾佻侪佼侬侔俦俨俪俅俚俣俜俑俟俸倩偌俳倬倏倭俾倜倌倥倨偾偃偕偈偎偬偻傥傧傩傺僖儆僭僬僦僮儇儋仝氽佘佥俎龠籴兮巽黉馘冁夔匍訇匐凫夙兕兖亳衮袤亵脔裒禀嬴蠃羸冱冽冼冢冥讦讧讪讴讵讷诂诃诋诏诒诓诔诖诘诙诜诟诠诤诨诩诮诰诳诶诹诼诿谀谂谄谇谌谏谑谒谔谕谖谙谛谘谝谟谠谡谥谧谪谫谮谯谲谳谵谶卺阢阡阱阪阽阼陂陉陔陟陧陬陲陴隈隍隗隰邗邛邝邙邬邡邴邳邶邺邸邰郏郅邾郐郇郓郦郢郜郗郛郫郯郾鄄鄢鄞鄣鄱鄯鄹酃酆刍奂劢劬劭劾哿勖勰叟燮矍鬯弁畚巯坌垩塾墼壅壑圩圬圳圹圮圯坜圻坩坫垆坼坻坨坭坶坳垭垤垌垲埏垓垠埕埘埚埙埒垸埴埸埤堋堍埽埭堀堞堙堠塥墁墉墀馨鼙懿艽艿芏芊芨芄芎芑芗芙芫芸芾芰苈苣芘芷芮苋苌苁芩芴芡芟苎芤苡茉苤茏茇苜苴苒茌苻苓茑茆茔茕苠苕茜荑荛荜茈莒茼茴茱莛荞茯荏荇荃荟荀茗荠茭茺茳荦荥茛荩荪荭荸莳莴莠莪莓莅荼莩荽莸荻莘莞莨莺菁萁菥菘堇萋菝菽菖萸萑萆菔菟萏萃菸菹菪菅菀萦菰菡葑葚葙葳蒇葺蒉葸萼葆葩葶蒌蒎萱葭蓁蓍蓐蓦蓓蓊蒿蒺蓠蒡蒹蒴蒗蓣蔌甍蓰蔹蔟蔺蕖蔻蓿蓼蕙蕈蕨蕤蕞蕺瞢蕃蕲蕻薤薨薇薏蕹薮薜薅薹薷薰藓藜藿蘧蘅蘩蘼廾弈夼奁耷奕奚奘匏尢尥尬尴扪抟抻拊拚拗拮挢拶挹捋捃掭揶捱捺掎掴捭掬掊捩掮掼揲揠揿揄揎摒揆掾摅摁搋搛搠搌搦搡摞撄摭撖摺撷撸撙撺擐擗擤擢攉攥攮弋忒弑叱叽叩叨叻吒吆呒呓呔呖呃呗咂呷呱呤咚咛咄呶呦咭哂哒咧咦哓哔呲哕咻咿哙哜咩咪哝哏哞唛哧唠哽唔哳唢唏唑唧唪啧喏喵啭啁啕啐唷啖啵啶唳唰啜喋嗒喃喱喈喁喟啾嗖喑啻嗟喽喾喔喙嗷嗉嘟嗑嗫嗔嗦嗝嗄嗯嗥嗲嗳嗌嗍嗨嗤辔嘈嘌嘁嘤嗾嘀嘧噘嘹噗嘬噢噙噜噌嚆噤噱噫嚅嚓囔囝囡囵囫囹囿圄圊圉圜帏帙帔帑帱帻帼帷幄幔幛幡岌屺岍岐岖岈岘岑岚岵岢岬岫岱岣岷峄峒峤峋峥崂崃崧崦崮崤崞崆崛嵘崴崽嵬嵛嵯嵝嵫嵋嵊嵩嶂嶙嶝豳嶷巅彳彷徂徇徉徕徙徜徨徭徵徼衢犰犴犷狃狁狎狒狨狯狩狲狴狷猁狳猃狺狻猗猓猡猊猞猝猕猢猥猱獐獍獗獠獬獯獾舛夥飧夤饧饨饩饪饫饬饴饷饽馀馄馊馍馐馑馔庀庑庋庖庥庠庹庵庾庳赓廒廑廛廨廪膺忉忖忏怃忮怄忡忤忾怅怆忪忭忸怙怵怦怛怏怍怩怫怊怿怡恸恹恻恺恂恪恽悖悚悭悝悃悒悌悛惬悻悱惝惘惆惚悴愠愦愕愣惴愀愎愫慊慵憬憔憧懔懵忝隳闩闫闱闳闵闶闼闾阃阄阆阈阊阌阍阏阒阕阖阗阙阚戕汔汜汊沣沅沐沔沌汨汴汶沆沩泐泔沭泷泸泱泗泠泖泺泫泮沱泓泯泾洹洧洌浃浈洇洄洙洎洫浍洮洵洚浏浒浔洳涑浯涞涠浞涓涔浠浼浣渚淇淅淞渎涿淠渑淦淝淙渖涫渌涮渫湮湎湫溲湟溆湓湔渲渥湄滟溱溘滠漭滢溥溧溽溷滗溴滏溏滂溟潢潆潇漕滹漯漶潋潴漪漉漩澉澍澌潸潲潼潺濑濉澧澹澶濂濡濮濠濯瀚瀣瀛瀹瀵灏灞宄宕宓宥宸甯骞搴寤寮褰寰蹇謇迓迕迥迮迤迩迦迳迨逅逄逋逦逑逍逖逡逵逶逭逯遄遑遒遐遨遘遢遛暹遴遽邂邈邃邋彗彖彘尻咫屐屙孱屣屦羼弪弩弭艴弼鬻妁妃妍妩妪妣妗姊妫妞妤姒妲妯姗妾娅娆姝娈姣姘娌娉娲娴娑娣娓婀婧婊婕娼婢婵媪媛婷婺媾嫫媲嫒嫔媸嫠嫣嫱嫖嫦嫘嫜嬉嬗嬖嬲嬷孀尕孚孥孳孑孓孢驵驷驸驺驿驽骀骁骅骈骊骐骒骓骖骘骛骜骝骟骠骢骣骥骧纡纣纥纨纩纭纰纾绀绁绂绉绋绌绗绛绠绡绨绫绮绯绲缍绶绺绻绾缁缂缃缇缈缋缌缏缑缒缗缙缜缛缟缡缢缣缤缥缦缧缪缫缬缭缯缱缲缳缵畿甾邕玎玑玮玢玟珏珂珑玷玳珀珈珥珙顼琊珩珧珞玺珲琏琪瑛琦琥琨琰琮琬琛琚瑁瑜瑗瑕瑙瑷瑭瑾璜璎璀璁璇璋璞璨璩璐璧瓒璺韪韫韬杌杓杞杈杩枥枇杪杳枘杵枨枞枭枋杷杼柰栉柘栊柩枰栌柙枵柚枳柝栀柃枸柢栎柁柽栲栳桠桡桎桢桄桤梃栝桦桁桧桀栾桉栩梵梏桴桷梓桫棂楮棼椟椠棹椤棰椋椁楗棣椐楱椹楠楂楝榄楫楸椴槌榇榈槎榉楦楣楹榛榧榻榫榭槔榱槁槊槟榕槠榍槿樯槭樗樘橥槲橄樾檠橐橛樵檎橹樽樨橘橼檑檐檩檗猷殁殂殇殄殒殓殍殚殛殡殪轫轭轲轳轵轶轸轹轺轼轾辁辂辄辇辋辍辎辏辘辚戋戗戛戟戢戡戥戤戬臧瓯瓴瓿甏甑甓旮旯旰昊昙杲昃昕昀炅曷昝昴昱昶昵耆晟晔晁晏晖晡晷暄暌暧暝暾曛曜曦曩贲贳贶贻贽赀赅赆赈赉赇赕赙觇觊觋觌觎觏觐觑牮牝牯牾牿犄犋犍犒挈挲掰搿擘耄毳毽毵毹氅氇氆氍氕氘氙氚氡氩氤氪氲敕牍牒牖爰虢刖肜肓朊肱肫肭肴胧胪胛胂胄胙胍胗朐胝胫胱胴胭脍胼朕豚脶脞脬脘腌腓腴腱腠腩腽塍媵膈膂膑滕膣臌朦臊膻膦欤欷欹歃歆歙飑飒飓飕飙彀毂觳斐齑斓於旆旄旃旌旎旒旖炀炜炖炷炫炱烨烊焐焓焖焯焱煜煨煲煸熳熵熨熠燠燔燧燹爝爨焘煦熹戾戽扃扈扉祀祆祉祛祜祓祚祢祗祠祯祧祺禅禊禚禧禳忑忐怼恝恚恧恁恙恣悫愆愍慝憩憝懋懑戆聿沓泶淼矶矸砀砉砗砑斫砭砝砺砻砟砥砬砣砩硎硭硖硗砦硐硌碛碓碚碇碜碡碣碲碥磔磉磬磲礅磴礓礤礞礴龛黹黻黼盱眄盹眇眈眚眢眙眭眵眸睐睑睇睚睨睢睥睿瞍睽瞀瞌瞑瞟瞠瞰瞵瞽町畀畎畋畈畛畲畹罘罡罟詈罨罴罹羁罾盍盥蠲钆钇钋钊钌钍钏钐钔钗钕钛钜钣钤钫钪钭钬钯钰钲钴钶钸钹钺钼钽钿铄铈铉铊铋铌铍铎铐铑铒铕铖铗铙铛铟铠铢铤铥铧铨铪铩铫铮铯铳铴铵铷铹铼铽铿锂锆锇锉锊锒锓锔锕锖锛锞锟锢锩锬锱锲锴锶锷锸锼锾镂锵镆镉镌镏镒镓镔镖镗镘镙镛镞镟镝镡镤镦镧镨镪镫镬镯镱镳锺矧矬雉秕秭秣秫嵇稃稂稞稔稹稷穑黏馥穰皈皎皓皙皤瓞瓠甬鸠鸢鸨鸩鸪鸫鸬鸲鸱鸶鸸鸷鸹鸺鸾鹁鹂鹄鹆鹇鹈鹉鹌鹎鹑鹕鹗鹞鹣鹦鹧鹨鹩鹪鹫鹬鹭鹳疔疖疠疝疣疳疸疰痂痍痣痨痦痤痫痧瘃痱痼痿瘐瘀瘅瘌瘗瘊瘥瘕瘙瘼瘢瘠瘭瘰瘿瘵癃瘾瘳癞癜癖癫翊竦穸穹窀窆窈窕窦窠窬窨窭窳衩衲衽衿袂袢裆袷袼裉裢裎裣裥裱褚裼裨裾裰褡褙褓褛褊褴褫褶襁襦襻疋胥皲皴矜耒耔耖耜耦耧耩耨耋耵聃聆聍聒聩聱覃顸颀颃颉颌颏颔颚颛颞颟颡颢颦虔虬虮虿虺虼虻蚨蚍蚋蚬蚝蚧蚣蚪蚓蚩蚶蛄蚵蛎蚰蚺蚱蚯蛉蛏蚴蛩蛱蛲蛭蛳蛐蜓蛞蛴蛟蛘蛑蜃蜇蛸蜈蜊蜍蜉蜣蜻蜞蜥蜮蜚蜾蝈蜴蜱蜩蜷蜿螂蜢蝾蝻蝠蝌蝮蝓蝣蝼蝤蝙蝥螓螯蟒蟆螈螅螭螗螃螫蟥螬螵螳蟋蟓螽蟑蟀蟊蟛蟪蟠蠖蠓蟾蠊蠛蠡蠹蠼缶罂罄罅舐竺竽笈笃笄笕笊笫笏筇笸笪笙笮笱笠笥笤笳笾笞筘筚筅筵筌筝筠筮筲筱箐箦箧箸箬箝箨箅箪箜箫箴篑篁篌篝篚篥篦篪簌篾簏簖簋簟簪簦簸籁籀臾舁舂舄臬衄舡舢舣舯舨舫舸舻舳舴艄艉艋艏艚艟艨衾袅袈裘裟襞羝羟羧羯羰羲敉粑粞粢粲粼粽糁糌糈糅糗糨艮暨羿翎翕翥翡翦翩翮翳糸絷綦綮繇纛麸麴赳趄趔趑趱赧赭豇豉酊酐酎酏酤酢酡酩酯酽酾酲酴酹醅醐醍醑醢醣醪醭醮醯醵醴醺豕鹾趸跫踅蹙蹩趵趿趼趺跄跖跗跚跞跎跏跛跆跬跷跸跣跹跻跤踉跽踔踝踟踬踮踣踯蹀踵踽踱蹉蹁蹂蹑蹒蹊蹰蹶蹼蹯蹴躅躏躔躐躜躞豸貂貊貅貘貔斛觖觞觚觜觥觫觯訾謦靓雩雳雯霆霁霈霏霎霪霭霰霾龀龃龅龆龇龈龉龊龌黾鼋鼍隹隼隽雎雒瞿雠銎銮鋈錾鍪鏊鎏鑫鱿鲂鲅鲈稣鲋鲎鲐鲒鲔鲕鲚鲛鲞鲟鲠鲡鲢鲣鲥鲦鲧鲨鲩鲫鲭鲮鲰鲱鲲鲳鲵鲶鲷鲻鲽鳄鳅鳆鳇鳌鳍鳎鳏鳐鳓鳔鳕鳗鳜鳝鳟鳢靼鞅鞑鞔鞯鞫鞣骱骰骷鹘骼髁髀髅髂髋髌髑魅魃魇魉魈魍魑飨餍餮饕饔髟髡髦髯髫髻髭髹鬈鬓鬟鬣麽麾縻麂麇麈麋麒鏖麝麟黛黜黝黠黟黩黧黥黪黯鼢鼬鼯鼹鼷鼽鼾";
	public static String big5_str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+-={}|:<>?,./;'[]（）——【】《》？啊阿埃挨哎唉哀皚癌藹矮艾礙愛隘鞍氨安俺按暗岸胺案骯昂盎凹敖熬翱襖傲奧懊澳芭捌扒叭吧笆八疤巴拔跋靶把耙壩霸罷爸白柏百擺佰敗拜稗斑班搬扳般頒板版扮拌伴瓣半辦絆邦幫梆榜膀綁棒磅蚌鎊傍謗苞胞包褒剝薄雹保堡飽寶抱報暴豹鮑爆杯碑悲卑北輩背貝鋇倍狽備憊焙被奔苯本笨崩繃甭泵蹦迸逼鼻比鄙筆彼碧蓖蔽畢斃毖幣庇痺閉敝弊必辟壁臂避陛鞭邊編貶扁便變卞辨辯辮遍標彪膘表鱉憋別癟彬斌瀕濱賓擯兵冰柄丙秉餅炳病並玻菠播撥缽波博勃搏鉑箔伯帛舶脖膊渤泊駁捕卜哺補埠不布步簿部怖擦猜裁材才財睬踩採彩菜蔡餐參蠶殘慚慘燦蒼艙倉滄藏操糙槽曹草廁策側冊測層蹭插叉茬茶查碴搽察岔差詫拆柴豺攙摻蟬饞讒纏鏟產闡顫昌猖場嘗常長償腸廠敞暢唱倡超抄鈔朝嘲潮巢吵炒車扯撤掣徹澈郴臣辰塵晨忱沉陳趁襯撐稱城橙成呈乘程懲澄誠承逞騁秤吃痴持匙池遲弛馳恥齒侈尺赤翅斥熾充沖虫崇寵抽酬疇躊稠愁籌仇綢瞅丑臭初出櫥廚躇鋤雛滁除楚礎儲矗搐觸處揣川穿椽傳船喘串瘡窗幢床闖創吹炊捶錘垂春椿醇唇淳純蠢戳綽疵茨磁雌辭慈瓷詞此刺賜次聰蔥囪匆從叢湊粗醋簇促躥篡竄摧崔催脆瘁粹淬翠村存寸磋撮搓措挫錯搭達答瘩打大呆歹傣戴帶殆代貸袋待逮怠耽擔丹單鄲撣膽旦氮但憚淡誕彈蛋當擋黨蕩檔刀搗蹈倒島禱導到稻悼道盜德得的蹬燈登等瞪凳鄧堤低滴迪敵笛狄滌翟嫡抵底地蒂第帝弟遞締顛掂滇碘點典靛墊電佃甸店惦奠澱殿碉叼雕凋刁掉吊釣調跌爹碟蝶迭諜疊丁盯叮釘頂鼎錠定訂丟東冬董懂動棟侗恫凍洞兜抖斗陡豆逗痘都督毒犢獨讀堵睹賭杜鍍肚度渡妒端短鍛段斷緞堆兌隊對墩噸蹲敦頓囤鈍盾遁掇哆多奪垛躲朵跺舵剁惰墮蛾峨鵝俄額訛娥惡厄扼遏鄂餓恩而兒耳爾餌洱二貳發罰筏伐乏閥法琺藩帆番翻樊礬釩繁凡煩反返范販犯飯泛坊芳方肪房防妨仿訪紡放菲非啡飛肥匪誹吠肺廢沸費芬酚吩氛分紛墳焚汾粉奮份忿憤糞豐封楓蜂峰鋒風瘋烽逢馮縫諷奉鳳佛否夫敷膚孵扶拂輻幅氟符伏俘服浮涪福袱弗甫撫輔俯釜斧脯腑府腐赴副覆賦復傅付阜父腹負富訃附婦縛咐噶嘎該改概鈣蓋溉干甘杆柑竿肝趕感稈敢贛岡剛鋼缸肛綱崗港杠篙皋高膏羔糕搞鎬稿告哥歌擱戈鴿胳疙割革葛格蛤閣隔鉻個各給根跟耕更庚羹埂耿梗工攻功恭龔供躬公宮弓鞏汞拱貢共鉤勾溝苟狗垢構購夠辜菇咕箍估沽孤姑鼓古蠱骨谷股故顧固雇刮瓜剮寡挂褂乖拐怪棺關官冠觀管館罐慣灌貫光廣逛瑰規圭硅歸龜閨軌鬼詭癸桂櫃跪貴劊輥滾棍鍋郭國果裹過哈骸孩海氦亥害駭酣憨邯韓含涵寒函喊罕翰撼捍旱憾悍焊汗漢夯杭航壕嚎豪毫郝好耗號浩呵喝荷菏核禾和何合盒貉閡河涸赫褐鶴賀嘿黑痕很狠恨哼亨橫衡恆轟哄烘虹鴻洪宏弘紅喉侯猴吼厚候後呼乎忽瑚壺葫胡蝴狐糊湖弧虎唬護互滬戶花嘩華猾滑畫劃化話槐徊懷淮壞歡環桓還緩換患喚瘓豢煥渙宦幻荒慌黃磺蝗簧皇凰惶煌晃幌恍謊灰揮輝徽恢蛔回毀悔慧卉惠晦賄穢會燴匯諱誨繪葷昏婚魂渾混豁活伙火獲或惑霍貨禍擊圾基機畸稽積箕肌飢跡激譏雞姬績緝吉極棘輯籍集及急疾汲即嫉級擠幾脊己薊技冀季伎祭劑悸濟寄寂計記既忌際妓繼紀嘉枷夾佳家加莢頰賈甲鉀假稼價架駕嫁殲監堅尖箋間煎兼肩艱奸緘繭檢柬鹼鹼揀撿簡儉剪減薦檻鑒踐賤見鍵箭件健艦劍餞漸濺澗建僵姜將漿江疆蔣槳獎講匠醬降蕉椒礁焦膠交郊澆驕嬌嚼攪鉸矯僥腳狡角餃繳絞剿教酵轎較叫窖揭接皆秸街階截劫節桔杰捷睫竭潔結解姐戒藉芥界借介疥誡屆巾筋斤金今津襟緊錦僅謹進靳晉禁近燼浸盡勁荊兢莖睛晶鯨京驚精粳經井警景頸靜境敬鏡徑痙靖竟競淨炯窘揪究糾玖韭久灸九酒廄救舊臼舅咎就疚鞠拘狙疽居駒菊局咀矩舉沮聚拒據巨具距踞鋸俱句懼炬劇捐鵑娟倦眷卷絹撅攫抉掘倔爵覺決訣絕均菌鈞軍君峻俊竣浚郡駿喀咖卡咯開揩楷凱慨刊堪勘坎砍看康慷糠扛抗亢炕考拷烤靠坷苛柯棵磕顆科殼咳可渴克刻客課肯啃墾懇坑吭空恐孔控摳口扣寇枯哭窟苦酷庫褲夸垮挎跨胯塊筷儈快寬款匡筐狂框礦眶曠況虧盔巋窺葵奎魁傀饋愧潰坤昆捆困括擴廓闊垃拉喇蠟臘辣啦萊來賴藍婪欄攔籃闌蘭瀾讕攬覽懶纜爛濫琅榔狼廊郎朗浪撈勞牢老佬姥酪烙澇勒樂雷鐳蕾磊累儡壘擂肋類淚棱楞冷厘梨犁黎籬狸離漓理李裡鯉禮莉荔吏栗麗厲勵礫歷利例俐痢立粒瀝隸力璃哩倆聯蓮連鐮廉憐漣帘斂臉鏈戀煉練糧涼梁粱良兩輛量晾亮諒撩聊僚療燎寥遼潦了撂鐐廖料列裂烈劣獵琳林磷霖臨鄰鱗淋凜賃吝拎玲菱零齡鈴伶羚凌靈陵嶺領另令溜琉榴硫餾留劉瘤流柳六龍聾嚨籠窿隆壟攏隴樓婁摟簍漏陋蘆盧顱廬爐擄鹵虜魯麓碌露路賂鹿潞祿錄陸戮驢呂鋁侶旅履屢縷慮氯律率濾綠巒攣孿灤卵亂掠略掄輪倫侖淪綸論蘿螺羅邏鑼籮騾裸落洛駱絡媽麻瑪碼螞馬罵嘛嗎埋買麥賣邁脈瞞饅蠻滿蔓曼慢漫謾芒茫盲氓忙莽貓茅錨毛矛鉚卯茂冒帽貌貿麼玫枚梅霉煤沒眉媒鎂每美昧寐妹媚門悶們萌蒙檬盟錳猛夢孟瞇醚靡糜迷謎彌米秘覓泌蜜密冪棉眠綿冕免勉娩緬面苗描瞄藐秒渺廟妙蔑滅民抿皿敏憫閩明螟鳴銘名命謬摸摹蘑模膜磨摩魔抹末莫墨默沫漠寞陌謀牟某拇牡畝姆母墓暮幕募慕木目睦牧穆拿哪吶鈉那娜納氖乃奶耐奈南男難囊撓腦惱鬧淖呢餒內嫩能妮霓倪泥尼擬你匿膩逆溺蔫拈年碾攆捻念娘釀鳥尿捏聶孽嚙鑷鎳涅您檸獰凝寧擰濘牛扭鈕紐膿濃農弄奴努怒女暖虐瘧挪懦糯諾哦歐鷗毆藕嘔偶漚啪趴爬帕怕琶拍排牌徘湃派攀潘盤磐盼畔判叛乓龐旁耪胖拋咆刨炮袍跑泡呸胚培裴賠陪配佩沛噴盆砰抨烹澎彭蓬棚硼篷膨朋鵬捧碰坯砒霹批披劈琵毗啤脾疲皮匹痞僻屁譬篇偏片騙飄漂瓢票撇瞥拼頻貧品聘乒坪蘋萍平憑瓶評屏坡潑頗婆破魄迫粕剖扑鋪仆莆葡菩蒲埔朴圃普浦譜曝瀑期欺棲戚妻七淒漆柒沏其棋奇歧畦崎臍齊旗祈祁騎起豈乞企啟契砌器氣迄棄汽泣訖掐恰洽牽扦鉛千遷簽仟謙乾黔錢鉗前潛遣淺譴塹嵌欠歉槍嗆腔羌牆薔強搶橇鍬敲悄橋瞧喬僑巧鞘撬翹峭俏竅切茄且怯竊欽侵親秦琴勤芹擒禽寢沁青輕氫傾卿清擎晴氰情頃請慶瓊窮秋丘邱球求囚酋泅趨區蛆曲軀屈驅渠取娶齲趣去圈顴權醛泉全痊拳犬券勸缺炔瘸卻鵲榷確雀裙群然燃冉染瓤壤攘嚷讓饒擾繞惹熱壬仁人忍韌任認刃妊紉扔仍日戎茸蓉榮融熔溶容絨冗揉柔肉茹蠕儒孺如辱乳汝入褥軟阮蕊瑞銳閏潤若弱撒洒薩腮鰓塞賽三三傘散桑嗓喪搔騷掃嫂瑟色澀森僧莎砂殺剎沙紗傻啥煞篩晒珊苫杉山刪煽衫閃陝擅贍膳善汕扇繕傷商賞晌上尚裳梢捎稍燒芍勺韶少哨邵紹奢賒蛇舌舍赦攝射懾涉社設砷申呻伸身深娠紳神沈審嬸甚腎慎滲聲生甥牲升繩省盛剩勝聖師失獅施濕詩尸虱十石拾時什食蝕實識史矢使屎駛始式示士世柿事拭誓逝勢是嗜噬適仕侍釋飾氏市恃室視試收手首守壽授售受瘦獸蔬樞梳殊抒輸叔舒淑疏書贖孰熟薯暑曙署蜀黍鼠屬術述樹束戍豎墅庶數漱恕刷耍摔衰甩帥栓拴霜雙爽誰水睡稅吮瞬順舜說碩朔爍斯撕嘶思私司絲死肆寺嗣四伺似飼巳鬆聳慫頌送宋訟誦搜艘擻嗽蘇酥俗素速粟僳塑溯宿訴肅酸蒜算雖隋隨綏髓碎歲穗遂隧祟孫損筍蓑梭唆縮瑣索鎖所塌他它她塔獺撻蹋踏胎苔抬台泰太態汰坍攤貪癱灘壇檀痰潭譚談坦毯袒碳探嘆炭湯塘搪堂棠膛唐糖倘躺淌趟燙掏濤滔絛萄桃逃淘陶討套特藤騰疼謄梯剔踢銻提題蹄啼體替嚏惕涕剃屜天添填田甜恬舔腆挑條迢眺跳貼鐵帖廳聽烴汀廷停亭庭挺艇通桐酮瞳同銅彤童桶捅筒統痛偷投頭透凸禿突圖徒途涂屠土吐兔湍團推頹腿蛻褪退吞屯臀拖托脫鴕陀馱駝橢妥拓唾挖哇蛙窪娃瓦襪歪外豌彎灣玩頑丸烷完碗挽晚皖惋宛婉萬腕汪王亡枉網往旺望忘妄威巍微危韋違桅圍唯惟為濰維葦萎委偉偽尾緯未蔚味畏胃喂魏位渭謂尉慰衛瘟溫蚊文聞紋吻穩紊問嗡翁瓮撾蝸渦窩我斡臥握沃巫嗚鎢烏污誣屋無蕪梧吾吳毋武五捂午舞伍侮塢戊霧晤物勿務悟誤昔熙析西硒矽晰嘻吸錫犧稀息希悉膝夕惜熄烯溪汐犀檄襲席習媳喜銑洗系隙戲細瞎蝦匣霞轄暇峽俠狹下廈夏嚇掀先仙鮮纖咸賢銜舷閑涎弦嫌顯險現獻縣腺餡羨憲陷限線相廂鑲香箱襄湘鄉翔祥詳想響享項巷橡像向象蕭硝霄削哮囂銷消宵淆曉小孝校肖嘯笑效楔些歇蠍鞋協挾攜邪斜脅諧寫械卸蟹懈泄瀉謝屑薪芯鋅欣辛新忻心信舋星腥猩惺興刑型形邢行醒幸杏性姓兄凶胸匈洶雄熊休修羞朽嗅鏽秀袖繡墟戌需虛噓須徐許蓄酗敘旭序畜恤絮婿緒續軒喧宣懸旋玄選癬眩絢靴薛學穴雪血勛熏循旬詢尋馴巡殉汛訓訊遜迅壓押鴉鴨呀丫芽牙蚜崖衙涯雅啞亞訝焉咽閹煙淹鹽嚴研蜒岩延言顏閻炎沿奄掩眼衍演艷堰燕厭硯雁唁彥焰宴諺驗殃央鴦秧楊揚佯瘍羊洋陽氧仰痒養樣漾邀腰妖瑤搖堯遙窯謠姚咬舀藥要耀椰噎耶爺野冶也頁掖業葉曳腋夜液一壹醫揖銥依伊衣頤夷遺移儀胰疑沂宜姨彝椅蟻倚已乙矣以藝抑易邑屹億役臆逸肄疫亦裔意毅憶義益溢詣議誼譯異翼翌繹茵蔭因殷音陰姻吟銀淫寅飲尹引隱印英櫻嬰鷹應纓瑩螢營熒蠅迎贏盈影穎硬映喲擁佣臃癰庸雍踴蛹詠泳涌永恿勇用幽優悠憂尤由郵鈾猶油游酉有友右佑釉誘又幼迂淤於盂榆虞愚輿余俞逾魚愉渝漁隅予娛雨與嶼禹宇語羽玉域芋郁吁遇喻峪御愈欲獄育譽浴寓裕預豫馭鴛淵冤元垣袁原援轅園員圓猿源緣遠苑願怨院曰約越躍鑰岳粵月悅閱耘雲鄖勻隕允運蘊醞暈韻孕匝砸雜栽哉災宰載再在咱攢暫贊贓臟葬遭糟鑿藻棗早澡蚤躁噪造皂灶燥責擇則澤賊怎增憎曾贈扎喳渣札軋鍘閘眨柵榨咋乍炸詐摘齋宅窄債寨瞻氈詹粘沾盞斬輾嶄展蘸棧佔戰站湛綻樟章彰漳張掌漲杖丈帳賬仗脹瘴障招昭找沼趙照罩兆肇召遮折哲蟄轍者鍺蔗這浙珍斟真甄砧臻貞針偵枕疹診震振鎮陣蒸掙睜征猙爭怔整拯正政幀症鄭証芝枝支吱蜘知肢脂汁之織職直植殖執值侄址指止趾隻旨紙志摯擲至致置幟峙制智秩稚質炙痔滯治窒中盅忠鐘衷終種腫重仲眾舟周州洲謅粥軸肘帚咒皺宙晝驟珠株蛛朱豬諸誅逐竹燭煮拄矚囑主著柱助蛀貯鑄筑住注祝駐抓爪拽專磚轉撰賺篆樁庄裝妝撞壯狀椎錐追贅墜綴諄准捉拙卓桌琢茁酌啄著灼濁茲咨資姿滋淄孜紫仔籽滓子自漬字鬃棕蹤宗綜總縱鄒走奏揍租足卒族祖詛阻組鑽纂嘴醉最罪尊遵昨左佐柞做作坐座亍丌兀丐廿卅丕亙丞鬲孬噩禺匕乇夭爻卮氐囟胤馗毓睪亟鼐乜乩亓羋孛嗇嘏仄厙厝厴厥靨贗匚叵匭匱匾賾卦卣刈刎剄刳劌剴剌剞剡剜蒯剽劂劁劓罔仃仉仂仨仡仞傴仳伢佤仵倀傖伉佇佞佧攸佚佝佟佗伽佶佴侑侉侃侏佾佻儕佼儂侔儔儼儷俅俚俁俜俑俟俸倩偌俳倬倏倭俾倜倌倥倨僨偃偕偈偎傯僂儻儐儺傺僖儆僭僬僦僮儇儋仝汆佘僉俎龠糴兮巽黌馘囅夔匍訇匐鳧夙兕兗亳袞袤褻臠裒稟嬴蠃羸冱冽冼塚冥訐訌訕謳詎訥詁訶詆詔詒誆誄詿詰詼詵詬詮諍諢詡誚誥誑誒諏諑諉諛諗諂誶諶諫謔謁諤諭諼諳諦諮諞謨讜謖謚謐謫譾譖譙譎讞譫讖巹阢阡阱阪阽阼陂陘陔陟隉陬陲陴隈隍隗隰邗邛鄺邙鄔邡邴邳邶鄴邸邰郟郅邾鄶郇鄆酈郢郜郗郛郫郯郾鄄鄢鄞鄣鄱鄯鄹酃酆芻奐勱劬劭劾哿勖勰叟燮矍鬯弁畚胇坌堊塾墼壅壑圩圬圳壙圮圯壢圻坩坫壚坼坻坨坭坶坳埡垤垌塏埏垓垠埕塒堝塤埒垸埴埸埤堋堍埽埭堀堞堙堠塥墁墉墀馨鼙懿艽艿芏芊芨芄芎芑薌芙芫芸芾芰藶苣芘芷芮莧萇蓯芩芴芡芟苧芤苡茉苤蘢茇苜苴苒茌苻苓蔦茆塋煢苠苕茜荑蕘蓽茈莒茼茴茱莛蕎茯荏荇荃薈荀茗薺茭茺茳犖滎茛藎蓀葒荸蒔萵莠莪莓蒞荼莩荽蕕荻莘莞莨鶯菁萁菥菘堇萋菝菽菖萸萑萆菔菟萏萃菸菹菪菅菀縈菰菡葑葚葙葳蕆葺蕢葸萼葆葩葶蔞蒎萱葭蓁蓍蓐驀蓓蓊蒿蒺蘺蒡蒹蒴蒗蕷蔌甍蓰蘞蔟藺蕖蔻蓿蓼蕙蕈蕨蕤蕞蕺瞢蕃蘄蕻薤薨薇薏蕹藪薜薅薹薷薰蘚藜藿蘧蘅蘩蘼廾弈夼奩耷奕奚奘匏尢尥尬尷捫摶抻拊拚拗拮撟拶挹捋捃掭揶捱捺掎摑捭掬掊捩掮摜揲揠撳揄揎摒揆掾攄摁搋搛搠榐搦搡摞攖摭撖摺擷擼撙攛擐擗擤擢攉攥攮弋忒弒叱嘰叩叨叻吒吆嘸囈呔嚦呃唄咂呷呱呤咚嚀咄呶呦咭哂噠咧咦嘵嗶呲噦咻咿噲嚌咩咪噥哏哞嘜哧嘮哽唔哳嗩唏唑唧唪嘖喏喵囀啁啕啐唷啖啵啶唳唰啜喋嗒喃喱喈喁喟啾嗖喑啻嗟嘍嚳喔喙嗷嗉嘟嗑囁嗔嗦嗝嗄嗯嗥嗲噯嗌嗍嗨嗤轡嘈嘌嘁嚶嗾嘀嘧噘嘹噗嘬噢噙嚕噌嚆噤噱噫嚅嚓囔囝囡圇囫囹囿圄圊圉圜幃帙帔帑幬幘幗帷幄幔幛幡岌屺岍岐嶇岈峴岑嵐岵岢岬岫岱岣岷嶧峒嶠峋崢嶗崍崧崦崮崤崞崆崛嶸崴崽嵬崳嵯嶁嵫嵋嵊嵩嶂嶙嶝豳嶷巔彳彷徂徇徉徠徙徜徨徭徵徼衢犰犴獷狃狁狎狒狨獪狩猻狴狷猁狳獫狺狻猗猓玀猊猞猝獼猢猥猱獐獍獗獠獬獯獾舛夥飧夤餳飩餼飪飫飭飴餉餑餘餛餿饃饈饉饌庀廡庋庖庥庠庹庵庾庳賡廒廑廛廨廩膺忉忖懺憮忮慪忡忤愾悵愴忪忭忸怙怵怦怛怏怍怩怫怊懌怡慟懨惻愷恂恪惲悖悚慳悝悃悒悌悛愜悻悱惝惘惆惚悴慍憒愕愣惴愀愎愫慊慵憬憔憧懍懵忝隳閂閆闈閎閔閌闥閭閫鬮閬閾閶閿閽閼闃闋闔闐闕闞戕汔汜汊灃沅沐沔沌汨汴汶沆溈泐泔沭瀧瀘泱泗泠泖濼泫泮沱泓泯涇洹洧洌浹湞洇洄洙洎洫澮洮洵洚瀏滸潯洳涑浯淶潿浞涓涔浠浼浣渚淇淅淞瀆涿淠澠淦淝淙瀋涫淥涮渫湮湎湫溲湟漵湓湔渲渥湄灩溱溘灄漭瀅溥溧溽溷潷溴滏溏滂溟潢瀠瀟漕滹漯漶瀲瀦漪漉漩澉澍澌潸潲潼潺瀨濉澧澹澶濂濡濮濠濯瀚瀣瀛瀹瀵灝灞宄宕宓宥宸甯騫搴寤寮褰寰蹇謇迓迕迥迮迤邇迦逕迨逅逄逋邐逑逍逖逡逵逶逭逯遄遑遒遐遨遘遢遛暹遴遽邂邈邃邋彗彖彘尻咫屐屙孱屣屨羼弳弩弭艴弼鬻妁妃妍嫵嫗妣妗姊媯妞妤姒妲妯姍妾婭嬈姝孌姣姘娌娉媧嫻娑娣娓婀婧婊婕娼婢嬋媼媛婷婺媾嫫媲嬡嬪媸嫠嫣嬙嫖嫦嫘嫜嬉嬗嬖嬲嬤孀尕孚孥孳孑孓孢駔駟駙騶驛駑駘驍驊駢驪騏騍騅驂騭騖驁騮騸驃驄驏驥驤紆紂紇紈纊紜紕紓紺紲紱縐紼絀絎絳綆綃綈綾綺緋緄綞綬綹綣綰緇緙緗緹緲繢緦緶緱縋緡縉縝縟縞縭縊縑繽縹縵縲繆繅纈繚繒繾繰繯纘畿甾邕玎璣瑋玢玟玨珂瓏玷玳珀珈珥珙頊琊珩珧珞璽琿璉琪瑛琦琥琨琰琮琬琛琚瑁瑜瑗瑕瑙璦瑭瑾璜瓔璀璁璇璋璞璨璩璐璧瓚璺韙韞韜杌杓杞杈榪櫪枇杪杳枘杵棖樅梟枋杷杼柰櫛柘櫳柩枰櫨柙枵柚枳柝梔柃枸柢櫟柁檉栲栳椏橈桎楨桄榿梃栝樺桁檜桀欒桉栩梵梏桴桷梓桫櫺楮棼櫝槧棹欏棰椋槨楗棣椐楱椹楠楂楝欖楫楸椴槌櫬櫚槎櫸楦楣楹榛榧榻榫榭槔榱槁槊檳榕櫧榍槿檣槭樗樘櫫槲橄樾檠橐橛樵檎櫓樽樨橘櫞檑檐檁檗猷歿殂殤殄殞殮殍殫殛殯殪軔軛軻轤軹軼軫轢軺軾輊輇輅輒輦輞輟輜輳轆轔戔戧戛戟戢戡戥戤戩臧甌瓴瓿甏甑甓旮旯旰昊曇杲昃昕昀炅曷昝昴昱昶昵耆晟曄晁晏暉晡晷暄暌曖暝暾曛曜曦曩賁貰貺貽贄貲賅贐賑賚賕賧賻覘覬覡覿覦覯覲覷牮牝牯牾牿犄犋犍犒挈挲掰搿擘耄毳毽毿毹氅氌氆氍氕氘氙氚氡氬氤氪氳敕牘牒牖爰虢刖肜肓朊肱肫肭肴朧臚胛胂冑胙胍胗朐胝脛胱胴胭膾胼朕豚腡脞脬脘腌腓腴腱腠腩膃塍媵膈膂臏滕膣臌朦臊膻膦歟欷欹歃歆歙颮颯颶颼飆彀轂觳斐齏斕於旆旄旃旌旎旒旖煬煒燉炷炫炱燁烊焐焓燜焯焱煜煨煲煸熳熵熨熠燠燔燧燹爝爨燾煦熹戾戽扃扈扉祀祆祉祛祜祓祚檷祗祠禎祧祺禪禊禚禧禳忑忐懟恝恚恧恁恙恣愨愆愍慝憩憝懋懣戇聿沓澩淼磯矸碭砉硨砑斫砭砝礪礱砟砥砬砣砩硎硭硤磽砦硐硌磧碓碚碇磣碡碣碲碥磔磉磬磲礅磴礓礤礞礡龕黹黻黼盱眄盹眇眈眚眢眙眭眵眸睞瞼睇睚睨睢睥睿瞍睽瞀瞌瞑瞟瞠瞰瞵瞽町畀畎畋畈畛畬畹罘罡罟詈罨羆罹羈罾盍盥蠲釓釔釙釗釕釷釧釤鍆釵釹鈦鉅鈑鈐鈁鈧鈄鈥鈀鈺鉦鈷鈳鈽鈸鉞鉬鉭鈿鑠鈰鉉鉈鉍鈮鈹鐸銬銠鉺銪鋮鋏鐃鐺銦鎧銖鋌銩鏵銓鉿鎩銚錚銫銃鐋銨銣鐒錸鋱鏗鋰鋯鋨銼鋝鋃鋟鋦錒錆錛錁錕錮錈錟錙鍥鍇鍶鍔鍤鎪鍰鏤鏘鏌鎘鐫鎦鎰鎵鑌鏢鏜鏝鏍鏞鏃鏇鏑鐔鏷鐓鑭鐠鏹鐙鑊鐲鐿鑣鍾矧矬雉秕秭秣秫嵇稃稂稞稔稹稷穡黏馥穰皈皎皓皙皤瓞瓠甬鳩鳶鴇鴆鴣鶇鸕鴝鴟鷥鴯鷙鴰鵂鸞鵓鸝鵠鵒鷴鵜鵡鵪鵯鶉鶘鶚鷂鶼鸚鷓鷚鷯鷦鷲鷸鷺鸛疔癤癘疝疣疳疸疰痂痍痣癆痦痤癇痧瘃痱痼痿瘐瘀癉瘌瘞瘊瘥瘕瘙瘼瘢瘠瘭瘰癭瘵癃癮瘳癩癜癖癲翊竦穸穹窀窆窈窕竇窠窬窨窶窳衩衲衽衿袂袢襠袷袼裉褳裎襝襉裱褚裼裨裾裰褡褙褓褸褊襤褫褶襁襦襻疋胥皸皴矜耒耔耖耜耦耬耩耨耋耵聃聆聹聒聵聱覃頇頎頏頡頜頦頷顎顓顳顢顙顥顰虔虯蟣蠆虺虼虻蚨蚍蚋蜆蚝蚧蚣蚪蚓蚩蚶蛄蚵蠣蚰蚺蚱蚯蛉蟶蚴蛩蛺蟯蛭螄蛐蜓蛞蠐蛟蛘蛑蜃蜇蛸蜈蜊蜍蜉蜣蜻蜞蜥蜮蜚蜾蟈蜴蜱蜩蜷蜿螂蜢蠑蝻蝠蝌蝮蝓蝣螻蝤蝙蝥螓螯蟒蟆螈螅螭螗螃螫蟥螬螵螳蟋蟓螽蟑蟀蟊蟛蟪蟠蠖蠓蟾蠊蠛蠡蠹蠷缶罌罄罅舐竺竽笈篤笄筧笊笫笏筇笸笪笙笮笱笠笥笤笳籩笞筘篳筅筵筌箏筠筮筲筱箐簀篋箸箬箝籜箅簞箜簫箴簣篁篌篝篚篥篦篪簌篾簏籪簋簟簪簦簸籟籀臾舁舂舄臬衄舡舢艤舯舨舫舸艫舳舴艄艉艋艏艚艟艨衾裊袈裘裟襞羝羥羧羯羰羲敉粑粞粢粲粼粽糝糌糈糅糗糨艮暨羿翎翕翥翡翦翩翮翳糸縶綦綮繇纛麩麴赳趄趔趑趲赧赭豇豉酊酐酎酏酤酢酡酩酯釅釃酲酴酹醅醐醍醑醢醣醪醭醮醯醵醴醺豕鹺躉跫踅蹙蹩趵趿趼趺蹌跖跗跚躒跎跏跛跆跬蹺蹕跣躚躋跤踉跽踔踝踟躓踮踣躑蹀踵踽踱蹉蹁蹂躡蹣蹊躕蹶蹼蹯蹴躅躪躔躐躦躞豸貂貊貅貘貔斛觖觴觚觜觥觫觶訾謦靚雩靂雯霆霽霈霏霎霪靄霰霾齔齟齙齠齜齦齬齪齷黽黿鼉隹隼雋雎雒瞿讎銎鑾鋈鏨鍪鏊鎏鑫魷魴鱍鱸穌鮒鱟鮐鮚鮪鮞鱭鮫鯗鱘鯁鱺鰱鰹鰣鰷鯀鯊鯇鯽鯖鯪鯫鯡鯤鯧鯢鯰鯛鯔鰈鱷鰍鰒鰉鰲鰭鰨鰥鰩鰳鰾鱈鰻鱖鱔鱒鱧靼鞅韃鞔韉鞫鞣骱骰骷鶻骼髁髀髏髂髖髕髑魅魃魘魎魈魍魑饗饜餮饕饔髟髡髦髯髫髻髭髹鬈鬢鬟鬣麼麾縻麂麇麈麋麒鏖麝麟黛黜黝黠黟黷黧黥黲黯鼢鼬鼯鼴鼷鼽鼾";
	
	/**
	 * 获取最简文件名
	 */ 
	public static String getShortFileName (String str) {
		if (!isEmpty(str)) {
			String[] x = str.split("\\\\");
			if (x != null && x.length > 0) {
				return x[x.length-1];
			}
		}
		return "";
	}
	/**
	 * unicode 转换成 中文
	 * 
	 * @author
	 * @param theString
	 * @return
	 */

	public static String decodeUnicode(String theString) {
		char aChar;
		int len = theString.length();
		StringBuffer outBuffer = new StringBuffer(len);
		for (int x = 0; x < len;) {
			aChar = theString.charAt(x++);
			if (aChar == '\\') {
				aChar = theString.charAt(x++);
				if (aChar == 'u') {
					// Read the xxxx
					int value = 0;
					for (int i = 0; i < 4; i++) {
						aChar = theString.charAt(x++);
						switch (aChar) {
						case '0':
						case '1':
						case '2':
						case '3':
						case '4':
						case '5':
						case '6':
						case '7':
						case '8':
						case '9':
							value = (value << 4) + aChar - '0';
							break;
						case 'a':
						case 'b':
						case 'c':
						case 'd':
						case 'e':
						case 'f':
							value = (value << 4) + 10 + aChar - 'a';
							break;
						case 'A':
						case 'B':
						case 'C':
						case 'D':
						case 'E':
						case 'F':
							value = (value << 4) + 10 + aChar - 'A';
							break;
						default:
							throw new IllegalArgumentException(
									"Malformed   \\uxxxx   encoding.");
						}

					}
					outBuffer.append((char) value);
				} else {
					if (aChar == 't')
						aChar = '\t';
					else if (aChar == 'r')
						aChar = '\r';
					else if (aChar == 'n')
						aChar = '\n';
					else if (aChar == 'f')
						aChar = '\f';
					outBuffer.append(aChar);
				}
			} else
				outBuffer.append(aChar);
		}
		return outBuffer.toString();
	}
	
	public static String pStr(String str){
		if(str==null){
			return "";
		}
		str = StringUtils.trim(str);
		str = str.replaceAll("'", "＇").replace("\\", "");
		return str;
	}




	/**
	 * 解决中文的乱码问题
	 * 
	 * @param chi
	 *            为输入的要汉化的字符串
	 * @return String 经过转换后的字符串
	 */
	public static String transChiTo8859(String chi) {

		if (StringUtil.isEmpty(chi))
			return "";

		String result = null;
		byte temp[];
		try {
			temp = chi.getBytes("GBK");
			result = new String(temp, "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
		}

		return result;

	}

	public static String parseEnter(String html) {
		String reg = "[\r\n]";
		Pattern p = Pattern.compile(reg);
		Matcher m = p.matcher(html);
		String s = m.replaceAll("\3\2\1");
		return s;
	}

	public static String parseHtml(String html) {
		if (html != null) {
			return html.replaceAll("\r", "<br>");
		}
		return "";
	}


	/**
	 * 截取字符串 包括中文
	 * 
	 * @param str
	 * @param count
	 * @return
	 */
	public static String dochar(String str, int count) {
		try {
			byte[] temp = str.getBytes("GBK");
			byte[] bArray = new byte[count * 2];

			int i;
			int ii = 0;// 用于判断最后一个是不是一半汉字
			String strc = "full";

			for (i = 0; i < count; i++) {
				bArray[i] = temp[i];
			}
			for (i = 0; i < count; i++) {
				if (bArray[i] < 0) {
					ii++;
				}
			}
			if (ii % 2 != 0) {
				strc = "hard";
			}

			// 截下去为完全的时候
			if (strc.equals("full") && bArray[i] < 0) {
				bArray[i] = ' ';
			}
			// 截下去为一半的时候
			if (strc.equals("hard") && bArray[i - 1] < 0) {
				bArray[i - 1] = ' ';
			}
			// String ret = new String(bArray,"utf8");
			String ret = new String(bArray, "gbk");
			// String ret2 = new String(bArray,"iso8859-1");
			return ret.trim();
		} catch (Exception e) {
			return str;
		}
	}

	public static String getChnmoney(double number_i) {
		String strNum = String.valueOf(number_i);
		int n, m, k, i, j, q, p, r, s = 0;
		int length, subLength, pstn;
		String change, output, subInput, input = strNum;
		output = "";
		if (strNum.equals(""))
			return null;
		else {
			length = input.length();
			pstn = input.indexOf('.'); // 小数点的位置

			if (pstn == -1) {
				subLength = length;// 获得小数点前的数字
				subInput = input;
			} else {
				subLength = pstn;
				subInput = input.substring(0, subLength);
			}

			char[] array = new char[4];
			char[] array2 = { '仟', '佰', '拾' };
			char[] array3 = { '亿', '万', '元', '角', '分' };

			n = subLength / 4;// 以千为单位
			m = subLength % 4;

			if (m != 0) {
				for (i = 0; i < (4 - m); i++) {
					subInput = '0' + subInput;// 补充首位的零以便处理
				}
				n = n + 1;
			}
			k = n;

			for (i = 0; i < n; i++) {
				p = 0;
				change = subInput.substring(4 * i, 4 * (i + 1));
				array = change.toCharArray();// 转换成数组处理

				for (j = 0; j < 4; j++) {
					output += formatC(array[j]);// 转换成中文
					if (j < 3) {
						output += array2[j];// 补进单位，当为零是不补（千百十）
					}
					p++;
				}

				if (p != 0)
					output += array3[3 - k];// 补进进制（亿万元分角）
				// 把多余的零去掉

				String[] str = { "零仟", "零佰", "零拾" };
				for (s = 0; s < 3; s++) {
					while (true) {
						q = output.indexOf(str[s]);
						if (q != -1)
							output = output.substring(0, q) + "零"
									+ output.substring(q + str[s].length());
						else
							break;
					}
				}
				while (true) {
					q = output.indexOf("零零");
					if (q != -1)
						output = output.substring(0, q) + "零"
								+ output.substring(q + 2);
					else
						break;
				}
				String[] str1 = { "零亿", "零万", "零元" };
				for (s = 0; s < 3; s++) {
					while (true) {
						q = output.indexOf(str1[s]);
						if (q != -1)
							output = output.substring(0, q)
									+ output.substring(q + 1);
						else
							break;
					}
				}
				k--;
			}

			if (pstn != -1)// 小数部分处理
			{
				for (i = 1; i < length - pstn; i++) {
					if (input.charAt(pstn + i) != '0') {
						output += formatC(input.charAt(pstn + i));
						output += array3[2 + i];
					} else if (i < 2)
						output += "零";
					else
						output += "";
				}
			}
			if (output.substring(0, 1).equals("零"))
				output = output.substring(1);
			if (output.substring(output.length() - 1, output.length()).equals(
					"零"))
				output = output.substring(0, output.length() - 1);
			return output += "整";
		}
	}

	public static String formatC(char x) {
		String a = "";
		switch (x) {
		case '0':
			a = "零";
			break;
		case '1':
			a = "壹";
			break;
		case '2':
			a = "贰";
			break;
		case '3':
			a = "叁";
			break;
		case '4':
			a = "肆";
			break;
		case '5':
			a = "伍";
			break;
		case '6':
			a = "陆";
			break;
		case '7':
			a = "柒";
			break;
		case '8':
			a = "捌";
			break;
		case '9':
			a = "玖";
			break;
		}
		return a;
	}


	/**
	 * 取得两个时间之间的差数（天）
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static String getTime(Date startDate, Date endDate) {
		if (startDate != null && endDate != null) {
			int date = (int) (endDate.getTime() - startDate.getTime())
					/ (1000 * 60 * 60 * 24);
			return String.valueOf(date);
		}
		return "";
	}

	/**
	 * 取得两个时间之间的差数（天）
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static String getTimeIncludeHead(Date startDate, Date endDate) {
		if (startDate != null && endDate != null) {
			int date = (int) (endDate.getTime() - startDate.getTime())
					/ (1000 * 60 * 60 * 24) + 1;
			return String.valueOf(date);
		}
		return "";
	}


	public static String readByURL(String url) {

		StringBuffer sb = new StringBuffer();
		InputStream l_urlStream=null;
		try {

			String sCurrentLine = "";
			URL l_url = new java.net.URL(url);
			HttpURLConnection l_connection = (java.net.HttpURLConnection) l_url
					.openConnection();

			l_connection.connect();

			l_urlStream = l_connection.getInputStream();

			java.io.BufferedReader l_reader = new java.io.BufferedReader(
					new java.io.InputStreamReader(l_urlStream, "UTF8"));

			while ((sCurrentLine = l_reader.readLine()) != null) {
				sb.append(sCurrentLine).append("\r\n");
			}
			l_reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(l_urlStream!=null){
				try {
					l_urlStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return sb.toString();

	}

	/**
	 * @param data
	 * @return
	 */
	public static String decodeUrlByUtf8(String data) {
		try {
			return java.net.URLDecoder.decode(data, "utf8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * encodeurl，使用Utf8编码
	 * 
	 * @param name
	 *            要编码的字符
	 * @return String 编码后的字符
	 */
	public static String encodeUrlByUtf8(String name) {
		if (name == null) {
			return "";
		}
		try {
			name = java.net.URLEncoder.encode(name, "UTF-8");
		} catch (Exception e) {
		}
		return name;
	}

	public static int parseInt(String s) {
		if (s == null) {
			return 0;
		}
		try {
			int i = Integer.parseInt(s);
			return i;
		} catch (Exception e) {
		}
		return 0;
	}



	private static String getFileName(String fileName) {
		if (fileName != null && !fileName.equalsIgnoreCase("")) {
			int index = fileName.indexOf(".");
			return fileName.substring(0, index);
		}
		return null;
	}

	/**
	 * 将helloWorld转hello_world
	 * 
	 * @param input
	 * @return
	 */
	public static String getSplitString(String input) {
		StringBuffer str = new StringBuffer();
		if (input != null) {
			for (int i = 0; i < input.length(); i++) {
				char a = input.charAt(i);
				if (i != 0 && (a >= 'A') && (a <= 'Z')) {
					a += 32;
					str.append("_");
				}
				str.append(a);
			}
		}
		return str.toString();
	}

	public static double parseDouble(String s){
		if(s == null){
			return 0.0;
		}
		try{
			double i = Double.parseDouble(s);
			return i;
		}catch(Exception e){
			
		}
		return 0.0;
	}

	/**
	 * 把控字符转换成空串
	 * @param str
	 * @return
	 */
	public static String blanknull(String str){
		if(str!=null){
			return str;
		}else{
			return "";
		}
	}
	
	/**
	 * 将0/1转换成否/是
	 * @param str
	 * @return
	 */
	public static String numToCh(String str){
		if (str != null) {
			if ("0".endsWith(str)) {
				return "否";
			} else if ("1".endsWith(str)) {
				return "是";
			}
		}
		return "";
	}
	
	/**
	 * 字符串只保留中文
	 */
	public static String toCH (String str) {
		String regEx = "[`~☆★!@#$%^&*()+=|{}':;,\\[\\]》·.<>/?~！@#￥%……（）——+|{}【】‘；：”“’。，、？]";//去除特殊字符
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(str);
		str = m.replaceAll("")
				.replace(" ", "")//去除空格
				.replaceAll("\\d+","")//去除数字
				.replaceAll("[a-zA-Z]", "");//去除英文字母
		return str;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: autoGenericCode 
	* @Description: 获取编码。不够位数的在前面补0，保留num的长度位数字
	* @param code   需要转换的编码
	* @param length   保留长度
	* @return
	* @return String    返回类型 
	* @date： 2019年7月9日下午3:20:51 
	* @throws
	 */
	public static String autoGenericCode(String code, int length) {
		if(StringUtils.isEmpty(code)){
			code="0";
		}
        String result = "";
        // 保留num的位数
        // 0 代表前面补充0     
        // length 代表长度  
        // d 代表参数为正数型 
        result = String.format("%0" + length + "d", Integer.parseInt(code) + 1);
 
        return result;
    }
	
	
	/**
	 * 
	 * @Description: 首页模块显示
	 * @author 汪耀
	 * @param @param list
	 * @param @param separator
	 * @param @return    
	 * @return String
	 */
	public static String nameJoint(List list, String separator, int rows){
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<list.size(); i++){
			sb.append(list.get(i)).append(separator);
			//rows:添加一行或者指标勾选的行数 资产：默认拼3项	写入4	内/外部指标：默认拼2项	写入3
			if(i == rows-2)break;
		}
		if(sb.length()>0){
			if(list.size()>3){
				sb.replace(sb.length()-1, sb.length(), "等");
			}else{
				sb.replace(sb.length()-1, sb.length(), "");
			}
		}
		return list.isEmpty()? "" : sb.toString();
	}
	
	
}