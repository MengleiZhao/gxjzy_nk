package com.braker.core.manager;


import java.lang.reflect.InvocationTargetException;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.YearsBasic;

public interface SysDepartEconomicMng extends BaseManager<SysDepartEconomic> {
	public List<SysDepartEconomic> findByPidAndEjProCode(String pId,String ejProCode,String fEcCode);
	
	public List<SysDepartEconomic> findDistinctByPidAndEjProCode(String pId,String ejProCode,String sign);
	
	public void deleteKeMu(String departId,String code,String ecCode);
	
	public Pagination getlist(String departId, Integer pageNo, Integer pageSize);
	
	public void subjectDelete(String departId,String deId,String fEjProCode);
	
	/**
	 * 
	 * @param oldYearId
	 * @param newYb
	 * @author 陈睿超
	 * @createtime 2020年2月25日
	 * @updator 陈睿超
	 * @updatetime 2020年2月25日
	 */
	void copyDE(Integer oldYearId, YearsBasic newYb) throws Exception;
	
	
}