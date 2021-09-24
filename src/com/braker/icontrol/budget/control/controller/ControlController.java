package com.braker.icontrol.budget.control.controller;

import java.text.SimpleDateFormat;
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
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.braker.icontrol.budget.control.entity.TProExpend;
import com.braker.icontrol.budget.control.manager.TBasicExpendMng;
import com.braker.icontrol.budget.control.manager.TBudgetControlNumMng;
import com.braker.icontrol.budget.control.manager.TProExpendMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;

/**
 * 预算控制数
 * @author zhangxun
 * @createtime 2018-06-29
 * @updatetime 2018-06-29
 *
 */
@Controller
@RequestMapping("/control")
@SuppressWarnings("serial")
public class ControlController extends BaseController {
	
	@Autowired 
	private TBudgetControlNumMng tBudgetControlNumMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private TProExpendMng tProExpendMng;
	@Autowired
	private TBasicExpendMng tBasicExpendMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;

	/*
	 * 列表
	 */
	@RequestMapping("/list")
	public String list(ModelMap model,String sbklx){
		if(sbklx != null&&sbklx.equals("essb")) {
			return "/WEB-INF/view/budget/control/control-list3";	//二上申报	
		} else if(sbklx != null&&sbklx.equals("essp")){
			return "/WEB-INF/view/budget/control/control-list4";	//二上审批
		} else {
			return "/WEB-INF/view/budget/control/control-list2";	//一下
		}
	}
	
	/*
	 * 台账列表 
	 */
	@RequestMapping("/tzList")
	public String tzList(ModelMap model){
		
		return "/WEB-INF/view/budget/control/control-tzlist";
	}

	/**
	 * 弹出集成指出指标明细列表页
	 * @param model
	 * @return
	 */
	@RequestMapping("/quotalist")
	public String quotalist(ModelMap model){
		return "/WEB-INF/view/budget/control/control_quota";
	}
	
