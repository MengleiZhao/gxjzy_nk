package com.braker.core.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.braker.common.web.BaseController;
import com.braker.core.model.User;

/**
 * 审批页面弹出controller
 * @author 叶崇辉
 *
 */
@Controller
@RequestMapping("/checkWin")
public class OpenCheckWinController extends BaseController {
	
	@RequestMapping(value = "/open")
	public String open(String result, ModelMap model) {
		User user = getUser();
		model.addAttribute("checkWinUserName", user.getName());
		model.addAttribute("checkWinResult", result);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		model.addAttribute("checkWinTime",format.format(new Date()));
		
		return "/WEB-INF/view/check_win";
	}
}
