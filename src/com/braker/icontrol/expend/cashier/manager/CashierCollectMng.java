package com.braker.icontrol.expend.cashier.manager;

import java.io.File;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.cashier.model.CashierCollectInfo;

/**
 * 出纳采集的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-27
 * @updatetime 2018-08-27
 */
public interface CashierCollectMng extends BaseManager<CashierCollectInfo> {
	/*
	 * 出纳采集分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	public Pagination pageList(CashierCollectInfo bean, int pageNo, int pageSize, User user);
	
	/*
	 * 保存出纳采集信息
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	public void saveCashierCollect(File file);
}
