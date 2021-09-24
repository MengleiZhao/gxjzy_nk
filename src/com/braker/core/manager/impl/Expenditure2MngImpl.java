package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.Expenditure1Mng;
import com.braker.core.manager.Expenditure2Mng;
import com.braker.core.model.ExpenditureBaseic1;
import com.braker.core.model.ExpenditureBaseic2;
import com.braker.core.model.User;

@Service
@Transactional
public class Expenditure2MngImpl extends BaseManagerImpl<ExpenditureBaseic2> implements Expenditure2Mng{

	@Autowired
	private Expenditure1Mng expenditure1Mng;
	
	@Override
	public Pagination list(ExpenditureBaseic2 eb2, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create("from ExpenditureBaseic2 where 1=1");
		if(!StringUtil.isEmpty(eb2.gettEbName2())){
			finder.append(" and tEbName2 like :tEbName2");
			finder.setParam("tEbName2", "%"+eb2.gettEbName2()+"%");
		}
		if(!StringUtil.isEmpty(eb2.gettEbCode2())){
			finder.append(" and tEbCode2 like :tEbCode2");
			finder.setParam("tEbCode2", "%"+eb2.gettEbCode2()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(eb2.getTEbIdTemp()))){
			finder.append(" and eb1.tEbId = :a");
			finder.setParam("a", eb2.getTEbIdTemp());
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void save(ExpenditureBaseic2 eb2, User user) {
		if(StringUtil.isEmpty(String.valueOf(eb2.gettEbId2()))){
			ExpenditureBaseic1 eb1= expenditure1Mng.findById(eb2.getTEbIdTemp());
			eb2.setEb1(eb1);
			eb2.setCreateTime(new Date());
			eb2.setCreator(user.getAccountNo());
		}else {
			eb2.setUpdateTime(new Date());
			eb2.setUpdator(user.getAccountNo());
		}
		super.saveOrUpdate(eb2);
		
	}

	@Override
	public boolean findbyCode2(ExpenditureBaseic2 bean) {
		Query query;
		if(StringUtil.isEmpty(String.valueOf(bean.gettEbId2()))){
			query=getSession().createSQLQuery(" select T_EB_NAME2 from T_EXPENDITURE_BASIC2 where T_EB_CODE2='"+ bean.gettEbCode2()+"'");
		}else{
			ExpenditureBaseic2 eb2 = findById(bean.gettEbId2());
			query=getSession().createSQLQuery(" select T_EB_NAME2 from T_EXPENDITURE_BASIC2 where T_EB_CODE2='"+eb2.gettEbCode2()+"'");
		}
		List<String[]> eb = query.list();
		if(eb.size()>0){
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<ExpenditureBaseic2> findALL() {
		Finder finder=Finder.create(" from ExpenditureBaseic2 ");
		return super.find(finder);
	}
}
