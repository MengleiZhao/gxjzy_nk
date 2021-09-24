package com.braker.core.manager.impl;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.ExpendStandConfMng;
import com.braker.core.model.ExpendStandConf;
import com.braker.core.model.User;

@Service
@Transactional
public class ExpendStandConfMngImpl extends BaseManagerImpl<ExpendStandConf> implements ExpendStandConfMng{

	@Override
	public Pagination list(ExpendStandConf expendStandConf, String sort,String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM ExpendStandConf where 1=1");
		if(!StringUtil.isEmpty(expendStandConf.getFpName())){
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName","%"+expendStandConf.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(expendStandConf.getFpLevel())){
			finder.append(" AND fpLevel LIKE :fpLevel");
			finder.setParam("fpLevel","%"+expendStandConf.getFpLevel()+"%");
		}
		if(expendStandConf.getfStandAmountD()!=null){
			finder.append(" AND fStandAmountD =:fStandAmountD");
			finder.setParam("fStandAmountD",expendStandConf.getfStandAmountD());
		}
		if(expendStandConf.getfStandAmountU()!=null){
			finder.append(" AND fStandAmountU =:fStandAmountU");
			finder.setParam("fStandAmountU",expendStandConf.getfStandAmountU());
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void save(ExpendStandConf expendStandConf, User user) {
		if(!StringUtil.isEmpty(String.valueOf(expendStandConf.getFeId()))){
			expendStandConf.setCreator(user.getAccountNo());
			expendStandConf.setCreateTime(new Date());
		}else{
			expendStandConf.setUpdator(user.getAccountNo());
			expendStandConf.setUpdateTime(new Date());
		}
		super.saveOrUpdate(expendStandConf);
	}

	@Override
	public void delete(String id) {
		super.deleteById(id);
	}
	
	

}
