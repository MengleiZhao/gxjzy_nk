package com.braker.core.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CategoryMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Category;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/lookup")
public class LookupsController extends BaseController{
	
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private CategoryMng categoryMng;
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/gwideal_core/lookup/list";
	}
	
	@RequestMapping("/add")
	public String add(String categoryCode,ModelMap model){
		if(!StringUtil.isEmpty(categoryCode)){
			model.addAttribute("category",categoryMng.findUniqueByProperty("code", categoryCode));
		}
		return "/WEB-INF/gwideal_core/lookup/edit";
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model) {
		Lookups bean=lookupsMng.findById(id);
		model.addAttribute("bean",bean);
		model.addAttribute("category",bean.getCategory());
		return "/WEB-INF/gwideal_core/lookup/edit";
	}
	
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			Lookups bean=lookupsMng.findById(id);
			bean.setFlag("0");
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			lookupsMng.updateDefault(bean);
			lookupsMng.init();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");
	}
	
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(Lookups bean,String categoryCode,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	if(null==bean){
    		bean=new Lookups();
    	}
    	if(null==bean.getCategory()){
    		bean.setCategory(new Category());
    	}
    	bean.getCategory().setCode(categoryCode);
		Pagination p=lookupsMng.list(bean,sort,order,page,rows);
		return getJsonPagination(p,page);
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Lookups bean,ModelMap model) {
		try {
			if(lookupsMng.isExist(bean)){
				return getJsonResult(false,"字典类型代码已存在，请重新填写！");
			}
			if(StringUtil.isEmpty(bean.getId())){
				bean.setCreator(getUser());
			}else{
				bean.setUpdator(getUser());
			}
			lookupsMng.save(bean);
			lookupsMng.init();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/**
	 * /lookup/lookupsJson
	 * 字典项查询
	 * @param parentCode 父节点编码
	 * @param selected 选中值
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookupsJson(String parentCode,String selected,String blanked){
		List<Lookups> list=lookupsMng.getLookupsSelect(parentCode,blanked);
		return getComboboxJson(list,selected);
	}
	
	@RequestMapping("/refData")
	public String refData(String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/lookup/refData";
	}
}
