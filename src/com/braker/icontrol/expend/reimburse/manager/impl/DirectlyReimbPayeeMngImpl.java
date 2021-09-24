package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;

/**
 * 直接报销申请收款人的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-07
 * @updatetime 2018-08-07
 */
@Service
@Transactional
public class DirectlyReimbPayeeMngImpl extends BaseManagerImpl<DirectlyReimbPayeeInfo> implements DirectlyReimbPayeeMng {

	/*
	 * 根据drId查询收款人信息
	 * @author 叶崇晖
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@Override
	public List<DirectlyReimbPayeeInfo> getByDrId(Integer drId) {
		Finder finder = Finder.create(" FROM DirectlyReimbPayeeInfo WHERE drId="+drId);
		return super.find(finder);
	}

}
