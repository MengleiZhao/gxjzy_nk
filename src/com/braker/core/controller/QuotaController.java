package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.Expenditure2Mng;
import com.braker.core.model.Economic;
import com.braker.core.model.ExpenditureBaseic2;
import com.braker.core.model.YearsBasic;

@Controller
@RequestMapping("/quotaConfig")
public class QuotaController extends BaseController{

	
	@Autowired
	private Expenditure2Mng expenditure2Mng;
	
	/**
	 * 跳转到支出事项限额配置主页
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/gwideal_core/quota/quota_list";
	}
	
	
	/**
	 * 树形图显示
	 * @param id
	 * @param fPeriod
	 * @param model
	 * @return
	 * @createtime 
	 * @author 
	 */
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,TreeEntity te,String fPeriod,ModelMap model) {
		// 内容。取所有列表，找出父菜单。
		List<ExpenditureBaseic2> eb2=null;
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		eb2=expenditure2Mng.findALL();
		for (int i = 0; i < eb2.size(); i++) {
			TreeEntity node = new TreeEntity();
			node.setText(eb2.get(i).gettEbName2());
			node.setId(eb2.get(i).gettEbId2().toString());
			list.add(node);
		}
		return list;
	}
	
	
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(String sort,String order,Integer page,Integer rows,ModelMap model){
		
		return null;
	}
}
