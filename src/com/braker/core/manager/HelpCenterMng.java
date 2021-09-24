package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.HelpCenter;

/**
 * 帮助中心的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
public interface HelpCenterMng extends BaseManager<HelpCenter>{
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-11
	 * @updatetime 2018-06-11
	 */
	public Pagination pageList(HelpCenter bean, int pageNo, int pageSize);
}
