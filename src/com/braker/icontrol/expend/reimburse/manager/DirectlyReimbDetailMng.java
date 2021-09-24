package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbDetail;

/**
 * 直接报销申请明细的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-04
 * @updatetime 2018-08-04
 */
public interface DirectlyReimbDetailMng extends BaseManager<DirectlyReimbDetail> {
	
	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	public List<DirectlyReimbDetail> getMingxi(Integer drId);
}
