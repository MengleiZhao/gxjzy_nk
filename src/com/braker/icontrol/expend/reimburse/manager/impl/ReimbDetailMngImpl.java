package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.ReimbDetailMng;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;

/**
 * 报销申请明细的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Service
@Transactional
public class ReimbDetailMngImpl extends BaseManagerImpl<ReimbDetail> implements ReimbDetailMng {

	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@Override
	public List<ReimbDetail> getMingxi(Integer rId) {
		Finder finder = Finder.create(" FROM ReimbDetail WHERE rId="+rId);
		return super.find(finder);
	}

}
