package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.Expenditure1Mng;
import com.braker.core.manager.Expenditure2Mng;
import com.braker.core.model.ExpenditureBaseic1;
import com.braker.core.model.User;

@Service
@Transactional
public class Expenditure1MngImpl extends BaseManagerImpl<ExpenditureBaseic1> implements Expenditure1Mng{

	@Autowired
	private Expenditure2Mng expenditure2Mng;
	
	@Override
	public Pagination list(ExpenditureBaseic1 eb1, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("from ExpenditureBaseic1 where 1=1");
		if(!StringUtil.isEmpty(eb1.gettEbName1())){
			finder.append(" and tEbName1 like :tEbName1");
			finder.setParam("tEbName1", "%"+eb1.gettEbName1()+"%");
		}
		if(!StringUtil.isEmpty(eb1.gettEbCode1())){
			finder.append(" and tEbCode1 like :tEbCode1");
			finder.setParam("tEbCode1", "%"+eb1.gettEbCode1()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void save(ExpenditureBaseic1 eb1, User user) {
		if(StringUtil.isEmpty(String.valueOf(eb1.gettEbId()))){
			eb1.setCreateTime(new Date());
			eb1.setCreator(user.getAccountNo());
		}else {
			eb1.setUpdateTime(new Date());
			eb1.setUpdator(user.getAccountNo());
		}
		super.saveOrUpdate(eb1);
	}

	@Override
	public void delete(String id) {
		Query query=getSession().createSQLQuery(" delete from T_EXPENDITURE_BASIC2 where T_EB_ID1 ="+id);
		query.executeUpdate();
		deleteById(Integer.valueOf(id));
	}

	@Override
	public boolean findbyCode1(ExpenditureBaseic1 bean) {
		Query query;
		if(StringUtil.isEmpty(String.valueOf(bean.gettEbId()))){
			query=getSession().createSQLQuery(" select T_EB_NAME1 from T_EXPENDITURE_BASIC1 where T_EB_CODE1='"+bean.gettEbCode1()+"'");
		}else{
			ExpenditureBaseic1 eb1 = findById(bean.gettEbId());
			query=getSession().createSQLQuery(" select T_EB_NAME1 from T_EXPENDITURE_BASIC1 where T_EB_CODE1='"+eb1.gettEbCode1()+"'");
		}
		List<String[]> eb = query.list();
		if(eb.size()>0){
			return true;
		}else {
			return false;
		}
	}

}
