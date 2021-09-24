package com.braker.icontrol.budget.manager.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.entity.TIndexReleasePlan;
import com.braker.icontrol.budget.manager.manager.BudgetIndexDetailMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.IndexReleasePlanMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasic;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.budget.release.manager.IndexDetailMng;
import com.braker.icontrol.contract.approval.model.BudgetIndexMgr;

/**
 * 预算指标下达（二下）控制层
 * 本模块用于控制数分解的控制
 * @author 叶崇晖
 * @createtime 2018-10-08
 * @updatetime 2018-10-08
 */
@Controller
@RequestMapping(value = "/transmit")
public class TransmitController extends BaseController {
	@Autowired
	private TransmitMng transmitMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private BudgetIndexDetailMng budgetIndexDetailMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private IndexDetailMng indexDetailMng;
	
	@Autowired
	private IndexReleasePlanMng indexReleasePlanMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;//项目支出明细
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		model.addAttribute("year",Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date()))+1);
		return "/WEB-INF/view/budget/manager/transmit/project-transmit-list";
	}
	
	/*
	 * 指标分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping(value = "/indexPage")
	@ResponseBody
	public JsonPagination indexPage(TBudgetIndexMgr bean, String indexType, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = transmitMng.pageList(bean, indexType, page, rows, "", "asc", getUser());
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	/*
	 * 指标下达页面跳转
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@RequestMapping("/transmit")
	public String transmit(ModelMap model, Integer bId){
		model.addAttribute("bean", budgetIndexMgrMng.findById(bId));
		
		List<TBudgetIndexDetail> li = budgetIndexDetailMng.getDetail(bId);
		model.addAttribute("num", li.size());
		
		return "/WEB-INF/view/budget/manager/transmit/project-transmit";
	}
	
	/*
	 * 指标下达保存
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(ModelMap model, String bId) {
		try {
			String[] indexId = bId.split(",");
			for(String id : indexId){
				transmitMng.saveIndex(Integer.parseInt(id));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/*
	 * 跳转下达明细列表页面
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/xdmx")
	public String xdmx(ModelMap model, Integer id) {
		model.addAttribute("bId", id);
		return "/WEB-INF/view/budget/manager/transmit/project-transmit-xdmx";
	}
	
	/*
	 * 下达明细列表
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/xdmxPage")
	@ResponseBody
	public List<TBudgetIndexDetail> xdmxPage(Integer id) {
		List<TBudgetIndexDetail> li = budgetIndexDetailMng.getDetail(id);
		for (int i = 0; i < li.size(); i++) {
			User user = userMng.findById(li.get(i).getReleaseUser());
			if(user != null) {
				li.get(i).setReleaseUserName(user.getName());
				li.get(i).setReleaseDepart(user.getDepartName());
			}
			TBudgetIndexMgr index = budgetIndexMgrMng.findById(li.get(i).getbId());
			li.get(i).setIndexName(index.getIndexName());
		}
		return li;
	}
	
	/*
	 * 跳转支出明细列表页面
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/zcmx")
	public String zcmx(ModelMap model, String code) {
		model.addAttribute("code", code);
		return "/WEB-INF/view/budget/manager/transmit/project-transmit-zcmx";
	}
	
	/*
	 * 支出明细列表
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@RequestMapping(value = "/zcmxPage")
	@ResponseBody
	public JsonPagination zcmxPage(String code,String userName,String searchTime1,String searchTime2, Integer page, Integer rows) {
		Pagination p = indexDetailMng.searchByIndexCode(code, userName, searchTime1, searchTime2,page,rows);
		List<TIndexDetail> dataList =  (List<TIndexDetail>) p.getList();
		for (TIndexDetail list:dataList) {
			User user = userMng.findById(list.getUserId());
			list.setUsername(user.getName());
		}
		return getJsonPagination(p, page);
	}
	
	/**
	 * 指标支出明细追踪 Excel导出
	 * @author 焦广兴
	 * @param code是预算指标的编码
	 * @return
	 */
	@RequestMapping("/exportData3")
	public String exportData2(ModelMap model, HttpServletResponse response, HttpServletRequest request,
			String code,String userName,String searchTime1,String searchTime2){
		OutputStream out =null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("指标支出明细追踪".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\指标支出明细追踪.xls";

			TIndexDetail t=new TIndexDetail();
			t.setIndexCode(code);
			t.setUsername(userName);
			t.setBegintime(searchTime1);
			t.setEndtime(searchTime2);
			Pagination index_p =indexDetailMng.searchByIndexCode(code, userName, searchTime1, searchTime2,0,10000);
			List<TIndexDetail> index_dataList = (List<TIndexDetail>) index_p.getList();
			
			//生成excel并导出
			HSSFWorkbook workbook = indexDetailMng.exportExcel(index_dataList, filePath);
			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
			}
		}
		
		return null;
	}
	
	
	
	/**
	 * 查询计划下达的list
	 * @author 叶崇晖
	 * @param code是预算指标的编码
	 * @return
	 */
	@RequestMapping(value = "/releasePlanList")
	@ResponseBody
	public List<TIndexReleasePlan> releasePlanList(String code) {
		/*根据指标的编码查询出相应的下达计划*/
		List<TIndexReleasePlan> list = indexReleasePlanMng.findByIndexCode(code);
		return list;
	}
	
	/**
	 * 立即下达计划
	 * @author 叶崇晖
	 * @param id是计划下达信息的主键
	 * @return 操作结果
	 */
	@RequestMapping(value = "/ljxd")
	@ResponseBody
	public Result ljxd(Integer id) {
		try {
			transmitMng.ljxd(id, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
}
