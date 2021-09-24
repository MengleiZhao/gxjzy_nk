package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.ExpenditureBaseic1;
import com.braker.core.model.ExpenditureBaseic2;
import com.braker.core.model.User;

public interface Expenditure2Mng extends BaseManager<ExpenditureBaseic2>{

	/**
	 * 加载支出明细事项list
	 * @param eb2
	 * @return
	 */
	Pagination list(ExpenditureBaseic2 eb2, Integer pageNo, Integer pageSize);


	/**
	 * 保存二级支出事项明细
	 * @param eb1
	 * @param user
	 */
	void save(ExpenditureBaseic2 eb2,User user);
	
	/**
	 * 查询有没有重复的代码
	 * @param eb2
	 * @return
	 */
	boolean findbyCode2(ExpenditureBaseic2 eb2);
	
	/**
	 * 查询所有信息
	 */
	List<ExpenditureBaseic2> findALL();
}
