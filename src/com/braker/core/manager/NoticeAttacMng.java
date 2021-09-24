package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;

/**
 * 公告中心附件的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
public interface NoticeAttacMng extends BaseManager<NoticeAttac>{
	/*
	 * 查询附件信息
	 * @author 叶崇晖
	 * @createtime 2018-06-11
	 * @updatetime 2018-06-11
	 */
	public NoticeAttac getAttac(Notice bean);
}
