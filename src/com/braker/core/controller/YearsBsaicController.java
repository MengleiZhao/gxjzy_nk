package com.braker.core.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.model.YearsBasic;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;

@Controller
@RequestMapping("/YearsBsaic")
public class YearsBsaicController extends BaseController{

	@Autowired
	private YearsBasicMng yearsBasicMng;
	@Autowired
	private EconomicMng economicMng;
	
	/**
	 * 跳转到主页面
	 * @param model
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/mainList")
	public String mainList(ModelMap model){
		return "/WEB-INF/gwideal_core/Years_Basic/YearsBasic_list";
	}
	
	/**
	 * 显示主页面的数据
	 * @param yearsBasic
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination dataList(YearsBasic yearsBasic,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p =yearsBasicMng.list(yearsBasic,sort, order, page, rows);
		List<YearsBasic> li= (List<YearsBasic>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 新增页面跳转
	 * @param model
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/add")
	public String addHtml(ModelMap model){
		model.addAttribute("openType", "add");
		return "/WEB-INF/gwideal_core/Years_Basic/yearsBasic_add";
	}
	
	/**
	 * 跳转修改页面
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/edit/{id}")
	public String editHtml(@PathVariable String id,ModelMap model){
		model.addAttribute("bean",yearsBasicMng.findById(Integer.valueOf(id)));
		model.addAttribute("openType", "edit");
		return "/WEB-INF/gwideal_core/Years_Basic/yearsBasic_add";
	}
	
	
	/**
	 * 跳转修改页面
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		model.addAttribute("bean",yearsBasicMng.findById(Integer.valueOf(id)));
		model.addAttribute("openType", "detail");
		return "/WEB-INF/gwideal_core/Years_Basic/yearsBasic_add";
	}
	
	/**
	 * 保存数据（添加、修改）
	 * @param yearsBasic
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result yearsBasic_add(YearsBasic yearsBasic){
		try {
			if(StringUtil.isEmpty(String.valueOf(yearsBasic.getFtName()))){
				return getJsonResult(false,"请填写模板名称（年份）！");
			}else if(StringUtil.isEmpty(yearsBasic.getfPeriod())){
				return getJsonResult(false,"请填写期次维度！");
			}else{
				yearsBasicMng.save(yearsBasic, getUser());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
		
	}
	
	/**
	 * 删除
	 * @param id
	 * @param model
	 * @return
	 * @createtime 2018-06-09
	 * @author crc
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			if(StringUtil.isEmpty(id)){
				return getJsonResult(false,"请选择你要删除的对象！");
			}
			yearsBasicMng.yearsBasic_delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败！");
		}
		return getJsonResult(true,"删除成功！");
	}
	
	/**
	 * 跳转到另存为模板页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/copymodel/{id}")
	public String copymodel(@PathVariable String id,ModelMap model){
		model.addAttribute("bean",yearsBasicMng.findById(Integer.valueOf(id)));
		model.addAttribute("openType", "copymodel");
		return "/WEB-INF/gwideal_core/Years_Basic/yearsBasic_add";
	}
	
	/**
	 * 复制年度模板
	 * @param id
	 * @param yearsBasic
	 * @param model
	 * @return
	 */
	@RequestMapping("/copyYears/{id}")
	@ResponseBody
	public Result copyYears(@PathVariable String id,YearsBasic yearsBasic,ModelMap model){
		try {
			List<YearsBasic> yearList = yearsBasicMng.findByYear(yearsBasic.getfPeriod());
			if(yearList.size()>0){//原来已经有该年度的经济分类数据模板了
				return getJsonResult(false,"已有该年度的经济科目模板，请不要重复添加！");
			}else{
				YearsBasic yb=new YearsBasic();
				yb.setfRemark(yearsBasic.getfRemark());
				yb.setFtName(yearsBasic.getFtName());
				yb.setfPeriod(yearsBasic.getfPeriod());
				yb.setCreateTime(new Date());
				yb.setCreator(getUser().getAccountNo());
				yb.setFbId(StringUtil.random8());
				yearsBasicMng.saveOrUpdate(yb);
				economicMng.copyEconomic(yearsBasic.getFbId(),yb);
				return getJsonResult(true,"操作成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误,请联系管理员！");
		}
	}
}
