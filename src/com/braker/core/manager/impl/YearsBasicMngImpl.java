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
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.model.User;
import com.braker.core.model.YearsBasic;

@Transactional
@Service
public class YearsBasicMngImpl extends BaseManagerImpl<YearsBasic> implements YearsBasicMng{

	@Override
	public Pagination list(YearsBasic yearsBasic,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM YearsBasic where 1=1");
		if(!StringUtil.isEmpty(yearsBasic.getFtName())){
			finder.append(" AND ftName LIKE :ftName");
			finder.setParam("ftName","%"+yearsBasic.getFtName()+"%");
		}
		if(!StringUtil.isEmpty(yearsBasic.getfPeriod())){
			finder.append(" AND fPeriod LIKE :fPeriod");
			finder.setParam("fPeriod","%"+yearsBasic.getfPeriod()+"%");
		}
		if(!StringUtil.isEmpty(yearsBasic.getfRemark())){
			finder.append(" AND fRemark LIKE :type");
			finder.setParam("type","%"+yearsBasic.getfRemark()+"%");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void save(YearsBasic yearsBasic, User user) {
		if(StringUtil.isEmpty(String.valueOf(yearsBasic.getFbId()))){
			yearsBasic.setFbId(StringUtil.random8());
			yearsBasic.setCreator(user.getAccountNo());
			yearsBasic.setCreateTime(new Date());
		}else{
			yearsBasic.setUpdator(user.getAccountNo());
			yearsBasic.setUpdateTime(new Date());
		}
		super.saveOrUpdate(yearsBasic);
	}
	
	@Override
	public void yearsBasic_delete(String fbId) {
		YearsBasic yb = findById(Integer.valueOf(fbId));
		Query query=getSession().createSQLQuery(" delete from T_ECONOMIC_SUBJECT_LIB where F_Y_B_ID="+Integer.valueOf(fbId));
		query.executeUpdate();
		delete(yb);
	}

	/**
	 * 更具年份查询
	 * @author 叶崇晖
	 * @return
	 * @param year
	 */
	@Override
	public List<YearsBasic> findByYear(String year) {
		Finder finder = Finder.create(" FROM YearsBasic WHERE fPeriod='"+year+"'");
		return super.find(finder);
	}

	@Override
	public Boolean findbyfPeriod(String fPeriod) {
		// TODO Auto-generated method stub
		return null;
	}

}
