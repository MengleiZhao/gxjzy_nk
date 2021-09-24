package com.braker.icontrol.budget.release.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.braker.common.web.BaseController;
import com.braker.icontrol.budget.arrange.entity.DepartIndexInfo;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.arrange.manager.DepartIndexInfoMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicPro;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TBasicMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.budget.release.manager.TProMng;

/**
 * 基本支出指标下达
 * @author zhangxun
 *
 */
@Controller
@RequestMapping("/release")
@SuppressWarnings("serial")
public class ReleaseController extends BaseController  {
	
	@Autowired
	private TBasicMng tBasicMng;
	@Autowired 
	private TBasicItfMng tBasicItfMng; 
	@Autowired
	private TProMng tProMng;
	@Autowired
	private TProItfMng tProItfMng;
	@Autowired
	private DepartIndexInfoMng departIndexInfoMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;

	/** 页面跳转start **/
	
	//列表
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/budget/release/release-list2";
	}
	
	//新增
	@RequestMapping("/add/{id}")
	public String add(ModelMap model, @PathVariable String id){
		
		model.addAttribute("infoId", id);//指标下达情况总表DepartIndexInfo id
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		model.addAttribute("currentUser", getUser());
		return "/WEB-INF/view/budget/release/release-add";
	}
	
	//修改
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable String id){
		model.addAttribute("infoId", id);//指标下达情况总表DepartIndexInfo id
		return "/WEB-INF/view/budget/release/release-edit";
	}
	
	//详情
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model, @PathVariable String id){
		return "/WEB-INF/view/budget/release/release-detail";
	}
	
	/** 页面跳转end **/
	
	
	
	/** 操作start **/
	
	//保存
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ModelMap modeal, String saveType, 
			String infoId,
			TBudgetaryIndicBasic basicRelease, TBudgetaryIndicPro proRelease,
			String personOutJson, String commOutJson, String yearOutJson, String leastOutJson){
		try {

			if ("edit".equals(saveType)) {
				
			}
			//基本支出
			float money1 = tBasicMng.save(saveType, basicRelease, getUser(), personOutJson, commOutJson);
			//项目支出
			float money2 = tProMng.save(saveType, proRelease, getUser(), yearOutJson, leastOutJson);
			//下达总表
			departIndexInfoMng.releaseById(infoId,money1 + money2);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
	//删除
	
	/** 操作end **/
	
	
	
	
	/** 数据获取start **/
	
	//列表
	@RequestMapping(value="/pageData")
	@ResponseBody
	public JsonPagination pageData(DepartIndexInfo bean, String sort,String order,Integer page,Integer rows){
		
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = departIndexInfoMng.pageList(bean, page, rows);
    	
		return getJsonPagination(p, page);
	}
	
	//修改-基本支出人员
	@ResponseBody
	@RequestMapping("/dataPerson2")
	public List<TreeEntity> dataPerson2(String id,ModelMap model){
		
		List<TreeEntity> list = tBasicItfMng.getTreeList(id,"1",getUser());
		return list;
	}
	//修改-基本支出公用
	@ResponseBody
	@RequestMapping("/dataComm2")
	public List<TreeEntity> dataComm2(String id,ModelMap model){
		
		List<TreeEntity> list = tBasicItfMng.getTreeList(id,"2",getUser());
		return list;
	}
	//修改-项目支出年度
	@ResponseBody
	@RequestMapping("/dataYear2")
	public List<TBudgetaryIndicPro> dataYear2(String id,ModelMap model){
		
		List<TBudgetaryIndicPro> list = tProMng.getDataList(id, getUser());
		return list;
	}
	//修改-项目支出历年
	@ResponseBody
	@RequestMapping("/dataLeast2")
	public List<TBudgetaryIndicPro> dataLeast2(String id,ModelMap model){
		
		List<TBudgetaryIndicPro> list = tProMng.getDataList(id, getUser());
		return list;
	}
	
	/** 数据获取end **/
	
	
	
	//列表
	@RequestMapping("/xiada")
	public String xiada(ModelMap model, Integer bId){
		model.addAttribute("bean", budgetIndexMgrMng.findById(bId));
		return "/WEB-INF/view/budget/release/release-xiada";
	}
}
