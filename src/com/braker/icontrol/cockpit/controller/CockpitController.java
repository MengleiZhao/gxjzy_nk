package com.braker.icontrol.cockpit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.cockpit.manager.CockpitMng;

/**
 * 驾驶舱
 * @author zhangxun
 * @createtime 2018-10-24
 * @updatetime 2018-10-24
 */
@Controller
@RequestMapping("/cockpit")
public class CockpitController extends BaseController {

	@Autowired
	public CockpitMng cockpitMng;
	@Autowired
	public DepartMng departMng;
	
	/**
	 * 驾驶舱主页面 
	 */
	@RequestMapping("/list")
	public String list(ModelMap model, String year){

		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
	/*	//各部门差旅费
		List<String[]> departTravels = cockpitMng.getDepartTravelSum(getUser().getDepart(),"proper",year);
		model.addAttribute("departTravels", departTravels);*/
		//当前年度 第一张图右上角年度
		model.addAttribute("currentYear", DateUtil.getCurrentYear());
		//查询框-当前年至2016年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		/*//查询框-部门(已经替换成下拉树结构)
		model.addAttribute("departList",departMng.getSonCompany(getUser().getDepart()));*/
		//默认查询年度
		model.addAttribute("defaultYear", DateUtil.getCurrentYear());
		//默认查询部门
		User user = getUser();
		String userName = user.getName();
		if (user.getRoleName().contains("校长") || userName.contains("管理员")) {
			model.addAttribute("defaultDepartId", "557743AE-4987-4B5A-ADBC-32E1D981044B");
		} else {
			model.addAttribute("defaultDepartId", user.getDepart()!=null? user.getDepart().getId():"");
		} 
		
		return "/WEB-INF/view/cockpit1/cockpit-list";
	}
	/**
	 * 主页面（旧版本）
	 */
	@RequestMapping("/list1")
	public String list1(ModelMap model){
		/*cockpitMng.getPublicExpensesDataSum(new String[]{"基本工资","奖金"});*/
		return "/WEB-INF/view/cockpit/Copy of cockpit-list.jsp";
	}
	
	
	
	/**     ---------------以下为返回数据-----------------          **/
	
	/**
	 * 获取单位列表
	 */
	/*public List<TreeEntity> departTree(String id){
		//获得数据
		List<Depart> departList = null;
		if (StringUtil.isEmpty(id)) {
			departList = departMng.getRoots();
		}
		//转换为tree
		List<TreeEntity> treeList = new ArrayList<>();
		return treeList;
	}
	*/
	
	
	/**
	 * 培训、会议执行情况
	 */
	@RequestMapping("/data1")
	@ResponseBody
	public List<String[]> data1(String year, String departId){
		
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		Depart depart = null;
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		
		List<String[]> result = new ArrayList<>();
		//培训数量
		String[] num1 = cockpitMng.getTrainDataCount(depart,year,getUser()); 
		//培训金额
		String[] sum1 = cockpitMng.getTrainDataSum(depart,year,getUser());
		//会议数量
		String[] num2 = cockpitMng.getMeetingDataCount(depart,year,getUser());
		//会议金额
		String[] sum2 = cockpitMng.getMeetingDataSum(depart,year,getUser());
		
		result.add(num1);
		result.add(sum1);
		result.add(num2);
		result.add(sum2);
		
		return result;
	}
	
	/**
	 * 部门预算执行排名
	 */
	@RequestMapping("/departProgress")
	@ResponseBody
	public Map<String, Double[]> departProgress(String year, String departId){
		
		Depart depart = null;
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		
		Map<String, Double[]> map = cockpitMng.getBudgetProjectDataSum(depart,year,getUser());
		return map;
	}
	
	/**
	 * 项目执行进度(执行率前五)
	 * @return
	 */
	@RequestMapping("/projectProgressTopFive")
	@ResponseBody
	public List<HashMap<Object, Object>> projectProgressTopFive(String year, String departId){
		
		Depart depart = null;
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		List<HashMap<Object, Object>> list = cockpitMng.getprojectProgressTopOrLastFive("desc",depart,year,getUser());
		return list;
	}
	
	/**
	 * 项目执行进度(执行率后五)
	 * @return
	 */
	@RequestMapping("/projectProgressLastFive")
	@ResponseBody
	public List<HashMap<Object, Object>> projectProgressLastFive(String year, String departId){
		
		Depart depart = null;
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		List<HashMap<Object, Object>> list = cockpitMng.getprojectProgressTopOrLastFive("asc",depart,year,getUser());
		return list;
	}
	
