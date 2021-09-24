package com.braker.icontrol.cgmanage.cgsupplier.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.braker.common.web.BaseController;


/**
 * 供应商白名单(台账)管理的控制层
 * 
 * @author 冉德茂
 * @createtime 2018-09-14
 * @updatetime 2018-09-14
 */
@Controller               
@RequestMapping(value = "/whitesuppliergl")
public class WhiteSupplierController extends BaseController{

	
	/*
	 * 跳转到供应商列表页面（展示审核完成  黑名单状态为0的数据   功能是拉黑）
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/white_supplier_list";
	}
	
	

	/**
	 * 跳转到添加黑名单界面（审核已完成  黑名单状态为0的数据   功能是拉黑）
	 * @author 焦广兴 
	 * @createtime 2019-06-03
	 * @updatetime 2019-06-03
	 */
	@RequestMapping(value = "blackAddList")
	public String data( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/black_add_supplier_list";
	}
}
