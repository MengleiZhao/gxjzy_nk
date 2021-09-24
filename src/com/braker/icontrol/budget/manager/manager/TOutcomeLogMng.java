package com.braker.icontrol.budget.manager.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TOutcomeLog;

public interface TOutcomeLogMng extends BaseManager<TOutcomeLog>  {
	
	public Pagination pageList(TOutcomeLog bean, User user, int pageNo, int pageSize,String searchUserName, String searchDeptName);
}
