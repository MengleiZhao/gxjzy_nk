package com.braker.icontrol.cgmanage.cgexpert.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.braker.common.web.BaseController;


/**
 * 专家库白名单(台账)管理的控制层
 * 
 * @author 冉德茂
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
@Controller               
@RequestMapping(value = "/whiteexpertgl")
public class WhiteExpertController extends BaseController{

	
	/*
	 * 跳转到专家库列表页面（展示审核完成  黑名单状态为0的数据   功能是拉黑）
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		
		return "/WEB-INF/view/purchase_manage/cgexpert/white_expert_list";

	}

}
