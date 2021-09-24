package com.braker.icontrol.budget.knot.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.icontrol.budget.knot.entity.TPorjectKnot;
import com.braker.icontrol.budget.knot.manager.PorjectKnotMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Controller
@RequestMapping("/projectknot")
public class PorjectKnotController extends BaseController{
	@Autowired
	private PorjectKnotMng porjectKnotMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	
	/**
	 * /projectknot/list
	* @author:安达
	* @Title: list 
	* @Description:项目完结审批列表
	* @param model
	* @param proLibType
	* @param sbkLx
	* @return
	* @return String    返回类型 
	* @date： 2019年6月12日下午9:44:06 
	* @throws
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String proLibType, String sbkLx) {
		return "/WEB-INF/view/budget/project/project-knot-check-list";
	}
	/**
	 * /projectknot/JsonPagination
	* @author:安达
	* @Title: jsonPagination 
	* @Description: 查询
	* @param bean
	* @param sort
	* @param order
	* @param page
	* @param rows
	* @param model
	* @return
	* @return JsonPagination    返回类型 
	* @date： 2019年6月11日下午10:12:00 
	* @throws
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(TProBasicInfo bean,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = porjectKnotMng.pageList(bean,getUser(), page, rows);
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
	}
	/**
	 * /projectknot/knot
	* @author:安达
	* @Title: add 
	* @Description: 跳转到新增
	* @param model
	* @param id
	* @param request
	* @return
	* @return String    返回类型 
	* @date： 2019年6月11日下午10:11:50 
	* @throws
	 */
	@RequestMapping("/knot")
	public String knot(ModelMap model,String id, HttpServletRequest request){
		try {
			model.addAttribute("operType", "add");
			TProBasicInfo pro = projectMng.findById(Integer.valueOf(id));
			TPorjectKnot bean = new TPorjectKnot();
			//获取当前登录对象获得申请部门
			bean.setFreqDept(getUser().getDepartName());
			bean.setFreqDeptId(getUser().getDepart().getId());
			bean.setFreqUserName(getUser().getName());	
			bean.setFreqUserId(getUser().getId());	
			bean.setFProCode(pro.getFProCode());
			bean.setFProId(pro.getBeanId());
			bean.setFProName(pro.getFProName());
			bean.setFirstLevelCode(pro.getFirstLevelCode());
			bean.setFProBudgetAmount(pro.getFProBudgetAmount());
			//申请日期
			bean.setFreqTime(new Date());
			bean.setProEndTime(new Date());
			/*String planStartYear=pro.getPlanStartYear();
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.YEAR, Integer.parseInt(planStartYear));
			calendar.set(Calendar.MONTH, 1);
			calendar.set(Calendar.DATE, 1);
			Calendar.getInstance().getTimeInMillis();
			bean.setProBeginTime(calendar.getTime());*/
			//自动生成标号
			String str="JX";
			bean.setFKnotCode(StringUtil.Random(str));	
			TBudgetIndexMgr index = budgetIndexMgrMng
					.findByIndexCode(pro.getFProCode());// 根据项目编码查询相应的指标
			BigDecimal pfAmount = index.getPfAmount();
			BigDecimal syAmount = index.getSyAmount();
			BigDecimal djAmount = index.getDjAmount();
			syAmount.setScale(2, RoundingMode.HALF_UP);
			BigDecimal efficiency = (BigDecimal.ONE.subtract(syAmount.divide(pfAmount,BigDecimal.ROUND_HALF_UP))).multiply(BigDecimal.valueOf(100));

			/*BigDecimal bg1 = efficiency;
			efficiency = bg1.setScale(2, BigDecimal.ROUND_HALF_UP);*/

			bean.setFProEfficiency(efficiency);
			
			BigDecimal value1=pfAmount.subtract(syAmount);
			BigDecimal outAmount=value1.subtract(djAmount);
			bean.setFProOutAmount(outAmount);
			model.addAttribute("djAmount", 0);
			if(djAmount.compareTo(BigDecimal.ZERO)==1){
				model.addAttribute("djAmount", djAmount);
			}
			
			model.addAttribute("bean", bean);
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"JXSQ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/budget/project/project-knot-add";
		} catch (Exception e) {
			return getException(e);
			//return "/WEB-INF/view/budget/project/project-knot-add";
		}
		
	}
	/**
	 * /projectknot/edit
	* @author:安达
	* @Title: edit 
	* @Description: 修改
	* @param model
	* @param id
	* @param request
	* @return
	* @return String    返回类型 
	* @date： 2019年6月11日下午10:11:43 
	* @throws
	 */
	@RequestMapping("/edit")
	public String edit(ModelMap model,String id,String proId, HttpServletRequest request){
		TPorjectKnot bean =new TPorjectKnot();
		if(StringUtil.isEmpty(id)){
			List<TPorjectKnot> knotList=porjectKnotMng.findByProperty("FProId", Integer.parseInt(proId));
			if(knotList!=null && knotList.size()>0){
				bean=knotList.get(0);
			}
		}else{
			bean = porjectKnotMng.findById(Integer.valueOf(id));
		}
		model.addAttribute("openType", "edit");
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("项目申报");
		model.addAttribute("cheterInfo", cheterInfo);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"JXSQ", getUser().getDpID(),null,bean.getnCode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getFKnotCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqUserName(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/budget/project/project-knot-add";
	}
	/**
	 * /projectknot/check
	* @author:安达
	* @Title: check 
	* @Description: 跳转审核页面
	* @param id
	* @param model
	* @return
	* @return String    返回类型 
	* @date： 2019年6月11日下午10:11:24 
	* @throws
	 */
	@RequestMapping("/check")
	public String check(String id ,ModelMap model) {
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

		//model.addAttribute("listid", listid);
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
		/*List<TProExpendDetail> expDetailList = tProExpendDetailMng
				.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);*/
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
		
		return "/WEB-INF/view/budget/project/detail/project-transfer-check";
	}

	
	/**
	 * /projectknot/save
	* @author:安达
	* @Title: save 
	* @Description: 结项申请保存和送审
	* @param bean
	* @param dc
	* @param dr
	* @return
	* @return Result    返回类型 
	* @date： 2019年6月20日下午2:56:23 
	* @throws
	 */
	@RequestMapping("/save")
	@ResponseBody
	//public Result save(TPorjectKnot bean, String operType, String files) {
	public Result save(Integer fkId,Integer FProId,Date proBeginTime,Date proEndTime ,String FProMemo,String flowStauts, String operType, String files) {
		try {
			TProBasicInfo pro = projectMng.findById(FProId);
			TPorjectKnot bean = new TPorjectKnot();
			//获取当前登录对象获得申请部门
			bean.setFreqDept(getUser().getDepartName());
			bean.setFreqDeptId(getUser().getDepart().getId());
			bean.setFreqUserName(getUser().getName());	
			bean.setFreqUserId(getUser().getId());	
			bean.setFProCode(pro.getFProCode());
			bean.setFProId(pro.getBeanId());
			bean.setFProName(pro.getFProName());
			bean.setFirstLevelCode(pro.getFirstLevelCode());
			bean.setFProBudgetAmount(pro.getFProBudgetAmount());
			//申请日期
			bean.setFreqTime(new Date());
			//自动生成标号
			String str="JX";
			bean.setFKnotCode(StringUtil.Random(str));	
			TBudgetIndexMgr index = budgetIndexMgrMng
					.findByIndexCode(pro.getFProCode());// 根据项目编码查询相应的指标
			BigDecimal pfAmount = index.getPfAmount();
			BigDecimal syAmount = index.getSyAmount();
			BigDecimal djAmount = index.getDjAmount();
			BigDecimal efficiency = (BigDecimal.ONE.subtract(syAmount.divide(pfAmount))).multiply(BigDecimal.valueOf(100));

			efficiency = efficiency.setScale(2, BigDecimal.ROUND_HALF_UP);

			bean.setFProEfficiency(efficiency);
			bean.setFProOutAmount(pfAmount.subtract(syAmount).subtract(djAmount));
			bean.setProBeginTime(proBeginTime);
			bean.setProEndTime(proEndTime);
			bean.setFProMemo(FProMemo);
			bean.setFlowStauts(flowStauts);
			porjectKnotMng.save(bean, getUser(),operType,files);
			
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveSuccessMessage);
		}
		return getJsonResult(true, Result.saveSuccessMessage);
	}
	/**
	 * /projectknot/checkResult
	* @author:安达
	* @Title: checkResult 
	* @Description: 审批结果
	* @param checkBean
	* @param bean
	* @param spjlFile
	* @return
	* @return Result    返回类型 
	* @date： 2019年6月11日下午10:11:13 
	* @throws
	 */
	@RequestMapping("/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,TProBasicInfo tprobasicinfo,ExecuteProject bean,Integer fkId,Integer FProId,String spjlFile) {
		try {
			List<ExecuteProject> zzxmList = projectMng.zzxmList(FProId.toString());
			porjectKnotMng.check(checkBean, tprobasicinfo,zzxmList.get(0),getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	/**
	 * /projectknot/detail
	* @author:安达
	* @Title: detail 
	* @Description: 详情
	* @param id
	* @param model
	* @return
	* @return String    返回类型 
	* @date： 2019年6月11日下午10:15:50 
	* @throws
	 */
	@RequestMapping("/detail")
	public String detail(String id,Integer proId,ModelMap model){
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

		//model.addAttribute("listid", listid);
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
		/*List<TProExpendDetail> expDetailList = tProExpendDetailMng
				.getByProId(Integer.valueOf(id));
		model.addAttribute("expDetailList", expDetailList);*/
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
		return "/WEB-INF/view/budget/project/detail/project-transfer-deatil";
	}
}
