package com.braker.icontrol.expend.loan.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;

/**
 * 借款申请人员信息的service抽象类
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
public interface LoanPayeeMng extends BaseManager<LoanPayeeInfo> {

	/*
	 * 根据借款单ID查询收款人信息
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	public List<LoanPayeeInfo> findBylId(Integer lId);
}
