package com.braker.core.manager.impl;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.BirthPlaceMng;
import com.braker.core.model.BirthPlace;
import com.braker.core.model.User;
@SuppressWarnings("unchecked")
@Service
@Transactional
public class BirthPlaceMngImpl extends BaseManagerImpl<BirthPlace> implements BirthPlaceMng {

	@Override
	public Pagination list(BirthPlace bean, String sort, String order,
			Integer pageIndex, Integer pageSize, boolean hasRole, boolean streetRole,
			User user) {
		Finder hql = Finder.create(" from BirthPlace where flag='1' ");
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
	public BirthPlace saveBirthPlace(BirthPlace bean, User user) {
		if (bean==null)
			return null;
		if (StringUtil.isEmpty(bean.getId())) {
			bean.setCreateTime(new Date());
			bean.setCreator(user);
		} else {
			bean.setUpdator(user);
			bean.setUpdateTime(new Date());
		}
		return super.save(bean);
	}
	
}
