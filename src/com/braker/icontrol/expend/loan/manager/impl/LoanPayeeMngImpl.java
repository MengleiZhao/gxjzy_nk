package com.braker.icontrol.expend.loan.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.loan.manager.LoanPayeeMng;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;

/**
 * 借款申请人员信息的service实现类
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
@Service
@Transactional
public class LoanPayeeMngImpl extends BaseManagerImpl<LoanPayeeInfo> implements LoanPayeeMng {

	/*
	 * 根据借款单ID查询收款人信息
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@Override
	public List<LoanPayeeInfo> findBylId(Integer lId) {
		Finder finder = Finder.create(" FROM LoanPayeeInfo WHERE lId="+lId);
		return super.find(finder);
	}

}
