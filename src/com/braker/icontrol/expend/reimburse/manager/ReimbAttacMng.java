package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.ReimbAttac;

/**
 * 报销附件的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
public interface ReimbAttacMng extends BaseManager<ReimbAttac> {
	
	/*
	 * 根据rId（报销ID）附件查询
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	public List<ReimbAttac> getByRId(Integer rId);
	
	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	public List<ReimbAttac> getAttacByName(String filename);
}
