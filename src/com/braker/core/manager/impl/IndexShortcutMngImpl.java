package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.IndexShortcutMng;
import com.braker.core.model.Function;
import com.braker.core.model.IndexShortcut;
import com.braker.core.model.User;

/**
 * 首页快速入口的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Service
@Transactional
public class IndexShortcutMngImpl extends BaseManagerImpl<IndexShortcut> implements IndexShortcutMng {
	@Autowired
	private FunctionMng functionMng;
	
	/*
	 * 根据用户ID查询快速入口
	 * @author 叶崇晖
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public List<IndexShortcut> findByUserId(User user) {
		Finder finder = Finder.create(" FROM IndexShortcut WHERE userId='"+user.getId()+"'");
		return super.find(finder);
	}

	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@Override
	public void save(String ksrk, User user) {
		List<IndexShortcut> li = findByUser(user);
		for (int i = 0; i < li.size(); i++) {
			super.delete(li.get(i));
		}
		if("".equals(ksrk) || ksrk==null) {
		} else {
			String[] idli = ksrk.split(",");
			for (int i = 0; i < idli.length; i++) {
				Long id = Long.valueOf(idli[i]);
				Function f = functionMng.findById(id);
				IndexShortcut bean = new IndexShortcut();
				bean.setUserId(user.getId());
				bean.setMenuCode(f.getId().toString());
				bean.setMenuName(f.getName());
				bean.setMenuUrl(f.getUrl());
				super.saveOrUpdate(bean);
				if(i==7) {
					break;
				}
			}
		}
	}

	/*
	 * 根据用户查询
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@Override
	public List<IndexShortcut> findByUser(User user) {
		Finder finder = Finder.create(" FROM IndexShortcut WHERE userId='"+user.getId()+"'");
		return super.find(finder);
	}
	

}
