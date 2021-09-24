package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;

/**
 * 直接报销申请收款人的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-07
 * @updatetime 2018-08-07
 */
public interface DirectlyReimbPayeeMng extends BaseManager<DirectlyReimbPayeeInfo> {
	
	/*
	 * 根据drId查询收款人信息
	 * @author 叶崇晖
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	public List<DirectlyReimbPayeeInfo> getByDrId(Integer drId);
}
