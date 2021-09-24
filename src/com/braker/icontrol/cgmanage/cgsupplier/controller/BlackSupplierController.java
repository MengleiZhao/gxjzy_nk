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
import com.braker.common.web.BaseController;
import com.braker.core.model.Proposer;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierBlackInfoMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.manager.TProcessCheckMng;

/**
 * 供应商黑名单管理的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Controller               
@RequestMapping(value = "/blacksuppliergl")
public class BlackSupplierController extends BaseController{
	@Autowired
	private SupplierMng supplierMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	SupplierBlackInfoMng supplierBlackInfoMng;
	/*
	 * 跳转到供应商列表页面（展示所有的供应商    状态显示是否黑名单）
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model,String type) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/black_supplier_list";

	}
	/*
	 * 移入黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/inblack")
	public String inblack( ModelMap model,String id) {
		//id是供应商的主键id
		model.addAttribute("fwid", id);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"GYSHMD", getUser().getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgsupplier/black_supplier_add";
		
	}


	/*
	 * 移出黑名单  页面跳转
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@RequestMapping(value = "/moveoutblack")
	public String moveoutblack( ModelMap model,String id) {
		//id是供应商的主键id
		model.addAttribute("fwid", id);
		return "/WEB-INF/view/purchase_manage/cgsupplier/black_supplier_delete";
		
	}
	/*
	 * 历史移动记录
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@RequestMapping(value = "/movehistory")
	@ResponseBody
	public JsonPagination movehistory(String id) {
		//id是专家库的主键id   
		Pagination p = new Pagination();
		if(id != null) {
			p.setList(supplierMng.movehistory(Integer.valueOf(id)));
		}
		return getJsonPagination(p, 0);
	}
	/*
	 * 加入/移除黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/moveintoblack")
	@ResponseBody	
	public Result save(SupplierBlackInfo supplierBlackInfo,ModelMap model) {
		try {
			supplierMng.moveblack(supplierBlackInfo, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 移除黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/moveOutBlack")
	@ResponseBody	
	public Result moveOutBlack(WinningBidder w,ModelMap model) {
		try {
			supplierMng.moveoutblack(w.getFwId());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 移除黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/deleteBlack")
	@ResponseBody	
	public Result deleteBlack(SupplierBlackInfo bean,ModelMap model) {
		try {
			supplierBlackInfoMng.deleteSupplierBlack(String.valueOf(bean.getFwId()),String.valueOf(bean.getFwBId()));
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
}
