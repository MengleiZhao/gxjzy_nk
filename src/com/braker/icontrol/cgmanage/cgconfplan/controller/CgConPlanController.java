package com.braker.icontrol.cgmanage.cgconfplan.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 年度计划管理的控制层
 * 
 * @author 冉德茂
 * @createtime 2018-10-11
 * @updater 陈睿超
 * @updatetime 2019-12-03
 */
@Controller               
@RequestMapping(value = "/cgconfplan")
public class CgConPlanController extends BaseController{
	@Autowired
	private CgConPlanMng confplanMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	/**
	 * 
	 * @Description 列表页面
	 * @author 陈睿超
	 * @param model
	 * @param freportStage
	 * @param sblx
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年11月29日
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model, Integer freportStage, String sblx) {
		model.addAttribute("sblx", sblx);//申报类型
		model.addAttribute("freportStage", freportStage);//上报阶段	1-一上	2-二上
		
		if("yssp".equals(sblx)){//yssp-一上审批
			return "/WEB-INF/view/purchase_manage/confplan/check/confplan_check_list";
		}else if("yxxd".equals(sblx)){//yxxd-一下下达
			return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_resolve_list";
		}else if("essb".equals(sblx)){//essb-二上申报
			return "/WEB-INF/view/purchase_manage/confplan/second/confplan_second_list";
		}else if("essp".equals(sblx)){//essp-二上审批
			return "/WEB-INF/view/purchase_manage/confplan/check/confplan_second_check_list";
		}else if("exxd".equals(sblx)){//exxd-二下下达
			return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_second_resolve_list";
		}else if("ndtz".equals(sblx)){//ndtz-年度台账
			return "/WEB-INF/view/purchase_manage/confplan/ledger/confplan_ledger_list";
		}
		//yssb-一上申报
		return "/WEB-INF/view/purchase_manage/confplan/first/confplan_list";
	}
	
	/**
	 * 
	 * @Description 跳转到采购模块年度计划中选择预算页面
	 * @author 陈睿超
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月3日
	 */
	@RequestMapping(value = "/probyProLibType")
	public String probyProLibType(ModelMap model){
		return "/WEB-INF/view/purchase_manage/confplan/expend/project_list";
	}
	
	/**
	 * 
	 * @Description 跳转到采购模块年度计划中选择预算指支出明细页面
	 * @author 陈睿超
	 * @param model
	 * @param FProId
	 * @param fproName
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月4日
	 */
	@RequestMapping(value = "/probyExpend")
	public String probyExpend(ModelMap model, Integer FProId){
		TProBasicInfo bean = projectMng.findById(FProId);
		model.addAttribute("FProId", FProId);
		model.addAttribute("FProName", bean.getFProName());
		return "/WEB-INF/view/purchase_manage/confplan/expend/expend_list";
	}
	
