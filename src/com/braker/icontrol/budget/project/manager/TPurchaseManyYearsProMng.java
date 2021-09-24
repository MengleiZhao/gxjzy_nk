package com.braker.icontrol.budget.project.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TPurchaseManyYearsPro;

/**
 * 采购一采多年项目表
* <p>Title:TPurchaseManyYearsProMng </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月10日
 */
public interface TPurchaseManyYearsProMng  extends BaseManager<TPurchaseManyYearsPro>{

	Pagination getPurchaseManyYearsPro(TPurchaseManyYearsPro bean, int pageNo, int pageSize, User user);
}
