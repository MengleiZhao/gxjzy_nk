package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.CategoryMng;
import com.braker.core.model.Category;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Service
@Transactional
public class CategoryMngImpl extends BaseManagerImpl<Category> implements CategoryMng{

    @Override
	public synchronized boolean isExist(Category bean) {
		List<Category> list = null;
		if (StringUtil.isEmpty(bean.getId())) {
			if (null != bean.getParent() && null != bean.getParent().getId() && !"".equals(bean.getParent().getId())) {
				list=super.find("from Category where flag='1' and code=? and parent.id=?",new Object[]{bean.getCode(),bean.getParent().getId()});
			} else {
				list=super.find("from Category where flag='1' and code=?",new Object[]{bean.getCode()});
			}
		} else {
			if (null != bean.getParent() && null != bean.getParent().getId() && !"".equals(bean.getParent().getId())) {
				String hql ="from Category where code=? and id<>? and flag='1' and parent.id=?";
				list=super.find(hql,new Object[]{bean.getCode(),bean.getId(),bean.getParent().getId()});
			} else {
				String hql ="from Category where code=? and id<>? and flag='1'";
				list=super.find(hql,new Object[]{bean.getCode(),bean.getId()});
			}
		}
		if(null!=list && list.size()>0){
			return true;
		}
		return false;
	}
    
	@Override
	public Pagination list(Category bean, String sort, String order,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Category Where flag='1'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getCode())){
				f.append(" and code = :code");
				f.setParam("code",bean.getCode());
			}
			if(!StringUtil.isEmpty(bean.getParentCode())){
				f.append(" and parent.code = :parentcode");
				f.setParam("parentcode",bean.getParentCode());
			}
		}
		if(!StringUtil.isEmpty(sort) && !StringUtil.isEmpty(order) && (order.equals("asc") || order.equals("desc"))){
			f.append(" order by "+sort+" "+order);
		}else{
			f.append(" order by orderNo,name");
		}
		return super.find(f, pageIndex, pageSize);
	}

	@Override
	public List<Category> getParent(String id) {
		// TODO Auto-generated method stub
		List<Category> list = null;
		if(StringUtil.isEmpty(id)){
			list=super.find("from Category Where flag='1' order by orderNo,name",new Object[]{});
		}else{
			list=super.find("from Category Where flag='1' and id<>? order by orderNo,name",new Object[]{id});
		}
		return list;
	}

	@Override
	public List<Category> getRoots() {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Category Where flag='1' and parent.id is null order by orderNo,name");
		return super.find(f);
	}

	@Override
	public List<Category> getChild(String pid) {
		// TODO Auto-generated method stub
		String hql = "from Category where flag='1' and parent.id = ? order by orderNo,name";
		return find(hql, pid);
	}

	@Override
	public List<Category> getChildByParentCode(String parentCode) {
		// TODO Auto-generated method stub
		String hql = "from Category where flag='1' and parent.code = ? order by orderNo,name";
		return find(hql, parentCode);
	}
	
	@Override
	public List<Category> getCategoryRoots(String name,String parentId){
		Finder f=Finder.create("from Category Where flag='1' and parent.id is null ");
		if( !StringUtil.isEmpty( parentId ) && !"zdlxbm".equals(parentId) ){  f.append(" and id<>:parentId ").setParam("parentId", parentId); }
		if( !StringUtil.isEmpty( name ) ){  f.append(" and name like :name ").setParam("name", "%"+name+"%"); }
		f.append(" order by orderNo,name");
		return super.find(f);
	}
	
	@Override
	public List<Category> getCategoryChild(String pid,String name,String parentId){
		Finder f = Finder.create("from Category where flag='1'  ");
		if( !StringUtil.isEmpty( parentId ) && !"zdlxbm".equals(parentId) ){  f.append(" and id<>:parentId ").setParam("parentId", parentId); }
		if( !StringUtil.isEmpty( pid ) ){  f.append(" and parent.id = :pid ").setParam("pid", pid); }
		if( !StringUtil.isEmpty( name ) ){  f.append(" and name like :name ").setParam("name", "%"+name+"%"); }
		f.append(" order by orderNo,name");
		return super.find(f);
	}

	@Override
	public Category getCateByParentAndSelf(String parentCode, String selfCode) {
		Finder f = Finder.create(" from Category where flag='1' ");
		if (!StringUtil.isEmpty(parentCode)) {
			f.append(" and parent.code =:parentCode").setParam("parentCode", parentCode);
		}
		if (!StringUtil.isEmpty(selfCode)) {
			f.append(" and code =:selfCode").setParam("selfCode", selfCode);
		}else{
			return null;
		}
		List<Category> list = super.find(f);
		if (list != null && 0 != list.size() ) {
			return list.get(0);
		}
		return null;
	}
	@Override
	public List<Category> getRylx(String parentCode) {
		String hql = "from Category where flag='1' and parent.code = ? order by orderNo+0,name";
		return find(hql, parentCode);
	}

	@Override
	public List<Category> getrylb() {
		String hql = "from Category c1 where c1.flag='1' and c1.parent.id in(select c2.id from Category c2 where c2.flag='1' and c2.parent.id in(select c3.id from Category c3 where c3.flag='1' and c3.code='RYLB'))  or c1.code ='GX0106'  order by c1.orderNo+0 asc";		
		return find(hql);
	}
	
	@Override
	public boolean isExist(String pCode, String code) {
		if (!StringUtil.isEmpty(code)) {
			List<Lookups> list = null;
			StringBuffer hql=new StringBuffer("from Category where flag='1' and code='"+code+"' ");
			if (!StringUtil.isEmpty(pCode)) {
				hql.append(" and parent.code='"+pCode+"' ");
			}
			list=super.find(hql.toString());
			if(null!=list && list.size()>0){
				return true;
			}
		}
		return false;
	}

	@Override
	public void saveDrug(String pCode, String code, User user) {
		Category category = new Category();
		category.setParent(findUniqueByProperty("code", pCode));
		category.setCode(code);
		category.setName(code);
		category.setCreator(user);
		category.setCreateTime(new Date());
		category.setOrderNo("10");
		save(category);
	}
}
