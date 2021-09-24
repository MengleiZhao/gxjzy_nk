package com.braker.core.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionClassMgrMng;
import com.braker.core.model.FunctionClassMgr;

/**
 * 功能分类科目管理的控制层
 * 
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
@Controller               
@RequestMapping(value = "/finctionclassmgrgl")
public class FunctionClassMgrController extends BaseController{
	@Autowired
	private FunctionClassMgrMng functionClassMgrMng;
	
	/*
	 * 跳转到功能分类科目页面
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/gwideal_core/functionclassmgr/functionclassmgr_list";
	}
	
	/*
	 * 分页数据获取功能科目信息
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/functionclassPageData")
	@ResponseBody
	public JsonPagination loanPage(FunctionClassMgr bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = functionClassMgrMng.pageList(bean, page, rows);;
    	List<FunctionClassMgr> li = (List<FunctionClassMgr>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/*
	 * 新增功能科目
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		return "/WEB-INF/gwideal_core/functionclassmgr/functionclassmgr_add";
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(FunctionClassMgr bean,ModelMap model) {
		
		try {
			functionClassMgrMng.save(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 查看功能科目信息
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//id是功能科目表的主键id   fmId
		//查询基本信息
		model.addAttribute("bean",functionClassMgrMng.findById(Integer.valueOf(id)));
		
		return "/WEB-INF/gwideal_core/functionclassmgr/functionclassmgr_detail";
	}
	/*
	 * 功能科目信息的修改
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		//查询基本信息
		model.addAttribute("bean",functionClassMgrMng.findById(Integer.valueOf(id)));
		
		return "/WEB-INF/gwideal_core/functionclassmgr/functionclassmgr_add";
	}	
	/*
	 * 功能科目信息的删除
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			functionClassMgrMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
