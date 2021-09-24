package com.braker.core.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.ExpenditureMatterMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.ExpenditureMatter;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.core.model.Vehicle;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;

/**
 * 支出事项表控制层
 * @author 陈睿超
 * @createtime 2018-10-18
 */
@Controller
@RequestMapping("/ExpenditureMatter")
public class ExpenditureMatterController extends BaseController{

	@Autowired
	private ExpenditureMatterMng expenditureMatterMng;
	
	@Autowired
	private RoleMng roleMng;
	
	@Autowired
	private VehicleMng vehicleMng;
	
	@Autowired
	private UserMng userMng;
	
	/**
	 * 跳转到主页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/gwideal_core/ExpenditureMatter/expenditureMatter_list";
	}

	/**
	 * 加载支出事项list页数据
	 * @param bean
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ExpenditureMatter bean,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Pagination p=expenditureMatterMng.list(bean, sort, order, page, rows);
    	List<ExpenditureMatter> li = (List<ExpenditureMatter>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		ExpenditureMatter em=new ExpenditureMatter();
		String da =null;
		da = "Z"+DateUtil.formatDate(new Date(), "mmss");
		if(expenditureMatterMng.findbycode(da)>0){
			da = "Z"+DateUtil.formatDate(new Date(), "mmss");
		}
		em.setFeCode(da);
		model.addAttribute("bean", em);
		model.addAttribute("openType", "EMadd");
		return "/WEB-INF/gwideal_core/ExpenditureMatter/expenditureMatter_add";
	}
	
	/**
	 * 保存
	 * @param bean
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ExpenditureMatter bean,ModelMap model){
		try {
			expenditureMatterMng.saveEM(bean,getUser());
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, Result.saveFailureMessage);
		}
	}
	
	/**
	 * 跳转到修改页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable String id,ModelMap model){
		ExpenditureMatter em = expenditureMatterMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", em);
		model.addAttribute("openType", "EMedit");
		return "/WEB-INF/gwideal_core/ExpenditureMatter/expenditureMatter_add";
	}
	
	/**
	 * 跳转到查看页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-10-18
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		ExpenditureMatter em = expenditureMatterMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", em);
		model.addAttribute("openType", "EMdetail");
		return "/WEB-INF/gwideal_core/ExpenditureMatter/expenditureMatter_detail";
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable String id,ModelMap model){
		try {
			expenditureMatterMng.deleteById(Integer.valueOf(id));
			return getJsonResult(false, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteFailureMessage);
		}
		
	}
	
	/**
	 * 查询所有的支出事项
	 * @param selected
	 * @return
	 */
	@RequestMapping("/lookupsJsonAll")
	@ResponseBody
	public List<ExpenditureMatter> lookupsJsonAll(String selected, String type, String meetingType, String trainingType, String placeEnd){
		List<ExpenditureMatter> list = expenditureMatterMng.getExpenditureMatterByType(type,getUser(), meetingType, trainingType, placeEnd);
		return list;
	}
	
	/**
	 * 通过支出事项的类型，查看相应的支出事项，并生产申请明细的List
	 * @author 叶崇晖
	 * @param type支出事项类型
	 * @return 支出申请的明细List
	 *//*
	@RequestMapping("/lookups")
	@ResponseBody
	public List<ApplicationDetail> lookups(String type) {
		List<ApplicationDetail> list = new ArrayList<ApplicationDetail>();
		List<ExpenditureMatter> li = expenditureMatterMng.getExpenditureMatterByType(type);
		for (int i = 0; i < li.size(); i++) {
			ApplicationDetail detail = new ApplicationDetail();
			detail.setCostDetail(li.get(i).getFeName());
			detail.setStandard(li.get(i).getFeStandard());
			list.add(detail);
		}
		return list;
	}*/
	
	/**
	 * 跳转适用角色选择页面
	 * @param model
	 * @return
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 */
	@RequestMapping("/choiceRoles")
	public String choiceRoles(ModelMap model){
		return "/WEB-INF/gwideal_core/ExpenditureMatter/expenditureMatter_user_list";
	}
	
	/**
	 * 查询所有角色
	 * @param model
	 * @return
	 * @author 叶崇晖
	 * @createtime 2019-01-10
	 */
	@RequestMapping("/roleList")
	@ResponseBody
	public List<Role> roleList() {
		List<Role> list = roleMng.findAll();
		return list;
	}

	/**
	 * 字典项查询
	 * @param parentCode 父节点编码
	 * @param selected 选中值
	 * @return
	 */
	@RequestMapping("/comboboxJson")
	@ResponseBody
	public List<ComboboxJson> comboboxJson(String code, String sonCode) {
		List<Vehicle> list = vehicleMng.findByCode(code);
		if(list.size()==1) {
			Vehicle bean = list.get(0);
			if(sonCode != null) {
				list = vehicleMng.findByParentCode(null);
				return getComboboxJson(list,bean.getParentCode());
			} else {
				if(bean.getParentCode()!=null) {
					list = vehicleMng.findByParentCode(bean.getParentCode());
				}
			}
		}
		return getComboboxJson(list,code);
	}
}
