package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.SystemThemes;

/**
 * 系统主题配置service抽象类
 * @author 叶崇晖
 * @createtime 2018-12-13
 * @updatetime 2018-12-13
 */
public interface SystemThemesMng extends BaseManager<SystemThemes> {
	
	/**
	 * 根据激活状态查询相应的主题
	 * @param stauts为激活状态
	 * @return 系统主题类list
	 */
	public List<SystemThemes> findByStauts(String stauts);
	
	/**
	 * 根据id修改系统激活状态
	 * @param id
	 */
	public void changeTheme(Integer id);
}
