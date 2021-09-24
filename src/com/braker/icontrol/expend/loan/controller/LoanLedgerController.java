package com.braker.icontrol.expend.loan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;

/**
 * 借款台账控制层
 */
@Controller
@RequestMapping(value = "/loanLedger")
public class LoanLedgerController extends BaseController {
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private UserMng userMng;
	
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/loan/loan_ledger_list";
	}
	/*
	 * 跳转到首页列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/list1")
	public String list1( ModelMap model) {
		return "/WEB-INF/view/expend/loan/loan_ledger_list1";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@RequestMapping(value = "/loanPage")
	@ResponseBody
	public JsonPagination noticePage(String loanString,LoanBasicInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = loanMng.ledgerPageList(loanString,bean, page, rows, getUser(),hasRole("R007"));
		List<LoanBasicInfo> li = (List<LoanBasicInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);
			//设置申请人姓名（id查姓名）,申请人所属部门
			User user = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(user.getName());
		}
		return getJsonPagination(p, page);
	}
}