	/**
	 * 表盘显示数据 三公经费
	 * @param indexName 要查的指标名称
	 * @return Map类型
	 */
	@RequestMapping("/dialData")
	@ResponseBody
	public Map<String, Double[]> test(String indexName, String year, String departId){
		//5 公务接待申请 6 公务用车申请 7公务出国申请
		if("因公出国出境费用".equals(indexName)){
			indexName="7";
		}else if("公务接待费".equals(indexName)){
			indexName="5";
		}else if("公务用车购置与运维费".equals(indexName)){
			indexName="6";
		}
		
		Depart depart = null;
		boolean isflag=StringUtil.isEmpty(departId);
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		
		Map<String, Double[]> map = cockpitMng.getPublicExpensesDataSum(new String[]{indexName}, depart,year,getUser());
		List<Map<String, Double[]>> list = new ArrayList<Map<String, Double[]>>();
		list.add(map);
		
		return map;
	}
	
	/**
	 * 差旅费（带排序） 
	 */
	@RequestMapping("/travelFunds")
	@ResponseBody
	public List<String[]> travelFunds(ModelMap model, String orderType, String year, String departId){
		
		if (StringUtil.isEmpty(year)) year = DateUtil.getCurrentYear();
		Depart depart = null;
		if (StringUtil.isEmpty(departId)) {
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		} 
		
		List<String[]> departTravels = cockpitMng.getDepartTravelSum(depart,orderType,year,getUser());
		model.addAttribute("departTravels", departTravels);
		return departTravels;
	}
	
	/**
	 * 单位结构
	 */
	@RequestMapping(value="/departTree")
	@ResponseBody
	public List<TreeEntity> departTree(String id) {
		
		User curretUser = getUser();
		
		List<Role> roleList=curretUser.getRoles();
		List<TreeEntity> treeList = null;
		for(Role role:roleList){
			if(roleList.size()>0){
				if("校长".equals(roleList.get(0).getName())&&"主管校长".equals(roleList.get(1).getName())){
					treeList = departTree1(id);
					return treeList;
				}
			}
		if ("校长".equals(role.getName()) || "系统管理员".equals(role.getName())) {
			treeList = departTree1(id);
		} else if ("主管校长".equals(role.getName())) {
			List<Depart> departList=departMng.findByProperty("manager", curretUser);
			treeList = departTree2(curretUser.getName(),departList);
		}else {
			treeList = departTree3(curretUser.getDepartName());
		}
		}
		return treeList;
	}
	
	//普通人员登录
	public List<TreeEntity> departTree3(String departName) {
		
		String id = "557743AE-4987-4B5A-ADBC-32E1D981044B";
		
		
		// 内容。取所有列表，找出父菜单。
		List<Depart> listDepart  = departMng.getChild(id);
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(null!=listDepart && listDepart.size()>0){
			for(Depart d:listDepart){
				TreeEntity ft=new TreeEntity();
				ft.setId(d.getId());
				ft.setText(d.getName());
				if(null!=d.getChildren() && d.getChildren().size()>0){
					ft.setState("closed");
				}else{
					ft.setLeaf(true);
				}
				if (departName.equals(ft.getText())) {
					list.add(ft);
				}
			}
		}
		return list;
	}
	
	//高级人员登录
	public List<TreeEntity> departTree2(String userName,List<Depart> departList) {
		
		String id = "557743AE-4987-4B5A-ADBC-32E1D981044B";
		
		Map<String,String> map = new HashMap<>();
		String deptIdStr="";
		//主管校长可以查看自己主管的所有部门
		for(Depart depart:departList){
			if("".equals(deptIdStr)){
				deptIdStr=depart.getName();
			}else{
				deptIdStr=deptIdStr+","+depart.getName();
			}
		}
		map.put(userName, deptIdStr);
		// 内容。取所有列表，找出父菜单。
		List<Depart> listDepart = departMng.getChild(id);
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(null!=listDepart && listDepart.size()>0){
			for(Depart d:listDepart){
				TreeEntity ft=new TreeEntity();
				ft.setId(d.getId());
				ft.setText(d.getName());
				if(null!=d.getChildren() && d.getChildren().size()>0){
					ft.setState("closed");
				}else{
					ft.setLeaf(true);
				}
				if (map.get(userName).contains(ft.getText())) {
					list.add(ft);
				}
			}
		}
		return list;
	}
	
	//最高人员登录
	public List<TreeEntity> departTree1(String id) {
		// 内容。取所有列表，找出父菜单。
		List<Depart> listDepart=null;
		if(null==id){
			listDepart = departMng.getRoots();
		}else{
			listDepart = departMng.getChild(id);
		}
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(null!=listDepart && listDepart.size()>0){
			for(Depart d:listDepart){
				TreeEntity ft=new TreeEntity();
				ft.setId(d.getId());
				ft.setText(d.getName());
				if(null!=d.getChildren() && d.getChildren().size()>0){
					ft.setState("closed");
				}else{
					ft.setLeaf(true);
				}
				list.add(ft);
			}
		}
		return list;
	}

}
