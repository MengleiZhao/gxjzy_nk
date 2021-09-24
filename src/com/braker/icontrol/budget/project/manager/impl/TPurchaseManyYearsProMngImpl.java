package com.braker.icontrol.budget.project.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TPurchaseManyYearsPro;
import com.braker.icontrol.budget.project.manager.TPurchaseManyYearsProMng;

/**
 * 采购一采多年项目表
* <p>Title:TPurchaseManyYearsProMngImpl </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月10日
 */
@Service
@Transactional
public class TPurchaseManyYearsProMngImpl  extends BaseManagerImpl<TPurchaseManyYearsPro>  implements TPurchaseManyYearsProMng {

	@Override
	public Pagination getPurchaseManyYearsPro(TPurchaseManyYearsPro bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create("  FROM TPurchaseManyYearsPro WHERE fProId ="+bean.getfProId()+" and fIfSoftware='"+bean.getfIfSoftware()+"'");
		finder.append(" order by pmId asc");
		return super.find(finder, pageNo, pageSize);
	}

}