	/*
	 * 新增
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		model.addAttribute("operationType", "add");
		model.addAttribute("currentUser", getUser());
		model.addAttribute("syysze", budgetIndexMgrMng.sumpfAmount(String.valueOf(1+Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date())))));
		model.addAttribute("currentYear",1+Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date())));
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("预算控制数分解");
		model.addAttribute("cheterInfo", cheterInfo);
		
		model.addAttribute("splc", "1");
		
		return "/WEB-INF/view/budget/control/control-add";
	}

	/*
	 * 修改
	 */
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model,@PathVariable Integer id){
		
		model.addAttribute("bean", tBudgetControlNumMng.findById(id));
		model.addAttribute("currentUser", getUser());
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("预算控制数分解");
		model.addAttribute("cheterInfo", cheterInfo);
		return "/WEB-INF/view/budget/control/control-edit";
	}
	
	/*
	 * 删除
	 */
	@ResponseBody
	@RequestMapping("/delete/{id}")
	public Result delete(ModelMap model, String conId){
		try {
			
			tBudgetControlNumMng.logicDeleteById(getUser(),conId);
			return getJsonResult(true,Result.deleteSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.deleteFailureMessage);
		}
	}

	/*
	 * 查看
	 */
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model,@PathVariable Integer id){
		
		model.addAttribute("bean", tBudgetControlNumMng.findById(id));
		return "/WEB-INF/view/budget/control/control-detail";
	}
	
	/*
	 * 数据-列表
	 */
	@ResponseBody
	@RequestMapping("/dataControlList")
	public JsonPagination dataControlList(TBudgetControlNum bean,String sort,String order,Integer page,Integer rows){
		
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = tBudgetControlNumMng.pageList(bean, getUser(), page, rows);
		//加入排序号
		List<TBudgetControlNum> li = (List<TBudgetControlNum>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p,page);
	}
	
	/*
	 * 数据-台账列表-按科目统计
	 */
	@ResponseBody
	@RequestMapping("/dataListSubject")
	public JsonPagination dataListSubject(TBudgetControlNum bean,String sort,String order,Integer page,Integer rows){
		//TODO
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = tBudgetControlNumMng.pageList(bean, getUser(), page, rows);
		return getJsonPagination(p,page);
	}
	
	/*
	 * 数据-台账列表-按部门统计
	 */
	@ResponseBody
	@RequestMapping("/dataListDepart")
	public JsonPagination dataListDepart(TBudgetControlNum bean,String sort,String order,Integer page,Integer rows){
		//TODO
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = tBudgetControlNumMng.pageList(bean, getUser(), page, rows);
		return getJsonPagination(p,page);
	}
	
	
	// 数据-新增-人员支出
	@ResponseBody
	@RequestMapping("/dataPersonOut")
	public List<TreeEntity> dataPersonOut(String id,ModelMap model){
		
		List<TreeEntity> treeList = tBudgetControlNumMng.getPersonOutListAdd(getUser(),id,null);
		return treeList;
	}
	
	// 数据-修改-人员支出
	@ResponseBody
	@RequestMapping("/dataPersonOutEdit")
	public List<TBasicExpend> dataPersonOutEdit(Integer numId,ModelMap model){
		
		List<TBasicExpend> list = tBasicExpendMng.getPersonOutListEdit(getUser(),numId,null);
		return list;
	}
	
	// 数据-新增-公用支出
	@ResponseBody
	@RequestMapping("/dataCommOut")
	public List<TreeEntity> dataCommOut(String id,ModelMap model){
		
		List<TreeEntity> treeList = tBudgetControlNumMng.getCommOutList("add",getUser(),id);
		return treeList;
	}
	
	//数据-修改-公用支出
	@ResponseBody
	@RequestMapping("/dataCommOutEdit")
	public List<TBasicExpend> dataCommOutEdit(Integer numId,ModelMap model){
		
		List<TBasicExpend> treeList = tBasicExpendMng.getCommOutListEdit(getUser(),numId,null);
		return treeList;
	}
	
	// 数据-新增-当年项目支出
	@ResponseBody
	@RequestMapping("/dataYearOut")
	public List<TProBasicInfo> dataYearOut(TBudgetControlNum bean, String sort, String order){
		List<TProBasicInfo> list = tProBasicInfoMng.proInfoForControlNum(new Date(),"2");
		return list;
	}
	
	// 数据-修改-当年项目支出
	@ResponseBody
	@RequestMapping("/dataYearOutEdit")
	public List<TProExpend> dataYearOutEdit(Integer numId, String sort, String order){
		
		List<TProExpend> list = tProExpendMng.getYearProOuts(numId,null);
		return list;
	}
	
	// 数据-新增-结转项目支出
	@ResponseBody
	@RequestMapping("/dataLeaveOut")
	public List<TProBasicInfo> dataLeaveOut(TBudgetControlNum bean, String sort, String order, String operationType){
		
		List<TProBasicInfo> list = tProBasicInfoMng.proInfoForControlNum(new Date(),"4");
		return list;
	}
	
	// 数据-修改-结转项目支出
	@ResponseBody
	@RequestMapping("/dataLeaveOutEdit")
	public List<TProExpend> dataLeaveOutEdit(Integer numId, String sort, String order, String operationType){
		
		List<TProExpend> list = tProExpendMng.getLeastProOuts(numId,null);
		
		return list;
	}
	
	/*
	 * 操作-保存 
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Result save(ModelMap model, TBudgetControlNum bean,
			String personOutJson, String commOutJson, String yearOutJson, String leastOutJson){
		
		try {
			tBudgetControlNumMng.save(getUser(),bean,personOutJson,commOutJson,yearOutJson,leastOutJson);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e){
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
	/*
	 * 操作-修改保存 
	 */
	@ResponseBody
	@RequestMapping("/editSave")
	public Result editSave(ModelMap model, TBudgetControlNum bean,
			String personOutJson, String commOutJson, String yearOutJson, String leastOutJson){
		
		try {
			tBudgetControlNumMng.editSave(getUser(),bean,personOutJson,commOutJson,yearOutJson,leastOutJson);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e){
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
}
