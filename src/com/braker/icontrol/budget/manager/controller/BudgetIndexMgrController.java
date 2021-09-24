package com.braker.icontrol.budget.manager.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;

/**
 * 预算指标管理预算指标生成的控制层
 * @author 叶崇晖
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Controller
@RequestMapping(value = "/quota")
public class BudgetIndexMgrController extends BaseController {
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/budget/quota/quota_list";
	}
	
	/*
	 * 指标分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@RequestMapping(value = "/indexPage")
	@ResponseBody
	public JsonPagination indexPage(TBudgetIndexMgr bean, String indexType, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = budgetIndexMgrMng.pageList(bean, indexType, page, rows, getUser());
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	/**
	* /quota/expDetailList
	* @author:安达
	* @Title: expDetailList 
	* @Description: 跳转到项目支出明细页面
	* @param model
	* @return
	* @return String    返回类型 
	* @date： 2019年6月17日上午11:01:32 
	* @throws
	 */
	@RequestMapping(value = "/expDetailList")
	public String expDetailList(ModelMap model ,String fproid,String index) {
		model.addAttribute("fproid", fproid);
		model.addAttribute("index", index);
		return "/WEB-INF/view/budget/adjust/expend-detail";
	}
	/**
	*  /quota/getExpDetailList
	* @author:安达
	* @Title: getExpDetailList 
	* @Description: 得到项目支出明细集合
	* @param id
	* @return
	* @return List<TProExpendDetail>    返回类型 
	* @date： 2019年6月17日上午10:27:46 
	* @throws
	 */
	@RequestMapping("/getExpDetailList")
	@ResponseBody
	public List<TProExpendDetail> getExpDetailList(String  fproid) {
		// 查询项目支出明细
			List<TProExpendDetail> expDetailList = tProExpendDetailMng
					.getByProId(Integer.valueOf(fproid));
		return expDetailList;
	}
	/*
	 * 文件导入页面显示
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@RequestMapping(value = "/imput")
	public String imput(ModelMap model) {
		return "/WEB-INF/view/budget/quota/quota_imput";
	}
	
	/*
	 * 读取导入的模板文件
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@RequestMapping(value = "/collect")
	@ResponseBody
	public Result collect(MultipartFile xlsx) {
		InputStream ins =null;
		OutputStream os =null;
		try {
			File f = null;
			if(xlsx.equals("")||xlsx.getSize()<=0){
				xlsx = null;
			}else{
				ins = xlsx.getInputStream();
			    f=new File(xlsx.getOriginalFilename());
			    os = new FileOutputStream(f);
				int bytesRead = 0;
				byte[] buffer = new byte[8192];
				while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
					os.write(buffer, 0, bytesRead);
				}
				File file = new File(f.toURI());
				budgetIndexMgrMng.saveFile(file, getUser());
			}
		} catch (Exception e) {
			return getJsonResult(false, getException(e));
		}finally{
			if(os!=null){
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ins!=null){
				try {
					ins.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return getJsonResult(true,"操作成功！");
		
	}
	
	/**
	 * 
	* @author:安达
	* @Title: add 
	* @Description: 跳转新增修改页面
	* @param type
	* @param model
	* @return
	* @return String    返回类型 
	* @date： 2019年6月24日上午11:24:16 
	* @throws
	 */
	@RequestMapping("/add")
	public String add(String type ,ModelMap model) {
		User user = getUser();
		TBudgetIndexMgr bean = new TBudgetIndexMgr();
		bean.setIndexType(type);
		bean.setDeptName(user.getDepart().getName());
		bean.setDeptCode(user.getDepart().getCode());
		bean.setControlType("1");
		String nowYear=DateUtil.formatDate(new Date(), "yyyy");
		bean.setYears(nowYear);
		model.addAttribute("bean", bean);
		
		model.addAttribute("splc", "1");
		
		return "/WEB-INF/view/budget/quota/quota_add";
		
	}
	
	/*
	 * 跳转修改页面
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		TBudgetIndexMgr bean = budgetIndexMgrMng.findById(id);
		model.addAttribute("bean", bean);
		
		if(bean.getFProId() != null){
			TProBasicInfo bean2 = projectMng.findById(bean.getFProId());
			model.addAttribute("bean2", bean2);
		}
		
		//根据修改还是查看跳转不同页面
		if(editType.equals("0")){
			model.addAttribute("splc", "0");
			return "/WEB-INF/view/budget/quota/quota_detail";
		} else if(editType.equals("1")){
			model.addAttribute("splc", "1");
			return "/WEB-INF/view/budget/quota/quota_add";
		} else {
			return null;
		}
	}
	
	/*
	 * 支出指标的保存
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(TBudgetIndexMgr bean) {
		try {
			budgetIndexMgrMng.saveIndex(bean);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 * 指标生成
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping(value = "/generate")
	@ResponseBody
	public Result generate(String fproIdLi) {
		try {
			budgetIndexMgrMng.generate(fproIdLi);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/*
	 * 操作删除基本支出 指标
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(String bId) {
		try {
			budgetIndexMgrMng.deleteIndex(bId);
			return getJsonResult(true, "删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "删除失败，请联系管理员！");
		}
	}

	/**
	 * 加载指标选择的数据
	 * @param bean 
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/insideOrProject")
	@ResponseBody
	public JsonPagination insideOrProject(TBudgetIndexMgr bean, Integer page, Integer rows, String indexType, String pids, String activitys){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = budgetIndexMgrMng.insideOrProject(page, rows, bean, getUser(), indexType);
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	
	/**
	 * 弹出选指标页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/choiceIndex")
	public String BudgetIndexCode(ModelMap model){
		return "/WEB-INF/view/choiceIndex";
	}

	/**
	 * 树形图：项目以及具体的支出科目
	 */
	// 获得支出项科目树（一级节点并且有默认值）
	@RequestMapping(value = "/treeIndex")
	@ResponseBody
	public List<TreeEntity> treeIndex(String id, String selectIds,String indexType,String changeType,String isAcrossDept,String drdc,String deptName,
				ModelMap model) {
		
		if (StringUtil.isEmpty(id)) {
			//默认打开1级节点
			return getTreeFather(selectIds,indexType,changeType,isAcrossDept,drdc,deptName);
		} else {
			return getTreeChild(Integer.parseInt(id), selectIds);
		}

	}
	
	// 获得支出项科目树(0级节点)
	private List<TreeEntity> getTreeFather(String selectIds,String indexType,String changeType,String isAcrossDept,String drdc,String deptName) {

		//初始化
		List<TreeEntity> treeList = new ArrayList<>();
		//获得一级分类
		List<TBudgetIndexMgr> list= budgetIndexMgrMng.getFirstSubject(indexType,getUser(),changeType,isAcrossDept,drdc,deptName);
		if (list != null && list.size() > 0) {
			//整合生成tree
			for (TBudgetIndexMgr indexMgr : list) {
				// 节点id 节点名称 节点代码 父节点代码
				TreeEntity node = new TreeEntity();
				node.setText(indexMgr.getIndexName());// 名称
				node.setId(indexMgr.getFProId()+"");// 节点id
				node.setCode(indexMgr.getIndexCode());//节点代码
				node.setCol1(indexMgr.getXdAmount()+"");//批复金额
				node.setCol2(indexMgr.getSyAmount()+"");//可用金额
				node.setCol3(indexMgr.getDjAmount()+"");//冻结金额
				node.setState("closed");
				node.setLeaf(false);
				treeList.add(node);
			}
		}
     		return treeList;
	}

	// 获得支出项科目树（经济支出科目,子节点）
	private List<TreeEntity> getTreeChild(Integer id, String selectIds) {

				List<TreeEntity> treeList = new ArrayList<>();
				List<TProExpendDetail> list=tProExpendDetailMng.getByProId(id);
				if (list != null && list.size() > 0) {
					//整合生成tree
					for (TProExpendDetail expendDetail : list) {
						// 节点id 节点名称 节点代码 父节点代码
						TreeEntity node = new TreeEntity();
						node.setText(expendDetail.getActivity());// 名称
						node.setId(expendDetail.getPid()+"");// 节点id
						node.setCode(expendDetail.getExpCode());//节点代码
						node.setCol1((expendDetail.getXdAmount())+"");//批复金额
						node.setCol2((expendDetail.getSyAmount())+"");//可用金额
						node.setCol3((expendDetail.getDjAmount())+"");//冻结金额
						node.setCol4(expendDetail.getPid()+"");//项目明细id
						node.setLeaf(true);
						treeList.add(node);
					}
				}
		     		return treeList;
		     		
	}
	
	
	/**
	 * 基本指标模板下载
	 * @author 叶崇晖
	 * @param response
	 * @return
	 */
	@RequestMapping("/download")
	@ResponseBody
	public Result download(HttpServletResponse response){
		OutputStream out = null;
		InputStream in = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resource");
			String filePath = path + "\\download\\TZMB_预算管理_部门基本指标模板.xlsx";
			
			File file = new File(filePath);
			/*File file = new File("D:/TZMB_预算管理_部门基本指标模板.xlsx");*/
			if(file.exists()){
				in = new FileInputStream(file);
				response.setContentType("APPLICATION/OCTET-STREAM");
				response.setContentLength(in.available());
				response.setHeader("Content-Disposition","attachment; filename=\""+ new String("TZMB_预算管理_部门基本指标模板.xlsx".getBytes("gbk"), "iso8859-1")+ "\"");
				out = response.getOutputStream();
				byte[] bt = new byte[1000];
				int a; 
				while ((a = in.read(bt, 0, 1000)) > 0) {
					out.write(bt, 0, a);
					out.flush();
				}
			}else{
				return getJsonResult(false,"文件不存在！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return getJsonResult(false,"出现错误,请联系管理员！");
		} finally {
			try {
				if (out != null){
					out.close();
				}
				if (in != null){
					in.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return getJsonResult(true,"操作成功！");
	}
}
