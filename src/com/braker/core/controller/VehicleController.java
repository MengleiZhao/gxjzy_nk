package com.braker.core.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.User;
import com.braker.core.model.Vehicle;

/**
 * 交通工具维护的控制层
 * 本模块用于交通工的增删改查
 * @author 叶崇晖
 * @createtime 2019-01-09
 * @updatetime 2019-01-09
 */
@Controller
@RequestMapping(value = "/vehicle")
public class VehicleController extends BaseController {
	@Autowired
	private VehicleMng vehicleMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/gwideal_core/vehicle/vehicle_list";
	}
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	@RequestMapping(value = "/pageData")
	@ResponseBody
	public JsonPagination pageData(Vehicle bean, ModelMap model, Integer page, Integer rows, String parentCode) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = vehicleMng.pageList(bean, page, rows, parentCode);
    	List<Vehicle> li = (List<Vehicle>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09         
	 */
	@RequestMapping("/add")
	public String add(ModelMap model, String code) {
		Vehicle bean = new Vehicle();
		Integer count =  vehicleMng.getCount(code)+2;
		if(code == null || "undefined".equals(code)) {
			code = "JTGJ";
		} else {
			bean.setParentCode(code);
		}
		if(count<10){
			code = code+"0"+count;
		} else {
			code = code+count;
		}
		bean.setCode(code);
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/vehicle/vehicle_add";
	}
	
	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09 
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(Vehicle bean) {
		try {
			vehicleMng.saveVehicle(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 跳转修改页面
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09         
	 */
	@RequestMapping("/edit")
	public String edit(ModelMap model, Integer id) {
		Vehicle bean = vehicleMng.findById(id);
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/vehicle/vehicle_add";
	}
	
	/*
	 * 跳转到交通工具等级列表页面
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	@RequestMapping(value = "/level")
	public String level(ModelMap model, String code) {
		model.addAttribute("parentCode", code);
		return "/WEB-INF/gwideal_core/vehicle/vehicle_level";
	}
	
	/**
	 * 字典项查询
	 * @param parentCode 父节点编码
	 * @param selected 选中值
	 * @return
	 */
	@RequestMapping("/comboboxJson")
	@ResponseBody
	public List<ComboboxJson> comboboxJson(String parentCode,String selected){
		List<Vehicle> list = vehicleMng.findByParentCode(parentCode);
		List<ComboboxJson> a = getComboboxJson(list,selected);
		for (int i = a.size()-1; i >=0; i--) {
			if("".equals(a.get(i).getId())){
				a.remove(i);
			}
		}
		return a;
	}
	/**
	 * 字典项查询
	 * @param parentCode 父节点编码
	 * @param selected 选中值
	 * @return
	 */
	@RequestMapping("/comboboxJsons")
	@ResponseBody
	public List<ComboboxJson> comboboxJsons(String parentCode,String selected,String level){
		List<Vehicle> list = vehicleMng.findByParentCodes(parentCode,level);
		return getComboboxJson(list,selected);
	}
	
	/*
	 * 删除
	 * @author 叶崇晖
	 * @createtime 2019-01-09
	 * @updatetime 2019-01-09
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			Vehicle bean = vehicleMng.findById(id);
			String code = bean.getCode();
			vehicleMng.delete(bean);
			
			List<Vehicle> list = vehicleMng.findByParentCode(code);
			for (int i = 0; i < list.size(); i++) {
				vehicleMng.delete(list.get(i));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
}
