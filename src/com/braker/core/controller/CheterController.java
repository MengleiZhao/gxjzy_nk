package com.braker.core.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;



import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.ftp.FileUpload;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.SystemCenterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;
import com.braker.core.model.SystemCenterAttac;


/**
 * 制度查找的controller
 * 本模块用于制度的查找
 * @author 冉德茂
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */

@Controller
@RequestMapping(value = "/cheter")
public class CheterController extends BaseController{
	
	@Autowired
	private CheterMng cheterMng;
	@Autowired
	private SystemCenterMng systemCenterMng;

	
	/*
	 * 制度查找
	 * @author 冉德茂
	 * @createtime 2018-07-19
	 * @updatetime 2018-07-19
	 */
	@RequestMapping(value = "/systemFind")
	@ResponseBody
	public String findSystem(Integer id) {
		SystemCenterAttac sca = cheterMng.getSystemCenterAttac(id);
		String fileUrl=sca.getFileSrc()+"/"+sca.getAttacName();
		
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		fileUrl="http://"+url+":8080/ftp/ff/"+fileUrl;
		return fileUrl;
	}
	
	/*
	 * 制度查看 
	 */
	@RequestMapping(value = "/detail/{id}")
	public String detail(@PathVariable Integer id, ModelMap model) {
		
		List<CheterInfo> cheter = systemCenterMng.getList();
		model.addAttribute("cheter", cheter);
		return "/WEB-INF/gwideal_core/notice/notice_detail";
	}

	

	



	
}
