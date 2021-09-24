package com.braker.core.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CountryMng;
import com.braker.core.model.Country;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/country")
public class CountryController extends BaseController {
	@Autowired
	private CountryMng conutryMng;
	
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/country/list";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/view/country/add";
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		Country bean = conutryMng.findById(id);
		model.addAttribute("bean",bean);
		return "/WEB-INF/view/country/edit";
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			Country bean = conutryMng.findById(id);
			conutryMng.deleteCountry(bean, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping(value="/save")
	@ResponseBody
	public Result save(Country bean){
		try {
			conutryMng.saveCountry(bean,getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	/**
	 * 国家选择页面 datagrid
	 */
	@RequestMapping("/refDataGrid/{selectType}")
	public String refDataGrid(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/country/refDataGrid";
	}
	
	@RequestMapping(value="/jsonDg")
	@ResponseBody
	public JsonPagination jsonDg(Country bean, Integer page ,Integer rows,String sort,String order){
		Pagination p = conutryMng.list(bean,sort,order,page,rows,hasRole("QU_ROLE"),isStreetRole(),getUser());
		return paginationJson(p, page);
	}

}
