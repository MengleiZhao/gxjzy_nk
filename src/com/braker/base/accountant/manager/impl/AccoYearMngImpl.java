package com.braker.base.accountant.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.base.accountant.entity.AccoTree;
import com.braker.base.accountant.entity.AccoYear;
import com.braker.base.accountant.manager.AccoYearMng;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Economic;
import com.braker.core.model.User;

@Transactional
@Service
public class AccoYearMngImpl extends BaseManagerImpl<AccoYear> implements AccoYearMng{

	@Override
	public Pagination list(AccoYear yearsBasic,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM AccoYear where 1=1");
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
	public void save(AccoYear yearsBasic, User user) {
		if(StringUtil.isEmpty(String.valueOf(yearsBasic.getFbId()))){
			yearsBasic.setFbId(StringUtil.random8() * 10);
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
		AccoYear yb = findById(Integer.valueOf(fbId));
		Query query=getSession().createSQLQuery(" delete from t_acco_tree where F_Y_B_ID="+Integer.valueOf(fbId));
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
	public List<AccoYear> findByYear(String year) {
		Finder finder = Finder.create(" FROM AccoYear WHERE fPeriod='"+year+"'");
		return super.find(finder);
	}
	
	@Override
	public List<AccoYear> getRoots(String parentId, String year) {
		Finder f=Finder.create("from AccoYear where 1=1");
		if(!StringUtil.isEmpty(parentId)){
			f.append(" and fbId="+Integer.valueOf(parentId));
		}
		return super.find(f);
	}
	
	@Override
	public Pagination list_add(AccoTree economic,String departId,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create("FROM AccoTree WHERE 1=1");
		if(!StringUtil.isEmpty(economic.getCode())){
			finder.append(" AND F_EC_CODE LIKE :code");
			finder.setParam("code","%"+economic.getCode()+"%");
		}
		if(!StringUtil.isEmpty(economic.getName())){
			finder.append(" AND F_EC_NAME LIKE :name");
			finder.setParam("name","%"+economic.getName()+"%");
		}
		if(!StringUtil.isEmpty(economic.getType())){
			finder.append(" AND F_EC_TYPE LIKE :type");
			finder.setParam("type","%"+economic.getType()+"%");
		}
		if(!StringUtil.isEmpty(departId)){
			finder.append(" and pid=:pid");
			if(departId.length()==3){
				finder.setParam("pid", 0);
			}else{
				finder.setParam("pid", Integer.valueOf(departId.substring(4,departId.length())));
			}
		}
		return super.find(finder, pageNo, pageSize);
	}
	
	public boolean queryID(String daw, String departId, AccoTree economic){
		List das=new ArrayList();
		String dawy=daw.substring(10, daw.length());
		String[] n=dawy.split(",");
		List<Object[]> number=new ArrayList<>();
		for (int i = 0; i < n.length; i++) {
			das.add(n[i]);
		}
		String sql=null;
		for (int i = 0; i < das.size(); i++) {
			sql = "select ESL.F_EC_ID FROM t_acco_tree ESL,T_YEAR_EC_UNION_BASIC YEUB WHERE YEUB.F_EC_ID=ESL.F_EC_ID AND ESL.F_EC_ID="+das.get(i);
			Query query = getSession().createSQLQuery(sql);
				number = query.list();
		}
		if(number.size()==0){
			return false;
		}else{
			return true;
		}
	}
	
	@Override
	public int ye_save(String daw, String departId, AccoTree economic) {
		int number=0;
		try {
			List das=new ArrayList();
			String dawy=daw.substring(10, daw.length());
			String[] n=dawy.split(",");
			List<Object[]> num=new ArrayList<>();
			String[] yearNumber= departId.split("-");
			for (int i = 0; i < n.length; i++) {
				das.add(n[i]);
			}
			
			for (int j = 0; j < das.size(); j++) {
				String sql = "insert into T_YEAR_EC_UNION_BASIC(F_EC_ID,F_Y_B_ID) values("+das.get(j)+","+yearNumber[0]+")";
				Query query = getSession().createSQLQuery(sql);
				number+=query.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return number;
	}
	
	@Override
	public boolean ye_delete(String fbId,String daw) {
		try {
			List das=new ArrayList();
			String dawy=daw.substring(10, daw.length());
			String[] n=dawy.split(",");
			String sql=null;
			String[] yearNumber= fbId.split("-");
			
			for (int i = 0; i < n.length; i++) {
				das.add(n[i]);
			}
			for (int i = 0; i < das.size(); i++) {
				
				sql = "delete FROM T_YEAR_EC_UNION_BASIC WHERE F_EC_ID="+das.get(i)+" AND F_Y_B_ID="+yearNumber[0];
				Query query = getSession().createSQLQuery(sql);
				query.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
