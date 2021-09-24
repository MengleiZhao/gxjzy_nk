package com.braker.icontrol.cgmanage.cgconfplan.mananger;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

public interface CgConPlanListMng extends BaseManager<ProcurementPlanList>{

	/**
	 * 根据条件查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	List<ProcurementPlanList> findby(String name, String val);
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
	List<ProcurementPlanList> findbyIdAndTypes(String name, String val,String type);
	List<PurchaseApplyBasic> findbyIdPurchase(String id);
}
