package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbDetailMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbDetail;


/**
 * 直接报销申请明细的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-04
 * @updatetime 2018-08-04
 */
@Service
@Transactional
public class DirectlyReimbDetailMngImpl extends BaseManagerImpl<DirectlyReimbDetail> implements DirectlyReimbDetailMng {

	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	@Override
	public List<DirectlyReimbDetail> getMingxi(Integer drId) {
		Finder finder = Finder.create(" FROM DirectlyReimbDetail WHERE drId="+drId);
		return super.find(finder);
	}

}
