package com.braker.icontrol.purchase.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.purchase.apply.model.PurchaseItemsDetail;

public interface PurchaseItemsMng extends BaseManager<PurchaseItemsDetail>{

	/**
	 * 根据条件查询
	 * @param name 条件名称
	 * @param val 条件的值
	 * @return
	 */
	public Pagination ItemsPageList(PurchaseItemsDetail purchaseItemsDetail,Integer page, Integer rows, String item, User user);
}
