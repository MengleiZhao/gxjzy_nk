package com.braker.icontrol.cgmanage.cgsupplier.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Result;
import com.braker.common.web.BaseController;
import com.braker.core.model.Proposer;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierOutMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.manager.TProcessCheckMng;

/**
 * 供应商出库的控制层
 * @author 焦广兴
 * @createtime 2019-06-13
 * @updatetime 2019-06-13
 */
@Controller               
@RequestMapping(value = "/supplierglOut")
public class SupplierOutController extends BaseController{
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private SupplierOutMng supplierOutMng;
	@Autowired
	private SupplierMng supplierMng;
	/*
	 *  供应商出库的list界面
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	@RequestMapping(value = "/list")
	public String list2( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_out_list";
	}
	
	/*
	 *  供应商出库界面
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	@RequestMapping(value = "/outJsp")
	public String inblack( ModelMap model,String id,String type) {
		//id是供应商的主键id
		model.addAttribute("fwid", id);
		model.addAttribute("type", type);	//出入库
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"GYSCK", getUser().getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_out";
		
	}
	
	/*
	 *  供应商出库
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	@RequestMapping(value = "/outAdd")
	@ResponseBody	
	public Result outAdd(SupplierOut so,ModelMap model) {
		try {
			//出库数据修改状态加审批
			supplierMng.outSupplier(so, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 *  供应商删除出库记录
	 * @author 焦广兴
	 * @createtime 2019-06-21
	 * @updatetime 2019-06-21
	 */
	@RequestMapping(value = "/deleteOut")
	@ResponseBody	
	public Result deleteOut(SupplierOut so,ModelMap model) {
		try {
			supplierOutMng.deleteSupplierOut(so.getFwId(),so.getFoId());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
}
