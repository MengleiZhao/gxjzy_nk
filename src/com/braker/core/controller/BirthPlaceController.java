package com.braker.core.controller;

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
import com.braker.common.web.BaseController;
import com.braker.core.manager.BirthPlaceMng;
import com.braker.core.model.BirthPlace;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/birthPlace")
public class BirthPlaceController extends BaseController  {
	@Autowired
	private BirthPlaceMng birthPlaceMng;
	
	/**
	 * 数据列表
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/birthPlace/list";
	}
	
	@RequestMapping(value="/birthPlaceJson")
	@ResponseBody
	public JsonPagination listData(BirthPlace bean, Integer page ,Integer rows,String sort,String order){
		Pagination p = birthPlaceMng.list(bean,sort,order,page,rows,hasRole("QU_ROLE"),isStreetRole(),getUser());
		return paginationJson(p, page);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/view/birthPlace/add";
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		BirthPlace bean = birthPlaceMng.findById(id);
		model.addAttribute("bean",bean);
		return "/WEB-INF/view/birthPlace/edit";
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			BirthPlace bean = birthPlaceMng.findById(id);
			bean.setFlag("0");
			bean.setUpdateTime(new Date());
			birthPlaceMng.saveBirthPlace(bean, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping(value="/save")
	@ResponseBody
	public Result save(BirthPlace bean){
		try {
			birthPlaceMng.saveBirthPlace(bean,getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	/**
	 * 跳转到户籍选择页面 datagrid
	 */
	@RequestMapping("/refDataGrid/{selectType}")
	public String refDataGrid(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/birthPlace/refDataGrid";
	}
	
	@RequestMapping(value="/jsonDg")
	@ResponseBody
	public JsonPagination jsonDg(BirthPlace bean, Integer page ,Integer rows,String sort,String order){
		Pagination p = birthPlaceMng.list(bean,sort,order,page,rows,hasRole("QU_ROLE"),isStreetRole(),getUser());
		return paginationJson(p, page);
	}
	
}
