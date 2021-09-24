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
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.ExpendStandConfMng;
import com.braker.core.model.ExpendStandConf;

@Controller
@RequestMapping("/ExpendStandConf")
public class ExpendStandConfContronller extends BaseController{

	@Autowired
	private ExpendStandConfMng expendStandConfMng;
	
	/**
	 * 跳转主页
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/list")
	public String mianjSP(ModelMap model){
		
		return "/WEB-INF/gwideal_core/ExpendStandConf/ExpendStandConf_list";
	}
	
	/**
	 * 显示主页信息
	 * @param expendStandConf
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(ExpendStandConf expendStandConf,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = expendStandConfMng.list(expendStandConf, sort, order, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到增加页面
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/gwideal_core/ExpendStandConf/expendStandConf_add";
	}
	
	/**
	 * 保存修改功能
	 * @param expendStandConf
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ExpendStandConf expendStandConf,ModelMap model){
		try {
			if(StringUtil.isEmpty(expendStandConf.getFpLevel())){
				return getJsonResult(false,"请填写岗位级别！");
			}
			if(StringUtil.isEmpty(expendStandConf.getFpName())){
				return getJsonResult(false,"请填写岗位名称！");
			}
			if(expendStandConf.getfStandAmountD()==null){
				return getJsonResult(false,"请填开支标准（下限）！");
			}
			if(expendStandConf.getfStandAmountU()==null){
				return getJsonResult(false,"请填开支标准（上限）！");
			}
			expendStandConfMng.save(expendStandConf, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败请联系管理员！");
		}
		return getJsonResult(true,"保存成功！");
	}
	
	/**
	 * 跳转到修改页面
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		model.addAttribute("bean",expendStandConfMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/ExpendStandConf/expendStandConf_add";
	}
	
	/**
	 * 根据id删除
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-11
	 * @author crc
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			expendStandConfMng.deleteById(Integer.valueOf((id)));
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");
	}
}
