package com.braker.icontrol.budget.adjust.controller;

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
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.manager.OutsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexExteAdLstMng;

/**
 * 预算外部修改台账的控制层
 * @author 叶崇晖
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
@Controller
@RequestMapping(value = "/outsideLedger")
public class OutsideLedgerController extends BaseController {
	@Autowired
	private OutsideAdjustMny adjustMny;
	@Autowired
	private TIndexExteAdLstMng adLstMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/budget/adjust/outsideLedger-list";
	}
	
}	
