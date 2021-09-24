package com.braker.icontrol.cgmanage.cginquiries.manager.impl;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.cgmanage.cginquiries.manager.CgInquiriesListMng;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningList;


/**
 * 询比价登记的service实现类
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
@Service
@Transactional
public class CgInquiriesListMngImpl extends BaseManagerImpl<InqWinningList> implements CgInquiriesListMng {
	/*
	 * 通过mainid查询报价清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@Override
	public List<InqWinningList> getQingdan(Integer mainid) {
		Finder finder = Finder.create(" FROM InqWinningList WHERE fmainId='"+mainid+"'");
		return super.find(finder);
	}




	
	


	
	
	
}

	
	
	


