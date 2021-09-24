package com.braker.core.manager.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.BeanUtils;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.YearsBasic;

@SuppressWarnings("unchecked")
@Service
@Transactional
public class SysDepartEconomicMngImpl extends BaseManagerImpl<SysDepartEconomic> implements SysDepartEconomicMng {
	
	@Autowired
	private YearsBasicMng yearsBasicMng;
	
	
	@Override
	public List<SysDepartEconomic> findByPidAndEjProCode(String pId,String ejProCode,String fEcCode) {
		 Finder hql=Finder.create("from SysDepartEconomic Where ");
				hql.append("  pId =:pId ").setParam("pId", pId);
				//hql.append("  and fEjProCode =:fEjProCode ").setParam("fEjProCode", ejProCode);
				/*if(!StringUtil.isEmpty(fEcCode)){
			    hql.append("  and fEcCode =:fEcCode ").setParam("fEcCode", fEcCode);
				}*/
				hql.append(" order by fEcCode ");
				return super.find(hql);
	}
	
	@Override
	public List<SysDepartEconomic> findDistinctByPidAndEjProCode(String pId,String ejProCode,String sign) {
		Finder hql=Finder.create("from SysDepartEconomic Where 1=1");
		//hql.append(" fDEYear =:fDEYear ").setParam("fDEYear", Integer.valueOf(DateUtil.getCurrentYear()));
		if(StringUtils.isNotEmpty(pId)){
			hql.append(" and pId =:pId ").setParam("pId", pId);
		}
		if(StringUtils.isNotEmpty(ejProCode)){
			hql.append("  and fEjProCode =:fEjProCode ").setParam("fEjProCode", ejProCode);
		}
		if(StringUtils.isEmpty(sign)){
			hql.append(" group by fEjProCode ");
		}
		hql.append(" order by deId ");
		return super.find(hql);
	}
	
	@Override
	public void deleteKeMu(String departId, String code,String ecCode) {
		if(StringUtil.isEmpty(ecCode) || "".equals(ecCode) ){
			getSession().createSQLQuery("DELETE FROM sys_depart_economic WHERE PID ="+departId+" and F_EJ_PRO_CODE="+code+"").executeUpdate();
		}else{
			getSession().createSQLQuery("DELETE FROM sys_depart_economic WHERE PID ="+departId+" and F_EJ_PRO_CODE="+code+" and fEcCode ="+ecCode+"").executeUpdate();
		}
		
	}
	
	
	@Override
	public Pagination getlist(String departId, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create("FROM SysDepartEconomic WHERE pId='"+departId+"' GROUP BY fEjProCode ORDER BY deId");
		return super.find(finder,pageNo,pageSize);
	}
	
	public void subjectDelete(String departId,String deId,String fEjProCode) {
		getSession().createSQLQuery("DELETE FROM sys_depart_economic WHERE PID ="+departId+" and F_EJ_PRO_CODE="+fEjProCode+"").executeUpdate();
		
	}

	@Override
	public void copyDE(Integer oldYearId, YearsBasic newYb) throws Exception {
		YearsBasic oldyear = yearsBasicMng.findById(oldYearId);
		Finder finder = Finder.create("from SysDepartEconomic where fDEYear="+oldyear.getfPeriod());
		List<SysDepartEconomic> dEconomicList = (List<SysDepartEconomic>) super.find(finder);
		for (int i = 0; i < dEconomicList.size(); i++) {//循环保存新的年度模板的部门和经济分类科目映射关系表
			SysDepartEconomic sde = new SysDepartEconomic();
			//sde = (SysDepartEconomic) dEconomicList.get(i);
			BeanUtils.copyProperties(dEconomicList.get(i), sde);
			sde.setDeId(null);
			sde.setfDEYear(Integer.valueOf(newYb.getfPeriod()));
			super.merge(sde);
		}
	}
	
	
	
	
	
}
