package com.braker.core.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.httpclient.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.util.SelectTreeUtils;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionMng;
import com.braker.core.model.Function;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/function")
public class FunctionController extends BaseController {
	@Autowired
	private FunctionMng functionMng;
	
	@RequestMapping("/main")
	public String main() {
		return "/WEB-INF/gwideal_core/function/main";
	}
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(Function bean,Long pid,ModelMap model){
		List<Function> list=new ArrayList<Function>();
		if (pid == null) {
			list = functionMng.getRoots();
		} else {
			Function parent=functionMng.findById(pid);
			if(null!=parent && null!=parent.getId()){
				if(null!=parent.getChild() && parent.getChild().size()>0){
					list = new ArrayList<Function>(parent.getChild());
				}else{
					list.add(parent);
				}
			}
		}
		model.addAttribute("pid",pid);
		Pagination p=new Pagination(1,50,list.size(),list);
		return getJsonPagination(p,1);
	}
	
	@RequestMapping("/list")
	public String list(Long pid,ModelMap model) {
		model.addAttribute("pid", pid);
		return "/WEB-INF/gwideal_core/function/list";
	}
	
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(Long id,ModelMap model) {
		try {
			// 内容。取所有列表，找出父菜单。
			List<Function> listFunction=null;
			if(null==id){
				listFunction = functionMng.getRoots();
			}else{
				listFunction = functionMng.getChild(id);
			}
			List<TreeEntity> list=new ArrayList<TreeEntity>();
			if(null!=listFunction && listFunction.size()>0){
				for(Function f:listFunction){
					TreeEntity ft=new TreeEntity();
					ft.setId(f.getId().toString());
					ft.setText(f.getName());
					if(null!=functionMng.getChild(f.getId()) ){
						ft.setState("closed");
					}else{
						ft.setLeaf(true);
					}
					list.add(ft);
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			return null;
		}
		
	}
	
	@RequestMapping("/add")
	public String add(Long pid,ModelMap model) {
		Function parent=null;
		if (pid != null) {
			parent = functionMng.findById(pid);
		}
		// 功能菜单
		model.addAttribute("pid",pid);
		model.addAttribute("parent",parent);
		return "/WEB-INF/gwideal_core/function/add";
	}
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Function bean) {
		try {
			if(null==bean.getId()){
				bean.setCreator(getUser());
			}else{
				bean.setUpdator(getUser());
			}
			functionMng.save(bean);
			//修改完毕以后，维护缓存里的权限数据跟数据库一致
			functionMng.init();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"保存失败,请联系管理员！");
		}
		return getJsonResult(true,"保存成功！");
	}
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable Long id,ModelMap model) {
		try {
			model.addAttribute("bean",functionMng.findById(id));
			model.addAttribute("listParent",SelectTreeUtils.webTree(functionMng.getRoots()));
			return "/WEB-INF/gwideal_core/function/edit";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/gwideal_core/function/edit";
			// TODO: handle exception
		}
	
	}
	@RequestMapping("/update")
	@ResponseBody
	public Result update(Function bean) {
		try {
			if(null==bean.getId()){
				bean.setCreator(getUser());
			}else{
				bean.setUpdator(getUser());
			}
			functionMng.updateDefault(bean);
			//修改完毕以后，维护缓存里的权限数据跟数据库一致
			functionMng.init();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"保存失败,请联系管理员！");
		}
		return getJsonResult(true,"保存成功！");
	}

	public String priorityUpdate(Long[] wids,Integer[] prioritys,Long pid,ModelMap model) {
		for (int i = 0; i < wids.length; i++) {
			Function f = functionMng.findById(wids[i]);
			f.setPriority(prioritys[i]);
			functionMng.update(f);
		}
		//修改完毕以后，维护缓存里的权限数据跟数据库一致
		functionMng.init();
		return list(pid,model);
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(Long id,Long ids[]) {
		try {
			if (id != null) {
				Function ft = functionMng.findById(id);
				if(null!=ft.getRoles() && ft.getRoles().size()>0){
					return getJsonResult(false,"记录已被角色引用,不能删除！");
				}else{
					ft.setFlag("0");
					ft.setUpdateTime(new Date());
					ft.setUpdator(getUser());
					functionMng.updateDefault(ft);
				}
			} else {
				boolean flag=true;
				for (int i = 0; i < ids.length; i++) {
					Function ft = functionMng.findById(ids[i]);
					if(null!=ft.getRoles() && ft.getRoles().size()>0){
						flag=false;
						break;
					}
				}
				if(flag){
					functionMng.deleteById(ids);
				}else{
					return getJsonResult(false,"记录已被角色引用,不能删除！");
				}
			}
			//修改完毕以后，维护缓存里的权限数据跟数据库一致
			functionMng.init();
		}catch(DataIntegrityViolationException e) {
			return getJsonResult(false,"记录已被角色引用,不能删除！");
		}catch(Exception e) {
			return getJsonResult(false,"删除失败,请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");
	}

	
}
