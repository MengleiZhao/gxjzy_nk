/**
 * <p>Title: ContractRevenueController.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年11月13日
 */
package com.braker.icontrol.incomemanage.contractRevenue.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.incomemanage.contractRevenue.manager.ContractRevenueMng;
import com.braker.icontrol.incomemanage.contractRevenue.model.ContractRevenue;

/**
 * <p>Title: ContractRevenueController</p>  
 * <p>Description: 合同类收入控制层</p>  
 * @author 陈睿超
 * @date 2020年11月13日  
 */
@Controller
@RequestMapping(value="/contractRevenue")
public class ContractRevenueController extends BaseController{

	
	@Autowired
	private ContractRevenueMng contractRevenueMng;
	
	
	/**
	 * 
	 * <p>Title: list</p>  
	 * <p>Description: 跳转list页面</p>  
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月13日
	 * @updator 陈睿超
	 * @updatetime 2020年11月13日
	 */
	@RequestMapping(value="/list")
	public String list(ModelMap model){
		return "/WEB-INF/view/income_manage/contractRevenue/contractRevenueRegisterList";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/pagelist")
	public JsonPagination pagelist(ContractRevenue bean, Integer page, Integer rows, ModelMap model){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = contractRevenueMng.pagelist(bean, page, rows, getUser());
		return getJsonPagination(p, page);
	}
	
}
