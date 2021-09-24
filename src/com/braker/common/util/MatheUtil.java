package com.braker.common.util;

import java.math.BigDecimal;


/**
 * 
 * <p>Description: 数据计算类</p>
 * @author:安达
 * @date： 2019年7月4日下午5:42:57
 */
public class MatheUtil {
	
	/**
	 * 
	* @author:安达
	* @Title: add 
	* @Description: 相加
	* @param a1
	* @param b1
	* @return
	* @return double    返回类型 
	* @date： 2019年7月4日下午5:45:19 
	* @throws
	 */
	 public static double add(double a1, double b1) {  
         BigDecimal a2 = new BigDecimal(Double.toString(a1));  
         BigDecimal b2 = new BigDecimal(Double.toString(b1));  
         return a2.add(b2).doubleValue();  
     }
	
	 /**
	  * 
	 * @author:安达
	 * @Title: sub 
	 * @Description: 相减
	 * @param a1
	 * @param b1
	 * @return
	 * @return double    返回类型 
	 * @date： 2019年7月4日下午5:45:29 
	 * @throws
	  */
	 public static double sub(double a1, double b1) {  
          BigDecimal a2 = new BigDecimal(Double.toString(a1));  
          BigDecimal b2 = new BigDecimal(Double.toString(b1));  
          return a2.subtract(b2).doubleValue();  
      }
	
	 /**
	  * 
	 * @author:安达
	 * @Title: mul 
	 * @Description: 相乘 
	 * @param a1
	 * @param b1
	 * @return
	 * @return double    返回类型 
	 * @date： 2019年7月4日下午5:45:46 
	 * @throws
	  */
	 public static double mul(double a1, double b1) {  
          BigDecimal a2 = new BigDecimal(Double.toString(a1));  
          BigDecimal b2 = new BigDecimal(Double.toString(b1));  
          return a2.multiply(b2).doubleValue();  
      }
	 
	 
	 /**
	  * 
	 * @author:安达
	 * @Title: div 
	 * @Description: 相除
	 * @param a1
	 * @param b1
	 * @param scale 保存小数点位数
	 * @return
	 * @return double    返回类型 
	 * @date： 2019年7月4日下午5:45:55 
	 * @throws
	  */
	 public static double div(double a1, double b1, int scale) {
	        if (scale < 0) {  
	            throw new IllegalArgumentException("error");  
	        }
	        BigDecimal a2 = new BigDecimal(Double.toString(a1));  
	        BigDecimal b2 = new BigDecimal(Double.toString(b1));  
	        return a2.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();  
	    } 
}
