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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.Proposer;
import com.braker.icontrol.cgmanage.cgpay.manager.CgPayCheckMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierBlackInfoMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierCheckMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierOutMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 供应商管理的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Controller               
@RequestMapping(value = "/suppliergl")
public class SupplierController extends BaseController{
	@Autowired
	private SupplierMng supplierMng;
	
	@Autowired
	private SupplierBlackInfoMng sbcMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private CgPayCheckMng cgcheckpayMng;
	
	@Autowired
	private SupplierCheckMng supplierCheckMng; 
	
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private SupplierOutMng supplierOutMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/*
	 * 跳转到供应商列表页面
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_list";
	}
	
	/*
	 * 分页数据获得供应商信息(供应商申请页面)
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/supplierPageData")
	@ResponseBody
	public JsonPagination loanPage(WinningBidder bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = supplierMng.pageList(bean, page, rows);;
    	List<WinningBidder> li = (List<WinningBidder>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}

	/**
	 * 供应商申请 弹出页面
	 * @author 焦广兴
	 * @createtime 2019-06-26
	 * @updatetime 2019-06-26
	 */
	@RequestMapping("/supplierApply")
	public String supplierApply(ModelMap model,String checkType){
		model.addAttribute("checkType", checkType);
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_apply_list";
	}
	
	/*
	 * 分页数据获得（中标登记选择供应商页面）
	 * @author 冉德茂
	 * @createtime 2018-10-19
	 * @updatetime 2018-10-19
	 */
	@RequestMapping(value = "/cgselPage")
	@ResponseBody
	public List<WinningBidder> getlistjson(WinningBidder bean,String fpid) {
		if(!StringUtil.isEmpty(fpid)){
			bean.setFpId(fpid);
		}
		List<WinningBidder> prolist = supplierMng.getWhiteSupplier(bean);
		for(int i=0;i<prolist.size();i++){
			prolist.get(i).setNum(i+1);
		}
		return prolist;
	}
	
	@RequestMapping("/blackCheckPage")
	@ResponseBody
	public JsonPagination blackCheckPage(SupplierBlackInfo sb,String timea,String timeb, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = sbcMng.blackCheckPageList(sb,page, rows,getUser());
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
	 * 分页数据获得（黑名单管理页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/blacksupPage")
	@ResponseBody
	public JsonPagination blacksupPage(WinningBidder bean,String timea,String timeb, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = supplierMng.blackpageList(bean,timea,timeb, page, rows);;
		List<WinningBidder> li = (List<WinningBidder>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	/*
	 * 分页数据获得（白名单管理页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/whitesupPage")
	@ResponseBody
	public JsonPagination whitesupPage(WinningBidder bean,String amounta,String amountb, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = supplierMng.whitepageList(bean,amounta,amountb, page, rows);;
		List<WinningBidder> li = (List<WinningBidder>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	/*
	 * 新增供应商
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		//自动生成标号
		String str="FW";
		String fwcode = StringUtil.Random(str);	
		model.addAttribute("fwcode", fwcode);
		model.addAttribute("operType", "add");
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"CGFWSQ", getUser().getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(),null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_add";
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(WinningBidder bean,ModelMap model) {
		
		try {
			bean.setfRecUser(getUser().getName());
			bean.setfRecDept(getUser().getDepartName());
			bean.setfRecDeptId(getUser().getDpID());
			supplierMng.save(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/*
	 * 查看供应商信息
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model,String checkType){
		//查询基本信息
		WinningBidder fwbean = supplierMng.findById(Integer.valueOf(id));
		model.addAttribute("operType", "detail");
		//id是供应商的主键id   fwid
		model.addAttribute("fwbean",fwbean);
		//黑名单
		if((!StringUtil.isEmpty(checkType))&&checkType.equals("black")){
			SupplierBlackInfo bean=sbcMng.findBySupplierBlack(id, fwbean.getFisBlackStatus()).get(0);
			model.addAttribute("bean", bean);	
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(fwbean.getUserId(),"GYSHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getFwBCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSHMD",bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
			model.addAttribute("proposer", proposer);
		//出库
		}else if((!StringUtil.isEmpty(checkType))&&checkType.equals("out")){
			SupplierOut bean=supplierOutMng.findBySupplierOut(id, fwbean.getFisOutStatus()).get(0);
			model.addAttribute("bean", bean);		
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(), bean.getBeanCodeField(),bean.getFoCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSCK", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
			model.addAttribute("proposer", proposer);
		//入库
		}else if("in".equals(checkType)){
			if(fwbean.getFisOutStatus().equals("9")||fwbean.getFisOutStatus().equals("1")){
				SupplierOut bean=supplierOutMng.findBySupplierOut(id, fwbean.getFisOutStatus()).get(0);
				model.addAttribute("bean", bean);		
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(), bean.getBeanCodeField(),  bean.getFoCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSCK", bean.getfRecDeptId());
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",bean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
				model.addAttribute("proposer", proposer);
				return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_detail";
			}
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(fwbean.getUserId(),"CGFWSQ", fwbean.getfRecDeptId(),fwbean.getBeanCode(),fwbean.getnCode(),fwbean.getJoinTable(), fwbean.getBeanCodeField(), fwbean.getFwCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGFWSQ", fwbean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象id
			model.addAttribute("foCode",fwbean.getBeanCode());
			Proposer proposer = new Proposer(fwbean.getfRecUser(), fwbean.getfRecDept(),fwbean.getfRecTime());
			model.addAttribute("proposer", proposer);
		}
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_detail";

	}
	/*
	 * 供应商信息的删除
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			supplierMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	/*
	 * 供应商信息 修改
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id, String checkType, ModelMap model){
		WinningBidder fwbean = supplierMng.findById(Integer.valueOf(id));
		//查询基本信息
		model.addAttribute("fwbean",fwbean);
		
		if(checkType.equals("in")){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(fwbean.getUserId(),"CGFWSQ", fwbean.getfRecDeptId(),fwbean.getBeanCode(),fwbean.getnCode(),fwbean.getJoinTable(), fwbean.getBeanCodeField(),fwbean.getFwCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGFWSQ", fwbean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",fwbean.getBeanCode());
			Proposer proposer = new Proposer(fwbean.getfRecUser(), fwbean.getfRecDept(),fwbean.getfRecTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_add";	
		//出库
		}else if(checkType.equals("out")){
			SupplierOut bean=supplierOutMng.findBySupplierOut(id, fwbean.getFisOutStatus()).get(0);
			model.addAttribute("bean", bean);		
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"GYSCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(), bean.getBeanCodeField(), bean.getFoCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSCK", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_out";
		//黑名单
		}else if(checkType.equals("black")){	
			SupplierBlackInfo bean=sbcMng.findBySupplierBlack(id, fwbean.getFisBlackStatus()).get(0);
			model.addAttribute("bean", bean);	
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"GYSHMD", getUser().getDpID(),null,null, bean.getJoinTable(),bean.getBeanCodeField(), bean.getFwCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GYSHMD",getUser().getDpID());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgsupplier/black_supplier_add";
		}
		return null;
	}
}
