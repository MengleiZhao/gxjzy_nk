package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.ReimbInvolMng;
import com.braker.icontrol.expend.reimburse.model.ReimbInvolDeatil;

/**
 * 报销申请发票明细表的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Service
@Transactional
public class ReimbInvolMngImpl extends BaseManagerImpl<ReimbInvolDeatil> implements ReimbInvolMng {

	/*
	 * 发票查询
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@Override
	public List<ReimbInvolDeatil> getFaPiao(Integer rId) {
		Finder finder = Finder.create(" FROM ReimbInvolDeatil WHERE rId="+rId);
		return super.find(finder);
	}

}
