package com.braker.icontrol.cgmanage.cgexpert.controller;

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
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Proposer;
import com.braker.core.model.Role;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertBlackMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertCheckMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertOutMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 专家库审核的控制层
 * 本模块用于采购申请的审批及查看
 * @author 冉德茂
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Controller
@RequestMapping(value = "/expertcheck")
public class ExpertCheckController extends BaseController{
	
	@Autowired
	private ExpertCheckMng expertcheckMng;
	@Autowired
	private ExpertBlackMng expertBlackMng;
	@Autowired
	private ExpertOutMng expertOutMng;
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	/*
	 * 跳转到专家库审核页面
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_check_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/expertCheckPageData")
	@ResponseBody
	public JsonPagination loanPage(ExpertInfo bean, String sort, String order,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = expertcheckMng.pageList(bean, page, rows, getUser());
    	return getJsonPagination(p, page);
	}	

	
	/*
	 * 跳转审批页面
	 * @author 冉德茂
	 * @createtime 2018-07—26
	 * @updatetime 2018-07—26
	 */
	@RequestMapping(value = "/check")
	public String check(String id ,String checkType,ModelMap model) {
		try {
			ExpertInfo ebean = expertcheckMng.findById(Integer.valueOf(id));
			//id是专家的主键id   feid
			//查询基本信息
			model.addAttribute("ebean",ebean);
			
			//入库流程
			if(checkType.equals("in")){
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(ebean.getUserId(),"CGEXSQ", ebean.getfRecDeptId(),ebean.getBeanCode(),ebean.getnCode(), ebean.getJoinTable(),  ebean.getBeanCodeField(),  ebean.getFexpertCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("CGEXSQ", ebean.getfRecDeptId());
				String flowJson=tNodeLinkMng.getGraphLinksModelByFlowId(processDefin.getFPId());
				model.addAttribute("flowJson", flowJson);
				model.addAttribute("nextKey", ebean.getnCode());
				model.addAttribute("fpId",processDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",ebean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(ebean.getfRecUser(), ebean.getfRecDept(), ebean.getfRecTime());
				model.addAttribute("proposer", proposer);
				return "/WEB-INF/view/purchase_manage/cgexpert/check_expert";
			//出库
			}else if(checkType.equals("out")){
				//查询基本信息				
				ExpertOutInfo bean = expertOutMng.findCheckOut(id, getUser()).get(0);
				model.addAttribute("bean", bean);		
				
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFoCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKCK", bean.getfRecDeptId());
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",bean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
				model.addAttribute("proposer", proposer);
				
				return "/WEB-INF/view/purchase_manage/cgexpert/check_out_expert";
			//黑名单
			}else if(checkType.equals("black")){
				//查询基本信息				
				ExpertBlackInfo bean = expertBlackMng.findCheckBlack(id, getUser()).get(0);
				model.addAttribute("bean", bean);		
				
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFeBCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKHMD", bean.getfRecDeptId());
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",bean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
				model.addAttribute("proposer", proposer);
				
				return "/WEB-INF/view/purchase_manage/cgexpert/check_black_expert";
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		

	}

	/*
	 * 进行审核
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/checkExpert")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,ExpertInfo bean1,ExpertBlackInfo bean2,ExpertOutInfo bean3,String spjlFile,String type) {
		try {
			if(type.equals("in")){	//新增入库审核
				List<Role> roleli = userMng.getUserRole(getUser().getId());
				expertcheckMng.saveCheckInfo(checkBean, bean1, getUser(), roleli.get(0), spjlFile);
			}else if(type.equals("outIn")){	//出入库审核
				expertOutMng.saveCheckOut(checkBean, bean3, getUser(), spjlFile);
			}else if(type.equals("black")){	//黑名单审核
				expertBlackMng.saveCheckBlack(checkBean, bean2, getUser(),spjlFile);
			} 
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 入库撤回
	 * @author 焦广兴
	 * @createtime 2019-10-08
	 * @updatetime 2019-10-08
	 */
	@RequestMapping(value = "/inRecall")
	@ResponseBody
	public Result inRecall(Integer id) {
		try {
			expertcheckMng.inRecall(id);
			return getJsonResult(true, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	/**
	 * 出库撤回
	 * @author 焦广兴
	 * @createtime 2019-10-08
	 * @updatetime 2019-10-08
	 */
	@RequestMapping(value = "/outRecall")
	@ResponseBody
	public Result outRecall(Integer id) {
		try {
			expertOutMng.outRecall(id);
			return getJsonResult(true, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	/**
	 * 黑名单撤回
	 * @author 焦广兴
	 * @createtime 2019-10-08
	 * @updatetime 2019-10-08
	 */
	@RequestMapping(value = "/blackRecall")
	@ResponseBody
	public Result blackRecall(Integer id) {
		try {
			expertBlackMng.blackRecall(id);
			return getJsonResult(true, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
}
