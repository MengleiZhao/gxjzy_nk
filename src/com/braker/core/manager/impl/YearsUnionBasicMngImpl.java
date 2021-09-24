package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.sql.Insert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.YearsUnionBasicMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.YearsBasic;
import com.sun.org.apache.bcel.internal.generic.IINC;

@Service
@Transactional
public class YearsUnionBasicMngImpl extends BaseManagerImpl<YearsBasic> implements YearsUnionBasicMng{

	
	@Override
	public List yearsBasicList() {
		
		return null;
	}
	
	@Override
	public List<YearsBasic> getRoots(String parentId, String year) {
		Finder f=Finder.create("from YearsBasic where 1=1");
		if(!StringUtil.isEmpty(parentId)){
			f.append(" and fbId="+Integer.valueOf(parentId));
		}
		return super.find(f);
	}

	@Override
	public List<Object[]> getChild(String fbid) {
		String hql = "select DISTINCT type from Economic";
		return find(hql);
	}
	
	@Override
	public List<Object[]> getChildList(String fbId,String pid) {
		//Finder f=Finder.create("from Economic,YearsBasic where Economic.fid=YearasBasic.fbId Economic.pid = 0");
		String sql = "select ESL.F_EC_CODE,ESL.F_EC_NAME from T_ECONOMIC_SUBJECT_LIB ESL,T_YEAR_EC_UNION_BASIC YEUB where ESL.F_EC_ID=YEUB.F_EC_ID AND YEUB.F_Y_B_ID="+fbId+" AND ESL.F_EC_TYPE='"+pid+"' AND ESL.F_EC_LEVE=1";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}

	/**
	 * 主页面的查询
	 * @author crc
	 * @createtime 2018-06-05
	 * @createname crc
	 */
	@Override
	public Pagination list(Economic economic, String fPeriod, String fbId,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create("FROM Economic WHERE 1=1");
		//String sql = "select ESL.F_EC_CODE,ESL.F_EC_NAME from T_ECONOMIC_SUBJECT_LIB ESL,T_YEAR_EC_UNION_BASIC YEUB where ESL.F_EC_ID=YEUB.F_EC_ID";
		//Query query = getSession().createSQLQuery(sql);
		String years="20";
		String year=fPeriod.substring(0, fPeriod.length()-2);
		if(year.equals(years)){
			finder.append(" and leve=9999");
		}
		if(fbId.substring(2).equals("1")||fbId.substring(2).equals("9")){
			finder.append(" and leve=1");
		}
		if(fbId.length()>4){
			finder.append(" and code=:code");
			finder.setParam("code", Integer.valueOf(fbId.substring(4, fbId.length())));
		}
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
		return super.find(finder, pageNo, pageSize);
		}

	@Override
	public List<Object[]> list1(Economic economic, String fPeriod, String fbId,String sort, String order, Integer pageNo, Integer pageSize) {
		//Finder finder=Finder.create("FROM Economic WHERE 1=1");
		String sql = "select ESL.F_EC_ID,ESL.F_EC_CODE,ESL.F_EC_NAME,F_EC_LEVE,F_P_EC_ID,F_IS_ON,F_EC_TYPE from T_ECONOMIC_SUBJECT_LIB ESL,T_YEAR_EC_UNION_BASIC YEUB where ESL.F_EC_ID=YEUB.F_EC_ID ";
	
		String years="20";
		String year=fPeriod.substring(0, fPeriod.length()-2);
		if(fbId.length()>4){
				sql+="and YEUB.F_Y_B_ID="+fbId.substring(0,1);
		}
		if(year.equals(years)){
			sql+=(" and F_EC_LEVE=9999");
		}
		if(fbId.substring(2).equals("1")||fbId.substring(2).equals("9")){
			sql+=(" and ESL.F_EC_LEVE=1");
		}
		if(fbId.length()>4){
			sql+=(" and ESL.F_P_EC_ID="+fbId.substring(4, fbId.length()));
		}
		if(!StringUtil.isEmpty(economic.getCode())){
			sql+=(" AND ESL.F_EC_CODE LIKE '%"+economic.getCode()+"%'");
		}
		if(!StringUtil.isEmpty(economic.getName())){
			sql+=(" AND ESL.F_EC_NAME LIKE '%"+economic.getName()+"%'");
		}
		if(!StringUtil.isEmpty(economic.getType())){
			sql+=(" AND ESL.F_EC_TYPE LIKE '%"+economic.getType()+"%'");
		}
		sql+=" order by ESL.F_EC_ID";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
		}

	
	@Override
	public Pagination list_add(Economic economic,String departId,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create("FROM Economic WHERE 1=1");
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

	@Override
	public int ye_save(String daw, String departId, Economic economic) {
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
	
	public boolean queryID(String daw, String departId, Economic economic){
		List das=new ArrayList();
		String dawy=daw.substring(10, daw.length());
		String[] n=dawy.split(",");
		List<Object[]> number=new ArrayList<>();
		for (int i = 0; i < n.length; i++) {
			das.add(n[i]);
		}
		String sql=null;
		for (int i = 0; i < das.size(); i++) {
			sql = "select ESL.F_EC_ID FROM T_ECONOMIC_SUBJECT_LIB ESL,T_YEAR_EC_UNION_BASIC YEUB WHERE YEUB.F_EC_ID=ESL.F_EC_ID AND ESL.F_EC_ID="+das.get(i);
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

	


