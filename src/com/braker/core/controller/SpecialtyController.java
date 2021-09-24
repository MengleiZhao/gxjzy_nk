package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.SpecialtyMng;
import com.braker.core.model.Specialty;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/profession")
public class SpecialtyController extends BaseController{

	@Autowired
	private SpecialtyMng specialtyMng;
	
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/profession/list";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/view/profession/add";
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		Specialty bean = specialtyMng.findById(id);
		model.addAttribute("bean",bean);
		return "/WEB-INF/view/profession/edit";
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			Specialty bean = specialtyMng.findById(id);
			specialtyMng.deleteSpecialty(bean, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping(value="/save")
	@ResponseBody
	public Result save(Specialty bean){
		try {
			specialtyMng.saveSpecialty(bean,getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	
	/**
	 * 跳转到职业选择页面 treegrid
	 */
	@RequestMapping("/refTreeGrid/{selectType}")
	public String refTreeGrid(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/profession/refTreeGrid";
	}
	/**
	 * 跳转到职业选择页面 datagrid
	 */
	@RequestMapping("/refDataGrid/{selectType}")
	public String refDataGrid(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/profession/refDataGrid";
	}
	
	@RequestMapping("/jsonDg")
	@ResponseBody
	public JsonPagination jsonDg(Specialty bean, String sort, String order, Integer page, Integer rows, ModelMap model) {
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = specialtyMng.list(bean, sort, order, page, rows, hasRole("QU_ROLE"), isStreetRole(), getUser());
		return paginationJson(p, page);
	}
	
	/**
	 * treegird列表-选择职业
	 */
	@RequestMapping(value="/treeGrid")
	@ResponseBody
	public List<TreeEntity> treeGrid(String name,String code,String id,ModelMap model){
		
		List<Specialty> professList = null;//职业集合
		List<TreeEntity> treeList = new ArrayList<TreeEntity>();//节点集合
		
		
		//输入了查询条件 输入查询时候id为null
		if(id==null && (!StringUtil.isEmpty(name) || !StringUtil.isEmpty(code))){
			Specialty profess = new Specialty();
			profess.setName(name);
			profess.setCode(code);
			treeList = specialtyMng.getQueryTree(profess);
		//获取父节点
		}else if(id==null){
			professList = specialtyMng.getRoots();
			for(Specialty profess: professList){
				TreeEntity tree = new TreeEntity();
				tree.setId(profess.getId());
				tree.setText(profess.getName());
				tree.setCode(profess.getCode());
//				tree.setChildren(new ArrayList<TreeEntity>());
				if(specialtyMng.haveChild(profess)){
					tree.setState("closed");
					tree.setHaveChild("1");
				}else{
					tree.setHaveChild("0");
				}
				treeList.add(tree);
			}
		//获取子节点
		}else if(id!=null){
			professList = specialtyMng.getChild(id);
			for(Specialty profess: professList){
				TreeEntity tree = new TreeEntity();
				tree.setId(profess.getId());
				tree.setText(profess.getName());
				tree.setCode(profess.getCode());
				tree.setLeaf(true);
				if(specialtyMng.haveChild(profess)){
					tree.setState("closed");
					tree.setLeaf(false);
					tree.setHaveChild("1");
				}else{
					tree.setHaveChild("0");
				}
				treeList.add(tree);
			}
		}
		return treeList;
	}
}
