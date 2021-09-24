package com.braker.icontrol.contract.approval.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.contract.approval.model.BudgetaryIndic;

@Controller
@RequestMapping("/BudgetaryIndic")
public class BudgetaryIndicController extends BaseController{

	
	@RequestMapping("/contract_list")
	public String contract_list(ModelMap model){
		return "/WEB-INF/view/contract/formulation/formulation_add_BI";
	}

	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(BudgetaryIndic BudgetaryIndic,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=null;
    	List<BudgetaryIndic> li= (List<BudgetaryIndic>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
}
