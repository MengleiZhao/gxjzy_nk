package com.braker.icontrol.budget.control.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.DataEntity;
import com.braker.common.entity.MergeCellInfo;
import com.braker.common.util.DataGridUtil;
import com.braker.common.web.BaseController;
import com.braker.icontrol.budget.control.entity.TProExpend;
import com.braker.icontrol.budget.control.manager.TBasicExpendMng;

/**
 * 基本支出
 * @author zhangxun
 * @createtime 2018-07-23
 * @updatetime 2018-06-23
 */
@Controller
@RequestMapping("/basicExpent")
@SuppressWarnings("serial")
public class BasicOutController extends BaseController  {

	@Autowired
	private TBasicExpendMng tBasicExpendMng;
	
	// 数据-科目控制数统计
	@ResponseBody
	@RequestMapping("/dataSubject")
	public List<DataEntity> dataSubject(ModelMap model, String subject, String depart, String year){
		
		List<DataEntity> list = tBasicExpendMng.getSubjectList(subject, depart, year);
		return list;
	}
	
	//数据-部门控制数统计
	@ResponseBody
	@RequestMapping("/dataDepart")
	public List<DataEntity> dataDepart(ModelMap model, String subject, String depart, String year){
		
		List<DataEntity> list = tBasicExpendMng.getDepartList(subject, depart, year, null);
		return list;
	}
}
