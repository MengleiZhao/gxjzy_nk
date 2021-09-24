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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.AreaMng;
import com.braker.core.model.AreaBasicInfo;
import com.braker.core.model.Vehicle;

/**
 * 省市地区维护的控制层
 * 本模块用于省市地区的增删改查
 * @author 叶崇晖
 * @createtime 2019-01-10
 * @updatetime 2019-01-10
 */
@Controller
@RequestMapping(value = "/area")
public class AreaController extends BaseController {
	@Autowired
	private AreaMng areaMng;
	
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/gwideal_core/area/area_list";
	}
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	@RequestMapping(value = "/pageData")
	@ResponseBody
	public JsonPagination pageData(AreaBasicInfo bean, ModelMap model, Integer page, Integer rows, String parentCode) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = areaMng.pageList(bean, page, rows, parentCode);
    	List<AreaBasicInfo> li = (List<AreaBasicInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10         
	 */
	@RequestMapping("/add")
	public String add(ModelMap model, String code) {
		AreaBasicInfo bean = new AreaBasicInfo();
		Integer count =  areaMng.getCount(code);
		if(code == null || "undefined".equals(code)) {
			code = "10";
		} else {
			bean.setParentCode(code);
			code = code + "10";
		}
		
		code = String.valueOf(Integer.valueOf(code)+count);
		
		bean.setCode(code);
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/area/area_add";
	}
	
	/*
	 * 跳转批量新增页面
	 * @author 叶崇晖
	 * @createtime 2019-01-23
	 * @updatetime 2019-01-23       
	 */
	@RequestMapping("/batchAdd")
	public String batchAdd(ModelMap model, String code) {
		Integer count =  areaMng.getCount(code);//查找在父节点下的子集条数
		model.addAttribute("parentCode", code);//设置父节点编码
		code = code + "10";
		code = String.valueOf(Integer.valueOf(code)+count);
		model.addAttribute("firstCode", code);//设置批量添加的第一个地区的编码
		return "/WEB-INF/gwideal_core/area/area_batch_add";
	}
	
	/*
	 * 保存
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(AreaBasicInfo bean) {
		try {
			areaMng.saveArea(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 批量保存
	 * @author 叶崇晖
	 * @createtime 2019-01-23
	 * @updatetime 2019-01-23
	 */
	@RequestMapping(value = "/batchSave")
	@ResponseBody
	public Result batchSave(String parentCode, String firstCode, String nameList) {
		try {
			areaMng.saveBatchSave(parentCode, firstCode, nameList);
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
		AreaBasicInfo bean = areaMng.findById(id);
		model.addAttribute("bean", bean);
		return "/WEB-INF/gwideal_core/area/area_add";
	}
	
	/*
	 * 城市地区列表页面
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 * @updatetime 2019-01-10
	 */
	@RequestMapping(value = "/level")
	public String level(ModelMap model, String code) {
		model.addAttribute("parentCode", code);
		return "/WEB-INF/gwideal_core/area/area_level";
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
		List<AreaBasicInfo> list = areaMng.comboboxFind(parentCode);
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
			AreaBasicInfo bean = areaMng.findById(id);
			String code = bean.getCode();
			areaMng.delete(bean);
			
			List<AreaBasicInfo> list = areaMng.comboboxFind(code);
			for (int i = 0; i < list.size(); i++) {
				areaMng.delete(list.get(i));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/**
	 * 字典项查询
	 * @param parentCode 父节点编码
	 * @param selected 选中值
	 * @return
	 */
	@RequestMapping("/placeEndJson")
	@ResponseBody
	public List<ComboboxJson> placeEndJson(String code, String sonCode) {
		String select = null;
		List<AreaBasicInfo> list = areaMng.comboboxFind(null);
		if(!StringUtil.isEmpty(sonCode)) {
			List<AreaBasicInfo> li = areaMng.findByCode(sonCode);
			if(li.size()==1) {
				String parentCode = li.get(0).getParentCode();
				select = parentCode;
			}
		}
		if(!StringUtil.isEmpty(code)) {
			List<AreaBasicInfo> li = areaMng.findByCode(code);
			if(li.size()==1) {
				String parentCode = li.get(0).getParentCode();
				list = areaMng.comboboxFind(parentCode);
				select = code;
			}
		}
		return getComboboxJson(list,select);
	}
	
}

