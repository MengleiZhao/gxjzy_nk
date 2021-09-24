package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.core.model.YearsBasic;

public interface YearsBasicMng extends BaseManager<YearsBasic>{

	/**
	 * 显示主页数据
	 * @param yearsBasic
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(YearsBasic yearsBasic,String sort, String order, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存
	 * @param yearsBasic
	 * @param user
	 */
	void save(YearsBasic yearsBasic,User user);
	
	/**
	 * 删除
	 * @param fbId
	 */
	void yearsBasic_delete(String fbId);
	
	/**
	 * 根据年份查询
	 * @author 叶崇晖
	 * @param year
	 * @return
	 */
	public List<YearsBasic> findByYear(String year);
	
	/**
	 * 查询是否有同一年度的数据
	 * @param fPeriod
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年2月25日
	 * @updator 陈睿超
	 * @updatetime 2020年2月25日
	 */
	Boolean findbyfPeriod(String fPeriod);
	
}
