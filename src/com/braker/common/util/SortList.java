package com.braker.common.util;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortList<E>{
	@SuppressWarnings("unchecked")
	public void Sort(List<E> list, final String method, final String sort,final String type){
	    Collections.sort(list, new Comparator() {
	      public int compare(Object a, Object b) {
	        int ret = 0;
	        try{
	          SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	          Method m1 = ((E)a).getClass().getMethod(method, null);
	          Method m2 = ((E)b).getClass().getMethod(method, null);
	         
	          if(sort != null && "desc".equals(sort)){//倒序
	        	/*字符串的排序*/
	        	  if("number".equals(type)){
		        	  ret = Integer.parseInt(m2.invoke(((E)b), null).toString())-Integer.parseInt(m1.invoke(((E)a), null).toString());
		          }else{
		        	  ret = m2.invoke(((E)b), null).toString().compareTo(m1.invoke(((E)a), null).toString());
		          }
	        	
	           
	          }else{//正序
	        	/*字符串的排序*/
	           
	        	  if("number".equals(type)){
		        	  ret = Integer.parseInt(m1.invoke(((E)b), null).toString())-Integer.parseInt(m2.invoke(((E)a), null).toString());
		          }else{
		        	  ret = m1.invoke(((E)a), null).toString().compareTo(m2.invoke(((E)b), null).toString());
		          }
	          }
	        }catch(NoSuchMethodException ne){
	          System.out.println(ne);
	        }catch(IllegalAccessException ie){
	          System.out.println(ie);
	        }catch(InvocationTargetException it){
	          System.out.println(it);
	        }
	        return ret;
	      }
	     });
	  }
	}
