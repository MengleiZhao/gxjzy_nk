package com.braker.core.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
import com.braker.core.manager.PurchasingCataloguesMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PurchasingCatalogues;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;

/**
 * 功能分类科目管理的控制层
 * 
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
@Controller               
@RequestMapping(value = "/purchaseCatagl")
public class PurchasingCataloguesController extends BaseController{
	@Autowired
	private PurchasingCataloguesMng purchasingCataloguesMng;
	
	/*
	 * 跳转到功能分类科目页面
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/gwideal_core/putchasecatalogues/putchasecatalogues_list";
	}
	
	/*
	 * 分页数据获取功能科目信息
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/purchaseCataPageData")
	@ResponseBody
	public JsonPagination loanPage(PurchasingCatalogues bean,String fPurName,String fPurCode, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}

    	Pagination p = purchasingCataloguesMng.pageList(bean, page, rows, fPurCode);;
  
    	List<PurchasingCatalogues> li = (List<PurchasingCatalogues>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/*
	 * 新增功能科目
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping("/add")
	public String add(ModelMap model,String catamainid){
		//catamainid是当前科目主键id
		PurchasingCatalogues pbean=new PurchasingCatalogues();
		//根据当前科目的主键查询当前科目的科目类别和上级的科目编码
		if(catamainid.equals("0")){//新增的是一级
			 model.addAttribute("upCode", "0");//下一级的上级编码
			 model.addAttribute("nextLevel", "1");//下一级的级别
		}else{//新增二三级
			pbean = purchasingCataloguesMng.findById(Integer.valueOf(catamainid));
			//下一级的上级编码
			model.addAttribute("upCode", pbean.getFpurCode());
			//下一级的级别
			Integer nextLevel = Integer.valueOf(pbean.getFlevel())+1;
			model.addAttribute("nextLevel", nextLevel);
		}
		model.addAttribute("pbean", pbean);

		return "/WEB-INF/gwideal_core/putchasecatalogues/putchasecatalogues_add";
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(PurchasingCatalogues bean,ModelMap model) {
		
		try {
			purchasingCataloguesMng.save(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 查看功能科目信息
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//id是功能科目表的主键id   fmId
		//查询基本信息
		model.addAttribute("bean",purchasingCataloguesMng.findById(Integer.valueOf(id)));
		
		return "/WEB-INF/gwideal_core/functionclassmgr/functionclassmgr_detail";
	}
	/*
	 * 功能科目信息的修改
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		//查询基本信息
		model.addAttribute("bean",purchasingCataloguesMng.findById(Integer.valueOf(id)));
		
		return "/WEB-INF/gwideal_core/putchasecatalogues/putchasecatalogues_edit";
	}	
	/*
	 * 功能科目信息的删除
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			purchasingCataloguesMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/*
	 * 树形图显示采购科目信息
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<TreeEntity> tree(String id,TreeEntity te,String fPeriod,ModelMap model) {
		//id是当前的点击的tree节点的id  自动获得
		//System.out.println("上级编码----"+id);
		
		// 内容。取所有列表，找出父菜单。
		List<Object[]> Economic = null;
		List<TreeEntity> list = new ArrayList<TreeEntity>();

		List<PurchasingCatalogues> e = new ArrayList<PurchasingCatalogues>();
		//PurchasingCatalogues cata = purchasingCataloguesMng.findById(Integer.valueOf(id));
		if(StringUtil.isEmpty(id)){//页面默认加载tree
			e= purchasingCataloguesMng.indexTree(null);//查询所有的采购目录信息
			for(int i=0;i<e.size();i++){
				TreeEntity node = new TreeEntity();
				node.setText(e.get(i).getFpurName());//科目名称
				node.setId(e.get(i).getFpurCode());//当前科目的编码
				node.setCol10(e.get(i).getfId().toString());//当前科目的id
				node.setCol9(e.get(i).getFmeasureUnit());//当前科目的计量单位
				node.setState("closed");
				node.setHaveChild("true");//有下级节点
				list.add(node);
			}
		}else{//点击tree  自动带id(当前的科目编码)
			e= purchasingCataloguesMng.indexTree(id);//查询点击的节点的采购目录信息
			for(int i=0;i<e.size();i++){
				TreeEntity node = new TreeEntity();
				node.setText(e.get(i).getFpurName());//科目名称
				node.setId(e.get(i).getFpurCode());//当前科目的编码
				node.setCol10(e.get(i).getfId().toString());//当前科目的id
				node.setCol9(e.get(i).getFmeasureUnit());//当前科目的计量单位
				if(purchasingCataloguesMng.indexTree(e.get(i).getFpurCode().toString()).size()>0){//有下级节点
					node.setState("closed");
					node.setHaveChild("true");//有下级节点
				}else{//没有下级节点
					node.setLeaf(true);
					node.setHaveChild("false");
				}
				list.add(node);
			}
		}

		
		return list;
	}
	
	/**
	 * 根据编号和名字查询采购品目明细信息
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月4日
	 */
	@ResponseBody
	@RequestMapping(value = "/getItemsCodeName")
	public List<ComboboxJson> getItemsCodeName(){
		List<PurchasingCatalogues> list = purchasingCataloguesMng.findAll();
		
		return getComboboxJsonNoDefault(list,"");
	}
	
	
	

	@ResponseBody
	@RequestMapping(value = "/findbyFId")
	public PurchasingCatalogues findbypayeeId(String id){
		PurchasingCatalogues bean = purchasingCataloguesMng.findById(Integer.valueOf(id));
		return bean;
	}
}
