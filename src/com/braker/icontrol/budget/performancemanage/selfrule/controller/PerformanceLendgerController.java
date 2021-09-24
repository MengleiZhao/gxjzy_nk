package com.braker.icontrol.budget.performancemanage.selfrule.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.BudgetResultMng;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.SelfEvaluationMng;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResult;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.PerformanceLendgerMng;
import com.braker.icontrol.budget.project.entity.TActFinishTarget;
import com.braker.icontrol.budget.project.entity.TProBasicAccoAttac;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicPlanAttac;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.manager.TActFinishTargetMng;
import com.braker.icontrol.budget.project.manager.TProBasicAccoAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProBasicPlanAttacMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;


/**
 * 绩效目标台账的控制层
 * 本模块用于绩效台账的查看
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
@Controller               
@RequestMapping(value = "/pfmlendgergl")
public class PerformanceLendgerController extends BaseController{

	@Autowired
	private PerformanceLendgerMng pfmlMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProBasicAccoAttacMng tProBasicAccoAttacMng;
	@Autowired
	private TProBasicPlanAttacMng tProBasicPlanAttacMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private BudgetResultMng budgetResultMng;
	@Autowired
	private SelfEvaluationMng selfEvaluationMng;
	@Autowired
	private TActFinishTargetMng tactFinishTargetMng;
	@Autowired
	private TProGoalMng tProGoalMng;
	
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/budget/performance_manage/performance_lendger_list";
	}	
	
	
	/*
	 * 分页数据获得  绩效台账
	 * @author 冉德茂
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@RequestMapping(value = "/projectPage")
	@ResponseBody
	public JsonPagination loanPage(TProBasicInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
//    	Pagination p = pfmlMng.pageList(bean, page, rows);;
    	TProGoal tProGoal=new TProGoal();
    	tProGoal.setProject(bean);
    	Pagination p = tProGoalMng.pageList(tProGoal, getUser(), page, rows);
    	List<TProGoal> li = (List<TProGoal>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
    		TProGoal goal = li.get(x);
    		goal.setPageOrder(page*rows+x-9);

		}
    	return getJsonPagination(p, 0);
	}
	/*
	 * 自评台账的查看信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value ="/pfmldetail")
	public String detail(String id,ModelMap model) {
		//id是项目的主键id
		//附件信息
		List<TProBasicAccoAttac> attaList1 = tProBasicAccoAttacMng.findByProperty("TProBasicInfo.FProId", Integer.valueOf(id));
		List<TProBasicPlanAttac> attaList2 = tProBasicPlanAttacMng.findByProperty("TProBasicInfo.FProId", Integer.valueOf(id));
		model.addAttribute("attaList1", attaList1);
		model.addAttribute("attaList2", attaList2);
		
		model.addAttribute("operation", "detail");//操作类型
		//项目基本信息
		TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", pro);//项目信息
		model.addAttribute("sbr", pro.getFProAppliPeople());//申报人
		model.addAttribute("sbbm", pro.getFProAppliDepart());//申报部门
		if (pro.getFProAppliTime() != null)
		model.addAttribute("sbsj", new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));//申报时间
		//项目支出信息查看
		TActFinishTarget tactbean = tactFinishTargetMng.findById(Integer.valueOf(id));
		model.addAttribute("tactbean", tactbean);

		
		//预算执行评价信息
		//BudgetResult budgetResult = budgetResultMng.getBudgetResultbypid(Integer.valueOf(id)).get(0);
		List<BudgetResult> list = budgetResultMng.getBudgetResultbypid(Integer.valueOf(id));
		if (list != null && list.size() > 0) {
			BudgetResult budgetResult = budgetResultMng.getBudgetResultbypid(Integer.valueOf(id)).get(0);
			model.addAttribute("budgetbean", budgetResult);//预算评价
		}
		//预算执行评价的附件信息
		List<BudgetResultAttac> attac = selfEvaluationMng.getAttacbyid(Integer.valueOf(id));
		if(attac.size()!=0){
			String fevalUser = attac.get(0).getFevalUser();
			String fevalMethod = attac.get(0).getFevalMethod();
			model.addAttribute("fevalUser", fevalUser);//自评负责人
			model.addAttribute("fevalMethod", fevalMethod);//自评方式
		}
		
		
		//model.addAttribute("budgetbean", budgetResult);//预算评价
		model.addAttribute("attac", attac);//附件信息
		
		
		
		return "/WEB-INF/view/budget/performance_manage/self_evaluation_lendger";
	}
	
	/*
	 * 查询绩效评价的明细信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(String id) {
		Pagination p = new Pagination();
			Integer pid=Integer.valueOf(id);
			//查询绩效评价的明细信息
			List<Object> mingxiList = pfmlMng.getMingxi("AchieveResult", "fproId", pid);
			p.setList(mingxiList);
					
		return getJsonPagination(p, 0);
	}
	/*
	 * 评价报告查看附件信息
	 * @author 冉德茂
	 * @createtime 2018-09-05
	 * @updatetime 2018-09-05
	 */
	@RequestMapping(value = "/attacFind")
	@ResponseBody
	public String attacFind(Integer id) {
		BudgetResultAttac attac = pfmlMng.getAttacByMainId(id);
		String fileUrl=attac.getAttacSrc()+"/"+attac.getAttacName();
		
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		fileUrl="http://"+url+":8080/ftp/ff/"+fileUrl;
		return fileUrl;
	}
	
	/**
	 * 导出绩效目标台账
	 * @author 安达
	 * @param TProBasicInfo bean
	 * @param model
	 */
	/**
	 * 情况报表导出
	 */
	@RequestMapping("/exportExcel")
	public String exportData1(ModelMap model, HttpServletResponse response, HttpServletRequest request, TProBasicInfo bean){
		OutputStream out = null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("指标执行情况报表".getBytes("gbk"), "iso8859-1")+".xls");   
			out=new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\绩效目标台账报表.xls";
			//获得年报数据
			TProGoal tProGoal=new TProGoal();
	    	tProGoal.setProject(bean);
			List<TProGoal> list = tProGoalMng.listAll(tProGoal);
			HSSFWorkbook workbook = tProGoalMng.exportExcel(list, filePath);
			
//			List<Fxpg> list = new ArrayList<Fxpg>();
//			list = fxpgMng.getExportList(hasRole("QU_ROLE"), bean, getUser());
//			HSSFWorkbook workbook = fxpgMng.exportExcel(list, filePath);
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
			}
		}
		
		return null;
	}
	
	
}
