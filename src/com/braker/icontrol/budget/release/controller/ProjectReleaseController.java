package com.braker.icontrol.budget.release.controller;

import java.util.List;

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
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicPro;

@Controller
@RequestMapping("/proRelease")
@SuppressWarnings("serial")
public class ProjectReleaseController extends BaseController  {

	/** 页面跳转start **/
	
	//列表
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/budget/release/release-list";
	}
	
	//新增
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/view/budget/release/release-add";
	}
	
	//修改
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable String id){
		return "/WEB-INF/view/budget/release/release-edit";
	}
	
	//详情
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model, @PathVariable String id){
		return "/WEB-INF/view/budget/release/release-detail";
	}
	
	/** 页面跳转end **/
	
	/** 操作start **/
	
	//保存
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ModelMap model, TBudgetaryIndicBasic basic, TBudgetaryIndicPro pro, String basicTf, String proTf){
		try {

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
	public JsonPagination pageData(DepartArrange bean, String sort,String order,Integer page,Integer rows){
		
//		if(page==null){page=1;}
//    	if(rows==null){rows=SimplePage.DEF_COUNT;}
//    	Pagination p = departArrangeMng.pageList(bean, getUser(), page, rows);
//    	//加入排序号
//		List<DepartArrange> list = (List<DepartArrange>) p.getList();
//		if (list != null && list.size() > 0) {
//			for (int i = 0; i < list.size(); i++) {
//				DepartArrange arr = list.get(i);
//				arr.setPageOrder(page*rows+i-9);
//			}
//		}
		return null;
	}
	
	//列表-项目指标
	
	/** 数据获取end **/
}
