package com.braker.icontrol.budget.project.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.DataEntity;
import com.braker.common.entity.TreeEntity;
import com.braker.common.ftp.FileUpload;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.ProMgrLevelMng;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.Function;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.Proposer;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.SystemCenterAttac;
import com.braker.core.model.User;
import com.braker.icontrol.budget.knot.manager.PorjectKnotMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.AddAndCheckTime;
import com.braker.icontrol.budget.project.entity.GoalDetailModel;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TCapitalSource;
import com.braker.icontrol.budget.project.entity.TCapitalSourceMatter;
import com.braker.icontrol.budget.project.entity.TGovernmentPurchaseDetail;
import com.braker.icontrol.budget.project.entity.TMediuLongTermGoals;
import com.braker.icontrol.budget.project.entity.TMediuLongTermGoalsOut;
import com.braker.icontrol.budget.project.entity.TProBasicAccoAttac;
import com.braker.icontrol.budget.project.entity.TProBasicCheckUpdate;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicPlanAttac;
import com.braker.icontrol.budget.project.entity.TProBasicRenameHistory;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.TProFunSub;
import com.braker.icontrol.budget.project.entity.TPurchaseManyYearsPro;
import com.braker.icontrol.budget.project.entity.TYearTermGoals;
import com.braker.icontrol.budget.project.entity.TYearTermGoalsOut;
import com.braker.icontrol.budget.project.entity.XmDept;
import com.braker.icontrol.budget.project.manager.AddAndCheckTimeMng;
import com.braker.icontrol.budget.project.manager.ExecuteProjectMng;
import com.braker.icontrol.budget.project.manager.PerformanceIndicatorModelMng;
import com.braker.icontrol.budget.project.manager.TCapitalSourceMatterMng;
import com.braker.icontrol.budget.project.manager.TCapitalSourceMng;
import com.braker.icontrol.budget.project.manager.TGovernmentPurchaseDetailMng;
import com.braker.icontrol.budget.project.manager.TMediuLongTermGoalsMng;
import com.braker.icontrol.budget.project.manager.TMediuLongTermGoalsOutMng;
import com.braker.icontrol.budget.project.manager.TProBasicAccoAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicFundsMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProBasicPlanAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicRenameHistoryMng;
import com.braker.icontrol.budget.project.manager.TProBudgetMng;
import com.braker.icontrol.budget.project.manager.TProCheckInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.project.manager.TProFunSubMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.braker.icontrol.budget.project.manager.TPurchaseManyYearsProMng;
import com.braker.icontrol.budget.project.manager.TYearTermGoalsMng;
import com.braker.icontrol.budget.project.manager.TYearTermGoalsOutMng;
import com.braker.icontrol.budget.project.manager.XmDeptMng;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 项目库管理
 * 
 * @author zhangxun
 * @createtime 2018-05-23
 * @updatetime 2018-05-23
 * 
 */
@Controller
@RequestMapping("/project")
public class ProBasicController extends BaseController {

	@Autowired
	private XmDeptMng xmDeptMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private TProBudgetMng tProBudgetMng;
	@Autowired
	private TProPlanMng tProPlanMng;
	@Autowired
	private TMediuLongTermGoalsMng tMediuLongTermGoalsMng;
	@Autowired
	private TMediuLongTermGoalsOutMng tMediuLongTermGoalsOutMng;
	@Autowired
	private TYearTermGoalsMng tYearTermGoalsMng;
	@Autowired
	private TYearTermGoalsOutMng tYearTermGoalsOutMng;
	@Autowired
	private TProBasicPlanAttacMng tProBasicPlanAttacMng;
	@Autowired
	private TProBasicAccoAttacMng tProBasicAccoAttacMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private TProGoalMng tProGoalMng;
	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;
	@Autowired
	private ProMgrLevelMng proMgrLevelMng;
	@Autowired
	private ProMgrLevel2Mng proMgrLevel2Mng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProCheckInfoMng tProCheckInfoMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProBasicFundsMng tProBasicFundsMng;
	@Autowired
	private TProBasicRenameHistoryMng tProBasicRenameHistoryMng;
	@Autowired
	private PorjectKnotMng porjectKnotMng;
	@Autowired
	private PerformanceIndicatorModelMng performancModelMng;
	@Autowired
	private SysDepartEconomicMng sysDepartEconomicMng;
	@Autowired
	private AddAndCheckTimeMng addAndCheckTimeMng;
	@Autowired
	private TProFunSubMng tProFunSubMng;
	@Autowired
	private TCapitalSourceMng tCapitalSourceMng;
	@Autowired
	private TGovernmentPurchaseDetailMng tGovernmentPurchaseDetailMng;
	@Autowired
	private TPurchaseManyYearsProMng tPurchaseManyYearsProMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private ExecuteProjectMng executeProjectMng;
	@Autowired
	private TCapitalSourceMatterMng tcapitalSourceMatterMng;
	
	
	@RequestMapping("/deptList")
	public String deptList(ModelMap model,String id) {
		model.addAttribute("xmid", id);
		String dept = "";
		List<XmDept> xmDeptList = projectMng.xmDeptList(id);
		for (int i = 0; i < xmDeptList.size(); i++) {
			dept += xmDeptList.get(i).getFdeptid()+",";
		}
		model.addAttribute("dept", dept);
		return "/WEB-INF/view/budget/project/dept-list";
	}
	
	
	@RequestMapping(value="/deptJsonPagination")
	@ResponseBody
	public JsonPagination deptJsonPagination(Depart bean,String xmid,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=projectMng.deptList(bean,sort,order,page,rows);
		
		return getJsonPagination(p,page);
	}
	
