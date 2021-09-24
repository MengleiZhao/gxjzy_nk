package com.braker.core.manager.impl;

import java.io.Serializable;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Condition;
import com.braker.common.hibernate.Finder;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.hibernate.Updater;
import com.braker.common.page.Pagination;
import com.braker.core.manager.SystemThemesMng;
import com.braker.core.model.SystemThemes;

/**
 * 系统主题配置service实现类
 * @author 叶崇晖
 * @createtime 2018-12-13
 * @updatetime 2018-12-13
 */
@Service
@Transactional
public class SystemThemesMngImpl extends BaseManagerImpl<SystemThemes> implements SystemThemesMng {

	@Override
	public List<SystemThemes> findByStauts(String stauts) {
		Finder finder = Finder.create(" FROM SystemThemes WHERE stauts='"+stauts+"'");
		return super.find(finder);
	}

	@Override
	public void changeTheme(Integer id) {
		getSession().createSQLQuery("UPDATE t_system_themes SET F_STAUTS=1 WHERE F_ID="+id).executeUpdate();
		getSession().createSQLQuery("UPDATE t_system_themes SET F_STAUTS=0 WHERE F_ID<>"+id).executeUpdate();
	}



}
