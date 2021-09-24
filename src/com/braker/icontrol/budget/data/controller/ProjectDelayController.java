package com.braker.icontrol.budget.data.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;

/**
 * 项目延期预警
 * @author shenfan
 * @createtime 2019-04-28
 * @updatetime 2019-04-28
 */
@Controller
@RequestMapping("/proDelay")

public class ProjectDelayController extends BaseController{
	
	@Autowired
	private TProBasicInfoMng projectMng;
	
	
	@RequestMapping("/proDelaylist")
	public String list2(ModelMap model){
		
	
		return "/WEB-INF/view/budget/data/project-delay";
		
	}
	
	
	
	
	@RequestMapping(value = "/proDelayPageData")
	@ResponseBody
	public JsonPagination projectPageData(Integer page, Integer rows,String fProCode,String fProName,String deptName) {
		Pagination p = projectMng.proDelayList(page,rows,fProCode,fProName,deptName);
		/*List<TProBasicInfo> dataList =  (List<TProBasicInfo>) p.getList();
		*/
		return getJsonPagination(p, page);
	}
}

