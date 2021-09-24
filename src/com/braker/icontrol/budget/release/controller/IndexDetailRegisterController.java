package com.braker.icontrol.budget.release.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.entity.TIndexDetailRegister;
import com.braker.icontrol.budget.release.manager.IndexDetailRegisterMng;

@Controller
@RequestMapping("/indexDetailRegister")
public class IndexDetailRegisterController extends BaseController {
	
	@Autowired
	private IndexDetailRegisterMng detailRegisterMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;

	/**
	* <p>Description:项目支出登记明细页面 </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月2日
	 */
	@RequestMapping(value = "/registerProJsp")
	public String registerProJsp(ModelMap model,String proId) {
		model.addAttribute("proId", proId);//通过项目Id去查绚项目明细新增的登记明细
		return "/WEB-INF/view/budget/project/zhichu_detail";
	}
	
	/**
	 * <p>Description:新增项目支出登记明细页面 </p>
	 * <p>Company: </p> 
	 * @author zml
	 * @date 2021年8月3日
	 */
	@RequestMapping(value = "/add")
	public String add(ModelMap model,String proId) {
		model.addAttribute("proId", proId);//通过项目Id去查绚项目明细新增的登记明细
		TIndexDetailRegister bean = new TIndexDetailRegister();
		bean.setTime(new Date());
		
		User user = getUser();
		bean.setUserId(user.getId());
		bean.setUserName(user.getName());
		bean.setDepartmentId(user.getDepart().getId());
		bean.setDepartment(user.getDepart().getName());
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/budget/project/project-detail-register-add";
	}
	
	
	@RequestMapping(value="/jsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(TIndexDetailRegister bean,Integer page,Integer rows){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=detailRegisterMng.jsonPagination(bean, page, rows);
		
		return getJsonPagination(p,page);
	}
	
	/**
	 * 
	* <p>Description: 保存项目明细登记明细</p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月3日
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(TIndexDetailRegister bean) {
		
		try {
			detailRegisterMng.saveProDetailRegister(bean);
			return getJsonResult(true, Result.saveSuccessMessage);
		}catch (ServiceException se) {
			se.printStackTrace();
			return getJsonResult(false, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}

	}
	
	
	/**
	 * 通过项目id  获取基本支出明细
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月4日
	 */
	@RequestMapping(value = "/findByfProIdGetDetail")
	@ResponseBody
	public List<ComboboxJson> findByfProIdGetDetail(Integer id, Integer page, Integer rows){
		List<TProExpendDetail> expDetailList = tProExpendDetailMng.findByProperty("FProId", id);
			return getComboboxJson(expDetailList, null);
		}
}
