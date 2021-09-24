package com.braker.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.braker.core.model.Lookups;

public class LookupsUtil {
	public static Map<String,List<Lookups>> codeLookupsListsMap=new HashMap<String,List<Lookups>>();// 根据 编码获得字典列表集合
	public static Map<String, Map<String,String>> pCodeCodeTextMap=new HashMap<String, Map<String,String>>();// 根据 父编码获得字典的键值对
	public static Map<String,Lookups> codeLookupsMap=new HashMap<String,Lookups>();// 根据 编码获得字典的键值对
	
	
	/**
	 * 
	* @author:安达
	* @Title: getLookupsByCategoryCode 
	* @Description: 根据父编码获得字典集合
	* @param categoryCode
	* @return
	* @return List<Lookups>    返回类型 
	* @date： 2019年7月20日上午9:55:38 
	* @throws
	 */
	public  static List<Lookups> getLookupsByCategoryCode(String categoryCode) {
		return codeLookupsListsMap.get(categoryCode);
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getLookupsSelect 
	* @Description: 根据父编码获得除黑名单之外的集合
	* @param categoryCode
	* @param blanked
	* @return
	* @return List<Lookups>    返回类型 
	* @date： 2019年7月20日上午9:55:55 
	* @throws
	 */
	public static  List<Lookups> getLookupsSelect(String categoryCode,String blanked) {
		List<Lookups> lookupsList=codeLookupsListsMap.get(categoryCode);
		List<Lookups> list=new ArrayList<Lookups>();
		for(Lookups lookups:lookupsList){
			if(blanked ==null || !blanked.equals(lookups.getCode())){
				list.add(lookups);
			}
		}
		return list;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: findByLookCode 
	* @Description: 根据编码获得字典对象
	* @param code
	* @return
	* @return Lookups    返回类型 
	* @date： 2019年7月20日上午9:57:34 
	* @throws
	 */
	public  static Lookups findByLookCode(String code) {
		return codeLookupsMap.get(code);
		
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getByParentAndName 
	* @Description: 根据父编码和 字典名字获得字典对象
	* @param parentCode
	* @param name
	* @return
	* @return Lookups    返回类型 
	* @date： 2019年7月20日上午9:57:50 
	* @throws
	 */
	public  static Lookups getByParentAndName(String parentCode, String name) {
		
		List<Lookups> lookupsList=codeLookupsListsMap.get(parentCode);
		for(Lookups lookups:lookupsList){
			if( name !=null &&  name.equals(lookups.getName())){
				return lookups;
			}
		}
		return null;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getNameByCategoryCodeAndCode 
	* @Description: 根据父编码和字典编码获得字典名字
	* @param categoryCode
	* @param code
	* @return
	* @return String    返回类型 
	* @date： 2019年7月20日上午9:58:19 
	* @throws
	 */
	public static String getNameByCategoryCodeAndCode(String categoryCode, String code) {
		// TODO Auto-generated method stub
		String name="";
		Map<String,String> map=pCodeCodeTextMap.get(categoryCode);
		if(map!=null){
			name=map.get(code);
		}
		return name;
	}
	
}
