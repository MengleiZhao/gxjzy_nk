package com.braker.icontrol.cgmanage.cgsupplier.controller;

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
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierBlackInfoMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierCheckMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierOutMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 供应商审核的控制层
 * 本模块用于采购申请的审批及查看
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Controller
@RequestMapping(value = "/suppliercheck")
public class SupplierCheckController extends BaseController{
	
	@Autowired
	private SupplierCheckMng suppliercheckMng;
	
	@Autowired
	private SupplierMng supplierMng;
	
	@Autowired
	private SupplierBlackInfoMng sbcMng;
	
	@Autowired
	private SupplierOutMng supplierOutMng;
	
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	/*
	 * 跳转到供应商入库审核页面
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		//供应商审批
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_check_list";
	}
	/**
	 * 跳转到供应商出库审核页面
	 * @author 焦广兴
	 * @createtime 2019-06-03
	 * @updatetime 2019-06-03
	 */
	@RequestMapping(value = "/list2")
	public String list2( ModelMap model) {
		//供应商出库审核
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_check_list";	//提示：界面未改
	}
	/**
	 * 跳转到供应商黑名单审核页面
	 * @author 焦广兴
	 * @createtime 2019-06-03
	 * @updatetime 2019-06-03
	 */
	@RequestMapping(value = "/list3")
	public String list3( ModelMap model) {
		//供应商出库审核
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_black_check_list";
	}
	
	
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@RequestMapping(value = "/supplierCheckPageData")
	@ResponseBody
	public JsonPagination loanPage(WinningBidder bean, String sort, String order,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = suppliercheckMng.pageList(bean, page, rows, getUser());
    	return getJsonPagination(p, page);
	}	
	
	/**
	 * 黑名单审核页面数据
	 * @author 冉德茂
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	@RequestMapping(value = "/blackCheckPageData")
	@ResponseBody
	public JsonPagination blackCheckPageData(SupplierBlackInfo sb, String sort, String order,Integer page, Integer rows){
		
    	if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = sbcMng.blackCheckPageList(sb, page, rows,getUser());
		List<SupplierBlackInfo> li = (List<SupplierBlackInfo>) p.getList();
		
		for(int x=0; x<li.size(); x++) {
			WinningBidder w=supplierMng.findById(li.get(x).getFwId());
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
			li.get(x).setFwuserName(w.getFwuserName());
			li.get(x).setFaccFreq(w.getFaccFreq());
		}
		return getJsonPagination(p, page);
	}	

	
	/*
	 * 跳转审批页面
	 * @author 冉德茂
	 * @createtime 2018-07—16
	 * @updatetime 2018-07—16
	 */
	@RequestMapping(value = "/check")
	public String check(String id ,String checkType, ModelMap model) {
		//传回来的id是主键 fpid
		//查询基本信息				
		WinningBidder wbean = supplierMng.findById(Integer.valueOf(id));
		model.addAttribute("fwbean", wbean);		
		
		//入库流程
		if(checkType.equals("in")){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(wbean.getUserId(),"CGFWSQ", wbean.getfRecDeptId(),wbean.getBeanCode(),wbean.getnCode(),wbean.getJoinTable(),  wbean.getBeanCodeField(),  wbean.getFwCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGFWSQ", wbean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",wbean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(wbean.getfRecUser(), wbean.getfRecDept(), wbean.getfRecTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgsupplier/check_supplier";
		//出库
		}else if(checkType.equals("out")){
			SupplierOut bean=supplierOutMng.findCheckOut(id, getUser()).get(0);
			model.addAttribute("bean", bean);		
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFoCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSCK", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgsupplier/check_out_supplier";
		//黑名单
		}else if(checkType.equals("black")){
			//查询基本信息				
			SupplierBlackInfo bean = sbcMng.findCheckBlack(id, getUser()).get(0);
			model.addAttribute("bean", bean);		
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFwBCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSHMD", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
			model.addAttribute("proposer", proposer);
			
			return "/WEB-INF/view/purchase_manage/cgsupplier/check_black_supplier";
		}
		
		
		
		return null;
	}

	/**
	 * 供应商黑名单跳转审批页面
	 * @author 焦广兴
	 * @createtime 2019-06-03
	 * @updatetime 2019-06-03
	 */
	@RequestMapping(value = "/checkBlack")
	public String checkBlack(String id ,ModelMap model) {
		//传回来的id是主键 fpid
		//查询基本信息				
		WinningBidder wbean = supplierMng.findById(Integer.valueOf(id));
		model.addAttribute("fwbean", wbean);	
		//查询基本信息				
		SupplierBlackInfo bean = sbcMng.findCheckBlack(id, getUser()).get(0);
		model.addAttribute("bean", bean);		
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getFwCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSHMD", bean.getfRecDeptId());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/check_black_supplier";

	}
	
	/**
	 * 供应商出库跳转审批页面
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	@RequestMapping(value = "/checkOut")
	public String checkO(String id ,ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/check_out_supplier";

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
			suppliercheckMng.inRecall(id);
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
			sbcMng.blackRecall(id);
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
			supplierOutMng.outRecall(id);
			return getJsonResult(true, "操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, getException(e));
		}

	}
	/*
	 * 进行入库审核
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@RequestMapping(value = "/checkSupplier")
	@ResponseBody
	public Result checkResult(TProcessCheck checkBean,WinningBidder bean,String spjlFile) {
		try {
			suppliercheckMng.saveCheckInfo(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 进行出库审核
	 * @author 焦广兴
	 * @createtime 2019-06-04
	 * @updatetime 2019-06-04
	 */
	@RequestMapping(value = "/checkOutSupplier")
	@ResponseBody
	public Result checkOutResult(TProcessCheck checkBean,SupplierOut bean,String spjlFile) {
		try {
			supplierOutMng.saveCheckOut(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 进行黑名单审核
	 * @author 焦广兴
	 * @createtime 2019-06-04
	 * @updatetime 2019-06-04
	 */
	@RequestMapping(value = "/checkBlackSupplier")
	@ResponseBody
	public Result checkBlackResult(TProcessCheck checkBean,SupplierBlackInfo bean,String spjlFile) {
		try {
			sbcMng.saveCheckBlack(checkBean, bean, getUser(), spjlFile);
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
	
}
