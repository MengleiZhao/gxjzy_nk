package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.SpecialtyMng;
import com.braker.core.model.Specialty;
import com.braker.core.model.User;

@SuppressWarnings("unchecked")
@Transactional
@Service
public class SpecialtyMngImpl extends BaseManagerImpl<Specialty> implements SpecialtyMng{

	@Override
	public List<Specialty> getChild(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TreeEntity> getQueryTree(Specialty profess) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Specialty> getRoots() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean haveChild(Specialty profess) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Pagination list(Specialty bean, String sort, String order,
			int pageIndex, int pageSize,boolean isQuRole,boolean isStreetRole, User user) {

//		Finder hql=Finder.create(" from Professional where flag='1' ");
		Finder hql = Finder.create(" from Specialty where (flag=1 or flag is null) ");
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getName())) {
				hql.append(" and name like:name").setParam("name", "%" + bean.getName() + "%");
			}
			if (!StringUtil.isEmpty(bean.getCode())) {
				hql.append(" and code =:code").setParam("code", bean.getCode());
			}
		}
		if(!StringUtil.isEmpty(sort)&&!StringUtil.isEmpty(order)){
			hql.append(" order by "+sort+" "+order);
		}else{
			hql.append(" order by code asc");
		}
		return super.find(hql,pageIndex, pageSize);
	}

	@Override
	public void deleteSpecialty(Specialty bean, User user) {
		bean.setFlag("0");
		bean.setCreator(user);
		bean.setOpDate(new Date());
		saveOrUpdate(bean);
	}

	@Override
	public Specialty saveSpecialty(Specialty bean, User user) {
		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getId())) {
				bean.setCreator(user);
				bean.setCreateTime(new Date());
			}
			bean.setUpdator(user);
			bean.setOpDate(new Date());
		}
		return (Specialty) saveOrUpdate(bean);
	}

}
