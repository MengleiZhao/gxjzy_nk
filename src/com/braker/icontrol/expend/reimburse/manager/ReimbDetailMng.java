package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;

/**
 * 报销申请明细的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
public interface ReimbDetailMng extends BaseManager<ReimbDetail> {
	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	public List<ReimbDetail> getMingxi(Integer rId);
}
