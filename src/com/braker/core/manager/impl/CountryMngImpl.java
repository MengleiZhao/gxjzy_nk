package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.CountryMng;
import com.braker.core.model.Country;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Transactional
@Service
public class CountryMngImpl extends BaseManagerImpl<Country> implements CountryMng {

	@Override
	public Pagination list(Country bean, String sort, String order,
			Integer pageIndex, Integer pageSize, boolean hasRole,
			boolean streetRole, User user) {
		Finder hql = Finder.create(" from Country where (flag='1' or flag is null) ");
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getName())) {
				hql.append(" and name like:name").setParam("name", "%" + bean.getName() + "%");
			}
			if (!StringUtil.isEmpty(bean.getCode())) {
				hql.append(" and code like:code").setParam("code", "%" + bean.getCode() + "%");
			}
		}
		if(!StringUtil.isEmpty(sort)&&!StringUtil.isEmpty(order)){
			hql.append(" order by "+sort+" "+order);
		}else{
			hql.append(" order by code desc");
		}
		return super.find(hql,pageIndex, pageSize);
	
	}

	@Override
	public void deleteCountry(Country bean, User user) {
		bean.setFlag("0");
		bean.setCreator(user);
		bean.setOpDate(new Date());
		saveOrUpdate(bean);
	}

	@Override
	public Country saveCountry(Country bean, User user) {
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getId())) {
				bean.setCreator(user);
				bean.setCreateTime(new Date());
			}
			bean.setUpdator(user);
			bean.setOpDate(new Date());
		}
		return (Country) saveOrUpdate(bean);
	}
	
	@Override
	public Country findByName(String name) {
		Finder hql=Finder.create(" from Country where flag=1 and name=:name").setParam("name", name);
		List<Country> list=super.find(hql);
		return list!=null&&list.size()>0?list.get(0):null;
	}
	
}