	@RequestMapping("/saveDept")
	@ResponseBody
	public Result saveDept(String id,String ids) {
		try {
			projectMng.saveDept(id,ids);
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}
	/*
	 * 跳转列表
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String proLibType, String sbkLx, String fproOrBasic) {
		model.addAttribute("proLibType", proLibType);// 四库类型
		model.addAttribute("sbkLx", sbkLx);// 申报库类型
		if ("xmtz".equals(sbkLx)) {
			//是否拥有项目复核权限
			if(hasFuncs("/project/review")){
				model.addAttribute("review", "true");
			}
			model.addAttribute("menuName", "pro4");
			model.addAttribute("listid", "4");
			return "/WEB-INF/view/budget/project/project-tzlist"; // 台账列表
		}else if ("zxmtz".equals(sbkLx)) {
			//是否拥有项目复核权限
			model.addAttribute("menuName", "pro4");
			model.addAttribute("listid", "4");
			return "/WEB-INF/view/budget/project/project-zxmtzlist"; // 台账列表
		} else if ("3".equals(proLibType)) {
			model.addAttribute("proLibType", "3");
			model.addAttribute("listid", "5");
			if("myzxk".equals(sbkLx)){
				model.addAttribute("user", "0");
				if(getUser().getRoleName().contains("预算主办会计岗")){
					model.addAttribute("user", "1");
				}
				return "/WEB-INF/view/budget/project/project-myzx-list";//我的执行库
			}
			return "/WEB-INF/view/budget/project/project-list";//执行库
		} else if ("4".equals(proLibType)) {
			model.addAttribute("proLibType", "4");
			model.addAttribute("listid", "6");
			return "/WEB-INF/view/budget/project/project-list";//完结库
		} else {
			model.addAttribute("menuName", "pro5");
			if("xmsp".equals(sbkLx)){
				model.addAttribute("listid", "1");//项目审批
				AddAndCheckTime bean = new AddAndCheckTime();
				User user = getUser();
				if((user.getRoleName().contains("部门负责人")||user.getRoleName().contains("预算主办会计"))&&user.getDpID().equals("2")){//财务处的部门负责人可以看到配置时间
					model.addAttribute("settime", "open");// 配置时间的权限
				}
				bean = addAndCheckTimeMng.findbyDataType(1);
				model.addAttribute("timeid", bean.getFid());// 配置时间的主键id
				model.addAttribute("timebean", bean);
			}else if("xmsb".equals(sbkLx)){
				AddAndCheckTime bean = new AddAndCheckTime();
				User user = getUser();
				if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("2")){//财务处的部门负责人可以看到配置时间
					model.addAttribute("settime", "open");// 配置时间的权限
				}
				if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("34")){
					model.addAttribute("daoru", "open");//导入子项目的权限-综合改革办公室部门负责人
				}
				bean = addAndCheckTimeMng.findbyDataType(1);
				model.addAttribute("timeid", bean.getFid());// 配置时间的主键id
				model.addAttribute("timebean", bean);
				model.addAttribute("listid", "2");//项目申报
			}else if("zxmsb".equals(sbkLx)){
				model.addAttribute("listid", "2");//子项目申报
			}else if("dwxmjx".equals(sbkLx)){
				model.addAttribute("listid", "8");//单位项目结项
			}else if("bmxmjx".equals(sbkLx)){
				model.addAttribute("listid", "9");//部门项目结项
			}else if("ysshoub".equals(sbkLx)){
				model.addAttribute("listid", "10");//预算收报
				return "/WEB-INF/view/budget/project/project-ysshoub";
			}
			if("zxmsp".equals(sbkLx)){
				model.addAttribute("listid", "1");//子项目审批
				return "/WEB-INF/view/budget/project/project-big-checkList";
			}
			if(fproOrBasic!=null&&fproOrBasic.equals("2")){
				return "/WEB-INF/view/budget/project/project-big-list";
			}else{
				return "/WEB-INF/view/budget/project/project-list";
			}
		}

	}
	
	/**
	 * 跳转到基本支出liet页面
	 * @return
	 * @author 陈睿超
	 * @createtime 2019年10月10日
	 */
	@RequestMapping("/basicExpInfolist")
	public String basicExpInfolist(ModelMap model, String proLibType, String sbkLx){
		model.addAttribute("listid", "2");//基本支出申请
		model.addAttribute("proLibType", proLibType);// 四库类型
		model.addAttribute("sbkLx", sbkLx);// 申报库类型
		User user = getUser();
		AddAndCheckTime bean = new AddAndCheckTime();
		if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("2")){//财务处的部门负责人可以看到配置时间
			model.addAttribute("settime", "open");// 配置时间的权限
		}
		bean = addAndCheckTimeMng.findbyDataType(1);
		model.addAttribute("timeid", bean.getFid());// 配置时间的主键id
		model.addAttribute("timebean", bean);
		
		return "/WEB-INF/view/budget/project/project-basic-expenditure-list";
	}
	
	
	/*
	 * 跳转新增
	 */
	@RequestMapping("/add")
	public String add(ModelMap model,String fproOrBasic, HttpServletRequest request) {
		try {
			User user = getUser();
			TProBasicInfo bean = new TProBasicInfo();
			bean.setFProOrBasic(Integer.valueOf(fproOrBasic));
			bean.setFContinuousYn("0");// 是否持续性项目
			bean.setIsOrientation("0");// 是否横向指标
			bean.setFProAppliDepartId(user.getDpID());//申报部门id
			bean.setFProAppliDepart(user.getDepartName());//申报部门
			bean.setFProBudgetAmount(BigDecimal.ZERO);//项目预算金额
			User user2 = userMng.getUserByRoleNameAndDepartName("部门负责人", user.getDepart().getName());
			bean.setFProHead(user2.getName());
			bean.setFProHeadId(user2.getId());
			bean.setPlanStartYear(String.valueOf(Integer
					.valueOf(new SimpleDateFormat("yyyy").format(new Date())) + 1));// 计划执行年份

			// 操作类型
			model.addAttribute("operation", "add");// 操作类型新增
			// 字段信息
			model.addAttribute("sbr", user.getName());// 申报人
			model.addAttribute("sbbm", user.getDepartName());// 申报部门
			model.addAttribute("sbsj", Integer.valueOf(new SimpleDateFormat("yyyy")
					.format(new Date())));// 申报时间

			model.addAttribute("bean", bean);
			// 查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
			model.addAttribute("cheterInfo", cheterInfo);
			// 当前年度
			model.addAttribute("currentYear",
					new SimpleDateFormat("yyyy").format(new Date()));
			//查询工作流
			//根据资源名称和当前登陆者所属部门查询对应工作流
			
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
			model.addAttribute("proposer", proposer);
			if("0".equals(fproOrBasic)){
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"JBZCSB", user.getDpID(),null,null, null, null, null, "1");
				model.addAttribute("nodeConf", nodeConfList);
				return "/WEB-INF/view/budget/project/project-add-two";
			}if("2".equals(fproOrBasic)){
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"ZXMSB", user.getDpID(),null,null, null, null, null, "1");
				model.addAttribute("nodeConf", nodeConfList);
				return "/WEB-INF/view/budget/project/project-add-big";
			}else{
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"XMSB", user.getDpID(),null,null, null, null, null, "1");
				model.addAttribute("nodeConf", nodeConfList);
				return "/WEB-INF/view/budget/project/project-add";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/budget/project/project-add";
		}
		
	}

	/*
	 * 跳转修改
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id, ModelMap model) {

		TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
		// 操作类型
		model.addAttribute("operation", "edit");

		// 查询附件信息
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);

		// 字段信息
		model.addAttribute("projectCode", pro.getFProCode());// 项目编号
		model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
		model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
		if (pro.getFProAppliTime() != null)
			model.addAttribute("sbsj",
					new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
		model.addAttribute("processCode", TProcessDefin.PROAPPLY);// 流程code
		model.addAttribute("level", pro.getFFlowStauts());// 当前项目审批进度

		// 查询项目支出明细
		List<TProExpendDetail> expDetailList = tProExpendDetailMng
				.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);
		/*// 查询项目计划
		List<TProPlan> planList = tProPlanMng.getTProPlansByPro(id);
		model.addAttribute("planList", planList);
		// 查询项目绩效目标总表
		List<TProGoal> goalList = tProGoalMng.getTProGoalByPro(id);
		model.addAttribute("goalList", goalList);
		if (goalList.size() > 0) {
			pro.setGoal(goalList.get(0));
		}
		// 查询项目绩效目标明细
		List<TProGoalDetail> goaDetailList = tProGoalDetailMng
				.getMingxi(Integer.valueOf(id));
		model.addAttribute("goaDetailList", goaDetailList);*/

		model.addAttribute("bean", pro);// 项目实体
		String ywfw = "XMSB";
		if(pro.getFProOrBasic()==0&&(("21").equals(pro.getFExt4())||("20").equals(pro.getFExt4()))){
			ywfw = "JBZCESSB";
		}else if(pro.getFProOrBasic()==0&&(("11").equals(pro.getFExt4())||("10").equals(pro.getFExt4())||("0").equals(pro.getFExt4())||StringUtil.isEmpty(pro.getFExt4()))){
			ywfw = "JBZCSB";
		}else if(pro.getFProOrBasic()==1&&(("21").equals(pro.getFExt4())||("20").equals(pro.getFExt4()))){
			ywfw = "ESSB";
		}else if(pro.getFProOrBasic()==1&&(("11").equals(pro.getFExt4())||("0").equals(pro.getFExt4())||("10").equals(pro.getFExt4())||StringUtil.isEmpty(pro.getFExt4()))){
			ywfw = "XMSB";
		}else if(pro.getFProOrBasic()==2){
			ywfw = "ZXMSB";
		}

		// 查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),ywfw, pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, pro.getFProAppliDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",pro.getBeanCode());
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
		model.addAttribute("proposer", proposer);
		/*int addorupdate = 0;
		for (int i = 0; i < nodeConfList.size(); i++) {
			if("0".equals(nodeConfList.get(i).getCheckInfo().getFcheckResult())){//有不通过
				addorupdate = 1;
			}
		}
		model.addAttribute("addorupdate", addorupdate);//修改
*/		if(pro.getFProOrBasic()==0){
			return "/WEB-INF/view/budget/project/project-add-two";
		}if(pro.getFProOrBasic()==2){
			return "/WEB-INF/view/budget/project/project-add-big";
		}else{
			return "/WEB-INF/view/budget/project/project-add";
		}
	}

	/*
	 * 跳转详情
	 * 
	 * @param logType 审批记录类型
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id, String logType,String foCode,
			ModelMap model, String remark) {
		try {
			User user = getUser();
			// 查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
			model.addAttribute("cheterInfo", cheterInfo);

			model.addAttribute("operation", "detail");// 操作类型
			TProBasicInfo pro =new TProBasicInfo();
			if( !StringUtils.isEmpty(id) && !"undefined".equals(id)){
				pro= projectMng.findById(Integer.valueOf(id));
			}else if(!StringUtils.isEmpty(foCode) ){
				pro= projectMng.findbyCode(foCode);
			}
			model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
			model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
			if (pro.getFProAppliTime() != null)
				model.addAttribute("sbsj",
						new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
			// 备用字段
			model.addAttribute("remark", remark);

			// 查询附件信息
			/*List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);*/

			// 查询项目支出明细
			List<TProExpendDetail> expDetailList = tProExpendDetailMng
					.getByProId(pro.getFProId());
			model.addAttribute("expDetailList", expDetailList);

			model.addAttribute("bean", pro);// 项目实体
			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);
			//一上申报审批流
			if("21".equals(pro.getFFlowStauts()) || "29".equals(pro.getFFlowStauts()) || "-21".equals(pro.getFFlowStauts())){
				if(pro.getFProOrBasic()==0){
					//基本支出
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(), pro.getJoinTable(), pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"XMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(), pro.getJoinTable(), pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
					
				}
			}else if("31".equals(pro.getFFlowStauts()) || "39".equals(pro.getFFlowStauts()) || "-31".equals(pro.getFFlowStauts())){//二上申报审批流
				if(pro.getFProOrBasic()==0){
					//基本支出
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCESSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCESSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					//查询工作流
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"ESSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ESSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}
				
			}else{
				//查询工作流
				if(pro.getFProOrBasic()==0){
					//基本支出
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"JBZCSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==1){
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"XMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}else if(pro.getFProOrBasic()==2){
					List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"ZXMSB",pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),  pro.getFProCode(),"1");
					model.addAttribute("nodeConf", nodeConfList);
					//得到工作流id
					TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZXMSB", pro.getFProAppliDepartId());
					model.addAttribute("fpId", tProcessDefin.getFPId());
				}
			}
			
			//对象编码
			model.addAttribute("foCode",pro.getBeanCode());	
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
			model.addAttribute("proposer", proposer);

			model.addAttribute("logType", logType);
			
			if(pro.getFProOrBasic() == 0){
				return "/WEB-INF/view/budget/project/detail/project-detail-two";
			}else if(pro.getFProOrBasic() == 1){
				return "/WEB-INF/view/budget/project/detail/project-detail";
			}else if(pro.getFProOrBasic() == 2){
				return "/WEB-INF/view/budget/project/detail/project-detail-big";
			}
		} catch (Exception e) {
			
		}
		return null;
		
	}
	/*
	 * 跳转审批
	 */
	@RequestMapping("/verdict/{id}")
	public String verdict(@PathVariable String id, ModelMap model,String listid) {
		try {
			// 查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
			model.addAttribute("cheterInfo", cheterInfo);

			// 操作类型
			model.addAttribute("operation", "verdict");
			model.addAttribute("listid", listid);

			TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
			model.addAttribute("bean", pro);// 项目信息
			model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
			model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门

			User userPeople = getUser();
			//判断审批人是不是预算主办会计岗
			if(userPeople.getRoleName().contains("预算主办会计岗")){
				model.addAttribute("checkPeople","1");//1是预算主办会计岗
			}else{
				model.addAttribute("checkPeople","");//空不是预算主办会计岗
			}
			
			if (pro.getFProAppliTime() != null) {
				model.addAttribute("sbsj",
						new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
			}

			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);
			String ywfw = null;
			 if(pro.getFProOrBasic()==0){
				ywfw = "JBZCSB";
			}else if(pro.getFProOrBasic()==1){
				ywfw = "XMSB";
			}else if(pro.getFProOrBasic()==2){
				ywfw = "ZXMSB";
			}
			 
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),ywfw, pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(), pro.getFProCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, pro.getFProAppliDepartId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",pro.getBeanCode());
			if(pro.getFProOrBasic()==2){
				return "/WEB-INF/view/budget/project/detail/project-verdict-big";
			}
			if(pro.getFProOrBasic()==1){
				return "/WEB-INF/view/budget/project/detail/project-verdict";
			}else{
				return "/WEB-INF/view/budget/project/detail/project-verdict-two";
			}
		} catch (Exception e) {
			return "/WEB-INF/view/budget/project/detail/project-verdict";
		}
		
	}

	/*
	 * 跳转选择基本支出明细支出科目
	 */
	@RequestMapping("/toChooseKm")
	public String toChooseKm(ModelMap model,String rIndex, String fProOrBasic,String ejProCode, String code,String fEcCode,String ejplanStartYear) {
		model.addAttribute("ejProCode", ejProCode);
		model.addAttribute("rIndex", rIndex);
		model.addAttribute("fProOrBasic", fProOrBasic);
		model.addAttribute("fEcCode", fEcCode);
		model.addAttribute("ejplanStartYear",ejplanStartYear);
		if (!StringUtil.isEmpty(code)) {
			model.addAttribute("sCode", code);
		}
		return "/WEB-INF/view/budget/project/project-choose-km";
	}
	
	/*
	 * 跳转选择基本支出明细支出科目
	 */
	@RequestMapping("/toChooseKmEssb")
	public String toChooseKmEssb(ModelMap model,String rIndex, String fProOrBasic,String ejProCode, String code,String fEcCode,String ejplanStartYear) {
		model.addAttribute("ejProCode", ejProCode);
		model.addAttribute("rIndex", rIndex);
		model.addAttribute("fProOrBasic", fProOrBasic);
		model.addAttribute("fEcCode", fEcCode);
		String thisYear = new SimpleDateFormat("yyyy").format(new Date());//当前年
		if(thisYear.equals(ejplanStartYear)){//今年申报今年的预算
			ejplanStartYear = String.valueOf(Integer.valueOf(ejplanStartYear)-1);
		}
		model.addAttribute("ejplanStartYear",ejplanStartYear);
		if (!StringUtil.isEmpty(code)) {
			model.addAttribute("sCode", code);
		}
		return "/WEB-INF/view/budget/project/project-choose-km-essb";
	}
	/*
	 * 跳转选择政府采购明细表支出科目
	 */
	@RequestMapping("/toChooseProcurment")
	public String toChooseProcurment(ModelMap model,String rIndex, String fProOrBasic,String ejProCode, String code,String fEcCode,String ejplanStartYear,String tabId) {
		model.addAttribute("ejProCode", ejProCode);
		model.addAttribute("rIndex", rIndex);
		model.addAttribute("fProOrBasic", fProOrBasic);
		model.addAttribute("fEcCode", fEcCode);
		model.addAttribute("tabId", tabId);
		String thisYear = new SimpleDateFormat("yyyy").format(new Date());//当前年
		if(thisYear.equals(ejplanStartYear)){//今年申报今年的预算
			ejplanStartYear = String.valueOf(Integer.valueOf(ejplanStartYear)-1);
		}
		model.addAttribute("ejplanStartYear",ejplanStartYear);
		if (!StringUtil.isEmpty(code)) {
			model.addAttribute("sCode", code);
		}
		return "/WEB-INF/view/budget/project/project-choose-proCurement";
	}
	
	/*
	 * 跳转选择功能分类科目
	 */
	@RequestMapping("/toChooseFun")
	public String toChooseFun(ModelMap model,String rIndex) {
		model.addAttribute("rIndex", rIndex);
		return "/WEB-INF/view/budget/project/project-choose-fun";
	}
	
	/**
	 * 获取功能分类科目数据
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月2日
	 */
	@RequestMapping(value = "/findProFunSub")
	@ResponseBody
	public JsonPagination findProFunSub(Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	List<TProFunSub> list = tProFunSubMng.findAll();
    	Pagination p = new Pagination();
    	p.setList(list);
    	return getJsonPagination(p, page);
	}
	/*
	 * 跳转选择资产来源页面
	 */
	@RequestMapping("/toChooseCapitalSource")
	public String toChooseCapitalSource(ModelMap model,String rIndex) {
		model.addAttribute("rIndex", rIndex);
		return "/WEB-INF/view/budget/project/project-choose-zcly";
	}
	
	/**
	 * 获取资产来源数据
	 * <p>Description: </p>
	 * <p>Company: </p> 
	 * @author zml
	 * @date 2021年6月2日
	 */
	@RequestMapping(value = "/findCapitalSource")
	@ResponseBody
	public JsonPagination findCapitalSource(Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		List<TCapitalSource> list = tCapitalSourceMng.findAll();
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, page);
	}
	/*
	 * 跳转结项界面
	 */
	@RequestMapping("/toFinish/{id}")
	public String toFinish(ModelMap model, @PathVariable String id) {

		return "/WEB-INF/view/budget/project/project-finish";
	}


	/*
	 * 操作结转
	 */
	@RequestMapping("/over/{id}")
	public String over(ModelMap model, @PathVariable String id,String listid) {

		TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
		List<ExecuteProject> zzxmList = projectMng.zzxmList(pro.getFProId().toString());
		if (zzxmList.size()>0) {
			ExecuteProject executeProject = zzxmList.get(0);
			model.addAttribute("expr", executeProject);// 项目实体
		}
		// 判断项目是否超时（还在计划年份中的项目结转不需要添加新的项目支出计划，也不需要修改计划执行周期，将要超出年限的添加新的支出计划，增加一年的执行周期）
		Integer planYear = Integer.valueOf(pro.getPlanStartYear());// 获取项目计划执行年份
		Integer yaer = DateUtil.getThisYear();//获得当前年
		if (StringUtils.isNotEmpty(pro.getFProRollingCycle())) {
			Integer rollingCycle = Integer.valueOf(pro.getFProRollingCycle());// 获取项目计划执行周期
			boolean flag = true;
			if ((planYear + rollingCycle - 1) <= yaer) {
				// 项目即将超出年限
				flag = false;
				pro.setFProRollingCycle(String.valueOf(rollingCycle + 1));
			}
		}
		//Integer yaer = 2020;// 获得当前年

		model.addAttribute("bean", pro);// 项目实体

		model.addAttribute("listid", listid);
		// 操作类型
		model.addAttribute("operation", "edit");

		// 查询附件信息
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);
		// 字段信息
		model.addAttribute("projectCode", pro.getFProCode());// 项目编号
		model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
		model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
		if (pro.getFProAppliTime() != null)
			model.addAttribute("sbsj",
					new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
		model.addAttribute("processCode", TProcessDefin.PROAPPLY);// 流程code
		model.addAttribute("level", pro.getFFlowStauts());// 当前项目审批进度

		// 查询项目支出明细
		List<TProExpendDetail> expDetailList = tProExpendDetailMng
				.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);
		/*// 查询项目计划
		List<TProPlan> planList = tProPlanMng.getTProPlansByPro(id);

		// 查询项目绩效目标总表
		List<TProGoal> goalList = tProGoalMng.getTProGoalByPro(id);
		model.addAttribute("goalList", goalList);
		pro.setGoal(goalList.get(0));
		// 查询项目绩效目标明细
		List<TProGoalDetail> goaDetailList = tProGoalDetailMng
				.getMingxi(Integer.valueOf(id));
		model.addAttribute("goaDetailList", goaDetailList);*/

		// 不需要显示工作流
		//model.addAttribute("splc", "1");
		//根据申请人得到申请部门id
		String departId=departMng.findDeptByUserId(getUser().getId())[0];
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"zxxm", departId,pro.getBeanCode(),null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(pro.getFProAppliPeople(), pro.getFProAppliDepart(), pro.getFProAppliTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("zxxm", departId);
		model.addAttribute("fpId", tProcessDefin.getFPId());
		// 查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
		model.addAttribute("cheterInfo", cheterInfo);

		/*if (!flag) {
			TProPlan plan = new TProPlan();
			plan.setYear(String.valueOf(Integer.valueOf(planList.get(
					planList.size() - 1).getYear()) + 1));
			planList.add(plan);
		}

		model.addAttribute("planList", planList);*/

		return "/WEB-INF/view/budget/project/detail/project-transfer";
	}

	/**
	 * 
	* @author:安达
	* @Title: oversave 
	* @Description: 设置项目到完结 库
	* @param bean
	* @param model
	* @return
	* @return Result    返回类型 
	* @date： 2019年6月3日下午3:44:51 
	* @throws
	 */
	@RequestMapping("/oversave")
	@ResponseBody
	public Result oversave(TProBasicInfo bean,ExecuteProject executeproject, ModelMap model,String flowStauts) {
		try {
			String reason = bean.getReason();
			bean = projectMng.findById(bean.getFProId());
			List<ExecuteProject> zzxmList = projectMng.zzxmList(bean.getFProId().toString());
			if (zzxmList.size()>0) {
				executeproject = zzxmList.get(0);
			}else {
				executeproject = new ExecuteProject();
			}
			if (("1").equals(flowStauts)) {
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(getUser().getDpID(),executeproject.getJoinTable(),executeproject.getBeanCodeField(),executeproject.getBeanCode(), "zxxm", getUser());
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("zxxm", getUser().getDpID());
				Integer flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				User nextUser=userMng.findById(node.getUserId());
				//根据前面获得的角色的信息设置下一环节的用户名称/编码
				executeproject.setZxxmclrbm(nextUser.getId());
				executeproject.setZxxmclr(nextUser.getName());
				//设置下节点节点编码
				executeproject.setXjdbm(firstKey+"");
				//把历史审批记录全部设置为1，表示重新审批
				tProcessCheckMng.updateStauts(flowId,executeproject.getBeanCode());
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(executeproject.getZxxmclrbm());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getFProId());//申请单ID
				work.setTaskCode(bean.getFProCode());//为申请单的单号
				work.setTaskName("[列支结转]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/projectknot/check?id="+bean.getFProId());//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/projectknot/detail?id="+bean.getFProId());//查看url
				work.setTaskStauts("0");//待办
				work.setType("1");//任务类型：1-审批
				work.setBeforeUser(getUser().getName());//任务提交人姓名
				work.setBeforeDepart(getUser().getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(new Date());//任务提交时间
				personalWorkMng.merge(work);
				
				
				//添加一个自己的已办事项
				PersonalWork minwork = new PersonalWork();
				minwork.setUserId(getUser().getId());//任务处理人ID既是下节点处理人ID
				minwork.setTaskId(bean.getFProId());//申请单ID
				minwork.setTaskCode(bean.getFProCode());//为申请单的单号
				minwork.setTaskName("[列支结转]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				minwork.setUrl("/project/over/id="+bean.getFProId());//退回修改url
				//minwork.setUrl1("/Enforcing/detailPay?id="+bean.getFProId());//查看url
				minwork.setUrl2("");//退回删除url
				minwork.setTaskStauts("2");//待办
				minwork.setType("2");//任务类型：2-查看
				minwork.setBeforeUser(getUser().getName());//任务提交人姓名
				minwork.setBeforeDepart(getUser().getDepartName());//任务提交人所属部门名称
				minwork.setBeforeTime(new Date());//任务提交时间
				minwork.setFinishTime(new Date());
				personalWorkMng.merge(minwork);
			}
			bean.setFjzclrbm(executeproject.getZxxmclrbm());
			bean.setFjzspzt(flowStauts);
			bean.setReason(reason);
			//bean.setFProLibType("4");//完结库
			executeproject.setFzxxmId(bean.getFProId().toString());
			executeproject.setFcCode(bean.getFProCode());
			executeproject.setfOperator(getUser().getName());
			executeproject.setfOperatorId(getUser().getId());
			executeproject.setfDeptName(getUser().getDepartName());
			executeproject.setfDeptId(getUser().getDpID());
			executeproject.setJzspzt(flowStauts);
			projectMng.merge(bean);
			executeProjectMng.saveOrUpdate(executeproject);
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}

	/*
	 * 跳转复核
	 */
	@RequestMapping("/review")
	public String review(ModelMap model, String id) {

		TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
		// 操作类型
		model.addAttribute("operation", "review");

		// 查询附件信息
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);

		// 字段信息
		model.addAttribute("projectCode", pro.getFProCode());// 项目编号
		model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
		model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
		if (pro.getFProAppliTime() != null)
			model.addAttribute("sbsj",
					new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
		model.addAttribute("processCode", TProcessDefin.PROAPPLY);// 流程code
		model.addAttribute("level", pro.getFFlowStauts());// 当前项目审批进度

		// 查询项目支出明细
		List<TProExpendDetail> expDetailList = tProExpendDetailMng
				.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);
		/*// 查询项目计划
		List<TProPlan> planList = tProPlanMng.getTProPlansByPro(id);
		model.addAttribute("planList", planList);
		// 查询项目绩效目标总表
		List<TProGoal> goalList = tProGoalMng.getTProGoalByPro(id);
		model.addAttribute("goalList", goalList);
		if (goalList.size() > 0) {
			pro.setGoal(goalList.get(0));
		}
		// 查询项目绩效目标明细
		List<TProGoalDetail> goaDetailList = tProGoalDetailMng
				.getMingxi(Integer.valueOf(id));
		model.addAttribute("goaDetailList", goaDetailList);*/

		model.addAttribute("bean", pro);// 项目实体


		// 查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),"XMSB", pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(),pro.getFProCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", pro.getFProAppliDepartId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",pro.getBeanCode());
		// 建立工作流发起人的信息
		Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/budget/project/detail/project-review";
	}
	/**
	 * 
	* @author:安达
	* @Title: saveReview 
	* @Description: 保存项目复核信息
	* @param bean
	* @return
	* @return Result    返回类型 
	* @date： 2019年5月27日下午5:34:07 
	* @throws
	 */
	@RequestMapping("/saveReview")
	@ResponseBody
	public Result saveReview(TProBasicInfo bean) {
		
		try {
			//1,2,3
			// 保存项目基本信息
			projectMng.saveReview(bean,getUser());// 保存项目

			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}
	/**
	 * /project/findReviewHistory
	* @author:安达
	* @Title: reviewHistory 
	* @Description: 复核记录列表
	* @param id
	* @return
	* @return List<TProBasicInfo>    返回类型 
	* @date： 2019年5月29日下午3:33:00 
	* @throws
	 */
	@RequestMapping(value = "/findReviewHistory")
	@ResponseBody
	public JsonPagination findReviewHistory(TProBasicRenameHistory bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = tProBasicRenameHistoryMng.pageList(bean, getUser(), page, rows);
    	List<TProBasicRenameHistory> li = (List<TProBasicRenameHistory>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
			//设置项目名称
			TProBasicInfo pro = projectMng.findById(li.get(x).getProId());
			li.get(x).setProName(pro.getFProName());
		}
    	return getJsonPagination(p, page);
	}
	/**
	 * /project/reviewHistory
	* @author:安达
	* @Title: reviewHistory 
	* @Description: 复核记录页面
	* @param model
	* @param id  
	* @return
	* @return String    返回类型 
	* @date： 2019年5月29日下午3:01:01 
	* @throws
	 */
	@RequestMapping(value = "/reviewHistory")
	public String  reviewHistory(ModelMap model, Integer id) {
		
		return "/WEB-INF/view/budget/project/project-review-history";
	}
	
	/**
	 * /project/zhichuDetail
	* @author:安达
	* @Title: zhichuDetail 
	* @Description: 支出历史记录
	* @param model
	* @param fProCode
	* @return
	* @return String    返回类型 
	* @date： 2019年6月13日上午11:11:17 
	* @throws
	 */
	@RequestMapping(value = "/zhichuDetail")
	public String  zhichuDetail(ModelMap model, String fProCode) {
		TProBasicInfo proBasic =new TProBasicInfo();
		proBasic.setFProCode(fProCode);
		model.addAttribute("bean", proBasic);
		
		TBudgetIndexMgr budgetIndexMgr =  budgetIndexMgrMng.findByIndexCode(fProCode);
		model.addAttribute("budgetIndexMgr", budgetIndexMgr.getbId());
		return "/WEB-INF/view/budget/project/zhichu_detail";
	}
	/*
	 * 基本预算操作保存
	 * 
	 * @param lxyjFiles 立项依据附件
	 * 
	 * @param ssfaFiles 实施方案附件
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(TProBasicInfo bean, ModelMap model, String saveType, String outcomeJson,String purchaseJson,
			String fundsJson, String lxyjFiles, String ssfaFiles,String purManyYearsProJson) {
		
		try {
			//1,2,3
			// 保存项目基本信息
			projectMng.saveProject(bean, getUser(), saveType,outcomeJson,purchaseJson,purManyYearsProJson);// 保存项目
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}
	/*
	 * 项目预算操作保存
	 * 
	 * @param lxyjFiles 立项依据附件
	 * 
	 * @param ssfaFiles 实施方案附件
	 */
	@RequestMapping("/savePro")
	@ResponseBody
	public Result savePro(TProBasicInfo bean, ModelMap model, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) {
		
		try {
			// 保存项目基本信息
			projectMng.saveProject1(bean, getUser(),saveType, outcomeJson,purchaseJson,purchaseJsonSE,
					fundsJson, lxyjFiles, ssfaFiles,totalityPerformanceJson,purManyYearsProJson,purManyYearsProJsonSE);// 保存项目
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
		
	}

	/*
	 * 跳转部门选择
	 */
	@RequestMapping("/choDepart")
	public String choDepart(ModelMap model, String inputId) {

		model.addAttribute("inputId", inputId);
		return "/WEB-INF/view/budget/project/project-choose-depart";
	}
	
	/*
	 * 跳转选择子项目
	 */
	@RequestMapping("/chooseZxmList")
	public String chooseZxmList(ModelMap model) {

		return "/WEB-INF/view/budget/project/choose_zxm_list";
	}

	/*
	 * 操作审批保存
	 */
	@RequestMapping("/saveVerdict")
	@ResponseBody
	public Result saveVerdict(TProBasicInfo newBean, TProcessCheck checkBean, String spjlFiles, String lxyjFiles, String ssfaFiles, String delIndex, String totalityPerformanceJson,String fundJson,String outcomeJson) {
		try {
			//修改前的bean数据
			TProBasicInfo oldBean = projectMng.findById(newBean.getFProId());
			/*TProBasicInfo resultBean = new TProBasicInfo();
			//比较后返回用于审批的bean
			if(oldBean.getZxmId()!=null){
				resultBean =oldBean;
			}else {
				 resultBean = projectMng.compareFields(oldBean, newBean, lxyjFiles, ssfaFiles, delIndex, totalityPerformanceJson, getUser());
			}*/
			projectMng.saveCheck(oldBean, checkBean, spjlFiles, getUser(),fundJson,outcomeJson);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}

	/*
	 * 操作删除
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable Integer id) {

		try {
			/* projectMng.deleteById(id); */
			projectMng.deleteProject(id);
			return getJsonResult(true, "删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "删除失败，请联系管理员！");
		}
	}
	/*
	 * 操作删除综合改革办公室项目申报数据，退回到大项目库综合改革办公室负责人手上
	 */
	@RequestMapping("/deleteDRSB/{id}")
	@ResponseBody
	public Result deleteDRSB(@PathVariable Integer id) {
		try {
			projectMng.updateProjectLibrary(id);
			return getJsonResult(true, "删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "删除失败，请联系管理员！");
		}
	}

	/*
	 * ajax 项目库列表 proLibType-四库类型 flowStatus-审批状态
	 */
	@RequestMapping(value = "/projectPageData")
	@ResponseBody
	public JsonPagination projectPageData(TProBasicInfo bean, String sort,
			String order, Integer page, Integer rows, String proLibType,
			String sbkLx) {
		try {
			if (page == null) {
				page = 1;
			}
			if (rows == null) {
				rows = SimplePage.DEF_COUNT;
			}
			/*int a = 0;
			if(a==0){
				throw new ServiceException("asiodhoi");
			}*/
			// //区分四库
			bean.setFProLibType(proLibType);
			bean.setSbkLx(sbkLx);
			Pagination p = projectMng.pageList(bean, getUser(), hasRole("OFFICE"),
					page, rows);
			// 加入排序号
			List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					TProBasicInfo pro = list.get(i);
					pro.setPageOrder(page * rows + i - 9);

					// 项目执行率查询，用于执行库和结转库list
					if ("3".equals(pro.getFProLibType())
							|| "4".equals(pro.getFProLibType())) {
						TBudgetIndexMgr index = budgetIndexMgrMng
								.findByIndexCode(pro.getFProCode());// 根据项目编码查询相应的指标
						BigDecimal pfAmount = index.getPfAmount();
						BigDecimal syAmount = index.getSyAmount();
						BigDecimal djAmount = index.getDjAmount();
						BigDecimal djAmounts = syAmount.add(djAmount);
						djAmounts.setScale(2, RoundingMode.HALF_UP);
						//BigDecimal efficiency = (BigDecimal.valueOf(1).subtract(((syAmount.add(djAmount)).divide(pfAmount)))).multiply(BigDecimal.valueOf(100));
						BigDecimal efficiency = (BigDecimal.valueOf(1).subtract(djAmounts.divide(pfAmount,20,BigDecimal.ROUND_HALF_UP))).multiply(BigDecimal.valueOf(100));
						efficiency = efficiency.setScale(2, BigDecimal.ROUND_HALF_UP);
						pro.setDjAmount(djAmount);
						pro.setEfficiency(efficiency);
						pro.setSyAmount(syAmount);
					}
				}
			}
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}
		
	}
	/*
	 * ajax 项目库列表 proLibType-四库类型 flowStatus-审批状态
	 */
	@RequestMapping(value = "/projectPageDataList")
	@ResponseBody
	public List<TProBasicInfo> projectPageDataList(TProBasicInfo bean, String sort,
			String order, Integer page, Integer rows, String proLibType,
			String sbkLx) {
		try {
			if (page == null) {
				page = 1;
			}
			if (rows == null) {
				rows = SimplePage.DEF_COUNT;
			}
			/*int a = 0;
			if(a==0){
				throw new ServiceException("asiodhoi");
			}*/
			// //区分四库
			bean.setFProLibType(proLibType);
			bean.setSbkLx(sbkLx);
			// 加入排序号
			List<TProBasicInfo> list = projectMng.pageLists(bean, getUser(), hasRole("OFFICE"));
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					TProBasicInfo pro = list.get(i);
					pro.setPageOrder(page * rows + i - 9);
					
					// 项目执行率查询，用于执行库和结转库list
					/*if ("3".equals(pro.getFProLibType())
							|| "4".equals(pro.getFProLibType())) {
						TBudgetIndexMgr index = budgetIndexMgrMng
								.findByIndexCode(pro.getFProCode());// 根据项目编码查询相应的指标
						BigDecimal pfAmount = index.getPfAmount();
						BigDecimal syAmount = index.getSyAmount();
						BigDecimal djAmount = index.getDjAmount();
//						BigDecimal efficiency = (BigDecimal.valueOf(1).subtract(((syAmount.add(djAmount)).divide(pfAmount)))).multiply(BigDecimal.valueOf(100));

//						efficiency = efficiency.setScale(2, BigDecimal.ROUND_HALF_UP);
						pro.setDjAmount(djAmount);
//						pro.setEfficiency(efficiency);
						pro.setSyAmount(syAmount);
					}*/
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}
		
	}

	/*
	 * ajax-选择科目页面-支出科目列表
	 */
	@RequestMapping(value = "/treezZckm")
	@ResponseBody
	public List<TreeEntity> treezZckm(String id, String qName, String sCode,String year,
			ModelMap model) {
		
		qName = StringUtil.setUTF8(qName);
		if (!StringUtil.isEmpty(sCode) && StringUtil.isEmpty(id)) {
			// 有默认值且展现的是一级节点,需要打开默认值
			return getTree2(sCode);
		} else {
			return getTree1(id, qName, year);
		}
	}

	// 获得支出项科目树（一级节点并且有默认值）
	private List<TreeEntity> getTree2(String sCode) {

		Economic defaultNode = null;// 默认选择的子节点
		Economic defaultParent = null;// 默认展开的根节点
		List<Economic> tList = economicMng.findByProperty("code", sCode);// 临时集合
		List<Economic> sonList = null;// 展开后的子节点集合
		if (tList != null && tList.size() > 0) {
			defaultNode = tList.get(0);
			List<Economic> list1 = economicMng.findByProperty("code",
					String.valueOf(defaultNode.getPid()));
			if (list1 != null && list1.size() > 0) {
				defaultParent = list1.get(0);
				sonList = economicMng.findByProperty("pid",
						Integer.valueOf(defaultParent.getCode()));
			}
		}

		List<TreeEntity> treeList = new ArrayList<>();
		List<TreeEntity> sonTreeList = new ArrayList<>();
		List<Object[]> objList = null;
		objList = projectMng.getOutComeSubject("project", "0", new SimpleDateFormat(
				"yyyy").format(new Date()), null);

		if (objList != null && objList.size() > 0) {
			String nodeCodes = "";
			for (Object[] array : objList) {
				if ("".equals(nodeCodes)) {
					nodeCodes = (String) array[2];
				} else {
					nodeCodes = nodeCodes + "," + (String) array[2];
				}
			}
			// 查询是否有下级节点
			Map<String, Integer> pidMap = projectMng.getPidMap(null, nodeCodes,
					new SimpleDateFormat("yyyy").format(new Date()), null);
			for (Object[] array : objList) {
				// 节点id 节点名称 节点代码 父节点代码
				String nodeId = String.valueOf(array[0]);
				String nodeName = (String) array[1];
				String nodeCode = (String) array[2];
				String parentCode = String.valueOf(array[3]);
				TreeEntity node = new TreeEntity();
				node.setText(nodeName);// 名称
				node.setCode(nodeCode);// 节点代码
				node.setId(nodeId);// 节点id
				node.setParentCode(parentCode);// 父节点代码
				if (pidMap.get(nodeCode) != null) {
					node.setState("closed");
				} else {
					node.setLeaf(true);
				}
				if (defaultParent != null
						&& node.getCode().equals(defaultParent.getCode())) {
					// 放入展开的根节点下的子节点
					if (sonList != null && sonList.size() > 0) {
						for (Economic eco : sonList) {
							TreeEntity son = new TreeEntity();
							son.setText(eco.getName());
							son.setCode(eco.getCode());
							son.setId(eco.getId());
							son.setParentCode(String.valueOf(eco.getPid()));
							son.setLeaf(true);
							if (sCode.equals(son.getCode())) {
								son.setSelected(true);
							}
							sonTreeList.add(son);
						}
					}
					node.setState(null);
					node.setChildren(sonTreeList);
				}
				treeList.add(node);
			}
		}

		return treeList;
	}

	// 获得支出项科目树（没有默认值）
	private List<TreeEntity> getTree1(String id, String qName, String year) {

		List<TreeEntity> treeList = new ArrayList<>();
		List<Object[]> objList = null;
		// 查询数据
		if (id == null) {
			// 获取本年第一级支出菜单
			objList = projectMng.getOutComeSubject("project", "0", year, qName);
		} else {
			// 获取本年非第一级支出菜单
			objList = projectMng.getOutComeSubject(null, id,year, qName);
		}
		// 放入tree值
		if (objList != null && objList.size() > 0) {
			String nodeCodes = "";
			for (Object[] array : objList) {
				if ("".equals(nodeCodes)) {
					nodeCodes = (String) array[2];
				} else {
					nodeCodes = nodeCodes + "," + (String) array[2];
				}
			}
			Map<String, Integer> pidMap = projectMng.getPidMap(null, nodeCodes,
					new SimpleDateFormat("yyyy").format(new Date()), qName);
			for (Object[] array : objList) {
				// 节点id 节点名称 节点代码 父节点代码
				String nodeId = String.valueOf(array[0]);
				String nodeName = (String) array[1];
				String nodeCode = (String) array[2];
				String parentCode = String.valueOf(array[3]);
				TreeEntity node = new TreeEntity();
				node.setText(nodeName);// 名称
				node.setCode(nodeCode);// 节点代码
				node.setId(nodeId);// 节点id
				node.setParentCode(parentCode);// 父节点代码
				if (pidMap.get(nodeCode) != null && nodeCode.length()<=3) {//nodeCode.length()<=3 是希望只显示二级指标
					node.setState("closed");
				} else {
					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;

	}
	
	/*
	 * ajax-选择科目页面-基本支出科目列表
	 */
	@RequestMapping(value = "/treezJbZckm")
	@ResponseBody
	public List<TreeEntity> treezJbZckm(String id, String qName, String sCode, String ejProCode,String year,String fEcCode,
			ModelMap model) {
		// 获得基本支出项科目树
		List<TreeEntity> treeList = new ArrayList<>();
		List<Object[]> objList = null;
		List<SysDepartEconomic> departEconomicList= sysDepartEconomicMng.findByPidAndEjProCode(getUser().getDpID(), ejProCode,fEcCode);
		String fEcCodes="";
		for(SysDepartEconomic departEconomic:departEconomicList){
			if("".equals(fEcCodes)){
				fEcCodes=departEconomic.getfEcCode();
			}else{
				fEcCodes=fEcCodes+","+departEconomic.getfEcCode();
			}
		}
		// 获取本年非第一级支出菜单
		//objList = projectMng.getOutComeSubject(year, fEcCodes);
		if (id == null) {
			// 获取本年非第一级支出菜单
			objList = projectMng.getOutComeSubject(year, fEcCodes);
		} else {
			// 获取本年非第一级支出菜单
			objList = projectMng.getOutComeSubject(null, id,year, qName);
		}
		// 放入tree值
		if (objList != null && objList.size() > 0) {
			String nodeCodes = "";
			for (Object[] array : objList) {
				if ("".equals(nodeCodes)) {
					nodeCodes = (String) array[2];
				} else {
					nodeCodes = nodeCodes + "," + (String) array[2];
				}
			}
			// 查询是否有下级节点
			Map<String, Integer> pidMap = projectMng.getPidMap(null, nodeCodes,
					new SimpleDateFormat("yyyy").format(new Date()), null);
			for (Object[] array : objList) {
				// 节点id 节点名称 节点代码 父节点代码
				String nodeId = String.valueOf(array[0]);
				String nodeName = (String) array[1];
				String nodeCode = (String) array[2];
				String parentCode = String.valueOf(array[3]);
				TreeEntity node = new TreeEntity();
				node.setText(nodeName);// 名称
				node.setCode(nodeCode);// 节点代码
				node.setId(nodeId);// 节点id
				node.setParentCode(parentCode);// 父节点代码
				node.setLeaf(false);
				if (pidMap.get(nodeCode) != null && nodeCode.length()<=3) {//nodeCode.length()<=3 是希望只显示二级指标
					node.setState("open");
				} else {
					node.setLeaf(false);
				}
				treeList.add(node);
			}
		}
		return treeList;

	}
	/*
	 * ajax-支出科目页面-支出科目列表
	 */
	@RequestMapping(value = "/treegridKm")
	@ResponseBody
	public JsonPagination treegridKm(ModelMap model, String data, String type,
			String beanId) {
		List<DataEntity> list = new ArrayList<>();
		String[] datas = new String[] {};
		// 新增时查询年度支出科目库
		if ("afterSelect".equals(type)) {
			if (!StringUtil.isEmpty(data)) {
				datas = data.split(",");
				for (int i = 0; i < datas.length; i++) {
					Economic lib = economicMng.findById(Integer
							.valueOf(datas[i]));
					DataEntity de = new DataEntity();
					de.setCol1(lib.getName());// 名称
					de.setCol2(lib.getCode());// 科目编码
					de.setCol3(lib.getLeve());// 科目级别
					de.setCol4(String.valueOf(lib.getPid()));// 父节点code
					list.add(de);
				}
			}
		} else {
			// 修改时查询项目支出科目库
			List<TProBudget> buList = tProBudgetMng.getBudgetsByPro(beanId);
			if (buList != null && buList.size() > 0) {
				for (TProBudget bud : buList) {
					DataEntity de = new DataEntity();
					de.setCol1(bud.getFSubName());// 名称
					de.setCol2(bud.getFSubNum());// 科目编码
					de.setCol3(bud.getFLevel());// 科目级别
					de.setCol4(bud.getFUpperSubNum());// 父节点code
					de.setCol5(bud.getFAppliAmount() == null ? "" : String
							.valueOf(bud.getFAppliAmount()));// 预算额
					de.setCol6(bud.getFAccording());// 测算依据
					de.setCol7(String.valueOf(bud.getFPBId()));// 主键id
					de.setCol8(bud.getFAttacName());
					list.add(de);
				}
			}
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
		// return list;返回treegrid
	}

	/*
	 * ajax-获取某项目相关计划
	 */
	@RequestMapping(value = "/datagridPlan")
	@ResponseBody
	public JsonPagination datagridPlan(ModelMap model, String beanId) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<DataEntity> list = new ArrayList<>();
//		List<TProPlan> plList = tProPlanMng.getTProPlansByPro(beanId);
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
	}

	@RequestMapping(value = "/datagridLongAim")
	// ajax-获取某项目中长期目标
	@ResponseBody
	public JsonPagination datagridLongAim(ModelMap model, String beanId) {

		List<DataEntity> list = new ArrayList<>();
		List<TMediuLongTermGoals> goList = tMediuLongTermGoalsMng
				.getGoalByPro(beanId);
		if (goList != null && goList.size() > 0) {
			for (TMediuLongTermGoals go : goList) {
				DataEntity de = new DataEntity();
				de.setCol1(go.getFNum());// 序号
				de.setCol2(go.getFPlan());// 目标名称
				de.setCol3(String.valueOf(go.getFMId()));// 主键
				list.add(de);
			}
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
	}

	@RequestMapping(value = "/datagridLongIndex")
	// ajax-获取某项目中长期指标
	@ResponseBody
	public JsonPagination datagridLongIndex(ModelMap model, String beanId) {

		List<DataEntity> list = new ArrayList<>();
		List<TMediuLongTermGoalsOut> goList = tMediuLongTermGoalsOutMng
				.getGoalOutByPro(beanId);
		if (goList != null && goList.size() > 0) {
			for (TMediuLongTermGoalsOut go : goList) {
				DataEntity de = new DataEntity();
				de.setCol1(go.getFNum());// 序号
				de.setCol2(go.getFIndexOne());// 一级指标
				de.setCol3(go.getFIndexTwo());// 二级指标
				de.setCol4(go.getFIndexName());// 指标名称
				de.setCol5(go.getFIndexNum());// 指标值
				de.setCol6(go.getFPerforNorm());// 绩效标准
				de.setCol7(String.valueOf(go.getFMLId()));// 主键
				list.add(de);
			}
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
	}

	@RequestMapping(value = "/datagridYearAim")
	// ajax-获取某项目年度目标
	@ResponseBody
	public JsonPagination datagridYearAim(ModelMap model, String beanId) {

		List<DataEntity> list = new ArrayList<>();
		List<TYearTermGoals> goList = tYearTermGoalsMng.getGoalByPro(beanId);
		if (goList != null && goList.size() > 0) {
			for (TYearTermGoals go : goList) {
				DataEntity de = new DataEntity();
				de.setCol1(go.getFNum());// 序号
				de.setCol2(go.getFPlan());// 目标名称
				de.setCol3(String.valueOf(go.getFMId()));// 主键
				list.add(de);
			}
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
	}

	@RequestMapping(value = "/datagridYearIndex")
	// ajax-获取某项目年度指标
	@ResponseBody
	public JsonPagination datagridYearIndex(ModelMap model, String beanId) {

		List<DataEntity> list = new ArrayList<>();
		List<TYearTermGoalsOut> goList = tYearTermGoalsOutMng.getGoalOutByPro(
				beanId, new SimpleDateFormat("yyyy").format(new Date()));
		if (goList != null && goList.size() > 0) {
			for (TYearTermGoalsOut go : goList) {
				DataEntity de = new DataEntity();
				de.setCol1(go.getFNum());// 序号
				de.setCol2(go.getFIndexOne());// 一级指标
				de.setCol3(go.getFIndexTwo());// 二级指标
				de.setCol4(go.getFIndexName());// 指标名称
				de.setCol5(go.getLastIndexNum());// 往年指标值
				de.setCol7(go.getFIndexNum());// 预期当年实现值
				de.setCol8(String.valueOf(go.getFMLId()));// 主键
				de.setCol9(go.getYear());// 年度
				de.setCol10(go.getFPerforNorm());
				list.add(de);
			}
		}
		Pagination p = new Pagination();
		p.setList(list);
		return getJsonPagination(p, 1);
	}

	/*
	 * 绩效自评页面 根据项目的主键id查询项目绩效指标明细表（中长期）的数据
	 * 
	 * @author 冉德茂
	 * 
	 * @createtime 2018-09-17
	 * 
	 * @updatetime 2018-09-17
	 */
	@RequestMapping(value = "/yearTargerJiXiao")
	@ResponseBody
	public JsonPagination yearTargerJiXiao(ModelMap model, String beanId) {
		Pagination p = new Pagination();
		/*// 查询通用申请明细
		List<TProGoalDetail> mingxiList = tProGoalDetailMng.getMingxi(Integer
				.valueOf(beanId));
		p.setList(mingxiList);*/

		return getJsonPagination(p, 0);
	}

	// 获取一级科目
	@RequestMapping("/getSubject1")
	@ResponseBody
	public List<ComboboxJson> getSubject1(String selected,String blank) {
		List<ProMgrLevel1> list = proMgrLevelMng.findAll();
		if(StringUtils.isNotEmpty(blank)){
			String[] blanks=blank.split(",");
			//如果有排除的数据，则循环一遍把被排除的给排掉
			List<ProMgrLevel1> newlist=new ArrayList<ProMgrLevel1>();
			for(ProMgrLevel1 proMgrLevel1:list){
				boolean flag=false; //是否屏蔽
				for(String str:blanks){
					if(str.equals(proMgrLevel1.getfLevCode1())){
						flag=true;
					}
				}
				if(!flag){
					newlist.add(proMgrLevel1);
				}
			}
			return getComboboxJson(newlist, selected);
		}
		return getComboboxJson(list, selected);
	}

	// 获取二级科目
	@RequestMapping("/getSubject2")
	@ResponseBody
	public List<ComboboxJson> getSubject2(String parentCode, String selected) {
		List<ProMgrLevel2> list = new ArrayList<ProMgrLevel2>();
		if(!StringUtil.isEmpty(parentCode)){
			list = proMgrLevel2Mng.findByParendCode(parentCode,getUser());
		}
		return getComboboxJson(list, selected);
	}
	// 获取基本支出的二级科目
	@RequestMapping("/getJbzcSubject2")
	@ResponseBody
	public List<ComboboxJson> getJbzcSubject2(String selected,String departId) {
		if(StringUtils.isEmpty(departId)){
			departId=getUser().getDpID();
		}
		List<SysDepartEconomic> departEconomicList= sysDepartEconomicMng.findDistinctByPidAndEjProCode( departId,"","");
		return getComboboxJson(departEconomicList, selected);
	}
	
	// 获取二级科目
	@RequestMapping("/getSubject2ByPm1")
	@ResponseBody
	public List<ComboboxJson> getSubject2ByPm1(String pml, String selected) {
		List<ProMgrLevel2> list = proMgrLevel2Mng.getSubject2ByPml(pml);
		return getComboboxJson(list, selected);
	}

	// 获取二级科目
	@RequestMapping("/getSubBean2")
	@ResponseBody
	public ProMgrLevel2 getSubject2(String code) {
		List<ProMgrLevel2> list = proMgrLevel2Mng.findByProperty("fLevCode2",
				code);
		if (list != null && list.size() != 0) {
			return list.get(0);
		}
		return null;
	}

	// 下载附件
	@RequestMapping(value = "/downFile")
	@ResponseBody
	public Result downFile(String fileName, String type, String savePath,
			ModelMap model, HttpServletResponse response,
			HttpServletRequest request) {
		InputStream is = null;
		OutputStream os = null;
		try {
			// projectMng.downFile(type, fileName, savePath);

			// 下载到服务器
			String path = request.getSession().getServletContext()
					.getRealPath("/resource")
					+ "\\download\\";
			projectMng.downFile(type, fileName, path);
			// 输出流下载
			String filePath = path + fileName;
			response.setHeader("Content-Disposition", "attachment; filename="
					+ new String(fileName.getBytes("gbk"), "iso8859-1"));
			response.setContentType("application/octet-stream;charset=UTF-8");

			is = new FileInputStream(new File(filePath));
			// InputStream is = new FileInputStream(new
			// File("D:"+File.separator+"test"+File.separator+"test.txt"));
			os = response.getOutputStream();

			byte[] b = new byte[2048];
			int length;
			while ((length = is.read(b)) > 0) {
				os.write(b, 0, length);
			}
			// 这里主要关闭。
			os.flush();
			return getJsonResult(true, Result.downSuccessMessage);
		} catch (Exception e) {
			return getJsonResult(false, Result.downFailureMessage);
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	// 附件上传
	@RequestMapping(value = "/uploadFile")
	@ResponseBody
	public boolean uploadFile(String fileurl, String type) {

		boolean flag = false;
		try {
			fileurl = java.net.URLDecoder.decode(fileurl, "UTF-8");
			// 获取文件名
			String[] names = fileurl.split("\\\\");
			String name = names[names.length - 1];
			// 保存文件
			FileUpload fu = new FileUpload();
			String url = fu.getFtpConfig("url");
			int port = Integer.parseInt(fu.getFtpConfig("port"));
			String username = fu.getFtpConfig("username");
			String password = fu.getFtpConfig("password");
			String path = "";
			if ("lxyj".equals(type)) {
				path = "XM\\PROACCO";
			} else if ("ssfa".equals(type)) {
				path = "XM\\PROPLAN";
			}
			String filename = name.trim();
			String input = fileurl.trim();
			if (!StringUtil.isEmpty(path))
				flag = fu.upLoadFromProduction(url, port, username, password,
						path, filename, input);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;

	}

	// 附件删除
	@RequestMapping(value = "/deleteFile")
	@ResponseBody
	public boolean deleteFile(String filename, String type) {

		boolean flag = false;
		try {
			// 获取文件名
			filename = java.net.URLDecoder.decode(filename, "UTF-8");
			String[] names = filename.split("\\\\");
			filename = names[names.length - 1].trim();
			// 删除附件信息
			if ("lxyj".equals(type)) {
				List<TProBasicAccoAttac> acctList = tProBasicAccoAttacMng
						.findByProperty("FAttacName", filename);
				tProBasicAccoAttacMng.batchDelete(acctList);
			} else if ("ssfa".equals(type)) {
				List<TProBasicPlanAttac> acctList = tProBasicPlanAttacMng
						.findByProperty("FAttacName", filename);
				tProBasicPlanAttacMng.batchDelete(acctList);
			}
			// 删除文件
			FileUpload fu = new FileUpload();
			String url = fu.getFtpConfig("url");
			int port = Integer.parseInt(fu.getFtpConfig("port"));
			String username = fu.getFtpConfig("username");
			String password = fu.getFtpConfig("password");
			String path = "";
			if ("lxyj".equals(type)) {
				path = "XM\\PROACCO";
			} else if ("ssfa".equals(type)) {
				path = "XM\\PROPLAN";
			}
			if (!StringUtil.isEmpty(path))
				fu.delFile(url, port, username, password, path, filename);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/*
	 * 制度查找
	 */
	@RequestMapping(value = "/systemFind")
	@ResponseBody
	public String findSystem(Integer id) {
		SystemCenterAttac sca = cheterMng.getSystemCenterAttac(id);
		String fileUrl = sca.getFileSrc() + "/" + sca.getAttacName();

		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		fileUrl = "http://" + url + ":8080/ftp/ff/" + fileUrl;
		return fileUrl;
	}

	/*
	 * ajax 项目库列表 proLibType-四库类型 flowStatus-审批状态
	 */
	@RequestMapping(value = "/ysprojectPageData")
	@ResponseBody
	public JsonPagination ysprojectPageData(TProBasicInfo bean, String sbkLx,
			Integer page, Integer rows) {

		if (page == null) {
			page = 1;
		}
		if (rows == null) {
			rows = SimplePage.DEF_COUNT;
		}
		// //区分四库
		bean.setFProLibType("2");
		Pagination p = projectMng
				.yspageList(bean, getUser(), page, rows, sbkLx);
		// 加入排序号
		List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page * rows + i - 9);
			}
		}
		return getJsonPagination(p, page);
	}

	/*
	 * ajax 项目库列表 proLibType-四库类型 flowStatus-审批状态
	 */
	@RequestMapping(value = "/yxprojectPage")
	@ResponseBody
	public JsonPagination yxprojectPage(TProBasicInfo bean, String sbkLx,
			Integer page, Integer rows) {

		if (page == null) {
			page = 1;
		}
		if (rows == null) {
			rows = SimplePage.DEF_COUNT;
		}
		// //区分四库
		bean.setFProLibType("2");
		Pagination p = projectMng
				.yspageList(bean, getUser(), page, rows, sbkLx);
		// 加入排序号
		List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TProBasicInfo pro = list.get(i);
				pro.setPageOrder(page * rows + i - 9);
			}
		}
		return getJsonPagination(p, page);
	}

	/** 叶添加的 **/
	/*
	 * 跳转二上修改控制树大于预算的项目页面
	 * 
	 * @author 叶崇晖
	 * 
	 * @createtime 2018-09-27
	 * 
	 * @updatetime 2018-09-27
	 */
	@RequestMapping(value = "/esedit/{id}")
	public String esedit(@PathVariable Integer id, ModelMap model) {
		try {
			TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
			// 操作类型
			model.addAttribute("operation", "essb");

			// 查询附件信息
			List<Attachment> attaList = attachmentMng.list(pro);
			model.addAttribute("attaList", attaList);

			// 字段信息
			model.addAttribute("projectCode", pro.getFProCode());// 项目编号
			model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
			model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
			if (pro.getFProAppliTime() != null)
				model.addAttribute("sbsj",
						new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
			model.addAttribute("processCode", TProcessDefin.PROAPPLY);// 流程code
			model.addAttribute("level", pro.getFFlowStauts());// 当前项目审批进度
			model.addAttribute("bean", pro);// 项目实体

			// 查询制度中心文件
			List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
			model.addAttribute("cheterInfo", cheterInfo);
			String ywfw = "ESSB";
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(pro.getUserId(),ywfw, pro.getFProAppliDepartId(),pro.getBeanCode(),pro.getFExt11(),pro.getJoinTable(),  pro.getBeanCodeField(), pro.getFProCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			// 建立工作流发起人的信息
			Proposer proposer = new Proposer(pro.getFProAppliPeople(),pro.getFProAppliDepart(), pro.getFProAppliTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, pro.getFProAppliDepartId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",pro.getBeanCode());		
			return "/WEB-INF/view/budget/project/project-essb-edit";
		} catch (Exception e) {
			e.printStackTrace();
			return "/WEB-INF/view/budget/project/project-essb-edit";
		}
		
	}

	@RequestMapping(value = "/export")
	public String export(ModelMap model, HttpServletResponse response,
			HttpServletRequest request, TProBasicInfo project) {
		
		OutputStream out = null;
		try {
			// 初始化
			response.setHeader("Content-Disposition", "attachment; filename="
					+ new String("项目库台账".getBytes("gbk"), "iso8859-1") + ".xls");
			out = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\项目库台账.xls";
			//转码
			/*String	FProAppliDepart=StringUtil.setUTF8(project.getFProAppliDepart());
			String	fproName=StringUtil.setUTF8(project.getFProName());
			project.setFProAppliDepart(FProAppliDepart);
			project.setFProName(fproName);*/
			// 获得数据
			Pagination p = projectMng.pageList(project, getUser(),
					hasRole("OFFICE"), 1, 10000);
			List<TProBasicInfo> dataList = (List<TProBasicInfo>) p.getList();
			if (dataList != null && dataList.size() > 0) {
				for (int i = 0; i < dataList.size(); i++) {
					TProBasicInfo pro = dataList.get(i);
					pro.setPageOrder(i + 1);
				}
			}
			
			// 生成excel并导出
			HSSFWorkbook workbook = projectMng.exportExcel(dataList, filePath);
			
			if (workbook == null) {
				out.flush();
				return null;
			}
			workbook.write(out);
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	private String getXmkSavePath() {
		return FileUpLoadUtil.getRootPath() + FileUpLoadUtil.getXmkSavePath();
	}

	/**
	 * 弹出项目支出明细导入页面
	 * 
	 * @author 叶崇晖
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/outcomeImput")
	public String outcomeImput(ModelMap model,String fProOrBasic) {
		model.addAttribute("fProOrBasic", fProOrBasic);
		return "/WEB-INF/view/budget/project/project-add-outcome-imput";
	}

	/**
	 * 读取导入的模板文件
	 * 
	 * @author 叶崇晖
	 * @param xlsx
	 * @return
	 */
	@RequestMapping(value = "/outcomeCollect")
	@ResponseBody
	public List<TProExpendDetail> outcomeCollect(MultipartFile xlsx) {
		List<TProExpendDetail> list = new ArrayList<TProExpendDetail>();
		InputStream ins = null;
		OutputStream os = null;
		try {
			File f = null;
			if (xlsx.equals("") || xlsx.getSize() <= 0) {
				xlsx = null;
			} else {
				ins = xlsx.getInputStream();
				f = new File(xlsx.getOriginalFilename());
				os = new FileOutputStream(f);
				int bytesRead = 0;
				byte[] buffer = new byte[8192];
				while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
					os.write(buffer, 0, bytesRead);
				}
				File file = new File(f.toURI());
				list = projectMng.outcomeCollect(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (ins != null) {
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return list;

	}

	/**
	 * 支出明细模板下载
	 * 
	 * @author 叶崇晖
	 * @param response
	 * @return
	 */
	@RequestMapping("/outcomeDownload")
	@ResponseBody
	public Result download(HttpServletResponse response) {
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\支出明细模板.xlsx";
			File file = new File(filePath);
			/* File file = new File("D:/项目申报支出明细模板.xlsx"); */
			if (file.exists()) {
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition",
						"attachment; filename=\""
								+ new String("支出明细模板.xlsx".getBytes("gbk"),
										"iso8859-1") + "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a;
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			} else {
				return getJsonResult(false, "文件不存在！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return getJsonResult(false, "出现错误,请联系管理员！");
		} finally {
			try {
				if (out != null)
					out.close();
				if (in != null)
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true, "操作成功！");
	}

	@RequestMapping("/jxIndex")
	@ResponseBody
	public List<GoalDetailModel> jxIndex(Integer id) {
		// 查询项目绩效目标明细
		/*List<TProGoalDetail> goaDetailList = tProGoalDetailMng
				.getMingxi(Integer.valueOf(id));*/
		List<GoalDetailModel> li = new ArrayList<GoalDetailModel>();
		/*for (int i = 0; i < goaDetailList.size(); i++) {
			GoalDetailModel model = new GoalDetailModel();
			model.setLongName1(goaDetailList.get(i).getLongName1());
			model.setLongCode1(goaDetailList.get(i).getLongCode1());
			model.setLongName2(goaDetailList.get(i).getLongName2());
			model.setLongCode2(goaDetailList.get(i).getLongCode2());
			model.setLongName3(goaDetailList.get(i).getLongName3());
			model.setLongAmount3(goaDetailList.get(i).getLongAmount3());
			model.setMidAmount3(goaDetailList.get(i).getMidAmount3());
			li.add(model);
		}*/

		return li;
	}

	/*
	 * 上传附件
	 * 
	 * @author zhangxun
	 * 
	 * @createtime 2018-10-31
	 * 
	 * @updatetime 2018-10-31
	 */
	@RequestMapping("/uploadAtt")
	@ResponseBody
	public Result uploadAtt(
			ModelMap model,
			String serviceType,
			@RequestParam(value = "attFiles", required = false) MultipartFile[] attFiles) {

		try {
			// 保存附件到服务器
			String ids = attachmentMng.uploadAjax(attFiles, serviceType,
					FileUpLoadUtil.getXmkSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}

	/*
	 * 审批意见页面跳转
	 * 
	 * @author 叶崇晖
	 * 
	 * @createtime 2018-09-26
	 * 
	 * @updatetime 2018-09-26
	 */
	@RequestMapping("/checkRemake")
	public String checkRemake(String type, String result, String data1,
			ModelMap model,String listid) {
		model.addAttribute("listid", listid);
		model.addAttribute("type", type);
		model.addAttribute("result", result);
		model.addAttribute("data1", data1);
		model.addAttribute("currentUser", getUser());
		model.addAttribute("time",
				new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
		if ("xmsb".equals(type)) {
			return "/WEB-INF/view/budget/project/project-check-remake";
		}
		return "";
	}

	/*
	 * 审批记录
	 * 
	 * @author 叶崇晖
	 * 
	 * @createtime 2018-11-28
	 * 
	 * @updatetime 2018-11-28
	 */
	@RequestMapping("/history")
	@ResponseBody
	public List<TProcessCheck> history(Integer id, String type, ModelMap model) {
		List<TProcessCheck> historyList = new ArrayList<TProcessCheck>();
			historyList = tProCheckInfoMng.getCheckList(id, type, null);
		return historyList;
	}
	
	
	/*
	 * 审批记录附件查询
	 * 
	 * @author 叶崇晖
	 * 
	 * @createtime 2018-11-28
	 * 
	 * @updatetime 2018-11-28
	 */
	@RequestMapping("/historyAttaList")
	@ResponseBody
	public List<Attachment> historyAttaList(String id, ModelMap model) {
		List<Attachment> attaList = attachmentMng.findByIdS(id);
		return attaList;
	}
	/**
	 * 
	 * @Description: 评审记录附件查询
	 * @param @param id
	 * @param @param model
	 * @param @return   
	 * @return List<Attachment>  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月17日
	 */
	@RequestMapping("/historyAttaListEntryIdS")
	@ResponseBody
	public List<Attachment> historyAttaListEntryIdS(String id, ModelMap model) {
		List<Attachment> attaList = attachmentMng.findEntryIdS(id);
		return attaList;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: fundssource 
	* @Description: 资金来源
	* @param FProId
	* @return
	* @return JsonPagination    返回类型 
	* @date： 2019年10月9日下午4:26:57 
	* @throws
	 */
	@RequestMapping(value = "/fundssource")
	@ResponseBody
	public JsonPagination fundssource(Integer FProId) {
		//Source of funds
		try {
			Pagination p = new Pagination();
			//查询资金来源信息
			List<TProBasicFunds> mingxiList = tProBasicFundsMng.findByProperty("FProId", FProId);
			for(int i=0;i<mingxiList.size();i++){
				mingxiList.get(i).setNum(i+1);
			}
			p.setList(mingxiList);
			p.setPageNo(1);
			p.setPageSize(mingxiList.size());
			p.setTotalCount(100);
			return getJsonPagination(p, 1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	/**
	 * 根据项目id获取绩效指标
	 * @param fProId
	 * @return
	 */
	@RequestMapping(value = "/proIndexList")
	@ResponseBody
	public JsonPagination proIndexList(Integer fProId) {
		try {
			Pagination p = new Pagination();
			//查询资金来源信息
			List<PerformanceIndicatorModel>list = performancModelMng.findByProperty("fProId", fProId);
			for(int i=0;i<list.size();i++){
				PerformanceIndicatorModel bean = (PerformanceIndicatorModel)list.get(i);
				bean.setNum(i+1);
			}
			p.setList(list);
			return getJsonPagination(p, 0);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	
	/**
	 * 
	* @author:安达
	* @Title: reCall 
	* @Description: 撤回
	* @param id
	* @return
	* @return Result    返回类型 
	* @date： 2019年10月9日下午4:26:48 
	* @throws
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			TProBasicInfo bean = projectMng.findById(Integer.valueOf(id));
			Boolean tof = tProcessCheckMng.findbyCode(bean.getFProCode(), "0");
			if(tof){
				return getJsonResult(false,"该申请已经被审批，不得撤回！");
			}else {
				projectMng.reCall(id,getUser());
				return getJsonResult(true, "操作成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	
	/**
	 * @Description: 合同付款申请退回
	 * @param @param id
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 崔敬贤
	 * @date 2019年10月8日
	 */
	@RequestMapping(value = "/ProReCall")
	@ResponseBody
	public Result proReCall(Integer id) {
		try {
			//传回来的id是主键
			projectMng.proReCall(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"撤回失败，请联系管理员！");
		}
		return getJsonResult(true,"撤回成功！");	
	}
	
	@RequestMapping("/refreshProcess")
	public String rerefreshProcess(TProBasicInfo bean,String proOrBasic,String fpId,ModelMap model){
		User user1 = getUser();
		User user = new User();
		try {
			BeanUtils.copyProperties(user, user1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//鉴别部门
		if(!StringUtil.isEmpty(bean.getFProAppliDepartId())){
			Depart depart = departMng.findById(bean.getFProAppliDepartId());
			user.setDepart(depart );
		}
		if("0".equals(proOrBasic)){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"JBZCSB", user.getDpID(),null,bean.getFExt11(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getFProCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("JBZCSB", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(user.getName(), user.getDepartName(),null);
			model.addAttribute("proposer", proposer);
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("JBZCSB",bean.getFProAppliDepartId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}else if("1".equals(proOrBasic)){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"XMSB", getUser().getDpID(),null,bean.getFExt11(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFProCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("XMSB", getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
			model.addAttribute("proposer", proposer);
			//历史审批节点
			String historyNodes=tProcessCheckMng.getHistoryNodes("XMSB",bean.getFProAppliDepartId(),bean.getBeanCode());
			model.addAttribute("historyNodes", historyNodes);
			return "/WEB-INF/view/check_system";
		}
		return null;
	}
	
	/**
	 * 
	 * @Description: 修改选中项的收报状态
	 * @author 汪耀
	 * @param @param sbIdList
	 * @param @param fExportStauts
	 * @param @return    
	 * @return Result
	 */
	@RequestMapping("/receiveReport")
	@ResponseBody
	public Result receiveReport(String receiveIdList, String fExportStauts) {
		try {
			projectMng.receiveReport(receiveIdList, fExportStauts);
			return getJsonResult(true, "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
	}
	
	/**
	 * 
	 * @Description: 校验二级分类名称是否重复
	 * @author 汪耀
	 * @param @param proId
	 * @param @param year
	 * @param @param name
	 * @param @return    
	 * @return Result
	 */
	@RequestMapping("/checkSecondLevelName")
	@ResponseBody
	public Result checkSecondLevelName(String year, String code, String FProCode){
		try {
			boolean flag; 
			if(!StringUtil.isEmpty(FProCode)){
				TProBasicInfo bean = projectMng.findbyCode(FProCode);
				flag = projectMng.checkSecondLevelName(bean.getFProAppliDepartId(), year, code, FProCode);
			}else {
				flag = projectMng.checkSecondLevelName(getUser().getDpID(), year, code, FProCode);
			}
			if(flag){
				return getJsonResult(true, "二级分类名称未重复！");
			}else {
				return getJsonResult(false, "二级分类名称重复！");
			}
		} catch (Exception e) {
			
		}
		return null;
	}

	/**
	 * 跳转到打印页面
	 * @param id 申报信息主见ID
	 * @param model
	 * @return 跳转到project-print.jsp
	 * @author 陈睿超
	 * @createTime2019年11月6日
	 * @updateTime2019年11月6日
	 */
	@RequestMapping("/print")
	public String print(String id ,ModelMap model,String openType){
		TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
		// 操作类型
		model.addAttribute("operation", "edit");
		// 查询附件信息
		List<Attachment> attaList = attachmentMng.list(pro);
		model.addAttribute("attaList", attaList);
		// 字段信息
		model.addAttribute("projectCode", pro.getFProCode());// 项目编号
		model.addAttribute("sbr", pro.getFProAppliPeople());// 申报人
		model.addAttribute("sbbm", pro.getFProAppliDepart());// 申报部门
		if (pro.getFProAppliTime() != null)
			model.addAttribute("sbsj",
					new SimpleDateFormat("yyyy").format(pro.getFProAppliTime()));// 申报时间
		model.addAttribute("processCode", TProcessDefin.PROAPPLY);// 流程code
		model.addAttribute("level", pro.getFFlowStauts());// 当前项目审批进度
		
		//查询资金来源信息
		List<TProBasicFunds> mingxiList = tProBasicFundsMng.findByProperty("FProId", pro.getFProId());
		TProBasicFunds proBasicFunds = mingxiList.get(0);
		String fundsSourceText = proBasicFunds.getFundsSourceText();//资金来源名称
		model.addAttribute("fundsSourceText", fundsSourceText);
		
		// 查询项目支出明细
		List<TProExpendDetail> expDetailList = tProExpendDetailMng.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);

		model.addAttribute("bean", pro);// 项目实体
		if("0".equals(openType)){
			//基本支出
			return "/WEB-INF/view/budget/project/project-print-two";
		}else if("1".equals(openType)){
			//项目支出
			return "/WEB-INF/view/budget/project/project-print";
		}
		return null;
	}
	
	/**
	 * 
	 * @Description: 项目申报页面导出
	 * @author 汪耀
	 * @param @param model
	 * @param @param response
	 * @param @param request
	 * @param @param id
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/proExport")
	public String proExport(ModelMap model, HttpServletResponse response, HttpServletRequest request, String id){
		OutputStream out = null;
		try {
			// 初始化
			response.setHeader("Content-Disposition", "attachment; filename=" + new String("项目申报明细模板".getBytes("gbk"), "iso8859-1") + ".xls");
			out = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath = path + "\\download\\项目申报明细模板.xls";
			
			//项目基本信息
			TProBasicInfo bean = projectMng.findById(Integer.valueOf(id));
			//资金来源
			List<TProBasicFunds> tpbfList = tProBasicFundsMng.getByProId(bean.getFProId()); 
			//项目支出绩效目标
			List<PerformanceIndicatorModel> pimList = performancModelMng.getByProId(bean.getFProId());
			//项目支出明细
			List<TProExpendDetail> tpedList = tProExpendDetailMng.getByProId(bean.getFProId());
			
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), "XMSB", bean.getFProAppliDepartId(), bean.getBeanCode(), bean.getFExt11(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFProCode(), "1");
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("XMSB", bean.getFProAppliDepartId());
			//审批记录
			List<TProcessCheck> tpcList =  tProcessCheckMng.checkHistory(tProcessDefin.getFPId(), bean.getFProCode());
			
			// 生成excel并导出
			HSSFWorkbook wb = projectMng.proExportExcel(bean, tpbfList, pimList, tpedList, tpcList, filePath);
			if (wb == null) {
				out.flush();
				return null;
			}
			wb.write(out);
			out.flush();
		} catch (Exception e) {
			
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					
				}
			}
		}
		return null;
	}
	
	/**
	 * 
	 * @Description: 基本支出申报页面导出
	 * @author 汪耀
	 * @param @param model
	 * @param @param response
	 * @param @param request
	 * @param @param id
	 * @param @return    
	 * @return String
	 */
	@RequestMapping(value = "/basicExpenditureExport")
	public String basicExpenditureExport(ModelMap model, HttpServletResponse response, HttpServletRequest request, String id){
		OutputStream out = null;
		try {
			// 初始化
			response.setHeader("Content-Disposition", "attachment; filename=" + new String("基本支出申报明细模板".getBytes("gbk"), "iso8859-1") + ".xls");
			out = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath = path + "\\download\\基本支出申报明细模板.xls";
			
			//基本支出信息
			TProBasicInfo bean = projectMng.findById(Integer.valueOf(id));
			//资金来源
			List<TProBasicFunds> tpbfList = tProBasicFundsMng.getByProId(bean.getFProId()); 
			//基本支出明细
			List<TProExpendDetail> tpedList = tProExpendDetailMng.getByProId(bean.getFProId());
			
			//查询工作流
			List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), "JBZCSB", bean.getFProAppliDepartId(), bean.getBeanCode(), bean.getFExt11(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFProCode(), "1");
			//得到工作流id
			TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode("JBZCSB", bean.getFProAppliDepartId());
			//审批记录
			List<TProcessCheck> tpcList =  tProcessCheckMng.checkHistory(tProcessDefin.getFPId(), bean.getFProCode());
			
			// 生成excel并导出
			HSSFWorkbook wb = projectMng.basicExpenditureExport(bean, tpbfList, tpedList, tpcList, filePath);
			if (wb == null) {
				out.flush();
				return null;
			}
			wb.write(out);
			out.flush();
		} catch (Exception e) {
			
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					
				}
			}
		}
		return null;
	}
	
	/**
	 * 跳转到项目申报审批记录
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月13日
	 * @updateTime2019年11月13日
	 */
	@RequestMapping("/approvalRecordlist")
	public String approvalRecordlist(ModelMap model){
		
		return "/WEB-INF/view/budget/project/project-record-list";
	}
	
	/**
	 * 跳转到审批记录页面
	 * @param model
	 * @param pro
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月13日
	 * @updateTime2019年11月13日
	 */
	@ResponseBody
	@RequestMapping("/recordProjectPage")
	public JsonPagination recordProjectPage(ModelMap model,TProcessCheck bean,String sort,String order,Integer page,Integer rows){
		
		Pagination p = projectMng.record(bean,getUser(),page,rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description: 审批页面的修改记录
	 * @author 汪耀
	 * @param @param model
	 * @param @param id
	 * @param @return    
	 * @return String
	 */
	@RequestMapping("/checkUpdateRecord")
	public String checkUpdateRecord(ModelMap model, Integer id){
		model.addAttribute("proId", id);//项目id
		return "/WEB-INF/view/budget/project/detail/project-verdict-update";
	}
	
	/**
	 * 
	 * @Description: 修改记录的分页查询
	 * @author 汪耀
	 * @param @param bean
	 * @param @param page
	 * @param @param rows
	 * @param @return    
	 * @return JsonPagination
	 */
	@RequestMapping(value = "/checkUpdatePage")
	@ResponseBody
	public JsonPagination checkUpdatePage(TProBasicCheckUpdate bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = projectMng.checkUpdatePageList(bean, page, rows);
    	List<TProBasicCheckUpdate> list = (List<TProBasicCheckUpdate>) p.getList();
    	for(int i=0; i<list.size(); i++) {
			//序号设置	
    		list.get(i).setNum((i+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/**
	 * 通过项目id  获取基本支出明细
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月4日
	 */
	@RequestMapping(value = "/findByfProIdGetDetail")
	@ResponseBody
	public JsonPagination findByfProIdGetDetail(Integer id, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		List<TProExpendDetail> expDetailList = tProExpendDetailMng.getByProId(id);
		Pagination p = new Pagination();
		p.setList(expDetailList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 通过项目id  获取政府采购明细
	 * <p>Description: </p>
	 * <p>Company: </p> 
	 * @author zml
	 * @date 2021年6月4日
	 */
	@RequestMapping(value = "/findByfProIdGetPur")
	@ResponseBody
	public JsonPagination findByfProIdGetPur(Integer id, Integer page, Integer rows,String fIfSoftware){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		List<TGovernmentPurchaseDetail> expDetailList = tGovernmentPurchaseDetailMng.getByProId(id,fIfSoftware);
		Pagination p = new Pagination();
		p.setList(expDetailList);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 加载大项目信息
	 */
	@RequestMapping(value = "/bigProlookupsJson")
	@ResponseBody
	public List<ComboboxJson> bigProlookupsJson(String selected){
		List<Lookups> list = projectMng.getBigProjectLookupsJson(selected);
		return getComboboxJson1(list,selected);
	}
	
	/**
	 * 
	 * @Description: 子项目选择列表分页查询
	 * @author 沈帆
	 * @param @param bean
	 * @param @param page
	 * @param @param rows
	 * @param @return    
	 * @return JsonPagination
	 */
	@RequestMapping(value = "/zxmPage")
	@ResponseBody
	public JsonPagination zxmPage(TProBasicInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	User user =getUser();
    	Pagination p = projectMng.zxmList(bean, page, rows,user);
    	List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
    	for(int i=0; i<list.size(); i++) {
			//序号设置	
    		list.get(i).setPageOrder((i+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/**
	 * 
	 * <p>Title: setAddAndCheckTime</p>  
	 * <p>Description:跳转到一上设置时间 </p>  
	 * @param model
	 * @param id 配置主键id
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	@RequestMapping("/setAddAndCheckTime")
	public String setAddAndCheckTime(ModelMap model, Integer id, Integer fDataType){
		AddAndCheckTime bean = new AddAndCheckTime();
		if(!StringUtil.isEmpty(String.valueOf(id))){
			bean = addAndCheckTimeMng.findById(id);
		}else {
			bean.setfDataType(fDataType);
		}
		model.addAttribute("bean", bean);//项目id
		return "/WEB-INF/view/budget/project/project-settime";
	}
	
	
	/**
	 * <p>Title: saveAddAndCheckTime</p>  
	 * <p>Description: 保存</p>  
	 * @param bean
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	@ResponseBody
	@RequestMapping("/saveAddAndCheckTime")
	public Result saveAddAndCheckTime(AddAndCheckTime bean){
		try {
			User user = getUser();
			addAndCheckTimeMng.save(bean, user);
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	/**
	 * 
	 * <p>Title: verifyToCheckTime</p>  
	 * <p>Description: 校验是否超过申报日期范围</p>  
	 * @param bean
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	@ResponseBody
	@RequestMapping("/verifyToCheckTime")
	public Boolean verifyToCheckTime(AddAndCheckTime bean, Integer addorupdate, ModelMap model){
		return addAndCheckTimeMng.verifyToCheckTime(bean);
	}
	
	/**
	 * 
	 * <p>Title: verifyToCheckTime</p>  
	 * <p>Description: 校验是否超过审批日期范围</p>  
	 * @param bean
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	@ResponseBody
	@RequestMapping("/verifyCheckTime")
	public Boolean verifyCheckTime(AddAndCheckTime bean,ModelMap model){
		return addAndCheckTimeMng.verifyCheckTime(bean);
	}
	
	/**
	 * 
	 * <p>Title: verifyToCheckTime</p>  
	 * <p>Description: 校验是否超过修改日期范围</p>  
	 * @param bean
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	@ResponseBody
	@RequestMapping("/verifyUpdateTime")
	public Boolean verifyUpdateTime(AddAndCheckTime bean,ModelMap model){
		return addAndCheckTimeMng.verifyUpdateTime(bean);
	}
	
	
	
	/*
	 * 导入子项目
	 * 
	 */
	@RequestMapping("/importZxm")
	@ResponseBody
	public Result importZxm(String ids) {
		
		try {
			ids = ids.substring(0,ids.length() - 1);
			String[] proIds = ids.split(",");
			for (String id: proIds) {
				projectMng.importZxm(Integer.valueOf(id), getUser());// 保存项目
			}
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}
	
	
	/**
	 * 
	 * @Title checkList 
	 * @Description 审批附件列表列表页面
	 * @author 赵孟雷
	 * @Date 2020年9月4日 
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 */
	@RequestMapping(value = "/historyAttaListJsp")
	public String historyAttaListJsp(ModelMap model,String id) {
		model.addAttribute("id", id);
		return "/WEB-INF/view/check_history_files";
	}
	
	/**
	 * 
	 * <p>Title: chooseFProHead</p>  
	 * <p>Description: 调后转到选择项目负责人界面</p>  
	 * @param model
	 * @return choose_fprohead.jsp
	 * @author 陈睿超
	 * @createtime 2020年10月30日
	 * @updator 陈睿超
	 * @updatetime 2020年10月30日
	 */
	@RequestMapping(value = "/chooseFProHead")
	public String chooseFProHead(ModelMap model) {
		return "/WEB-INF/view/budget/project/choose_fprohead";
	}

	
	/**
	 * 获取一采多年数据列表
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月10日
	 */
	@RequestMapping(value = "/getPurchaseManyYearsPro")
	@ResponseBody
	public JsonPagination getPurchaseManyYearsPro(TPurchaseManyYearsPro bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	User user =getUser();
    	Pagination p = tPurchaseManyYearsProMng.getPurchaseManyYearsPro(bean, page, rows,user);
    	return getJsonPagination(p, page);
	}
	
	
	public static void main(String args[]){
        String[] a = {"01", "02", "03", "04","05"};
        String[] b = {"01", "05", "03"};
        System.out.println("isContains = " + isContains(a, b));
    }

    private static boolean isContains(String[] a,String[] b) {
        List<String> listA = Arrays.asList(a);
        List<String> listB = Arrays.asList(b);
        return listA.containsAll(listB);
    }
    
    
	/**
	 * 资金来源树查询
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,ModelMap model) {
		try {
			// 内容。取所有列表，找出父菜单。
			List<TCapitalSourceMatter> lists=null;
			if(null==id){
				lists = tcapitalSourceMatterMng.findByProperty("parent", 0);
			}else{
				lists = tcapitalSourceMatterMng.findByProperty("parent", Integer.valueOf(id));
			}
			List<TreeEntity> list=new ArrayList<TreeEntity>();
			if(null!=lists && lists.size()>0){
				for(TCapitalSourceMatter f:lists){
					TreeEntity ft=new TreeEntity();
					ft.setId(String.valueOf(f.getCsmId()));
					ft.setText(f.getCsmName());
					if(!tcapitalSourceMatterMng.findByProperty("parent", 0).isEmpty()){
						ft.setState("closed");
					}else{
						ft.setLeaf(true);
					}
					list.add(ft);
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	
	/**
	* <p>Description:导出绩效目标申报 </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月20日
	 */
	@RequestMapping(value = "/exportPerformance")
	public String exportPerformance(ModelMap model, HttpServletResponse response,
			HttpServletRequest request, String proId,String jsonPerformance) {
		
		OutputStream out = null;
		try {
			// 初始化
			if(StringUtils.isNotEmpty(proId)){
				TProBasicInfo bean = projectMng.findById(Integer.valueOf(proId));
				String proName = bean.getFProName()+"绩效目标申报表";
				response.setHeader("Content-Disposition", "attachment; filename="
						+ new String(proName.getBytes("gbk"), "iso8859-1") + ".xls");
			}else{
				response.setHeader("Content-Disposition", "attachment; filename="
						+ new String("绩效目标申报表".getBytes("gbk"), "iso8859-1") + ".xls");
			}
			out = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\绩效目标申报表.xls";
			List<PerformanceIndicatorModel> performanceIndicatorModelList = new ArrayList<PerformanceIndicatorModel>();
			if(!StringUtil.isEmpty(jsonPerformance)){
				//获取绩效明细的Json对象
				performanceIndicatorModelList = JSON.parseObject("["+jsonPerformance+"]",new TypeReference<List<PerformanceIndicatorModel>>(){});
			}
			
			// 生成excel并导出
			HSSFWorkbook workbook = projectMng.exportExcePerformance(performanceIndicatorModelList, filePath);
			
			if (workbook == null) {
				out.flush();
				return null;
			}
			workbook.write(out);
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
}
