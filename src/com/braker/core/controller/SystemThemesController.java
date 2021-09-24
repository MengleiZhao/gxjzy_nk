package com.braker.core.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.web.BaseController;
import com.braker.core.manager.SystemThemesMng;

/**
 * 主题配置管理的控制层
 * @author 叶崇晖
 * @createtime 2018-12-11
 * @updatetime 2018-12-11
 */
@Controller               
@RequestMapping(value = "/systemthemes")
public class SystemThemesController extends BaseController {
	@Autowired
	private SystemThemesMng systemThemesMng;
	
	/**
	 * 跳转到主题管理页面
	 * @author 叶崇晖
	 * @createtime 2018-12-11
	 * @updatetime 2018-12-11
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/system-themes";
	}
	
	@RequestMapping(value = "/changeTheme")
	@ResponseBody
	public String changeTheme(Integer id) {
		systemThemesMng.changeTheme(id);
		return "true";
	}
}
