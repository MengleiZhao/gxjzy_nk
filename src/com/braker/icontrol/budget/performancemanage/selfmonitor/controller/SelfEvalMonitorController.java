package com.braker.icontrol.budget.performancemanage.selfmonitor.controller;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sun.java2d.pipe.SpanShapeRenderer.Simple;

import com.braker.common.entity.DataEntity;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.Lookups;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.SelfEvaluationMng;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalTempMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * 绩效监控的控制层 （监控参与自评的项目）
 * 本模块用于绩效监控的操作
 * @author 冉德茂
 * @createtime 2018-09-06
 * @updatetime 2018-09-06
 */
@Controller               
@RequestMapping(value = "/pfmmonitor")
public class SelfEvalMonitorController extends BaseController{
	@Autowired
	private SelfEvalTempMng selfEvalTempMng;
	@Autowired
	private SelfEvaluationMng selfEvaluationMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private TProGoalMng tProGoalMng;
	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;
	
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-09-06
	 * @updatetime 2018-09-06
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/budget/self_eval_monitor/self_monitor_list";
	}
	
	/*
	 * 分页数据获得  展示参与自评的项目监控的信息        只显示展示状态1不焦虑自评状态
	 * @author 冉德茂
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@RequestMapping(value = "/monitorprojectPage")
	@ResponseBody
	public JsonPagination loanPage(TProBasicInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = tProBasicInfoMng.proInfoForControlNumP(bean,new Date(), "3",page,rows);
    	List<TProBasicInfo> li =  (List<TProBasicInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
    		li.get(x).setPageOrder(x+1);
    	}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 弹出修改页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-17
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		TProBasicInfo pic = tProBasicInfoMng.findById(Integer.valueOf(id));
		List<TProGoal> pgl = tProGoalMng.findByproject(pic);
		TProGoal pg=new TProGoal();
		if(pgl.size()<=0){
			pg.setProject(pic);
		}else{
			pg=pgl.get(0);
		}
		model.addAttribute("bean", pg);
		model.addAttribute("openType", "edit");
		return "/WEB-INF/view/budget/self_eval_monitor/self_monitor_edit";
	}
	
	/**
	 * 加载明细表数据
	 * @param goal1
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/PGDJsonPagination")
	@ResponseBody
	public JsonPagination PGDJsonPagination(String goal1, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p =tProGoalDetailMng.findBygoal(goal1, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 保存更新绩效目标表和绩效指标明细表
	 * @param planJson 绩效指标明细表数据
	 * @param pg 绩效目标表数据
	 * @param model
	 * @return
	 * @throws JsonParseException
	 * @throws JsonMappingException
	 * @throws IOException
	 * @author 陈睿超
	 * @createtime 2018-09-17
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(String planJson,TProGoalDetail pgd,TProGoal pg,ModelMap model) throws JsonParseException, JsonMappingException, IOException{
		//转化json对象
		ObjectMapper mapper = new ObjectMapper();  //json解析
		List<TProGoalDetail> List = mapper.readValue(planJson, new TypeReference<List<TProGoalDetail>>(){});
		tProGoalMng.save(pg, List, getUser());
		return getJsonResult(true, Result.saveSuccessMessage);
	}
	
	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-17
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = tProGoalMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
	/**
	 * 弹出查看页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-17
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		TProBasicInfo pic = tProBasicInfoMng.findById(Integer.valueOf(id));
		List<TProGoal> pgl = tProGoalMng.findByproject(pic);
		TProGoal pg=new TProGoal();
		if(pgl.size()<=0){
			pg.setProject(pic);
		}else{
			pg=pgl.get(0);
		}
		model.addAttribute("bean", pg);
		model.addAttribute("openType", "detail");
		return "/WEB-INF/view/budget/self_eval_monitor/self_monitor_edit";
	}
}

