package com.braker.icontrol.expend.apply.controller;

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
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;

/**
 * 支出申请台账的控制层
 * 本模块用于支出申请台账的审批及查看
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
@Controller
@RequestMapping(value = "/applyLedger")
public class ApplyLedgerController extends BaseController{
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private UserMng userMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/expend/apply/ledger/apply_ledger_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@RequestMapping(value = "/applyPage")
	@ResponseBody
	public JsonPagination noticePage(ApplicationBasicInfo bean,String applyType,Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = applyMng.ledgerPageList(bean, applyType,page, rows, getUser());
		List<ApplicationBasicInfo> li = (List<ApplicationBasicInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);
			//设置申请人姓名（id查姓名）,申请人所属部门
			User user = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(user.getName());
		}
		return getJsonPagination(p, page);
	}
	
	/**
	 * 查询可以申请报销的当前登录人的事前申请信息
	 * @param applyType
	 * @return
	 */
	@RequestMapping(value = "/reimburseList")
	@ResponseBody
	public List<ApplicationBasicInfo> reimburseList(String applyType,String reqTime) {
		 List<ApplicationBasicInfo> list=applyMng.reimburseList(applyType, getUser(),reqTime);
		 if (list != null && list.size() > 0) {
				for (ApplicationBasicInfo a: list) {
					User user = userMng.findById(a.getUser());
					a.setUserName(user.getName());
				}
				return list;
			}		
			return null;
	}
}
