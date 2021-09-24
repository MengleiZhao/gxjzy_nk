package com.braker.core.manager.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.ProMgrLevelMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.ProMgrLevel1;

@Service
@Transactional
public class ProMgrLevelMngImpl extends BaseManagerImpl<ProMgrLevel1> implements ProMgrLevelMng{

	@Autowired
	private ProMgrLevel2Mng proMgrLevel2Mng;
	
	@Override
	public Pagination list1(ProMgrLevel1 proMgrLevel1, String sort,String order, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create("FROM ProMgrLevel1 WHERE 1=1");
		if(!StringUtil.isEmpty(proMgrLevel1.getfYear1())){
			finder.append(" and fYear1 like :fYear1");
			finder.setParam("fYear1", "%"+proMgrLevel1.getfYear1()+"%");
		}if(!StringUtil.isEmpty(proMgrLevel1.getfLevName1())){
			finder.append(" and fLevName1 like :fLevName1");
			finder.setParam("fLevName1", "%"+proMgrLevel1.getfLevName1()+"%");
		}if(!StringUtil.isEmpty(proMgrLevel1.getfLevCode1())){
			finder.append(" and fLevCode1 like :fLevCode1");
			finder.setParam("fLevCode1", "%"+proMgrLevel1.getfLevCode1()+"%");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Integer findbyFLevCode1(String fLevCode1) {
		Finder finder =Finder.create("FROM ProMgrLevel1 WHERE fLevCode1='"+fLevCode1+"'");
		return super.find(finder).size();
	}
	
	@Override
	public Integer findbyFLevCode1NotMine(String fLevCode1,Integer fLvId1) {
		Finder finder =Finder.create("FROM ProMgrLevel1 WHERE fLevCode1='"+fLevCode1+"' and fLvId1 <>"+fLvId1);
		return super.find(finder).size();
	}

	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public void deleteAll(Integer id) {
		proMgrLevel2Mng.deleteAll(id);
		super.deleteById(id);
	}

	@Override
	public String maxfLevCode1() {
		String s="SELECT max(F_LEV_CODE) FROM T_PRO_MGR_LEVEL_1 ";
		Query query = getSession().createSQLQuery(s);
		String code=(String) query.list().get(0);
		String[] c = code.split("-");
		String num = String.valueOf(Integer.valueOf(c[1])+1);
//		if(1==(num.length())){
//			code=c[0]+"-00"+num;
//		}else if(2==(num.length())){
//			code=c[0]+"-0"+num;
//		}else if(3==(num.length())){
//			code=c[0]+"-"+num;
//		}
		if(1==(num.length())){
			code=c[0]+"-0"+num;
		}else if(2==(num.length())){
			code=c[0]+"-"+num;
		}
		return code;
	}	
	
	

}
