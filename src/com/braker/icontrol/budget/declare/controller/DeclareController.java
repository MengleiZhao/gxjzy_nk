package com.braker.icontrol.budget.declare.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.declare.manager.DeclareMng;
import com.braker.icontrol.budget.project.entity.AddAndCheckTime;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProCheckInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * ?????????????????????????????????
 * ????????????????????????????????????????????????????????????
 * @author ?????????
 * @createtime 2018-09-20
 * @updatetime 2018-09-20
 */
@Controller
@RequestMapping(value = "/declare")
public class DeclareController extends BaseController{
	@Autowired
	private RoleMng roleMng;
	
	@Autowired
	private DeclareMng declareMng;
	
	@Autowired
	private TProCheckInfoMng tProCheckInfoMng;
	
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private AttachmentMng attachmentMng;//??????
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;//??????????????????
	
	@Autowired
	private TProPlanMng tProPlanMng;//????????????
	
	@Autowired
	private TProGoalMng tProGoalMng;//??????????????????
	
	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;//??????????????????
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private AddAndCheckTimeMng addAndCheckTimeMng;
	/*
	 * ?????????????????????
	 * @author ?????????
	 * @createtime 2018-09-20
	 * @updatetime 2018-09-20
	 */
	@RequestMapping(value = "/list")
	public String list(String type, ModelMap model) {
		//type????????????????????????yssb??????????????????yssp?????????????????????????????????essb??????????????????essp???
		model.addAttribute("year",Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date()))+1);
		if("yssb".equals(type)) {
			return "/WEB-INF/view/budget/project/project-yssb-list";
		} else if("yssp".equals(type)) {
			return "/WEB-INF/view/budget/project/project-yssp-list";
		} else if("essb".equals(type)) {
			User user = getUser();
			AddAndCheckTime bean = new AddAndCheckTime();
			if(user.getDpID().equals("2")){
				model.addAttribute("addPro", "1");//????????????????????????????????????????????????????????????
				if(user.getRoleName().contains("???????????????")){//???????????????????????????????????????????????????
					model.addAttribute("settime", "open");// ?????????????????????
				}
			}
			bean = addAndCheckTimeMng.findbyDataType(2);
			model.addAttribute("timeid", bean.getFid());// ?????????????????????id
			model.addAttribute("timebean", bean);
			return "/WEB-INF/view/budget/project/project-essb-list";
		} else if("essp".equals(type)) {
			User user = getUser();
			AddAndCheckTime bean = new AddAndCheckTime();
			if(user.getRoleName().contains("???????????????")&&user.getDpID().equals("32")){//???????????????????????????????????????????????????
				model.addAttribute("settime", "open");// ?????????????????????
			}
			bean = addAndCheckTimeMng.findbyDataType(2);
			model.addAttribute("timeid", bean.getFid());// ?????????????????????id
			model.addAttribute("timebean", bean);
			return "/WEB-INF/view/budget/project/project-essp-list";
		} else {
			return "";
		}
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping("/checkRemake")
	public String checkRemake(String type, String result, String data1, ModelMap model) {
		model.addAttribute("type", type);
		model.addAttribute("result", result);
		model.addAttribute("data1", data1);
		model.addAttribute("time",new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
		if("yssp".equals(type)) {
			return "/WEB-INF/view/budget/project/detail/check-remake";
		}
		if("essp".equals(type)) {
			return "/WEB-INF/view/budget/project/detail/check-remake";
		}
		return "";
	}
	
	/*
	 * ????????????????????????
	 * @author zhangxun
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	@RequestMapping("/verdict/{id}")
	public String verdict(@PathVariable String id, ModelMap model){
		
		// ????????????????????????
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
		model.addAttribute("cheterInfo", cheterInfo);
		// ????????????
		model.addAttribute("operation", "verdict");
		//????????????
		model.addAttribute("currentUser", getUser());

		TProBasicInfo pro = tProBasicInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", pro);// ????????????
		model.addAttribute("sbr", pro.getFProAppliPeople());// ?????????
		model.addAttribute("sbbm", pro.getFProAppliDepart());// ????????????
		if (pro.getFProAppliTime() != null)
			model.addAttribute("sbsj", new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// ????????????
		// ??????????????????
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);
		
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"YSSB", pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(), pro.getFProCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//?????????????????????????????????
		Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
		model.addAttribute("proposer", proposer);
		//???????????????id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("YSSB", pro.getFProAppliDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//????????????
		model.addAttribute("foCode",pro.getBeanCode());
		
		return "/WEB-INF/view/budget/project/project-yssp-verdict";
	}
	
	/*
	 * ????????????????????????
	 * @author zhangxun
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	@RequestMapping("/verdict2/{id}")
	public String verdict2(@PathVariable Integer id, ModelMap model){
		try {
			User user = getUser();

			model.addAttribute("operation", "check");// ????????????
			TProBasicInfo pro= tProBasicInfoMng.findById(Integer.valueOf(id));
			model.addAttribute("sbr", pro.getFProAppliPeople());// ?????????
			model.addAttribute("sbbm", pro.getFProAppliDepart());// ????????????
			if (pro.getFProAppliTime() != null)
				model.addAttribute("sbsj", new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// ????????????

			model.addAttribute("bean", pro);// ????????????
			//?????????????????????????????????????????????
			if(user.getRoleName().contains("?????????????????????")){
				model.addAttribute("checkPeople","1");//???????????????????????????
			}else{
				model.addAttribute("checkPeople","");//1???????????????????????????
			}
			// ??????????????????
			List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);
			if("31".equals(pro.getFFlowStauts()) || "39".equals(pro.getFFlowStauts()) || "-31".equals(pro.getFFlowStauts())){//?????????????????????
				//???????????????
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"ESSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//???????????????id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ESSB", pro.getFProAppliDepartId());
				model.addAttribute("fpId", tProcessDefin.getFPId());
			}
			
			//????????????
			model.addAttribute("foCode",pro.getBeanCode());	
			// ?????????????????????????????????
			Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/budget/project/detail/project-essp-verdict";
		} catch (Exception e) {
			
		}
		return null;
		
	}
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@RequestMapping(value = "/yssbProjectPage")
	@ResponseBody
	public List<TProBasicInfo> yssbProjectPage(TProBasicInfo bean, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	/*Pagination p = declareMng.yssbPageList(bean, page, rows, getUser());*/
    	List<TProBasicInfo> list = declareMng.yssbPageList(bean, page, rows, getUser());
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
			}
		}
    	return list;
	}
	
	/*
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-09-20
	 * @updatetime 2018-09-20
	 */
	@RequestMapping("/yssb")
	@ResponseBody
	public Result yssb(String fproIdLi,ModelMap model) {
		try {
			if(fproIdLi != null) {
				declareMng.firstUpApply(fproIdLi, getUser());
			}
			return getJsonResult(true,"?????????????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
	}
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@RequestMapping(value = "/ysspProjectPage")
	@ResponseBody
	public JsonPagination ysspProjectPage(TProBasicInfo bean, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = declareMng.ysspPageList(bean, page, rows, getUser());
    	List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@RequestMapping("/yssp")
	@ResponseBody
	public Result yssp(String fproIdLi,String result, String remake,String spjlFiles, ModelMap model) {
		try {
			tProCheckInfoMng.firstUpCheck(fproIdLi, result, remake, getUser(), getUser().getRoles().get(0),spjlFiles);
			return getJsonResult(true,"?????????????????????");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"????????????????????????????????????");
		}
	}
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-27
	 * @updatetime 2018-09-27
	 */
	@RequestMapping(value = "/essbProjectPage")
	@ResponseBody
	public JsonPagination  essbProjectPage(TProBasicInfo bean, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = declareMng.essbPageList(bean, page, rows, getUser());
    	List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-28
	 * @updatetime 2018-09-28
	 */
	@RequestMapping("/essb")
	@ResponseBody
	public Result essb(TProBasicInfo bean, ModelMap model, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) {
		try {
			declareMng.secondUpApply(bean, getUser(),saveType, outcomeJson,purchaseJson,purchaseJsonSE,
					fundsJson, lxyjFiles, ssfaFiles,totalityPerformanceJson,purManyYearsProJson,purManyYearsProJsonSE);
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
		
	}
	
	/*
	 * ??????????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-28
	 * @updatetime 2018-09-28
	 */
	@RequestMapping(value = "/esspProjectPage")
	@ResponseBody
	public JsonPagination  esspProjectPage(TProBasicInfo bean, ModelMap model, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = declareMng.esspPageList(bean, page, rows, getUser());
    	List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
    	if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page*rows+i-9);
			}
		}
    	return getJsonPagination(p, page);
	}
	
	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-29
	 * @updatetime 2018-09-29
	 */
	@RequestMapping("/essp")
	@ResponseBody
	public Result essp(TProBasicInfo bean, TProcessCheck checkBean,String spjlFiles, ModelMap model,String fundJson,String outcomeJson,String hyjyfile) {
		try {
			tProCheckInfoMng.secondUpCheck(bean, checkBean, getUser(), getUser().getRoles().get(0),spjlFiles, fundJson, outcomeJson,hyjyfile);
			return getJsonResult(true,"?????????????????????");
		} catch (ServiceException se) {
			se.printStackTrace();
			return getJsonResult(false,"????????????????????????");
	} catch (Exception e) {
		e.printStackTrace();
		return getJsonResult(false,"????????????????????????????????????");
	}
	}
	
	/*
	 * ?????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	@RequestMapping(value = "/checkInfoPage")
	@ResponseBody
	public JsonPagination checkInfoPage(TProcessCheck bean , Integer page, Integer rows, String type) {
		try {
			if(page == null){page = 1;}
	    	if(rows == null){rows = SimplePage.DEF_COUNT;}
	    	Pagination p = tProCheckInfoMng.checkInfoPageList(bean,page, rows, getUser(), type);
	    	List<TProcessCheck> li = (List<TProcessCheck>) p.getList();
	    	for(int x=0; x<li.size(); x++) {
	    		TProBasicInfo pro = tProBasicInfoMng.findbyCode(li.get(x).getFoCode());
	    		if(pro!=null) {
	    			//????????????	
	    			li.get(x).setNum((x+1)+(page-1)*rows);
	    			li.get(x).setFProCode(pro.getFProCode());
	    			li.get(x).setFProName(pro.getFProName());
	    			li.get(x).setFProHead(pro.getFProHead());
	    			li.get(x).setFProAppliTime(pro.getFProAppliTime());
	    		}
			}
	    	p.setList(li);
	    	return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	/**
	 * 
	* @author:??????
	* @Title: reCall 
	* @Description: ??????
	* @param id
	* @return
	* @return Result    ???????????? 
	* @date??? 2019???10???8?????????10:12:32 
	* @throws
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			TProBasicInfo bean = declareMng.findById(Integer.valueOf(id));
			
			//????????????
			String busiArea = null;
			if(bean.getFProOrBasic() == 0){
				busiArea = "JBZCESSB";
			}else if(bean.getFProOrBasic() == 1){
				busiArea = "ESSB";
			}
			//???????????????id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFProAppliDepartId());
			
			Boolean tof = tProcessCheckMng.findbyCodeES(bean.getFProCode(), "0", tProcessDefin.getFPId());
			if(tof){
				return getJsonResult(false, "??????????????????????????????????????????");
			}else {
				declareMng.reCall(id);
				return getJsonResult(true, "????????????");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}
	}
	
	
	
	
	/*
	 * ????????????
	 */
	@RequestMapping("/add")
	public String add(ModelMap model,String fproOrBasic, HttpServletRequest request) {
		try {
			User user = getUser();
			TProBasicInfo bean = new TProBasicInfo();
			bean.setFProOrBasic(Integer.valueOf(fproOrBasic));
			bean.setFContinuousYn("0");// ?????????????????????
			bean.setProApplyType("1");//??????????????????
			bean.setIsOrientation("0");// ??????????????????
			bean.setFProAppliDepartId(user.getDpID());//????????????id
			bean.setFProAppliDepart(user.getDepartName());//????????????
			bean.setFProBudgetAmount(BigDecimal.ZERO);//??????????????????
			User user2 = userMng.getUserByRoleNameAndDepartName("???????????????", user.getDepart().getName());
			bean.setFProHead(user2.getName());
			bean.setFProHeadId(user2.getId());
			bean.setPlanStartYear(String.valueOf(Integer
					.valueOf(new SimpleDateFormat("yyyy").format(new Date())) + 1));// ??????????????????

			// ????????????
			model.addAttribute("operation", "add");// ??????????????????
			// ????????????
			model.addAttribute("sbr", user.getName());// ?????????
			model.addAttribute("sbbm", user.getDepartName());// ????????????
			model.addAttribute("sbsj", Integer.valueOf(new SimpleDateFormat("yyyy")
					.format(new Date())));// ????????????

			model.addAttribute("bean", bean);
			// ????????????????????????
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("????????????");
			model.addAttribute("cheterInfo", cheterInfo);
			// ????????????
			model.addAttribute("currentYear",
					new SimpleDateFormat("yyyy").format(new Date()));
			//???????????????
			//?????????????????????????????????????????????????????????????????????
			
			// ?????????????????????????????????
			Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
			model.addAttribute("proposer", proposer);
			//???????????????
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"ESSB", user.getDpID(),null,null, null, null, null, "1");
			model.addAttribute("nodeConf", nodeConfList);
			return "/WEB-INF/view/budget/project/project-essb-edit";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/budget/project/project-essb-edit";
		}
		
	}

}
