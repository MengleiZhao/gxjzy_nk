package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.PerformanceIndicator1Mng;
import com.braker.core.manager.PerformanceIndicator2Mng;
import com.braker.core.manager.PerformanceIndicator3Mng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PerformanceIndicator1;
import com.braker.core.model.PerformanceIndicator2;
import com.braker.core.model.PerformanceIndicator3;
import com.braker.core.model.PurchasingCatalogues;
import com.sun.xml.internal.ws.util.StringUtils;

/**
 * 绩效指标管理控制层
 * @author 陈睿超
 *
 */
@Controller
@RequestMapping("/PerformanceIndicator")
public class PerformanceIndicatorController extends BaseController{

	
	@Autowired
	private PerformanceIndicator1Mng performanceIndicator1Mng;
	
	@Autowired
	private PerformanceIndicator2Mng performanceIndicator2Mng;
	
	@Autowired
	private PerformanceIndicator3Mng performanceIndicator3Mng;
	
	/**
	 * 跳转到绩效指标管理List页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_list";
	}
	
	/**
	 * 一级绩效指标List数据
	 * @param pi1 查询条件 
	 * @param model
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/PerformanceList1")
	@ResponseBody
	public JsonPagination PerformanceListJson1(PerformanceIndicator1 pi1,ModelMap model,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = performanceIndicator1Mng.List(pi1, page, rows);
		List<PerformanceIndicator1> li= (List<PerformanceIndicator1>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 二级绩效指标List数据
	 * @param pi2  查询条件
	 * @param model
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/PerformanceList2")
	@ResponseBody
	public JsonPagination PerformanceListJson2(PerformanceIndicator2 pi2,ModelMap model,String sort,String order,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = performanceIndicator2Mng.List(pi2, page, rows);
		List<PerformanceIndicator2> li= (List<PerformanceIndicator2>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到添加页面
	 * @param leixing
	 * @param model
	 * @param fP1
	 * @return
	 */
	@RequestMapping("/add")
	public String add(String leixing,ModelMap model,String fP1){
		String code="PI"+String.valueOf(StringUtil.random8()).substring(4);
		model.addAttribute("openType", "add");
		if(leixing.equals("1")){
			PerformanceIndicator1 pi1=new PerformanceIndicator1();
			pi1.setfPerCode1(code);
			model.addAttribute("bean", pi1);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add1";
		}else {
			PerformanceIndicator2 pi2=new PerformanceIndicator2();
			pi2.setfPerCode2(code+String.valueOf(StringUtil.random8()).substring(4));
			pi2.setfP1(Integer.valueOf(fP1));
			model.addAttribute("bean", pi2);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add2";
		}
		
	}
	
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,TreeEntity te,ModelMap model) {
		List<TreeEntity> list = new ArrayList<TreeEntity>();
		
		List<PerformanceIndicator1> list1 = new ArrayList<PerformanceIndicator1>();
		List<PerformanceIndicator2> list2 = new ArrayList<PerformanceIndicator2>();
		System.out.println(id);
		if(StringUtil.isEmpty(id)) {
			//加入"请选择"
			TreeEntity zero = new TreeEntity();
			zero.setText("-请选择-");
			zero.setId("0");
			list.add(zero);
			
			list1 = performanceIndicator1Mng.getList();
			for (int i = 0; i < list1.size(); i++) {
				TreeEntity node = new TreeEntity();
				node.setText(list1.get(i).getfPerName1());//科目名称
				node.setId(list1.get(i).getfPerId1().toString());//当前科目的编码
				node.setState("closed");
				node.setHaveChild("true");//有下级节点
				list.add(node);
			}
		} else {
			list2 = performanceIndicator2Mng.getList(Integer.valueOf(id));
			for (int i = 0; i < list2.size(); i++) {
				TreeEntity node = new TreeEntity();
				PerformanceIndicator1 model1 = performanceIndicator1Mng.findById(Integer.valueOf(id));
				
				node.setText(list2.get(i).getfPerName2());//科目名称
				node.setId(list2.get(i).getfPerId2().toString());//当前科目的编码
				node.setCol1(model1.getfPerId1().toString());
				node.setCol2(model1.getfPerName1());
				node.setLeaf(true);
				node.setHaveChild("false");
				list.add(node);
			}
		}
		return list;
	}
	/**
	 * 保存修改
	 * @param leixing
	 * @param pi1
	 * @param pi2
	 * @param model
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(String leixing,PerformanceIndicator1 pi1,PerformanceIndicator2 pi2,ModelMap model){
		try {
			if(leixing.equals("1")){
				performanceIndicator1Mng.merge(pi1);
				return getJsonResult(true, Result.saveSuccessMessage);
			}else {
				//pi2.setPi1(performanceIndicator1Mng.findById(pi2.getfP1()));
				performanceIndicator2Mng.merge(pi2);
				return getJsonResult(true, Result.saveSuccessMessage);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}

	/**
	 * 跳转到修改页面
	 * @param id
	 * @param leixing
	 * @param model
	 * @param fP1
	 * @return
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,String leixing,ModelMap model,String fP1){
		model.addAttribute("openType", "edit");
		if(leixing.equals("1")){
			PerformanceIndicator1 pi1=performanceIndicator1Mng.findById(Integer.valueOf(id));
			model.addAttribute("bean", pi1);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add1";
		}else {
			PerformanceIndicator2 pi2=performanceIndicator2Mng.findById(Integer.valueOf(id));
		//	pi2.setfP1(pi2.getPi1().getfPerId1());
			model.addAttribute("bean", pi2);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add2";
		}
		
	}
	
	/**
	 * 跳转到查看页面
	 * @param id
	 * @param leixing
	 * @param model
	 * @param fP1
	 * @return
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,String leixing,ModelMap model,String fP1){
		model.addAttribute("openType", "detail");
		if(leixing.equals("1")){
			PerformanceIndicator1 pi1=performanceIndicator1Mng.findById(Integer.valueOf(id));
			model.addAttribute("bean", pi1);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add1";
		}else {
			PerformanceIndicator2 pi2=performanceIndicator2Mng.findById(Integer.valueOf(id));
			//pi2.setfP1(pi2.getPi1().getfPerId1());
			model.addAttribute("bean", pi2);
			return "/WEB-INF/gwideal_core/PerformanceIndicator/PerformanceIndicator_add2";
		}
		
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,String leixing,ModelMap model,String fP1){
		try {
			if(leixing.equals("1")){
				PerformanceIndicator1 pi1=performanceIndicator1Mng.findById(Integer.valueOf(id));
				performanceIndicator1Mng.delete(pi1);
				return getJsonResult(true, Result.deleteSuccessMessage);
			}else {
				PerformanceIndicator2 pi2=performanceIndicator2Mng.findById(Integer.valueOf(id));
				performanceIndicator2Mng.delete(pi2);
				return getJsonResult(true, Result.deleteSuccessMessage);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(true, Result.deleteFailureMessage);
		}
	}
	
	/**
	 * 加载绩效指标列表数据
	 */
	@RequestMapping(value = "/performanceIndicatorJson")
	@ResponseBody
	public List<ComboboxJson> performanceIndicatorJson(String id,String selected){
		List<PerformanceIndicator1> list = performanceIndicator1Mng.findAll();
		return getAllStreetComboboxJson(list,selected);
	}
	/**
	 * 加载绩效指标列表数据
	 */
	@RequestMapping(value = "/performanceIndicatorTwoJson")
	@ResponseBody
	public List<ComboboxJson> performanceIndicatorTwoJson(String id,String selected2){
		List<PerformanceIndicator2> list2 = performanceIndicator2Mng.findByProperty("pi1", Integer.valueOf(id));
		return getAllStreetComboboxJson(list2,selected2);
	}
	
	/**
	 * 根据编号和名字查询采购品目明细信息
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月4日
	 */
	@ResponseBody
	@RequestMapping(value = "/getPerformanceIndicator3")
	public List<ComboboxJson> getPerformanceIndicator3(){
		List<PerformanceIndicator3> list = performanceIndicator3Mng.findAll();
		return getComboboxJsonNoDefault(list,"");
	}
}
