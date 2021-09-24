package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.IndexShortcut;
import com.braker.core.model.User;

/**
 * 首页快速入口的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
public interface IndexShortcutMng extends BaseManager<IndexShortcut> {
	
	/*
	 * 根据用户ID查询快速入口
	 * @author 叶崇晖
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public List<IndexShortcut> findByUserId(User user);
	
	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	public void save(String ksrk, User user);
	
	
	/*
	 * 根据用户查询
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	public List<IndexShortcut> findByUser(User user);
}
