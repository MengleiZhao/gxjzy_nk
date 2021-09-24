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
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.EconomicMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;

@RequestMapping("/economic")
@Controller
public class EconomicController extends BaseController{
	
	@Autowired
	private EconomicMng economicMng;
	
	/**
	 * @author crc
	 * 显示主页面的查询功能
	 * @param economic
	 * @param departId
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @createtime 2018-06-05
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(Economic economic,String departId,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = economicMng.list(economic, departId, sort, order, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 显示主页
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	@RequestMapping("/list")
	public String list(ModelMap model) {
		model.addAttribute("economic", economicMng.EconomicList());
		return "/WEB-INF/gwideal_core/economic/economic_list";
	}
	
	/**
	 * 跳转新增页面
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 * @updateTime 2018-08-29
	 */
	@RequestMapping("/add")
	public String add(ModelMap model,String departId) {
		Economic e=new Economic();
		if(departId.length()==8){
			e.setfYBId(Integer.valueOf(departId));
			e.setLeve("KMJB-01");
			e.setPid(0);
		}else{
			Economic ec = economicMng.findById(Integer.valueOf(departId));
			e.setfYBId(ec.getfYBId());
			String level = ec.getLeve();
			String[] l = level.split("-");
			level=l[0]+"-"+"0"+(Integer.valueOf(l[1])+01);
			e.setLeve(level);
			e.setPid(Integer.valueOf(ec.getCode()));
		}
		model.addAttribute("bean", e);
		model.addAttribute("openType", "add");
		return "/WEB-INF/gwideal_core/economic/economic_add";
	}
	
	/**
	 * 跳转修改页面
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model) {
		model.addAttribute("bean",economicMng.findById(Integer.valueOf(id)));
		model.addAttribute("openType", "edit");
		return "/WEB-INF/gwideal_core/economic/economic_add";
	}
	
	/**
	 * 跳转详情页面
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	@RequestMapping("/view/{id}")
	public String view(@PathVariable String id,ModelMap model) {
		model.addAttribute("bean",economicMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/economic/economic_view";
	}
	
	/**
	 * 保存修改或新增的内容
	 * @param economic
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(Economic economic,ModelMap model) {
		try {
			if(StringUtil.isEmpty(economic.getCode())){
				return getJsonResult(false,"请填写科目编号！");
			}else if(StringUtil.isEmpty(economic.getName())){
				return getJsonResult(false,"请填写科目名称！");
			}else if(StringUtil.isEmpty(economic.getLeve())){
				return getJsonResult(false,"请选择科目级别！");
			}else if(StringUtil.isEmpty(String.valueOf(economic.getPid()))){
				return getJsonResult(false,"请填写上级科目编号！");
			}else if(StringUtil.isEmpty(economic.getType())){
				return getJsonResult(false,"请填写科目类型！");
			}else if(StringUtil.isEmpty(String.valueOf(economic.getOn()))){
				return getJsonResult(false,"请选择是否启用！");
			}else{
				int num = economicMng.queryFECCode(economic);
				if(num>0){
					return getJsonResult(false,"该科目编号已存在！");
				}
			}
			economicMng.economic_save(economic, getUser());
			//重新初始化加入内存里
			economicMng.init();
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 根据fid删除数据
	 * @param id
	 * @param model
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			if(StringUtil.isEmpty(id)){
				return getJsonResult(false,"请选择你要删除的对象！");
			}
			economicMng.economic_delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败！");
		}
		return getJsonResult(true,"删除成功！");
	}
	
	
	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = economicMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	

	/**
	 * 查询二级分类
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/findEconomicLeve2")
	@ResponseBody
	public List<ComboboxJson> findEconomicLeve2(String selected){
		List<Economic> list = economicMng.findEconomicLeve2();
		return getComboboxJson(list,selected);
	}
	
}
