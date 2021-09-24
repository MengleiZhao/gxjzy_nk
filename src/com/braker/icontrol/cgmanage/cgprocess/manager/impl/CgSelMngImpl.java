package com.braker.icontrol.cgmanage.cgprocess.manager.impl;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;


/**
 * 供应商的service实现类
 * @author 冉德茂
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Service
@Transactional
public class CgSelMngImpl extends BaseManagerImpl<WinningBidder> implements CgSelMng {
		
	/*
	 * 通过ID查询供应商信息
	 * @author 冉德茂
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@Override
	public List<WinningBidder> findByWid(Integer wid) {
		Finder finder = Finder.create(" FROM WinningBidder WHERE fpabId="+wid+" ");
		return super.find(finder);
	}
	



	
	


}

	
	
	


