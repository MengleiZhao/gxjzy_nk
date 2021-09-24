package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.ExpenditureBaseic1;
import com.braker.core.model.User;

public interface Expenditure1Mng extends BaseManager<ExpenditureBaseic1>{

	/**
	 * 加载支出明细事项list
	 * @param eb1
	 * @return
	 */
	Pagination list(ExpenditureBaseic1 eb1, Integer pageNo, Integer pageSize);

	/**
	 * 保存一级支出事项明细
	 * @param eb1
	 * @param user
	 */
	void save(ExpenditureBaseic1 eb1,User user);
	
	/**
	 * 删除一级支出事项明细并删除其下的所以二级支出事项明细
	 * @param id
	 */
	void delete(String id);
	
	/**
	 * 查询有没有重复的代码
	 * @param eb1
	 * @return
	 */
	boolean findbyCode1(ExpenditureBaseic1 eb1);
}
