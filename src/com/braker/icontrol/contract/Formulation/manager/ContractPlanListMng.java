package com.braker.icontrol.contract.Formulation.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.contract.Formulation.model.ContractPlanList;

public interface ContractPlanListMng extends BaseManager<ContractPlanList>{

	/**
	 * 根据条件查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	List<ContractPlanList> findby(String name, String val);
	/**
	 * 根据id和type查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	List<Object> findbyIdAndType(String name, String val,String type);
	/**
	 * 根据id和type查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	List<ContractPlanList> findbyIdAndTypes(String name, String val,String type);
}
