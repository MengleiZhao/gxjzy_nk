package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.page.Pagination;
import com.braker.common.util.LookupsUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.CategoryMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Category;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Transactional
@Service
public class LookupsMngImpl extends BaseManagerImpl<Lookups> implements LookupsMng{
	
	@Autowired
	private CategoryMng categoryMng;
	
	public  void init(){
		//查询所有字典表数据
		List<Lookups> lookupsList=super.findAll(OrderBy.asc("orderNo"));
		Map<String,List<Lookups>> lookupsListMap=getEmptyLookupsListMap(lookupsList);
		Map<String,Map<String,String>> pcCodeTextMap=getEmptyCodeTextMap(lookupsList);
		for(Lookups lookups:lookupsList){
			if("1".equals(lookups.getFlag())){
				if(lookupsListMap.get(lookups.getCategoryCode()) !=null){
					List<Lookups> childList=lookupsListMap.get(lookups.getCategoryCode());
					childList.add(lookups);
					lookupsListMap.put(lookups.getCategoryCode(), childList);
				}
				if(pcCodeTextMap.get(lookups.getCategoryCode()) !=null){
					Map<String,String> childMap=pcCodeTextMap.get(lookups.getCategoryCode());
					childMap.put(lookups.getCode(), lookups.getName());
					pcCodeTextMap.put(lookups.getCategoryCode(), childMap);
				}
				LookupsUtil.codeLookupsMap.put(lookups.getCode(), lookups);
			}
		}
		LookupsUtil.codeLookupsListsMap=lookupsListMap;
		LookupsUtil.pCodeCodeTextMap=pcCodeTextMap;
	}
	/**
	 * 
	* @author:安达
	* @Title: getEmptyLookupsListMap 
	* @Description: 这里用一句话描述这个方法的作用 
	* @param lookupsList
	* @return
	* @return Map<String,List<Lookups>>    返回类型 
	* @date： 2019年7月19日下午11:08:40 
	* @throws
	 */
	private Map<String,List<Lookups>> getEmptyLookupsListMap(List<Lookups> lookupsList){
		 Map<String,List<Lookups>> parentLookupsMap=new HashMap<String,List<Lookups>>();
		 for(Lookups lookups:lookupsList){
				List<Lookups> childLst=new ArrayList<Lookups>();
				if(parentLookupsMap.get(lookups.getCategoryCode())==null){
					parentLookupsMap.put(lookups.getCategoryCode(), childLst);
				}
			}
		 return parentLookupsMap;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getEmptyCodeTextMapp 
	* @Description: 这里用一句话描述这个方法的作用 
	* @param lookupsList
	* @return
	* @return Map<String,Map<String,String>>    返回类型 
	* @date： 2019年7月19日下午11:08:24 
	* @throws
	 */
	private Map<String,Map<String,String>> getEmptyCodeTextMap(List<Lookups> lookupsList){
		 Map<String,Map<String,String>> pCodeCodeTextMap=new HashMap<String,Map<String,String>>();
		 for(Lookups lookups:lookupsList){
				Map<String,String> childMap=new HashMap<String,String>();
				if(pCodeCodeTextMap.get(lookups.getCategoryCode())==null){
					pCodeCodeTextMap.put(lookups.getCategoryCode(), childMap);
				}
			}
		 return pCodeCodeTextMap;
	}
	
	@Override
	public Pagination list(Lookups bean, String sort, String order,
			int pageIndex, int pageSize) {
		Finder f=Finder.create("from Lookups Where flag='1'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(null!=bean.getCategory() && !StringUtil.isEmpty(bean.getCategory().getCode())){
				f.append(" and category.code = :categoryCode");
				f.setParam("categoryCode",bean.getCategory().getCode());
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			f.append(" order by "+sort+" "+order);
		}else{
			f.append(" order by CONVERT(orderNo,SIGNED),name");
		}
		return super.find(f, pageIndex, pageSize);
	}

	@Override
	public boolean isExist(Lookups bean) {
		List<Lookups> list = null;
		StringBuffer hql=new StringBuffer("from Lookups where flag='1' ");
		hql.append(" and code='"+bean.getCode()+"' ");
		hql.append(" and category.id='"+bean.getCategory().getId()+"' ");
		if (!StringUtil.isEmpty(bean.getId())) {
			hql.append(" and id<>'"+bean.getId()+"' ");
		}
		
		list=super.find(hql.toString());
		if(null!=list && list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public List<Lookups> getLookupsByCategoryCode(String categoryCode) {
		//return super.find("from Lookups Where flag='1' and category.code = ? order by convert(orderNo,SIGNED)",new Object[]{categoryCode});
	//	return codeLookupsListsMap.get(categoryCode);
		return LookupsUtil.getLookupsByCategoryCode(categoryCode);
	}
	@Override
	public List<Lookups> getLookupsSelect(String categoryCode,String blanked) {
//		Finder hql=Finder.create("from Lookups Where flag='1' ");
//		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
//		if(!StringUtil.isEmpty(blanked)){
//			hql.append(" and code<>:code").setParam("code", blanked);
//		}
//		hql.append(" order by convert(orderNo,SIGNED)");
		return LookupsUtil.getLookupsSelect(categoryCode,blanked);
	}
	@Override
	public Lookups findByLookId(String id) {
		Finder hql=Finder.create(" from Lookups where flag=1 and id=:id").setParam("id", id);
		List<Lookups> list=super.find(hql);
		return list!=null&&list.size()>0?list.get(0):null;
	}

	@Override
	public Lookups findByLookCode(String code) {
//		Finder hql=Finder.create(" from Lookups where flag=1 and code=:code").setParam("code", code);
//		List<Lookups> list=super.find(hql);
//		return list!=null&&list.size()>0?list.get(0):null;
		return LookupsUtil.findByLookCode(code);
	}

	@Override
	public Lookups getByParentAndName(String parentCode, String name) {
//		List<Lookups> list = super.find("from Lookups Where flag='1' and category.code = ? and name like ?" +
//				"order by convert(int,orderNo)",new Object[]{parentCode,"%"+name+"%"});
//		if (list!=null && list.size()>0) {
//			return list.get(0);
//		}
//		return null;
		return LookupsUtil.getByParentAndName(parentCode,name);
	}

	@Override
	public int getMaxOrderByParent(String pCode) {
		int version=1;
		List<?> list=super.find("Select max(orderNo) from Lookups Where flag='1' and category.code=?",pCode);	
		if(null!=list && list.get(0)!=null && list.get(0).toString()!=null){
			version=Integer.valueOf(list.get(0).toString())+1;
		}    
		return version;
	}

	@Override
	public Lookups createNewLookups(String name, String pCode, User user) {
		int order = getMaxOrderByParent(pCode);//排序
		String code = pCode + "-" + String.valueOf(order);//代码
		Category cate = categoryMng.getCateByParentAndSelf(null, pCode);//父字典
		Lookups look = new Lookups(name, order, code, cate, user, new Date());
		look = (Lookups) saveOrUpdate(look);
		init();//操作完毕以后重新写入缓存
		return look;
	}

	@Override
	public String getNameByCategoryCodeAndCode(String categoryCode, String code) {
		// TODO Auto-generated method stub
		return LookupsUtil.getNameByCategoryCodeAndCode(categoryCode,code);
	}
	
}
