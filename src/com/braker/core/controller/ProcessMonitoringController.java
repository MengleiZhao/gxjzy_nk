package com.braker.core.controller;

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
import com.braker.core.model.Proposer;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessDefinMng;
/**
 * 流程监控控制层
 * @author 陈睿超
 *
 */
@Controller
@RequestMapping("/Monitoring")
public class ProcessMonitoringController extends BaseController{

	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	/**
	 * 跳转到监控的主页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/gwideal_core/ProcessMonitoring/monitoring_list";
	}
	
	/**
	 * 加载监控list页面的数据
	 * @param tProcessDefin 搜索的条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-30
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(TProcessDefin tProcessDefin,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		try {
			if(rows==null){rows=SimplePage.DEF_COUNT;}
			if(page==null){page=1;}
			Pagination p = tProcessDefinMng.PMlist(tProcessDefin, page, rows);
			List<TProcessDefin> li= (List<TProcessDefin>) p.getList();
	    	for (int i = 0; i < li.size(); i++) {
				li.get(i).setNumber(i+1);
			}
	    	p.setList(li);
			return getJsonPagination(p, page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}
		
	}
}
