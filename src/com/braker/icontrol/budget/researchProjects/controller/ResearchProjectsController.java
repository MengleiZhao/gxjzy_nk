package com.braker.icontrol.budget.researchProjects.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.Proposer;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.researchProjects.manager.ResearchProjectsMng;
import com.braker.icontrol.budget.researchProjects.model.ResearchProjectsInfo;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.icontrol.purchase.apply.model.PurchaseUpdateInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 科研项目登记的控制层
 * @author 方淳洲
 * @createtime 2021-06-18
 * @updatetime 2021-06-18
 */
@Controller
@RequestMapping(value = "/researchProjects")
public class ResearchProjectsController extends BaseController{
	@Autowired
	private ResearchProjectsMng researchProjectsMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private LookupsMng lookupsMng;
	/*
	 * 跳转到列表页面
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/budget/researchProjects/researchProjects_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	@RequestMapping(value = "/pageData")
	@ResponseBody
	public JsonPagination pageData(ResearchProjectsInfo bean,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = researchProjectsMng.pageList(bean, page, rows, getUser());
    	List<ResearchProjectsInfo> li = (List<ResearchProjectsInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
    		if(StringUtils.isNotEmpty(li.get(x).getResearchType())){
    			Lookups lookups = lookupsMng.findByLookCode(li.get(x).getResearchType());
    			li.get(x).setResearchTypeName(lookups.getName());
    		}
    		//序号设置	
    		li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 新增
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		ResearchProjectsInfo bean = new ResearchProjectsInfo();
		User user = getUser();
		//获取当前登录对象获得名称和所属部门
		bean.setfUserName(user.getName());
		bean.setfUser(user.getId());
		bean.setfDeptName(user.getDepartName());
		bean.setfDeptId(user.getDpID());
		bean.setfReqTime(new Date());
		//自动生成编号
		String str="KYXM";
		bean.setFpCode(StringUtil.Random(str));
		model.addAttribute("bean", bean);// 建立工作流发起人的信息
		Proposer proposer = new Proposer(user.getName(),user.getDepartName(), null);
		model.addAttribute("proposer", proposer);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(user.getId(),"KYXMDJ", user.getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//历史审批节点
		String historyNodes=tProcessCheckMng.getHistoryNodes("KYXMDJ",getUser().getDpID(),bean.getBeanCode());
		model.addAttribute("historyNodes", historyNodes);
		
		return "/WEB-INF/view/budget/researchProjects/researchProjects_add";
	}
	
	
	/*
	 * 保存
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(ResearchProjectsInfo bean, String files,ModelMap model) {
		try {
			//保存
			researchProjectsMng.save(bean, files, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	
	/**
	 * 跳转到选择行程单人员选择页面
	 * @param model
	 * @return
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(ModelMap model,String index,String editType,String tabId,String peopId){
		model.addAttribute("index", index);
		model.addAttribute("editType", editType);
		model.addAttribute("tabId", tabId);
		model.addAttribute("peopId", peopId);
		return "/WEB-INF/view/budget/researchProjects/choose_projectMember";
	}
	
	
	/*
	 * 查看详情
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//查询基本信息
		ResearchProjectsInfo bean = researchProjectsMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attaList", attac);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(), "KYXMDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("KYXMDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		return "/WEB-INF/view/budget/researchProjects/researchProjects_detail";
	}
	
	/*
	 * 修改
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value ="/edit")
	public String edit(String id,ModelMap model){
		//查询基本信息
		ResearchProjectsInfo bean = researchProjectsMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attaList", attac);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(), "KYXMDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("KYXMDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		return "/WEB-INF/view/budget/researchProjects/researchProjects_add";
	}
	
	/*
	 * 删除
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			researchProjectsMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	
	/**
	 * 采购申请撤回
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value = "/reCall")
	@ResponseBody
	public Result reCall(Integer id) {
		try {
			researchProjectsMng.reCall(id);
			return getJsonResult(true, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	
	
	
	
	
	
	/*
	 * 跳转到审批列表页面
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	@RequestMapping(value = "/checkList")
	public String checkList(ModelMap model) {
		return "/WEB-INF/view/budget/researchProjects/researchProjects_checkList";
	}
	
	/*
	 * 审批分页数据获得
	 * @author 方淳洲
	 * @createtime 2021-06-18
	 * @updatetime 2021-06-18
	 */
	@RequestMapping(value = "/checkPageData")
	@ResponseBody
	public JsonPagination checkPageData(ResearchProjectsInfo bean,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = researchProjectsMng.checkPageList(bean, page, rows, getUser());
    	List<ResearchProjectsInfo> li = (List<ResearchProjectsInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
    		if(StringUtils.isNotEmpty(li.get(x).getResearchType())){
    			Lookups lookups = lookupsMng.findByLookCode(li.get(x).getResearchType());
    			li.get(x).setResearchTypeName(lookups.getName());
    		}
    		//序号设置	
    		li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	
	/*
	 * 审批
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value ="/check")
	public String check(String id,ModelMap model){
		//查询基本信息
		ResearchProjectsInfo bean = researchProjectsMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attaList", attac);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(), "KYXMDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("KYXMDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		return "/WEB-INF/view/budget/researchProjects/researchProjects_check";
	}
	
	/*
	 * 审批结果
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value = "/checkResult")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,ResearchProjectsInfo bean,String spjlFile) {
		try {
			researchProjectsMng.saveCheck(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 跳转到预算项目选择科研项目页面
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月24日
	 */
	@RequestMapping(value = "/skipScientificPro")
	public String skipScientificPro(ModelMap model,String userName) {
		model.addAttribute("userName", userName);
		return "/WEB-INF/view/budget/researchProjects/researchProjects_list_YS";
	}
	
	/**
	 * 根据项目申报人名称获取项目负责人
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月24日
	 */
	@RequestMapping(value = "/getProjectUserAndProjectMemberById")
	@ResponseBody
	public JsonPagination getProjectUserAndProjectMemberById(ResearchProjectsInfo bean,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = researchProjectsMng.getProjectUserAndProjectMemberById(bean, page, rows, getUser());
    	List<ResearchProjectsInfo> li = (List<ResearchProjectsInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
    		if(StringUtils.isNotEmpty(li.get(x).getResearchType())){
    			Lookups lookups = lookupsMng.findByLookCode(li.get(x).getResearchType());
    			li.get(x).setResearchTypeName(lookups.getName());
    		}
    		//序号设置	
    		li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}

	
	/*
	 * 查看详情
	 * @author 方淳洲
	 * @createtime 2021-06-19
	 * @updatetime 2021-06-19
	 */
	@RequestMapping(value ="/detailYS")
	public String detailYS(String id,ModelMap model){
		//查询基本信息
		ResearchProjectsInfo bean = researchProjectsMng.findById(Integer.valueOf(id));
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attaList", attac);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(), "KYXMDJ", bean.getfDeptId(), bean.getBeanCode(), bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFpCode(), "1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("KYXMDJ", bean.getfDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfUserName(), bean.getfDeptName(), bean.getfReqTime());
		model.addAttribute("proposer", proposer);
		//对象编码
		model.addAttribute("foCode", bean.getBeanCode());
		
		return "/WEB-INF/view/budget/researchProjects/researchProjects_detail_ys";
	}
	
}
