package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.ReimbInvolDeatil;

/**
 * 报销申请发票明细表的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
public interface ReimbInvolMng extends BaseManager<ReimbInvolDeatil> {
	
	/*
	 * 发票查询
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	public List<ReimbInvolDeatil> getFaPiao(Integer rId);
}
