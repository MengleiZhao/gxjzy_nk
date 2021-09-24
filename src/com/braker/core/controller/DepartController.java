package com.braker.core.controller;




import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
@SuppressWarnings("serial")
@Controller
@RequestMapping("/depart")
public class DepartController extends BaseController{
	
	@Autowired
	private DepartMng departMng;
	@Autowired
	private UserMng userMng;
	
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,ModelMap model) {
		// 内容。取所有列表，找出父菜单。
		List<Depart> listDepart=null;
		if(null==id){
			listDepart = departMng.getRoots();
		}else{
			listDepart = departMng.getChild(id);
		}
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(null!=listDepart && listDepart.size()>0){
			for(Depart d:listDepart){
				TreeEntity ft=new TreeEntity();
				ft.setId(d.getId());
				ft.setText(d.getName());
				if(null!=d.getChildren() && d.getChildren().size()>0){
					ft.setState("closed");
				}else{
					ft.setLeaf(true);
				}
				list.add(ft);
			}
		}
		return list;
	}
	
	@RequestMapping("/list")
	public String list() {
		return "/WEB-INF/gwideal_core/depart/list";
	}
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(Depart bean,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=departMng.list(bean,sort,order,page,rows);
		return getJsonPagination(p,page);
	}
	
	/**
	 * 部门选择treegrid数据
	 */
	@RequestMapping(value="/treeGrid")
	@ResponseBody
	public List<TreeEntity> treeGrid(String name,String code,String id,ModelMap model){
		
		List<Depart> departList = null;//部门集合
		List<TreeEntity> treeList = new ArrayList<TreeEntity>();//节点集合
		
		
		//输入了查询条件 输入查询时候id为null
		if(id==null && (!StringUtil.isEmpty(name) || !StringUtil.isEmpty(code))){
			Depart depart = new Depart();
			depart.setName(name);
			depart.setCode(code);
			treeList = departMng.getQueryTree(depart);
		//获取根节点
		}else if(id==null){
			departList = departMng.getRoots();
			for(Depart depart: departList){
				TreeEntity tree = new TreeEntity();
				tree.setId(depart.getId());
				tree.setText(depart.getName());
				tree.setCode(depart.getCode());
				tree.setGrww_zrld(depart.getGrww_zrld());
				tree.setGrww_zrlddh(depart.getGrww_zrlddh());
				tree.setGrww_lxr(depart.getGrww_lxr());
				tree.setGrww_lxrdh(depart.getGrww_lxrdh());
//				tree.setChildren(new ArrayList<TreeEntity>());
				if(departMng.haveChild(depart)){
					tree.setState("closed");
					tree.setHaveChild("1");
				}else{
					tree.setHaveChild("0");
				}
				treeList.add(tree);
			}
		//获取子节点
		}else if(id!=null){
			departList = departMng.getChild(id);
			for(Depart depart: departList){
				TreeEntity tree = new TreeEntity();
				tree.setId(depart.getId());
				tree.setText(depart.getName());
				tree.setCode(depart.getCode());
				tree.setGrww_zrld(depart.getGrww_zrld());
				tree.setGrww_zrlddh(depart.getGrww_zrlddh());
				tree.setGrww_lxr(depart.getGrww_lxr());
				tree.setGrww_lxrdh(depart.getGrww_lxrdh());
				tree.setLeaf(true);
				if(departMng.haveChild(depart)){
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
		
		/** start:内容。取所有列表，找出父菜单。 **/
//		List<Depart> listDepart=null;
//		if(null==id){
//			listDepart = departMng.getRoots();
//		}else{
//			listDepart = departMng.getChild(id);
//		}
//		
//		if(null!=listDepart && listDepart.size()>0){
//			for(Depart d:listDepart){
//				TreeEntity ft=new TreeEntity();
//				ft.setId(d.getId());
//				ft.setText(d.getName());
//				if(null!=d.getChildren() && d.getChildren().size()>0){
//					ft.setState("closed");
//				}else{
//					ft.setLeaf(true);
//				}
//				list.add(ft);
//			}
//		}
//		return list;
		/** end:内容。取所有列表，找出父菜单。 **/
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model) {
		model.addAttribute("bean",departMng.findById(id));
		return "/WEB-INF/gwideal_core/depart/edit";
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model,String id) {
		if(!StringUtil.isEmpty(id)) { 
			model.addAttribute("depart",departMng.findById(id)); 
		}
		return "/WEB-INF/gwideal_core/depart/edit";
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id) {
		try {
			Depart bean = departMng.findById(id);
			boolean flag = userMng.checkUsersByDepartId(id);
			if(flag){
				return getJsonResult(false,"操作失败，该部门下存在其他用户！");
			}
			bean.setFlag("0");
			bean.setUpdateTime(new Date());
			bean.setUpdator(getUser());
			departMng.updateDefault(bean);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Depart bean){
		try {
			if(departMng.isExist(bean)){
				return getJsonResult(false,"部门名称或代码已存在，请重新填写！");
			}
			if(StringUtil.isEmpty(bean.getId())){
				bean.setCreator(getUser());
			}else{
				bean.setUpdator(getUser());
			}
			if(null==bean.getParent() || StringUtil.isEmpty(bean.getParent().getId())){
				bean.setParent(null);
			}
			if(!StringUtil.isEmpty(bean.getId()) && null!=bean.getParent() && 
			!StringUtil.isEmpty(bean.getParent().getId()) && bean.getId().equals(bean.getParent().getId())){
				return getJsonResult(false,"不能选择自己作为父部门，请重新选择！");
			}
			if (bean.getManager() != null) {
				bean.setManager(userMng.findById(bean.getManager().getId()));
			}
			departMng.save(bean);
			//修改完毕以后，维护缓存里的权限数据跟数据库一致
			departMng.init();
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 跳转到部门选择页面
	 */
	@RequestMapping("/refList/{selectType}")
	public String refList(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/depart/refTreeGrid";
	}
	
	/*
	 * 跳转到部门选择页面
	 */
	@RequestMapping("/refUserDepart/{selectType}")
	public String refUserDepart(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/depart/refUserDepartGrid";
	}
	
	/*
	 * 跳转到部门选择页面
	 */
	@RequestMapping("/refList2")
	public String refList2(String selectType,String depart_id,String num, ModelMap model){
		model.addAttribute("selectType", selectType);
		model.addAttribute("depart_id", depart_id);
		model.addAttribute("num", num);
		return "/WEB-INF/gwideal_core/depart/refTreeGrid";
	}
	
	/*
	 * 跳转到部门选择页面
	 */
	@RequestMapping("/refOneselfDepart/{selectType}")
	public String refOneselfDepart(@PathVariable String selectType, ModelMap model){
		model.addAttribute("selectType", selectType);
		return "/WEB-INF/gwideal_core/depart/refDepartOneselfTree";
	}
	
	/*
	 * 跳转到主管领导选择页面 
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(){
		
		return "/WEB-INF/gwideal_core/depart/choose_user";
	}
	
	/**
	 * 查询部门下拉框
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/getDepartCombobox")
	@ResponseBody
	public List<ComboboxJson> getDepartCombobox(String selected){
		List<Depart> list  = departMng.getChild(departMng.getRoots().get(0).getId());
		return getComboboxJson(list,selected);
	}
	
	
	/**
	 * 加载数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createtime 2019年10月15日
	 */
	@ResponseBody
	@RequestMapping("/chooseDepart")
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = departMng.getAllDeptsPartsLookups(null);
		return getComboboxJson(list,selected);
	}
	
	
}
