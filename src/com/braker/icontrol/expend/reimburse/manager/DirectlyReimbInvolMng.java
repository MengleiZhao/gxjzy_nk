package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbInvolDeatil;


/**
 * 直接报销申请发票明细表的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-06
 * @updatetime 2018-08-06
 */
public interface DirectlyReimbInvolMng extends BaseManager<DirectlyReimbInvolDeatil> {
	
	/*
	 * 发票查询
	 * @author 叶崇晖
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	public List<DirectlyReimbInvolDeatil> getFaPiao(Integer drId);
}
