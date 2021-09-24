package com.braker.core.controller;

import javax.servlet.http.HttpServletResponse;

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
import com.braker.core.manager.SysLogMng;
import com.braker.core.model.SysLog;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/log")
public class SysLogController extends BaseController{

	@Autowired
	private SysLogMng logMng;
	
	@RequestMapping("/list")
	public String list(SysLog log, ModelMap model) {
		model.addAttribute("bean", log);
		return "/WEB-INF/gwideal_core/log/log_list";
	}
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(SysLog log,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=logMng.list(log,sort,order,page,rows);
		return getJsonPagination(p,page);
	}
	
	@RequestMapping("/toArchive")
	public String toArchive() {
		return "/WEB-INF/gwideal_core/log/archive";
	}
	
	@RequestMapping("/help")
	public String onLineHelpLog(String requestURI,HttpServletResponse response) {
		try {
			SysLog sysLog=new SysLog();
			sysLog.setCreator(getUser());
			sysLog.setOperateUrl(requestURI);
			sysLog.setOperateContent("在线帮助");
			logMng.save(sysLog);
			response.sendRedirect(request.getContextPath()+requestURI+"?t="+Math.random());
		} catch (Exception e) {
			// TODO: handle exception
			log.error("onLineHelpLog",e);
		}
		return null;
	}
	
	@RequestMapping("/archive")
	@ResponseBody
	public Result archive(String archiveDate,ModelMap model) {
		try {
			logMng.archive(archiveDate);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"归档成功！");
	}
}
