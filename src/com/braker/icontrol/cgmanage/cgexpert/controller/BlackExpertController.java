package com.braker.icontrol.cgmanage.cgexpert.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.Proposer;
import com.braker.icontrol.cgmanage.cgexpert.manager.CgExpertMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertBlackMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.manager.TProcessCheckMng;


/**
 * 专家库黑名单管理的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Controller               
@RequestMapping(value = "/blackexpertgl")
public class BlackExpertController extends BaseController{
	@Autowired
	private CgExpertMng expertMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private ExpertBlackMng expertBlackMng;
	/*
	 * 跳转到专家库列表页面（黑名单状态的专家）
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		
		return "/WEB-INF/view/purchase_manage/cgexpert/black_expert_list";

	}
	/*
	 * 移入黑名单  页面跳转
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/inblack")
	public String inblack( ModelMap model,String id) {
		//id是供应商的主键id
		model.addAttribute("feid", id);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"ZJKHMD", getUser().getDpID(),null,null, null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgexpert/black_expert_add";
		
	}
	/*
	 * 移出黑名单  页面跳转
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@RequestMapping(value = "/moveoutblack")
	public String moveoutblack( ModelMap model,String id) {
		//id是供应商的主键id
		model.addAttribute("feid", id);
		return "/WEB-INF/view/purchase_manage/cgexpert/black_expert_delete";
		
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
			p.setList(expertMng.movehistory(Integer.valueOf(id)));
		}
		return getJsonPagination(p, 0);
	}
	/*
	 * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@RequestMapping(value = "/moveblack")
	@ResponseBody	
	public Result moveblack(ExpertBlackInfo expertBlackInfo,ModelMap model) {
		try {
			expertMng.moveblack(expertBlackInfo, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}

	/*
	 * 加入黑名单操作
	  * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@RequestMapping(value = "/moveintoblack")
	@ResponseBody	
	public Result moveintoblack(ExpertBlackInfo expertBlackInfo,ModelMap model) {
		try {
			expertMng.moveblack(expertBlackInfo, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 *  专家库黑名单删除记录
	 * @author 焦广兴
	 * @createtime 2019-06-21
	 * @updatetime 2019-06-21
	 */
	@RequestMapping(value = "/deleteBlack")
	@ResponseBody	
	public Result deleteBlack(ExpertBlackInfo bean,ModelMap model) {
		try {
			//只允许删除被退回的记录
			expertBlackMng.deleteBlackExpert(String.valueOf(bean.getFeId()),String.valueOf(bean.getFeBId()));
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
}
