package com.braker.icontrol.contract.approval.manager.Impl;

import java.util.List;

import org.hibernate.Query;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.contract.approval.manager.BudgetaryIndicMng;
import com.braker.icontrol.contract.approval.model.BudgetaryIndic;

public class BudgetaryIndicMngImpl extends BaseManagerImpl<BudgetaryIndic> implements BudgetaryIndicMng{

	@Override
	public Pagination queryList(BudgetaryIndic budgetaryIndic) {
		
		String sql = "";
		
		
		sql+=" order by ESL.F_EC_ID";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		
		return null;
	}

}
