package com.braker.core.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.swing.event.ListSelectionEvent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.ProMgrLevelMng;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.manager.YearsBasicMng;
import com.braker.core.manager.YearsUnionBasicMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.SysDepartEconomic;
import com.braker.core.model.YearsBasic;

@Controller
@RequestMapping("/yearsUnionBasic")
public class YearsUnionBasicController extends BaseController{

	@Autowired
	private YearsUnionBasicMng yearsUnionBasicMng;
	@Autowired
	private YearsBasicMng yearsBasicMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private SysDepartEconomicMng sysDepartEconomicMng;
	@Autowired
	private ProMgrLevelMng proMgrLevelMng;
	@Autowired
	private ProMgrLevel2Mng proMgrLevelMng2;
	
	
	
	
	/**
	 * 显示主页面
	 * @param model
	 * @return
	 * @createtime 2018-06-08
	 * @author crc
	 */
	@RequestMapping("/list")
	public String List(ModelMap model){
		return "/WEB-INF/gwideal_core/yearEcBasic/yearEcBasic_list";
	}
	
	/**
	 * @Description: 显示主页面年度科目树配置管理
	 * @param @param model
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/ecBasicOrDepart")
	public String ecBasicOrDepart(ModelMap model){
		return "/WEB-INF/gwideal_core/yearEcBasic/yearEcBasicOrDepart_list";
	}
	/**
	 * @Description: 添加二级分类的科目
	 * @param @param model
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/subjectEdit")
	public String subjectEdit(ModelMap model,String departId,String deId,String fEjProCode){
		model.addAttribute("deId", deId);
		model.addAttribute("departId", departId);
		model.addAttribute("fEjProCode", fEjProCode);
		return "/WEB-INF/gwideal_core/economic/subject_edit";
	}
	
	/**
	 * @Description: 显示主页面年度科目树配置管理主页面的查询功能
	 * @param @param model
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/JsonPaginations")
	@ResponseBody
	public JsonPagination JsonPaginations(SysDepartEconomic sysDepartEconomic, String departId,String fPeriod,String fbId,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		try {
			if(page==null){page=1;}
			if(rows==null){rows=SimplePage.DEF_COUNT;}
			Pagination p = new Pagination();
			if(!StringUtil.isEmpty(departId)){
					p=sysDepartEconomicMng.getlist(departId,page,rows);
					p.setPageNo(page);
					p.setPageSize(rows);
					p.setTotalCount(page*rows);
			}else {
				p.setPageNo(page);
				p.setPageSize(rows);
				p.setTotalCount(page*rows);
			}
			return getJsonPagination(p, page);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * @Description: 年度科目树配置管理保存修改或新增的内容
	 * @param @param sysDepartEconomic
	 * @param @param model
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/subjectSave")
	@ResponseBody
	public Result subjectSave(SysDepartEconomic sysDepartEconomic,ModelMap model) {
		try {
			if(StringUtil.isEmpty(sysDepartEconomic.getFuncIds())){
				return getJsonResult(false,"请选择科目！");
			}else{
				String[] FuncIdsString = sysDepartEconomic.getFuncIds().split(",");
				SysDepartEconomic sysDepartEconomics = sysDepartEconomicMng.findById(sysDepartEconomic.getDeId());
				sysDepartEconomicMng.deleteKeMu(sysDepartEconomic.getpId(),sysDepartEconomics.getfEjProCode(), null);
				for(int i = 0; i < FuncIdsString.length; i++){
					SysDepartEconomic sysDepartEconomic1 = new SysDepartEconomic();
					Economic ec = economicMng.findById(Integer.valueOf(FuncIdsString[i]));
					/*List<SysDepartEconomic> lists = sysDepartEconomicMng.findByProperty("pId", sysDepartEconomic.getpId());
					for(int j=0;j<lists.size();j++){
						if(lists.get(j).getfEcCode().equals(ec.getCode())){
							sysDepartEconomicMng.deleteKeMu(sysDepartEconomic.getpId(),lists.get(j).getfEcCode(), ec.getCode());
						}
					}*/
					sysDepartEconomic1.setfEcCode(ec.getCode());
					sysDepartEconomic1.setfEcName(ec.getName());
					sysDepartEconomic1.setfEjProCode(sysDepartEconomics.getfEjProCode());
					sysDepartEconomic1.setfEjProName(sysDepartEconomics.getfEjProName());
					sysDepartEconomic1.setpId(sysDepartEconomic.getpId());
					sysDepartEconomicMng.saveOrUpdate(sysDepartEconomic1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/**
	 * @Description: 部门科目树配置管理删除
	 * @param @param sysDepartEconomic
	 * @param @param model
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月12日
	 */
	@RequestMapping("/subjectDelete")
	@ResponseBody
	public Result subjectDelete(String departId,String deId,String fEjProCode) {
		try {
			sysDepartEconomicMng.subjectDelete(departId, deId, fEjProCode);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/**
	 * @Description: 添加二级分类保存修改或新增的内容
	 * @param @param sysDepartEconomic
	 * @param @param model
	 * @param @return   
	 * @return Result  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/ecBasicOrDepartSave")
	@ResponseBody
	public Result ecBasicOrDepartSave(SysDepartEconomic sysDepartEconomic,ModelMap model) {
		try {
			if(StringUtil.isEmpty(sysDepartEconomic.getfEjProCode())){
				return getJsonResult(false,"请选择二级科目！");
			}else{
			String[] fEjProCodeString = sysDepartEconomic.getfEjProCode().split(",");
			List<String> allList = new ArrayList<String>();//相同的
			List<String> allLists = new ArrayList<String>();//独有的
			List<SysDepartEconomic> lists =null;
			List<ProMgrLevel2> ProMgrLevel2list =null;
			Pagination p = sysDepartEconomicMng.getlist(sysDepartEconomic.getpId(),0,1000);
			lists = (java.util.List<SysDepartEconomic>) p.getList();
			
			for(int i = 0; i < fEjProCodeString.length; i++){//页面传值的code
				allList.add(fEjProCodeString[i].toString());
			}
			for (int j = 0; j < lists.size(); j++) {
				allLists.add(lists.get(j).getfEjProCode());
			}
			
			if(allList.size()<allLists.size()){//数据库的code
				allLists.removeAll(allList);
				for (int i = 0; i < allLists.size(); i++) {
					List<ProMgrLevel2> ecs = proMgrLevelMng2.findByProperty("fLevCode2", allLists.get(i));
					for (int j = 0; j < ecs.size(); j++) {
						sysDepartEconomicMng.deleteKeMu(sysDepartEconomic.getpId(),ecs.get(j).getfLevCode2(), null);
					}
				}
			}else{
				allList.removeAll(allLists);//页面code大于数据库code
				for (int i = 0; i < allList.size(); i++) {
					ProMgrLevel2list = proMgrLevelMng2.findByProperty("fLevCode2", allList.get(i));
					SysDepartEconomic sysDepartEconomic1 = new SysDepartEconomic();
					sysDepartEconomic1.setfEjProCode(ProMgrLevel2list.get(0).getfLevCode2());
					sysDepartEconomic1.setfEjProName(ProMgrLevel2list.get(0).getfLevName2());
					sysDepartEconomic1.setpId(sysDepartEconomic.getpId());
					sysDepartEconomicMng.saveOrUpdate(sysDepartEconomic1);
				}
			}
			if(allList.retainAll(allLists)&&allList.size()==allLists.size()){
				return getJsonResult(true,"数据相同，无需修改");
			}
			
			if (lists.isEmpty()) {
				String[] funcIdsString = sysDepartEconomic.getFuncIds().split(",");
				for (int i = 0; i < funcIdsString.length; i++) {
					ProMgrLevel2 ecs = proMgrLevelMng2.findById(Integer.valueOf(funcIdsString[i]));
					SysDepartEconomic sysDepartEconomic1 = new SysDepartEconomic();
					sysDepartEconomic1.setfEjProCode(ecs.getfLevCode2());
					sysDepartEconomic1.setfEjProName(ecs.getfLevName2());
					sysDepartEconomic1.setpId(sysDepartEconomic.getpId());
					sysDepartEconomicMng.saveOrUpdate(ecs);
				}
			}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	
	/**
	 * @Description: 年度科目树配置管理跳转新增页面
	 * @param @param model
	 * @param @param departId
	 * @param @param deId
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月10日
	 */
	@RequestMapping("/ecBasicOrDepartAdd")
	public String ecBasicOrDepartAdd(ModelMap model,String departId,String deId) {
		List<SysDepartEconomic> departEconomicList=null;
		if(!StringUtil.isEmpty(departId) || !"".equals(departId)){
			 departEconomicList=sysDepartEconomicMng.findByProperty("pId", departId);
		}
		
		List<ProMgrLevel2> proMgrLevel2= proMgrLevelMng2.findByProperty("pml.fLvId1", 1);
		
		model.addAttribute("proMgrLevel2", proMgrLevel2);
		model.addAttribute("departEconomicList", departEconomicList);
		model.addAttribute("departId", departId);
		model.addAttribute("openType", "add");
		return "/WEB-INF/gwideal_core/economic/economic_add_depart";
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
		model.addAttribute("departId", departId); 
		return "/WEB-INF/gwideal_core/yearEcBasic/yearEcBasic_add";
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
	@RequestMapping(value="/economicAddDepartTree")
	@ResponseBody
	public List<TreeEntity> economicAddDepartTree(String id,TreeEntity te,String departId,String fEjProCode,String fPeriod,ModelMap model) {
		// 内容。取所有列表，找出父菜单。
		List<Object[]> Economic=null;
		List<YearsBasic> yb=null;
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		String sign = "0";
		List<SysDepartEconomic> lists = sysDepartEconomicMng.findDistinctByPidAndEjProCode(departId,fEjProCode,sign);
		if(StringUtil.isEmpty(id)){
			yb=yearsBasicMng.findByYear(new SimpleDateFormat("yyyy").format(new Date()));
			if(yb.size()>0){
				for (YearsBasic i : yb) {
					TreeEntity node = new TreeEntity();
					node.setText(i.getFtName());
					node.setId(i.getFbId().toString());
					node.setCode("year");
					node.setChecked(true);
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
			YearsBasic ybm =new YearsBasic();
			List<Economic> e=new ArrayList<Economic>();
			Economic economic= economicMng.findById(Integer.valueOf(id));
			if(id.length()==8){
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
					for (int h = 0; h < lists.size(); h++) {
						if(e.get(i).getCode().equals(lists.get(h).getfEcCode()) || e.get(i).getCode().equals(lists.get(h).getfEcCode())){
							node.setChecked(true);
						}
					}
					if(economicMng.indexTree(e.get(i).getfYBId().toString(),e.get(i).getCode().toString()).size()>0){
						if(e.get(i).getCode().length()<5){
							node.setState("closed");
							node.setHaveChild("true");
						}else{
							node.setLeaf(true);
							node.setHaveChild("false");
						}
						
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
	public List<TreeEntity> tree(String id,TreeEntity te,String fPeriod,String departId,ModelMap model) {
		// 内容。取所有列表，找出父菜单。
		List<Object[]> Economic=null;
		List<YearsBasic> yb=null;
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(StringUtil.isEmpty(id)){
			yb=yearsUnionBasicMng.getRoots(null,null);
			if(yb.size()>0){
				for (YearsBasic i : yb) {
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
			YearsBasic ybm =new YearsBasic();
			List<Economic> e=new ArrayList<Economic>();
			Economic economic= economicMng.findById(Integer.valueOf(id));
			if(id.length()==8){
				ybm = yearsBasicMng.findById(Integer.valueOf(id));
				e=economicMng.indexTree(ybm.getFbId().toString(), id);
			}else {
				e= economicMng.indexTree(economic.getfYBId().toString(),economic.getFid().toString());
			}
			if(e.size()>0){
				for (int i = 0; i < e.size(); i++) {
					TreeEntity node = new TreeEntity();
					node.setText(e.get(i).getName());
					node.setId(e.get(i).getFid().toString());
					if(economicMng.indexTree(e.get(i).getfYBId().toString(),e.get(i).getFid().toString()).size()>0){
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
	
	
	@RequestMapping(value="/fourTree")
	@ResponseBody
	public List<TreeEntity> fourTree(String code,String id,TreeEntity te,String fPeriod,ModelMap model) {
		try {
			// 内容。取所有列表，找出父菜单。
			List<Object[]> Economic=null;
			List<YearsBasic> yb=null;
			List<TreeEntity> list=new ArrayList<TreeEntity>();
			YearsBasic ybm =new YearsBasic();
			List<Economic> e=new ArrayList<Economic>();
			Economic economic = new Economic();
	 		/*if(!StringUtil.isEmpty(code)){
	 			economic= economicMng.findbyCode(code);
			}else {
				economic= economicMng.findById(Integer.valueOf(id));
			}*/
			
			if(StringUtil.isEmpty(id)){
				economic= economicMng.findbyCode(code);
			}else{
				economic= economicMng.findById(Integer.valueOf(id));
			}
			e= economicMng.indexTree(economic.getfYBId().toString(),economic.getPid().toString());
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
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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
	public JsonPagination JsonPagination(Economic economic, String departId,String fPeriod,String fbId,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
    	Economic e=null;
    	Pagination p = new Pagination();
    	if(!StringUtil.isEmpty(fbId)){
    		//判断是否是年度经济科目的id
    		if(fbId.length()!=8){
    			e=economicMng.findById(Integer.valueOf(fbId));
    			//判断是否是第一个节点
    			if(e.getPid()==0){
    				p =economicMng.List(e.getCode(), economic, departId, page, rows);
    			}else{
    				p =economicMng.List(e.getCode(), economic, departId, page, rows);
    				//如果是最后一个节点了，就把当前的节点返回
    				if(p.getList().size()==0){
    					List<Economic> li=new ArrayList<Economic>();
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
	public JsonPagination JsonPagination_add(Economic economic,String sort,String order,Integer page,Integer rows,ModelMap modelmap){
		String departId=request.getParameter("departId");
		if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}
		Pagination p=yearsUnionBasicMng.list_add(economic,departId, sort, order, page, rows);
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
	public Result yeub_add(String daw,String departId,Economic economic,ModelMap model){
		try {
			boolean number=yearsUnionBasicMng.queryID(daw, departId, economic);
			if(!number){
				int num=yearsUnionBasicMng.ye_save(daw, departId, economic);
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
				if(yearsUnionBasicMng.ye_delete(fbId, daw)){
					return getJsonResult(true,"操作成功！");
				}
			} catch (Exception e) {
				e.printStackTrace();
				return getJsonResult(false,"操作失败！");
			}
			return getJsonResult(false,"操作失败！");
	}
}
