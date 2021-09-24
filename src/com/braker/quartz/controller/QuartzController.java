package com.braker.quartz.controller;

import java.util.List;

import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.quartz.QuartzManager;
import com.braker.quartz.model.Wsdoc;
import com.braker.quartz.service.WsdocService;


@Controller
@RequestMapping(value = "/quartzController")
public class QuartzController extends BaseController{
	@Autowired
	SchedulerFactoryBean schedulerFactoryBean;
	@Autowired
	QuartzManager quartzManager;
	@Autowired
	WsdocService wsdocService;
	/*
	 * 初始化调度器
	 * 
	 */
	@RequestMapping(value = "/runquartz")
    public void reScheduleJob() {
        try {
        	//quartzManager.reScheduleJob();
        	Wsdoc tbcq=new Wsdoc();//
			tbcq.setTriggername("getcgplanList");//triggername   getcgplanList
			tbcq.setCronexpression("0/10 * * * * ?");
			tbcq.setJobdetailname("detailname");
			/*tbcq.setTargetobject("com.braker.quartz.ISCSynAllData");*/
			tbcq.setTargetobject("com.braker.quartz.task.CgConPlanTask");
			tbcq.setMethodname("run");
			tbcq.setConcurrent("1");
			tbcq.setState("1");
			tbcq.setReadme("readme");
			quartzManager.configQuatrz(tbcq);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /*
	 * 跳转到任务列表页面
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		
		return "/WEB-INF/view/quartz/quartz_list";

	}
	
	/*
	 * 分页数据获得定时任务信息
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value = "/QuzrtzPageData")
	@ResponseBody
	public JsonPagination loanPage(Wsdoc bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = wsdocService.pageList(bean, page, rows);;
    	List<Wsdoc> li = (List<Wsdoc>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * 新增任务
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		return "/WEB-INF/view/quartz/quartz_add";
	}
	/*
	 * 新增的保存
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(Wsdoc bean,ModelMap model) {
		
		try {
			bean.setCreator(getUser().getName());
			wsdocService.saveTarger(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/*
	 * 查看任务信息
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		Wsdoc bean = wsdocService.findById(id);
		//查询基本信息
		model.addAttribute("bean",bean);
		return "/WEB-INF/view/quartz/quartz_detail";

	}
	/*
	 * 任务信息的删除
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			Wsdoc bean =new Wsdoc();
			bean.setId(id+"");
			wsdocService.deleteTargerByProperty(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	/*
	 * 任务信息 修改
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		Wsdoc bean = wsdocService.findById(id);
		//查询基本信息
		model.addAttribute("bean",bean);
		return "/WEB-INF/view/quartz/quartz_add";
	}
	
}