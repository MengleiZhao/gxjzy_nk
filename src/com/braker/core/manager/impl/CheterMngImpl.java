package com.braker.core.manager.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Condition;
import com.braker.common.hibernate.Finder;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.hibernate.Updater;
import com.braker.common.page.Pagination;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.SystemCenterAttac;

/**
 * 制度政策中心的service实现类
 * @author 叶崇晖
 * @createtime 2018-07-04
 * @updatetime 2018-07-04
 */
@Service
@Transactional
public class CheterMngImpl extends BaseManagerImpl<CheterInfo> implements CheterMng {

	/*
	 * 查询制度中心
	 * @author 叶崇晖
	 * @createtime 2018-07-04
	 * @updatetime 2018-07-04
	 */
	@Override
	public List<CheterInfo> getCheterInfoList(String belong) {
		Finder finder = Finder.create(" FROM CheterInfo WHERE fstauts=1 and belong='"+belong+"' ORDER BY clickNum DESC");
		return super.find(finder);
	}

	
	/*
	 * 制度查找
	 * @author 叶崇晖
	 * @createtime 2018-07-04
	 * @updatetime 2018-07-04
	 */
	@Override
	public SystemCenterAttac getSystemCenterAttac(Integer id) {
		Finder finder = Finder.create(" FROM SystemCenterAttac WHERE naId='"+id+"'");
		List<SystemCenterAttac> li = super.find(finder);
		return li.get(0);
	}


}
