package com.braker.core.controller;

import java.util.List;

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
import com.braker.core.manager.Expenditure1Mng;
import com.braker.core.manager.Expenditure2Mng;
import com.braker.core.model.ExpenditureBaseic1;
import com.braker.core.model.ExpenditureBaseic2;
/**
 * 支出明细事项配置
 * @author 陈睿超
 */
@Controller
@RequestMapping("/ExpenditureBaseic")
public class ExpenditureController extends BaseController{

	
	@Autowired
	private Expenditure1Mng expenditure1Mng;
	@Autowired
	private Expenditure2Mng expenditure2Mng;
	
	/**
	 * 跳转到主页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/gwideal_core/expenditure/expenditure_list";
	}
	
	/**
	 * 加载一级事项列表
	 * @param eb1 搜索条件
	 * @param model
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/expenditureList1")
	@ResponseBody
	public JsonPagination expenditureList1(ExpenditureBaseic1 eb1,ModelMap model,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = expenditure1Mng.list(eb1, page, rows);
		List<ExpenditureBaseic1> li= (List<ExpenditureBaseic1>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 加载二级事项列表
	 * @param eb1 搜索条件
	 * @param model
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/expenditureList2")
	@ResponseBody
	public JsonPagination expenditureList2(ExpenditureBaseic2 eb2,ModelMap model,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = expenditure2Mng.list(eb2, page, rows);
		List<ExpenditureBaseic2> li= (List<ExpenditureBaseic2>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 弹出新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/add")
	public String expenditure1Add(String tEbIdTemp,String leixing ,ModelMap model){
		model.addAttribute("openType", "add");
		if(leixing.equals("1")){
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add1";
		}else if(leixing.equals("2")){
			ExpenditureBaseic2 eb2=new ExpenditureBaseic2();
			eb2.setEb1(expenditure1Mng.findById(Integer.valueOf(tEbIdTemp)));
			model.addAttribute("bean", eb2);
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add2";
		}
		return null;
	}
	
	/**
	 * 弹出修改页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/edit/{id}")
	public String expenditureEdit(@PathVariable String id,String leixing ,ModelMap model){
		model.addAttribute("openType", "edit");
		if(leixing.equals("1")){
			model.addAttribute("bean", expenditure1Mng.findById(Integer.valueOf(id)));
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add1";
		}else if(leixing.equals("2")){
			model.addAttribute("bean", expenditure2Mng.findById(Integer.valueOf(id)));
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add2";
		}
		return null;
	}
	/**
	 * 弹出详情页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/detail/{id}")
	public String expenditureDetail(@PathVariable String id,String leixing ,ModelMap model){
		model.addAttribute("openType", "detail");
		if(leixing.equals("1")){
			model.addAttribute("bean", expenditure1Mng.findById(Integer.valueOf(id)));
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add1";
		}else if(leixing.equals("2")){
			model.addAttribute("bean", expenditure2Mng.findById(Integer.valueOf(id)));
			return "/WEB-INF/gwideal_core/expenditure/expenditure_add2";
		}
		return null;
	}
	
	/**
	 * 保存
	 * @param leixing 保存的是以及还是二级
	 * @param eb1
	 * @param eb2
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(String leixing,ExpenditureBaseic1 eb1,ExpenditureBaseic2 eb2,ModelMap model){
		try {
			if(leixing.equals("1")){
				if(StringUtil.isEmpty(eb1.gettEbName1())){
					return getJsonResult(false, "请填写费用类型！");
				}
				if(StringUtil.isEmpty(eb1.gettEbCode1())){
					return getJsonResult(false, "请填写费用类型代码！");
				}
				if(expenditure1Mng.findbyCode1(eb1)){
					return getJsonResult(false, "费用类型代码重复,请重新填写！");
				}else {
					expenditure1Mng.save(eb1, getUser());
					return getJsonResult(true, Result.saveSuccessMessage);
				}
			}else if(leixing.equals("2")){
				if(StringUtil.isEmpty(eb2.gettEbName2())){
					return getJsonResult(false, "请填写明细科目！");
				}
				if(StringUtil.isEmpty(eb2.gettEbCode2())){
					return getJsonResult(false, "请填写费用类型代码,请重新填写！");
				}
				if(expenditure2Mng.findbyCode2(eb2)){
					return getJsonResult(false, "费用类型代码重复！");
				}else {
					expenditure2Mng.save(eb2, getUser());
					return getJsonResult(true, Result.saveSuccessMessage);
				}
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "系统错误,请联系管理员！");
		}
	}
	
	/**
	 * 删除
	 * @param id 主键
	 * @param leixing
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-21
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,String leixing ,ModelMap model){
		try {
			if(leixing.equals("1")){
				expenditure1Mng.delete(id);
			}
			if(leixing.equals("2")){
				expenditure2Mng.deleteById(Integer.valueOf(id));
			}
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
	}
	
	
}
