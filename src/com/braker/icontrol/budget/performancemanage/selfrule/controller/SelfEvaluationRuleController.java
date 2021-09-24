package com.braker.icontrol.budget.performancemanage.selfrule.controller;

import java.util.ArrayList;
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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.SelfEvaluationMng;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.PerformanceLendgerMng;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalConfMng;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalTempMng;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfProRefMng;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalTemp;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfProRef;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 自评规则配置的控制层
 * 本模块用于配置自评规则
 * @author 冉德茂
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
@Controller               
@RequestMapping(value = "/selfevaluationrule")
public class SelfEvaluationRuleController extends BaseController{

	@Autowired
	private SelfEvalTempMng selfEvalTempMng;
	@Autowired
	private SelfEvalConfMng selfEvalConfMng;
	@Autowired
	private SelfProRefMng selfProRefMng;
	@Autowired
	private SelfEvaluationMng selfEvaluationMng;
	@Autowired
	private PerformanceLendgerMng proMng;
	@Autowired
	private CheterMng cheterMng;
	
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/budget/performance_manage/self_evaluation_rule_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@RequestMapping(value = "/selfevalPage")
	@ResponseBody
	public JsonPagination loanPage(SelfEvalTemp bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = selfEvalTempMng.pageList(bean, page, rows);;
    	List<SelfEvalTemp> li = (List<SelfEvalTemp>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}	
	
	/*
	 * 新增自评模版
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		SelfEvalTemp bean=new SelfEvalTemp() ;
		//自动生成登记单号
		String str="TEMP";
		bean.setFtempCode(StringUtil.Random(str));	
		model.addAttribute("bean", bean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("自评配置");
		model.addAttribute("cheterInfo", cheterInfo);
		
		return "/WEB-INF/view/budget/performance_manage/self_eval_temp_add";
	}

	/*
	 * 跳转选择要规避的项目
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@RequestMapping(value = "/guibipro")
	public String prolist( ModelMap model) {
		return "/WEB-INF/view/budget/performance_manage/guibi_pro_info";
	}
	/*
	 * 保存模版表    配置信息表    以及配置信息和规避清单的映射表   3个表
	 * @author 冉德茂
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(SelfEvalTemp bean,SelfEvalConf fevalbean, ModelMap model,String rate,String proid,String finalproid,String qiyong) {						
		//System.out.println(proid);
		try {
			selfEvalTempMng.save(bean,fevalbean,getUser(),rate,proid,finalproid,qiyong);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	
	/*
	 * 删除模版信息   同时会删除配置信息和规避清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			selfEvalTempMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	
	/*
	 * 查看模版 及配置信息
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//id是模版表的ftid   配置表的外键id
		//查询基本信息
		SelfEvalTemp bean = selfEvalTempMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);	
		//查询配置信息
		SelfEvalConf fevalbean = selfEvalConfMng.getConfByFtId(Integer.valueOf(id));
		model.addAttribute("fevalbean", fevalbean);	
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("自评配置");
		model.addAttribute("cheterInfo", cheterInfo);

		return "/WEB-INF/view/budget/performance_manage/self_evaluation_rule_detail";
	}
	
	/*
	 * 模版，配置，映射信息信息  
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id, ModelMap model) {
		//id是模版表的ftid   配置表的外键id
		//查询基本信息
		SelfEvalTemp bean = selfEvalTempMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);	
		//查询配置信息
		SelfEvalConf fevalbean = selfEvalConfMng.getConfByFtId(Integer.valueOf(id));
		model.addAttribute("fevalbean", fevalbean);	
		Integer cid = fevalbean.getFcId();
		String fisAvoid = fevalbean.getFisAvoid();
		//判断是否有映射信息  有才会查询规避清单
		List<TProBasicInfo> proList = new ArrayList<TProBasicInfo>();
		if(fisAvoid.equals("1")){//获取规避清单信息
			List<SelfProRef> refbean = selfProRefMng.getRef(cid);
			for(int i=0;i<refbean.size();i++){
				TProBasicInfo probean=new TProBasicInfo();
				probean= proMng.findById(refbean.get(i).getFproId());
				proList.add(probean);
			}
			model.addAttribute("proList", proList);			
		}
		

		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("自评配置");
		model.addAttribute("cheterInfo", cheterInfo);

		return "/WEB-INF/view/budget/performance_manage/self_eval_temp_edit";
	}

	
	/*
	 * 启用模版信息  生成自评项目   设置启用状态   自评项目的展示状态
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@RequestMapping(value = "/turnon")
	@ResponseBody
	public Result turnon(Integer id) {
		
		try {
			//传回来的id是模版表的F_T_ID   是配置表的外键id   
			selfEvalTempMng.turnon(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"启用失败，请联系管理员！");
		}
		return getJsonResult(true,"启用成功！");	
	}
	/*
	 * 停用模版模版信息  生成自评项目   设置启用状态   自评项目的展示状态
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@RequestMapping(value = "/turnoff")
	@ResponseBody
	public Result turnoff(Integer id) {
		try {
			//传回来的id是模版表的F_T_ID   是配置表的外键id   
			selfEvalTempMng.turnoff(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"停用失败，请联系管理员！");
		}
		return getJsonResult(true,"停用成功！");	
	}
	/*
	 * 根据模版填写信息   展示筛选的项目清单
	 * @author 冉德茂
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	
	@RequestMapping(value = "/showlist")
	public String showlist( ModelMap model) {
		return "/WEB-INF/view/budget/performance_manage/self_showpro_info";
	}
	
	/*
	 * 预览筛选的自评信息   获取json数据
	 * @author 冉德茂
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@RequestMapping(value = "/getlistjson")
	@ResponseBody
	public List<TProBasicInfo> getlistjson(String rate,String proids,String min,String max,String randM,String fixed,String othM,String isavoid) {
		//获取配置信息   比例信息   和规避项目的id
			List<TProBasicInfo> prolist = selfEvalTempMng.getprolist(rate,proids,min,max,randM,fixed,othM,isavoid);
			return prolist;
	}	
	/*
	 * 页面加载已结项的项目信息  用于规避操作
	 * @author 冉德茂
	 * @createtime 2018-08-28
	 * @updatetime 2018-08-28
	 */
	@RequestMapping(value = "/getjiexiangjson")
	@ResponseBody
	public List<TProBasicInfo> getjiexiangjson(TProBasicInfo bean) {
		List<TProBasicInfo> prolist = selfEvalTempMng.getjiexianglist(bean);
		for(int i=0;i<prolist.size();i++){
			prolist.get(i).setPageOrder(i+1);
		}
		return prolist;
	}	
	/*
	 * 修改页面加载上次规避的项目信息
	 * @author 冉德茂
	 * @createtime 2018-08-28
	 * @updatetime 2018-08-28
	 */
	@RequestMapping(value = "/getoldgb")
	@ResponseBody
	public List<TProBasicInfo> getoldgbjson(Integer id) {
		//id是配置表的主键    自评项目的外键
		List<TProBasicInfo> prolist = selfEvaluationMng.getoldgblist(id);
		for(int i=0;i<prolist.size();i++){
			prolist.get(i).setPageOrder(i+1);
		}
		return prolist;
	}	
	/*
	 * 修改页面加载上次生成自评的项目信息
	 * @author 冉德茂
	 * @createtime 2018-08-28
	 * @updatetime 2018-08-28
	 */
	@RequestMapping(value = "/getoldeval")
	@ResponseBody
	public List<TProBasicInfo> getoldevaljson(Integer id) {
		//id是配置表的主键    自评项目的外键
		List<TProBasicInfo> prolist = selfEvaluationMng.getoldeval(id);
		for(int i=0;i<prolist.size();i++){
			prolist.get(i).setPageOrder(i+1);
		}
		return prolist;
	}	
	
	
	
	
	
	
	
}