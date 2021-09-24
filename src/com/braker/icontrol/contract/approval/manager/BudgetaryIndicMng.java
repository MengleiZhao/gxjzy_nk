package com.braker.icontrol.contract.approval.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.contract.approval.model.BudgetaryIndic;

public interface BudgetaryIndicMng extends BaseManager<BudgetaryIndic>{

	Pagination queryList(BudgetaryIndic budgetaryIndic);
}
