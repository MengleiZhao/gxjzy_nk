package com.braker.icontrol.expend.loan.controller;

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
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.Payment;

@Controller
@RequestMapping(value = "/paymentCheck")
public class PaymentCheckController extends BaseController {
	
	@Autowired
	private PaymentMng paymentMng;

	@RequestMapping(value = "/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/expend/loan/payment_list";
	}
	
	@RequestMapping(value = "/pageList")
	@ResponseBody
	public JsonPagination noticePage(Payment bean, Integer pageNo, Integer pageSize){
		
		if(pageNo == null){pageNo = 1;}
    	if(pageSize == null){pageSize = SimplePage.DEF_COUNT;}
    	
    	Pagination p = paymentMng.pageList(bean, getUser(), "2", pageNo, pageSize);
    	
    	return getJsonPagination(p, pageNo);
	}
	
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		return "";
	}
	
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(Payment bean,String files){
		try {
			paymentMng.savePayment(bean, files, getUser());
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}
		return getJsonResult(true, "操作成功！");
	}
}
