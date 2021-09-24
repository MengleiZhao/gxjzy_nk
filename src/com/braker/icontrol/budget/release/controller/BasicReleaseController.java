package com.braker.icontrol.budget.release.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TBasicMng;

/**
 * 基本支出指标下达
 * @author zhangxun
 *
 */
@Controller
@RequestMapping("/basicRelease")
@SuppressWarnings("serial")
public class BasicReleaseController extends BaseController  {
	
	@Autowired
	private TBasicMng tBasicMng;
	@Autowired 
	private TBasicItfMng tBasicItfMng; 

	/** 页面跳转start **/
	
	//列表
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/budget/base-release/release-list";
	}
	
	//新增
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		model.addAttribute("currentUser", getUser());
		return "/WEB-INF/view/budget/base-release/release-add";
	}
	
	//修改
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable String id){
		return "/WEB-INF/view/budget/base-release/release-edit";
	}
	
	//详情
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model, @PathVariable String id){
		return "/WEB-INF/view/budget/base-release/release-detail";
	}
	
	/** 页面跳转end **/
	
	
	
	/** 操作start **/
	
	//保存
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ModelMap modeal, String saveType, TBudgetaryIndicBasic basicRelease, 
			String personOutJson, String commOutJson, String yearOutJson, String leastOutJson){
		try {

//			tBasicMng.save(saveType, basicRelease, getUser(), personOutJson, commOutJson, yearOutJson, leastOutJson);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
	//删除
	
	/** 操作end **/
	
	
	
	
	/** 数据获取start **/
	
	//列表-基本指标
	@RequestMapping(value="/pageData")
	@ResponseBody
	public JsonPagination pageData(TBudgetaryIndicBasicItf bean, String sort,String order,Integer page,Integer rows){
		
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = tBasicItfMng.pageList(bean, getUser(), page, rows);
    	
		return getJsonPagination(p, page);
	}
	
	//列表-项目指标
	
	/** 数据获取end **/
}
