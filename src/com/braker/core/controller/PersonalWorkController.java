package com.braker.core.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.model.PersonalWork;

/**
 * 首页个人工作台的控制层
 * @author 叶崇晖
 * @createtime 2018-08-31
 * @updatetime 2018-08-31
 */

@Controller
@RequestMapping(value = "/psersonalWork")
public class PersonalWorkController extends BaseController {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	/*
	 * 代办信息分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	@RequestMapping(value = "/PageList")
	@ResponseBody
	public JsonPagination PageList(PersonalWork bean, ModelMap model, Integer page, Integer rows, String taskStauts) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = personalWorkMng.PageList(bean, page, rows, getUser(), taskStauts);
    	List<PersonalWork> li = (List<PersonalWork>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setUserName(getUser().getName());
			li.get(x).setNum((x+1)+(page-1)*rows);
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 待办删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(PersonalWork bean, ModelMap model,String id) {
    	try {
			personalWorkMng.delete(id,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
    	return getJsonResult(true,"操作成功！");
	}
}