	/**
	 * 
	 * @Description 加载申报库可以送审或审批结束数据
	 * @author 陈睿超
	 * @param bean
	 * @param page
	 * @param rows
	 * @param proLibType
	 * @param sbkLx
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2019年12月4日
	 */
	@RequestMapping(value = "/proLibTypePageData")
	@ResponseBody
	public JsonPagination proLibTypePageData(TProBasicInfo bean, Integer page, Integer rows) {
		if (page == null) {page = 1;}
		if (rows == null) {rows = SimplePage.DEF_COUNT;}
		Pagination p = projectMng.proLibTypePageList(bean, page, rows, getUser());
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description 加载申报库项目对应项目支出明细
	 * @author 陈睿超
	 * @param bean
	 * @param page
	 * @param rows
	 * @param FProId
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2019年12月4日
	 */
	@RequestMapping(value = "/probyExpendPageData")
	@ResponseBody
	public JsonPagination probyExpendPageData(Integer FProId, Integer page, Integer rows) {
		Pagination p = new Pagination();
		//根据项目id查询对应的项目支出明细
		List<TProExpendDetail> detailList = tProExpendDetailMng.getByProId(FProId);
		//查询采购年度计划中已关联项目支出明细的明细主键
		List<Integer> pidList = confplanMng.getPidList();
		
		//需要删除的项目支出明细
		List<TProExpendDetail> tpedRemove = new ArrayList<>();
		TProExpendDetail tped = new TProExpendDetail();
		for(Integer pid:pidList){
			tped = tProExpendDetailMng.findById(pid);
			tpedRemove.add(tped);
		}
		//删除项目支出明细
		detailList.removeAll(tpedRemove);
		p.setList(detailList);
		p.setPageNo(1);
		p.setPageSize(detailList.size());
		p.setTotalCount(detailList.size());
		return getJsonPagination(p, page);
	}

	/**
	 * 
	 * @Description 分页查询
	 * @author 陈睿超
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/confplanPageData")
	@ResponseBody
	public JsonPagination pageList(ProcurementPlan bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = confplanMng.pageList(bean, page, rows, getUser());
    	List<ProcurementPlan> li = (List<ProcurementPlan>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description 审批分页查询
	 * @author 汪耀
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2019年12月6日
	 */
	@RequestMapping(value = "/confplanCheckPageData")
	@ResponseBody
	public JsonPagination checkPageList(ProcurementPlan bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = confplanMng.checkPageList(bean, page, rows, getUser());
    	List<ProcurementPlan> li = (List<ProcurementPlan>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description: 下达分页查询
	 * @author : 汪耀
	 * @param : @param bean
	 * @param : @param page
	 * @param : @param rows
	 * @param : @return
	 * @return : JsonPagination
	 * @throws
	 * @date : 2019年12月9日
	 */
	@RequestMapping(value = "/confplanResolvePageData")
	@ResponseBody
	public JsonPagination resolvePageList(ProcurementPlan bean, Integer page, Integer rows, String status){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = confplanMng.resolvePageList(bean, status, page, rows, getUser());
    	List<ProcurementPlan> li = (List<ProcurementPlan>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description 年度台账分页查询
	 * @author 汪耀
	 * @param bean
	 * @param page
	 * @param rows
	 * @param status
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2020年1月7日
	 */
	@RequestMapping(value = "/confplanLedgerPageList")
	@ResponseBody
	public JsonPagination ledgerPageList(ProcurementPlan bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = confplanMng.ledgerPageList(bean, page, rows, getUser());
    	List<ProcurementPlan> li = (List<ProcurementPlan>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @Description 一上申报
	 * @author 陈睿超
	 * @param model
	 * @param freportStage
	 * @param sblx
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/add")
	public String add(ModelMap model, Integer freportStage){
		model.addAttribute("openType", "add");
		
		ProcurementPlan bean = new ProcurementPlan();
		//设置基本信息
		bean.setFreqUserId(getUser().getId());
		bean.setFreqLinkMen(getUser().getName());	
		bean.setFreqDept(getUser().getDepartName());
		bean.setFreqDeptId(getUser().getDepart().getId());
		bean.setFreqTime(new Date());
		bean.setFreportStage(freportStage);
		//自动生成标号
		String str="JH";
		bean.setFlistNum(StringUtil.Random(str));
		model.addAttribute("bean", bean);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(getUser().getId(), busiArea, getUser().getDpID(), null, null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);

		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/confplan/first/confplan_add";
	}
	
	/**
	 * 
	 * @Description 一上保存
	 * @author 陈睿超
	 * @param bean
	 * @param mingxi
	 * @param files
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(ProcurementPlan bean, String mingxi, String files) {
		try {
			confplanMng.save(bean, mingxi, files, getUser());
		} catch (Exception e) {
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 一上修改
	 * @author 陈睿超
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/edit")
	public String edit(ModelMap model, Integer id){
		model.addAttribute("openType", "edit");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/first/confplan_add";
	}
	
	/**
	 * 
	 * @Description 一上查看
	 * @author 陈睿超
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/detail")
	public String detail(ModelMap model, Integer id){
		model.addAttribute("openType", "detail");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/first/confplan_detail";
	}
	
	/**
	 * 
	 * @Description 一上删除
	 * @author 陈睿超
	 * @param id
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月5日
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			confplanMng.delete(id);
		} catch (Exception e) {
			return getJsonResult(false, "删除失败，请联系管理员！");
		}
		return getJsonResult(true, "删除成功！");	
	}
		
	/**
	 * 
	 * @Description 明细
	 * @author 陈睿超
	 * @param id
	 * @param planid
	 * @return
	 * @return JsonPagination
	 * @throws
	 * @date 2019年12月5日
	 */
	@RequestMapping(value = "/mingxi")
	@ResponseBody
	public JsonPagination mingxi(String id,String planid) {
		Pagination p = new Pagination();
		Integer fpId;
		if(planid!=null){//页面默认查询清单
			 fpId=Integer.valueOf(planid);
		}else{//选择配置单  加载清单信息
			fpId=Integer.valueOf(id);
		}
		//查询采购清单信息
		List<Object> mingxiList = confplanMng.getMingxi("ProcurementPlanList", "fplId", fpId);
		for(int i=0;i<mingxiList.size();i++){
			ProcurementPlanList bean = (ProcurementPlanList)mingxiList.get(i);
			bean.setNum(i+1);
		}
		p.setList(mingxiList);
		return getJsonPagination(p, 0);
	}
	
	/**
	 * 
	 * @Description: 刷新流程
	 * @author : 汪耀
	 * @param @param model
	 * @param @param fprocurType
	 * @param @return
	 * @return String
	 * @throws
	 * @date : 2019年12月6日
	 */
	@RequestMapping(value = "/refreshProcess")
	public String rerefreshProcess(ModelMap model, String fprocurType){
		//业务范围
		String busiArea = null;
		if("A40".equals(fprocurType)){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(getUser().getId(), busiArea, getUser().getDpID(), null, null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/check_system";
	}
	
	/**
	 * 
	 * @Description 跳转一上审批页面
	 * @author 汪耀
	 * @param id
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月6日
	 */
	@RequestMapping(value = "/check")
	public String check(ModelMap model, Integer id) {
		model.addAttribute("openType", "check");
		
		//查询基本信息				
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);		
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/check/confplan_check";

	}
	
	/**
	 * 
	 * @Description 一上审批保存
	 * @author 汪耀
	 * @param checkBean
	 * @param bean
	 * @param spjlFile
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月6日
	 */
	@RequestMapping(value = "/saveCheck")
	@ResponseBody
	public Result saveCheck(TProcessCheck checkBean, ProcurementPlan bean, String spjlFile) {
		try {
			confplanMng.saveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 跳转一下下达页面
	 * @author 汪耀
	 * @param model
	 * @param fProType
	 * @param fProLibType
	 * @param sbkLx
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月13日
	 */
	@RequestMapping(value = "/resolve")
	public String resolve(ModelMap model, Integer id){
		model.addAttribute("openType", "resolve");
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		
		//设置审核人、审核时间 
		bean.setFapproveUserName(getUser().getName());
		bean.setFapproveTime(new Date());
		model.addAttribute("bean", bean);
		
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_resolve";
	}
	
	/**
	 * 
	 * @Description 下达保存
	 * @author 汪耀
	 * @param bean
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月13日
	 */
	@RequestMapping(value = "/resolveSave")
	@ResponseBody	
	public Result resolveSave(ProcurementPlan bean) {
		try {
			confplanMng.resolveSave(bean);
		} catch (Exception e) {
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 一下查看
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月13日
	 */
	@RequestMapping(value = "/resolveDetail")
	public String resolveDetail(ModelMap model, Integer id){
		model.addAttribute("openType", "resolveDetail");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_resolve_detail";
	}
	
	/**
	 * 
	 * @Description 预算指标选择
	 * @author 汪耀
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月6日
	 */
	@RequestMapping(value = "/chooseIndex")
	public String chooseIndex(ModelMap model){
		return "/WEB-INF/view/purchase_manage/confplan/index/confplan_index";
	}
	
	/**
	 * 
	 * @Description 获得项目科目树
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @param indexName
	 * @param indexType
	 * @return
	 * @return List<TreeEntity>
	 * @throws
	 * @date 2020年1月6日
	 */
	@RequestMapping(value = "/indexTree")
	@ResponseBody
	public List<TreeEntity> indexTree(ModelMap model, String id, String indexType) {
		List<TreeEntity> treeList = null;
		if(StringUtil.isEmpty(id)){
			//页面加载时默认显示一级节点
			treeList = confplanMng.getIndexTreeOne(indexType, getUser());
		}else {
			//单击1级节点后根据id查询对应二级节点
			treeList = confplanMng.getIndexTreeTwo(id);
		}
		return treeList;
	}
	
	/**
	 * 
	 * @Description 刷新二上流程
	 * @author 汪耀
	 * @param model
	 * @param planBean
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月11日
	 */
	@RequestMapping(value = "/secondRefreshProcess")
	public String secondRefreshProcess(ModelMap model, ProcurementPlan planBean){
		//设置二上申报金额并返回对象
		ProcurementPlan bean = confplanMng.setPurSecondAmount(planBean.getFplId(), planBean.getPurSecondAmount());
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(getUser().getId(), busiArea, getUser().getDpID(), null, null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/check_system";
	}
	
	/**
	 * 
	 * @Description 二上申报
	 * @author 汪耀
	 * @param model
	 * @param bean
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月17日
	 */
	@RequestMapping(value = "/secondEdit")
	public String secondEdit(ModelMap model, ProcurementPlan planBean){
		model.addAttribute("openType", "secondEdit");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(planBean.getFplId());
		bean.setFreportStage(planBean.getFreportStage());
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/second/confplan_second_edit";
	}
	
	/**
	 * 
	 * @Description 二上保存
	 * @author 汪耀
	 * @param bean
	 * @param mingxi
	 * @param files
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月17日
	 */
	@RequestMapping(value = "/secondSave")
	@ResponseBody	
	public Result secondSave(ProcurementPlan bean, String mingxi, String files) {
		try {
			confplanMng.secondSave(bean, mingxi, files, getUser());
		} catch (Exception e) {
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 二上查看
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月17日
	 */
	@RequestMapping(value = "/secondDetail")
	public String secondDetail(ModelMap model, Integer id){
		model.addAttribute("openType", "secondDetail");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/second/confplan_second_detail";
	}
	
	/**
	 * 
	 * @Description 跳转二上审批页面
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2019年12月17日
	 */
	@RequestMapping(value = "/secondCheck")
	public String secondCheck(ModelMap model, Integer id) {
		model.addAttribute("openType", "secondCheck");
		
		//查询基本信息				
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);		
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/check/confplan_second_check";
	}
	
	/**
	 * 
	 * @Description 二上审批保存
	 * @author 汪耀
	 * @param checkBean
	 * @param bean
	 * @param spjlFile
	 * @return
	 * @return Result
	 * @throws
	 * @date 2019年12月17日
	 */
	@RequestMapping(value = "/secondSaveCheck")
	@ResponseBody
	public Result secondSaveCheck(TProcessCheck checkBean, ProcurementPlan bean, String spjlFile) {
		try {
			confplanMng.secondSaveCheck(checkBean, bean, spjlFile, getUser());
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 跳转二下下达页面
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月13日
	 */
	@RequestMapping(value = "/secondResolve")
	public String secondResolve(ModelMap model, Integer id){
		model.addAttribute("openType", "secondResolve");
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		
		//设置审核人、审核时间 
		bean.setFapproveUserName(getUser().getName());
		bean.setFapproveTime(new Date());
		model.addAttribute("bean", bean);
		
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";				//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_second_resolve";
	}
	
	/**
	 * 
	 * @Description 二下查看
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月13日
	 */
	@RequestMapping(value = "/secondResolveDetail")
	public String secondResolveDetail(ModelMap model, Integer id){
		model.addAttribute("openType", "secondResolveDetail");
		
		//查询基本信息
		ProcurementPlan bean = confplanMng.findById(id);
		model.addAttribute("bean", bean);
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//查询工作流
		List<TNodeData> nodeConfList = tProcessCheckMng.getNodeConf(bean.getUserId(), busiArea, bean.getFreqDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFlistNum(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getFreqLinkMen(), bean.getFreqDept(), bean.getFreqTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, bean.getFreqDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/confplan/resolve/confplan_second_resolve_detail";
	}
}
