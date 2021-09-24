package com.braker.core.controller;

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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionClassMgrMng;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.ProMgrLevelMng;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.Lookups;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.YearsBasic;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;

/**
 * 项目管理控制层
 * @author 陈睿超
 */
@Controller
@RequestMapping("/ProMgrLevel")
public class ProMgrLevelController extends BaseController{

	@Autowired
	private ProMgrLevelMng proMgrLevelMng;
	@Autowired
	private ProMgrLevel2Mng proMgrLevel2Mng;
	@Autowired
	private FunctionClassMgrMng functionClassMgrMng;
	
	/**
	 * 跳转到一二级分类管理List页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_list";
	}
	
	/**
	 * 加载一级分类List页面数据
	 * @param proMgrLevel1 搜索条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination jsonPagination(ProMgrLevel1 proMgrLevel1,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = proMgrLevelMng.list1(proMgrLevel1, sort, order, page, rows);
		List<ProMgrLevel1> li= (List<ProMgrLevel1>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 加载二级分类List页面数据
	 * @param proMgrLevel2 搜索条件
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/JsonPagination2")
	@ResponseBody
	public JsonPagination jsonPagination2(ProMgrLevel2 proMgrLevel2,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p = proMgrLevel2Mng.list(proMgrLevel2, sort, order, page, rows);
		List<ProMgrLevel2> li= (List<ProMgrLevel2>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
		p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 弹出一级分类的新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/add1")
	public String add1(ModelMap model){
		model.addAttribute("openType", "add");
		ProMgrLevel1 p1 = new ProMgrLevel1();
		p1.setfLevCode1(proMgrLevelMng.maxfLevCode1());
		model.addAttribute("bean", p1);
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add1";
	}
	
	/**
	 * 弹出二级分类的新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/add2")
	public String add2(Integer a, ModelMap model){
		model.addAttribute("openType", "add");
		ProMgrLevel2 pml2=new ProMgrLevel2();
		ProMgrLevel1 pml=new ProMgrLevel1();
		//pml.setfLevCode1(String.valueOf(a));
		pml=proMgrLevelMng.findById(a);
		pml2.setPml(pml);//maxfLevCode2
		model.addAttribute("bean", pml2);
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add2";
	}
	
	/**
	 * 保存更新一级分类
	 * @param proMgrLevel1 保存数据
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/save1")
	@ResponseBody
	public Result save1(ProMgrLevel1 proMgrLevel1,ModelMap model){
		try {
			if(StringUtil.isEmpty(String.valueOf(proMgrLevel1.getfLvId1()))){
				Integer codeNumber = proMgrLevelMng.findbyFLevCode1(proMgrLevel1.getfLevCode1());
				if(codeNumber>0){
					return getJsonResult(false,"一级分类代码重复，请重新填写！");
				}
				proMgrLevelMng.saveOrUpdate(proMgrLevel1);
				return getJsonResult(true,"操作成功！");
			}else {
				Integer codeNumber = proMgrLevelMng.findbyFLevCode1NotMine(proMgrLevel1.getfLevCode1(),proMgrLevel1.getfLvId1());
				if(codeNumber>0){
					return getJsonResult(false,"一级分类代码重复，请重新填写！");
				}
				proMgrLevelMng.saveOrUpdate(proMgrLevel1);
				return getJsonResult(true,"操作成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误,请联系管理员！");
		}
	}
	
	/**
	 * 保存更新二级分类
	 * @param proMgrLevel1 保存数据
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/save2")
	@ResponseBody
	public Result save2(ProMgrLevel2 proMgrLevel2,ModelMap model){
		try {
			if(StringUtil.isEmpty(String.valueOf(proMgrLevel2.getfLvId2()))){
				ProMgrLevel1 pml1 = proMgrLevelMng.findById(proMgrLevel2.getA());
				proMgrLevel2.setPml(pml1);
				proMgrLevel2Mng.saveOrUpdate(proMgrLevel2);
				return getJsonResult(true,"操作成功！");
			}else{
				ProMgrLevel1 pml1 = proMgrLevelMng.findById(proMgrLevel2.getA());
				proMgrLevel2.setPml(pml1);
				proMgrLevel2Mng.saveOrUpdate(proMgrLevel2);
				return getJsonResult(true,"操作成功！");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误,请联系管理员！");
		}
	}
	
	/**
	 * 弹出一级分类查看页面
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/detail1/{id}")
	public String detail1(@PathVariable String id ,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("bean", proMgrLevelMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add1";
	}
	
	/**
	 * 弹出二级分类查看页面
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/detail2/{id}")
	public String detail2(@PathVariable String id ,ModelMap model){
		model.addAttribute("openType", "detail");
		model.addAttribute("bean", proMgrLevel2Mng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add2";
	}
	
	/**
	 * 弹出一级分类修改页面
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/edit1/{id}")
	public String edit1(@PathVariable String id ,ModelMap model){
		model.addAttribute("openType", "edit");
		model.addAttribute("bean", proMgrLevelMng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add1";
	}
	
	/**
	 * 弹出二级分类修改看页面
	 * @param id 主键id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/edit2/{id}")
	public String edit2(@PathVariable String id ,ModelMap model){
		model.addAttribute("openType", "edit");
		model.addAttribute("bean", proMgrLevel2Mng.findById(Integer.valueOf(id)));
		return "/WEB-INF/gwideal_core/projectMGR/projectMGR_add2";
	}
	
	/**
	 * 删除一级分类
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/delete1/{id}")
	@ResponseBody
	public Result delete1(@PathVariable String id,ModelMap model){
		try {
			proMgrLevelMng.deleteAll(Integer.valueOf(id));
			return getJsonResult(true, "操作成功！");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误,请联系管理员！");
		}
	}
	/**
	 * 删除二级分类
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/delete2/{id}")
	@ResponseBody
	public Result delete2(@PathVariable String id,ModelMap model){
		try {
			proMgrLevel2Mng.deleteById(Integer.valueOf(id));
			return getJsonResult(true, "操作成功！");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false,"系统错误,请联系管理员！");
		}
	}
	
	/**
	 * 查询所有功能分类
	 * @param selected
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/lookupsJsonFFunctionClass")
	@ResponseBody
	public List<FunctionClassMgr> assName(String selected){
		List<FunctionClassMgr> list=functionClassMgrMng.findAll(selected);
		return list;
	}
	
	/**
	 * 查询字典里资产类型
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-09-07
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = proMgrLevelMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
}
