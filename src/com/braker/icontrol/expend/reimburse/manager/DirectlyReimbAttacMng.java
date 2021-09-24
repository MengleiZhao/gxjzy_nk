package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAttac;

/**
 * 直接报销单据附件的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
public interface DirectlyReimbAttacMng extends BaseManager<DirectlyReimbAttac> {
	
	/*
	 * 根据drId（直接报销ID）附件查询
	 * @author 叶崇晖
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	public List<DirectlyReimbAttac> getByDrId(Integer drId);
	
	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public List<DirectlyReimbAttac> getAttacByName(String filename);
	
}
