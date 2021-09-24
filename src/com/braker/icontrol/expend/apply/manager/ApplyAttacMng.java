package com.braker.icontrol.expend.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.apply.model.ApplicationAttac;

/**
 * 事前申请附件的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-29
 * @updatetime 2018-06-29
 */
public interface ApplyAttacMng extends BaseManager<ApplicationAttac> {
	
	/*
	 * 根据gId（直接申请ID）附件信息
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	public List<ApplicationAttac> getByGId(Integer gId);
	
	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-07-09
	 * @updatetime 2018-07-09
	 */
	public List<ApplicationAttac> getAttacByName(String filename);
	
}
