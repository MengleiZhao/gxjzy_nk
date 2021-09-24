package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.base.accountant.entity.AccoTree;
import com.braker.base.accountant.entity.AccoYear;
import com.braker.base.accountant.manager.AccoTreeMng;
import com.braker.base.accountant.manager.AccoYearMng;
import com.braker.common.entity.TreeEntity;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;

@Controller
@RequestMapping("/accoTree")
public class AccoTreeController extends BaseController{

	@Autowired
	private AccoYearMng yearsBasicMng;
	@Autowired
	private AccoTreeMng economicMng;
	
	
	
	
	/**
	 * 显示主页面
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/list")
	public String List(ModelMap model){
		return "/WEB-INF/gwideal_core/accountant/tree/yearEcBasic_list";
	}
	
	/**
	 * 添加
	 * @param departId
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/add")
	public String ys_add(String departId,ModelMap model){
		AccoTree e = new AccoTree();
		if(departId.length()==9){
			e.setfYBId(Integer.valueOf(departId));
			e.setLeve("KMJB-01");
			e.setPid(0);
		}else{
			AccoTree ec = economicMng.findById(Integer.valueOf(departId));
			e.setfYBId(ec.getfYBId());
			String level = ec.getLeve();
			String[] l = level.split("-");
			level=l[0]+"-"+"0"+(Integer.valueOf(l[1])+01);
			e.setLeve(level);
			e.setPid(Integer.valueOf(ec.getCode()));
		}
		model.addAttribute("bean", e);
		model.addAttribute("openType", "add");
		return "/WEB-INF/gwideal_core/accountant/tree/economic_add";
	}
	/**
	 * 修改
	 * @param departId
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/edit")
	public String edit(String departId,ModelMap model){
		AccoTree ec = economicMng.findById(Integer.valueOf(departId));
		model.addAttribute("bean", ec);
		model.addAttribute("openType", "edit");
		return "/WEB-INF/gwideal_core/accountant/tree/economic_edit";
	}
	
	/**
	 * 修改方法
	 * @param fbId
	 * @param daw
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public Result update(AccoTree accoTree){
			try {
				economicMng.saveOrUpdate(accoTree);
				return getJsonResult(true,"操作成功！");
			} catch (Exception e) {
				e.printStackTrace();
				return getJsonResult(false,"操作失败！");
			}
	}
	/**
	 * 树形图显示
	 * @param id
	 * @param fPeriod
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,TreeEntity te,String fPeriod,ModelMap model) {
		// 内容。取所有列表，找出父菜单。
		List<Object[]> Economic=null;
		List<AccoYear> yb=null;
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(StringUtil.isEmpty(id)){
			yb=yearsBasicMng.getRoots(null,null);
			if(yb.size()>0){
				for (AccoYear i : yb) {
					TreeEntity node = new TreeEntity();
					node.setText(i.getFtName());
					node.setId(i.getFbId().toString());
					node.setCode("year");
					if(economicMng.indexTree(i.getFbId().toString(),id).size()>0){
						node.setState("closed");
						node.setHaveChild("true");
					}else{
						node.setLeaf(true);
						node.setHaveChild("false");
					}
					list.add(node);
				}
			}
		}else{
			AccoYear ybm =new AccoYear();
			List<AccoTree> e=new ArrayList<AccoTree>();
			AccoTree economic= economicMng.findById(Integer.valueOf(id));
			if(id.length()==9){
				ybm = yearsBasicMng.findById(Integer.valueOf(id));
				e=economicMng.indexTree(ybm.getFbId().toString(), id);
			}else {
				e= economicMng.indexTree(economic.getfYBId().toString(),economic.getCode().toString());
			}
			if(e.size()>0){
				for (int i = 0; i < e.size(); i++) {
					TreeEntity node = new TreeEntity();
					node.setText(e.get(i).getName());
					node.setId(e.get(i).getFid().toString());
					if(economicMng.indexTree(e.get(i).getfYBId().toString(),e.get(i).getCode().toString()).size()>0){
						node.setState("closed");
						node.setHaveChild("true");
					}else{
						node.setLeaf(true);
						node.setHaveChild("false");
					}
					list.add(node);
				}
			}
		}
		return list;
	}
	
	
	/**
	 * @author crc
	 * 显示主页面的查询功能
	 * @param economic
	 * @param departId
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @createtime 2018-06-07
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(AccoTree economic, String departId,String fPeriod,String fbId,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	AccoTree e=null;
    	Pagination p = new Pagination();
    	if(!StringUtil.isEmpty(fbId)){
    		//判断是否是年度经济科目的id
    		if(fbId.length()!=9){
    			e=economicMng.findById(Integer.valueOf(fbId));
    			//判断是否是第一个节点
    			if(e.getPid()==0){
    				p =economicMng.List(e.getCode(), economic, departId, page, rows);
    			}else{
    				p =economicMng.List(e.getCode(), economic, departId, page, rows);
    				//如果是最后一个节点了，就把当前的节点返回
    				if(p.getList().size()==0){
    					List<AccoTree> li=new ArrayList<AccoTree>();
    					li.add(e);
    					p.setList(li);
    				}
    			}
    		}else {
    			economic.setfYBId(Integer.valueOf(fbId));
    			p =economicMng.List("0", economic, departId, page, rows);
    		}
    	}else {
    		p.setPageNo(page);
    		p.setPageSize(rows);
    		p.setTotalCount(page*rows);
    	}
		return getJsonPagination(p, page);
	}
	
	/**
	 * 添加时显示可以选择添加的信息
	 * @param economic
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param modelmap
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/JsonPaginationadd")
	@ResponseBody
	public JsonPagination JsonPagination_add(AccoTree economic,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		String departId=request.getParameter("departId");
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=yearsBasicMng.list_add(economic,departId, sort, order, page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 模板添加信息
	 * @param daw
	 * @param departId
	 * @param economic
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/yeubadd")
	@ResponseBody
	public Result yeub_add(String daw,String departId,AccoTree economic,ModelMap model){
		try {
			boolean number=yearsBasicMng.queryID(daw, departId, economic);
			if(!number){
				int num=yearsBasicMng.ye_save(daw, departId, economic);
				if(num>0){
					return getJsonResult(true,"操作成功！");
				}
				return getJsonResult(false,"操作失败！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
			
			return getJsonResult(false,"有已存在的科目，请重新选择！");
		
	}
	
	/**
	 * 删除
	 * @param fbId
	 * @param daw
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(String fbId,String daw){
			try {
				if(yearsBasicMng.ye_delete(fbId, daw)){
					return getJsonResult(true,"操作成功！");
				}
			} catch (Exception e) {
				e.printStackTrace();
				return getJsonResult(false,"操作失败！");
			}
			return getJsonResult(false,"操作失败！");
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Result save(AccoTree economic,ModelMap model) {
		try {
			if(StringUtil.isEmpty(economic.getCode())){
				return getJsonResult(false,"请填写科目编号！");
			}else if(StringUtil.isEmpty(economic.getName())){
				return getJsonResult(false,"请填写科目名称！");
			}else if(StringUtil.isEmpty(economic.getLeve())){
				return getJsonResult(false,"请选择科目级别！");
			}else if(StringUtil.isEmpty(String.valueOf(economic.getPid()))){
				return getJsonResult(false,"请填写上级科目编号！");
			}else if(StringUtil.isEmpty(economic.getType())){
				return getJsonResult(false,"请填写科目类型！");
			}else if(StringUtil.isEmpty(String.valueOf(economic.getOn()))){
				return getJsonResult(false,"请选择是否启用！");
			}else{
				int num = economicMng.queryFECCode(economic);
				if(num>0){
					return getJsonResult(false,"该科目编号已存在！");
				}
			}
			economicMng.economic_save(economic, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 查询字典里相应数据
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	@RequestMapping("/lookupsJson")
	@ResponseBody
	public List<ComboboxJson> lookJson(String parentCode,String selected,String blanked){
		List<Lookups> list = economicMng.getLookupsJson(parentCode, parentCode);
		return getComboboxJson(list,selected);
	}
	
}
