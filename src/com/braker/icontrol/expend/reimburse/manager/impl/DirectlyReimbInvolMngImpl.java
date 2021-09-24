package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbInvolMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbInvolDeatil;

/**
 * 直接报销申请发票明细表的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-06
 * @updatetime 2018-08-06
 */
@Service
@Transactional
public class DirectlyReimbInvolMngImpl extends BaseManagerImpl<DirectlyReimbInvolDeatil> implements DirectlyReimbInvolMng {

	/*
	 * 发票查询
	 * @author 叶崇晖
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	@Override
	public List<DirectlyReimbInvolDeatil> getFaPiao(Integer drId) {
		Finder finder = Finder.create(" FROM DirectlyReimbInvolDeatil WHERE drId="+drId);
		return super.find(finder);
	}

}
