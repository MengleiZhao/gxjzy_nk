package com.braker.core.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.HelpCenterMng;
import com.braker.core.model.HelpCenter;


/**
 * 帮助中心的控制层
 * 本模块用于帮助信息的增删改查
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */

@Controller
@RequestMapping(value = "/helpCenter")
public class HelpCenterController extends BaseController{
	@Autowired
	private HelpCenterMng helpCenterMng;
	
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-06-11
	 * @updatetime 2018-06-11
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/gwideal_core/helpCenter/helpCenter_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-06-6
	 * @updatetime 2018-06-6
	 */
	@RequestMapping(value = "/helpCenterPage")
	@ResponseBody
	public JsonPagination helpCenterPage(HelpCenter bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	//序号设置
		Pagination p = helpCenterMng.pageList(bean, page, rows);
		List<HelpCenter> li = (List<HelpCenter>) p.getList();
		for(int x=0; x<li.size(); x++) {
			li.get(x).setNum((x+1)+(page-1)*rows);
		}
		return getJsonPagination(p, page);
	}
}
