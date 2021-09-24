package com.braker.icontrol.budget.arrange.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.arrange.manager.DepartArrangeMng;
import com.braker.icontrol.budget.arrange.manager.DepartBasicOutMng;
import com.braker.icontrol.budget.arrange.manager.DepartProjectOutMng;
import com.braker.icontrol.budget.control.entity.TProExpend;
import com.braker.icontrol.budget.control.manager.TBasicExpendMng;
import com.braker.icontrol.budget.control.manager.TProExpendMng;

/**
 * 部门预算编制
 * @author zhanxun
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
@Controller
@RequestMapping("/arrange")
@SuppressWarnings("serial")
public class ArrangeController extends BaseController {

	@Autowired
	private DepartArrangeMng departArrangeMng;
	@Autowired
	private DepartBasicOutMng departBasicOutMng;
	@Autowired
	private DepartProjectOutMng departProjectOutMng;
	@Autowired
	private TBasicExpendMng tBasicExpendMng;
	@Autowired
	private TProExpendMng tProExpendMng;
	
	//列表
	@RequestMapping("/list/{menuType}")
	public String list(ModelMap model, @PathVariable String menuType){
		
		model.addAttribute("menuType", menuType);
		if ("1".equals(menuType)) {
			//部门预算编制
			return "/WEB-INF/view/budget/arrange/arrange-list";
		} else if ("2".equals(menuType)) {
			//预算编制审批
		} else if ("3".equals(menuType)) {
			//预算编制台账
		}
		return "/WEB-INF/view/budget/arrange/arrange-list";
	}
	
	//新增
	@RequestMapping("/add")
	public String add(ModelMap model){
		
		model.addAttribute("operationType", "add");
		model.addAttribute("currentUser", getUser());
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		model.addAttribute("arrCode", StringUtil.Random("ARR"));
		return "/WEB-INF/view/budget/arrange/arrange-add";
	}
	
	//修改
	@RequestMapping("/edit/{id}")
	public String edit(ModelMap model, @PathVariable Integer id){
		
		model.addAttribute("operationType", "edit");
		DepartArrange bean = departArrangeMng.findById(id);
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/budget/arrange/arrange-edit"; 
	}
	
	//审批
	@RequestMapping("/approve/{id}")
	public String approve(ModelMap model, @PathVariable Integer id){
		
		model.addAttribute("operationType", "approve");
		DepartArrange bean = departArrangeMng.findById(id);
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/budget/arrange/arrange-approve"; 
	}
	
	//查看
	@RequestMapping("/detail/{id}")
	public String detail(ModelMap model,@PathVariable Integer id){
		
		DepartArrange bean = departArrangeMng.findById(id);
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/budget/arrange/arrange-detail";
	}
	
	//保存
	//TODO 区分新增和修改保存
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ModelMap modeal, DepartArrange arrange, String saveType,
			String personOutJson, String commOutJson, String yearOutJson, String leastOutJson){
		
		double total = 0;//部门编制总金额
		try {
			if ("add".equals(saveType) || "edit".equals(saveType)) {
				//暂存
				arrange.setFlowStatus("0");
				arrange = departArrangeMng.save(saveType, arrange, getUser(), personOutJson, commOutJson, yearOutJson, leastOutJson);
			} else if ("pass".equals(saveType)) {
				//审批通过 (去下一环节)
				if (arrange != null && arrange.getFDCId() != null) {
					//新增后审批通过
					departArrangeMng.passArrange(arrange,getUser(),0);
				} else {
					//新增时审批通过
					arrange = departArrangeMng.save("add", arrange, getUser(), personOutJson, commOutJson, yearOutJson, leastOutJson);
					departArrangeMng.passArrange(arrange,getUser(),0);
				}
			} else if ("nopass".equals(saveType)) {
				//审批不通过
				departArrangeMng.noPassArrange(arrange,getUser());
			}
			return getJsonResult(true,Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,Result.saveFailureMessage);
		}
	}
	
	//预算编制/编制审批/编制台账
	@RequestMapping(value="/pageData/{menuType}")
	@ResponseBody
	public JsonPagination pageData1(@PathVariable String menuType, DepartArrange bean, String sort,String order,Integer page,Integer rows){
		
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p = departArrangeMng.pageList(bean, getUser(), page, rows, menuType);
    	
		return getJsonPagination(p,page);
	}
	
	//人员支出
	@ResponseBody
	@RequestMapping("/dataPerson")
	public List<TreeEntity> dataPerson(String id,ModelMap model){
		
		List<TreeEntity> list = departArrangeMng.getPersonOutFromControl(id, getUser().getDepartName());
		return list;
	}
	@ResponseBody
	@RequestMapping("/dataPerson2")
	public List<TreeEntity> dataPerson2(String id,String arrangeId,String isRelease,ModelMap model){
		
		List<TreeEntity> list = departArrangeMng.getPersonOutFromArrange(id,arrangeId,isRelease);
		return list;
	}
	//公用支出
	@ResponseBody
	@RequestMapping("/dataComm")
	public List<TreeEntity> dataComm(String id,ModelMap model){
		
		List<TreeEntity> list = departArrangeMng.getCommOutFromControl(id, getUser().getDepartName());
		return list;
	}
	@ResponseBody
	@RequestMapping("/dataComm2")
	public List<TreeEntity> dataComm2(String id,String arrangeId,String isRelease,ModelMap model){
		
		List<TreeEntity> list = departArrangeMng.getCommOutFromArrange(id,arrangeId, isRelease);
		return list;
	}
	//年度项目支出
	@ResponseBody
	@RequestMapping("/dataYear")
	public List<TProExpend> dataYear(Integer numId, String sort, String order){
		
		List<TProExpend> list = tProExpendMng.getYearProOuts(numId,getUser().getDepartName());
		return list;
	}
	@ResponseBody
	@RequestMapping("/dataYear2")
	public List<DepartProjectOut> dataYear2(Integer arrangeId, String sort, String order){
		
		List<DepartProjectOut> list = departProjectOutMng.getProjectOutByArrange(arrangeId, 1);
		return list;
	}
	//结转项目支出
	@ResponseBody
	@RequestMapping("/dataLeast")
	public List<TProExpend> dataLeast(Integer numId, String sort, String order, String operationType){
		
		List<TProExpend> list = tProExpendMng.getLeastProOuts(numId,getUser().getDepartName());
		
		return list;
	}
	@ResponseBody
	@RequestMapping("/dataLeast2")
	public List<DepartProjectOut> dataLeast2(Integer arrangeId, String sort, String order, String operationType){
		
		List<DepartProjectOut> list = departProjectOutMng.getProjectOutByArrange(arrangeId, 2);
		return list;
	}
}
