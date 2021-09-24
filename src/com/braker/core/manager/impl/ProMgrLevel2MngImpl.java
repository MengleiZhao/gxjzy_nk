package com.braker.core.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Condition;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.ProMgrLevelMng;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.User;

@Service
@Transactional
public class ProMgrLevel2MngImpl extends BaseManagerImpl<ProMgrLevel2> implements ProMgrLevel2Mng{

	@Autowired
	private ProMgrLevelMng proMgrLevelMng;
	@Autowired
	private LookupsMng lookupsMng;
	
	
	@Override
	public Pagination list(ProMgrLevel2 proMgrLevel2, String sort,String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" from ProMgrLevel2 where 1=1");
		if(!StringUtil.isEmpty(proMgrLevel2.getfLevCode2())){
			finder.append(" and fLevCode2 like :fLevCode2");
			finder.setParam("fLevCode2", "%"+proMgrLevel2.getfLevCode2()+"%");
		}if(!StringUtil.isEmpty(proMgrLevel2.getfLevName2())){
			finder.append(" and fLevName2 like :fLevName2");
			finder.setParam("fLevName2", "%"+proMgrLevel2.getfLevName2()+"%");
		}if(!StringUtil.isEmpty(proMgrLevel2.getfFunctionClass())){
			finder.append(" and fFunctionClass like :fFunctionClass");
			finder.setParam("fFunctionClass", "%"+proMgrLevel2.getfFunctionClass()+"%");
		}if(!StringUtil.isEmpty(proMgrLevel2.getfProType())){
			finder.append(" and fProType like :fProType");
			finder.setParam("fProType", proMgrLevel2.getfProType());
		}if(!StringUtil.isEmpty(String.valueOf(proMgrLevel2.getA()))){
			finder.append(" and pml.fLvId1 = :pmlfLvId1");
			finder.setParam("pmlfLvId1", proMgrLevel2.getA());
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public ProMgrLevel2 findbyCode2(String fLevCode2) {
		Finder finder =Finder.create(" from ProMgrLevel2 where fLevCode2='"+fLevCode2+"'");
		return (ProMgrLevel2) super.find(finder).get(0);
	}
	
	@Override
	public Integer findbyFLevCode2(String fLevCode2) {
		Finder finder =Finder.create(" from ProMgrLevel2 where fLevCode2='"+fLevCode2+"'");
		return super.find(finder).size();
	}

	@Override
	public Integer findbyFLevCode2NotMine(String fLevCode2,Integer fLvId2) {
		Finder finder =Finder.create(" from ProMgrLevel2 where fLevCode2='"+fLevCode2+"' and fLvId2<>"+fLvId2);
		return super.find(finder).size();
	}
	
	@Override
	public void deleteAll(Integer id) {
		Finder finder=Finder.create("from ProMgrLevel2 where pml.fLvId1 ="+id);
		List<ProMgrLevel2> li = super.find(finder);
		for (int i = 0; i < li.size(); i++) {
			delete(li.get(i));
		}
	}

	@Override
	public List<ProMgrLevel2> findByParendCode(String parentCode,User user) {
		
		Finder finder=Finder.create(" from ProMgrLevel2 where 1=1");
		if (!StringUtil.isEmpty(parentCode)) {
			finder.append(" and pml.fLevCode1=:parentCode").setParam("parentCode", parentCode);
		}
		return super.find(finder);
	}
	
	@Override
	public List<ProMgrLevel2> getSubject2ByPml(String pml) {
		
		Finder finder=Finder.create(" from ProMgrLevel2 where pml="+pml);
		/*if (!StringUtil.isEmpty(pml)) {
			finder.append(" and pml=:pml").setParam("pml", pml);
		}*/
		return super.find(finder);
	}

	@Override
	public String maxfLevCode2(String str) {
		String s="SELECT max(F_LEV_CODE) FROM T_PRO_MGR_LEVEL_2 where F_LEV_CODE LIKE '%"+str+"%'";
		Query query = getSession().createSQLQuery(s);
		String code=(String) query.list().get(0);
		if(StringUtil.isEmpty(code)){
			code=str+"-001";
		}else{
			String[] c = code.split("-");
			String num = String.valueOf(Integer.valueOf(c[2])+1);
			if(1==(num.length())){
				code=str+"-00"+num;
			}else if(2==(num.length())){
				code=str+"-0"+num;
			}else if(3==(num.length())){
				code=str+"-"+num;
			}
		}
		return code;
	}

	@Override
	public List<ProMgrLevel2> basicTypeList() {
		//select * from t_pro_mgr_level_2 where F_LV_ID1=1 order by field(F_PRO_TYPE,'2007','2006','2005','2004','2003','2002','2001') desc,f_LEV_CODE asc
		Finder finder=Finder.create(" from ProMgrLevel2 where pml=1 order by"
				+ " field(fProType,'2007','2006','2005','2004','2003','2002','2001') desc,fLevCode2 asc");
		return super.find(finder);
	}

	/* 
	 * <p>Title: save</p>
	 * <p>Description: </p>
	 * @param proMgrLevel2
	 * @param proMgrLevel1
	 * @see com.braker.core.manager.ProMgrLevel2Mng#save(com.braker.core.model.ProMgrLevel2, com.braker.core.model.ProMgrLevel1) 
	 * @author 陈睿超
	 * @createtime 2021年1月11日
	 * @updator 陈睿超
	 * @updatetime 2021年1月11日
	 */
	@Override
	public void save(ProMgrLevel2 proMgrLevel2, ProMgrLevel1 proMgrLevel1) {
		
		if(StringUtil.isEmpty(String.valueOf(proMgrLevel2.getfLvId2()))){
			ProMgrLevel1 pml1 = proMgrLevelMng.findById(proMgrLevel2.getA());
			proMgrLevel2.setPml(pml1);
			super.saveOrUpdate(proMgrLevel2);
		}else{
			ProMgrLevel1 pml1 = proMgrLevelMng.findById(proMgrLevel2.getA());
			proMgrLevel2.setPml(pml1);
			super.saveOrUpdate(proMgrLevel2);
		}
		
	}
}
