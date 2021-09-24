package com.braker.core.manager.impl;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.HelpCenterMng;
import com.braker.core.model.HelpCenter;

/**
 * 帮助中心的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Service
@Transactional
public class HelpCenterMngImpl extends BaseManagerImpl<HelpCenter> implements HelpCenterMng {
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-11
	 * @updatetime 2018-06-11
	 */
	@Override
	public Pagination pageList(HelpCenter bean, int pageNo, int pageSize) {
		//查询条件
		Finder finder = Finder.create(" FROM HelpCenter WHERE 1=1");
		if (!StringUtil.isEmpty(bean.getHelpName())) {
			finder.append(" and helpName like :helpName").setParam("helpName", "%" + bean.getHelpName() + "%");
		}
		if (!StringUtil.isEmpty(bean.getReleaseUser())) {
			finder.append(" and releaseUser like :releaseUser").setParam("releaseUser", "%" + bean.getReleaseUser() + "%");
		}
		finder.append(" ORDER BY helpNum");
		return super.find(finder, pageNo, pageSize);
	}

	

}
