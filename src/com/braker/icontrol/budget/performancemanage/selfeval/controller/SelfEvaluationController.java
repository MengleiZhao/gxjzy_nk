package com.braker.icontrol.budget.performancemanage.selfeval.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.SelfEvaluationMng;
import com.braker.icontrol.budget.performancemanage.selfeval.model.AchieveResult;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResult;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.SelfEvalTempMng;
import com.braker.icontrol.budget.project.entity.TActFinishTarget;
import com.braker.icontrol.budget.project.entity.TProBasicAccoAttac;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicPlanAttac;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TActFinishTargetMng;
import com.braker.icontrol.budget.project.manager.TProBasicAccoAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProBasicPlanAttacMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicPro;
import com.braker.icontrol.budget.release.manager.TProMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ??????????????????????????????
 * ????????????????????????????????????
 * @author ?????????
 * @createtime 2018-08-21
 * @updatetime 2018-08-21
 */
@Controller  
@RequestMapping(value = "/selfevaluation")
public class SelfEvaluationController extends BaseController{
	@Autowired
	private SelfEvalTempMng selfEvalTempMng;
	@Autowired
	private SelfEvaluationMng selfEvaluationMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProBasicAccoAttacMng tProBasicAccoAttacMng;
	@Autowired
	private TProBasicPlanAttacMng tProBasicPlanAttacMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProMng tproMng;
	@Autowired
	private TProPlanMng texpendplanMng;
	@Autowired
	private TProGoalMng tprogoalMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TActFinishTargetMng tActFinishTargetMng;
	
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model,String type) {
		model.addAttribute("type", type);
		return "/WEB-INF/view/budget/self_evaluation/self_evaluation_list";
	}
	
	/*
	 * ??????????????????  ??????????????????    ????????????1
	 * @author ?????????
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	@RequestMapping(value = "/evalprojectPage")
	@ResponseBody
	public JsonPagination loanPage(TProBasicInfo bean, String sort, String order, Integer page, Integer rows){
		try {
			if(page == null){page = 1;}
	    	if(rows == null){rows = SimplePage.DEF_COUNT;}
	    	Pagination p = selfEvaluationMng.pageList(bean, page, rows);;
	    	List<TProBasicInfo> li = (List<TProBasicInfo>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
				//????????????	
	    		TProBasicInfo pro = li.get(x);
				pro.setPageOrder(page*rows+x-9);

			}
	    	return getJsonPagination(p, 0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/**
	 * 
	* @author:??????
	* @Title: detail 
	* @Description: ?????????????????????????????????
	* @param id
	* @param model
	* @return
	* @return String    ???????????? 
	* @date??? 2019???6???3?????????4:51:37 
	* @throws
	 */
	@RequestMapping(value ="/proeval")
	public String proeval(String id,String type,ModelMap model) {
		//System.out.println(id);
		//id??????????????????id
		//????????????????????????
		try {
//			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
//			model.addAttribute("cheterInfo", cheterInfo);
			model.addAttribute("type", type);
			//????????????
			TActFinishTarget actfinbean=tActFinishTargetMng.findUniqueByProperty("fproId", Integer.parseInt(id));
			model.addAttribute("actfinbean", actfinbean);
			//??????????????????
			TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
			model.addAttribute("bean", pro);//????????????
			if(pro!=null){
				List<Attachment> attac =attachmentMng.list(pro);
				model.addAttribute("attaList", attac);
			}
			model.addAttribute("proeval", "proeval");//????????????
			} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		

		return "/WEB-INF/view/budget/project/detail/self_evaluation_eval";
	}
	
	/*
	 * ?????????????????????    ?????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	@RequestMapping(value = "/evalsave")
	@ResponseBody	
	public Result save(TProBasicInfo bean,String jxzpFiles,ModelMap model) {
		try {
			selfEvaluationMng.save(bean,jxzpFiles,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
		return getJsonResult(true,"???????????????");
	}
	
	
}
