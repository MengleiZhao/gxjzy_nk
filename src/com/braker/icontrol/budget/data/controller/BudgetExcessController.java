package com.braker.icontrol.budget.data.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.manager.BudgetData2Mng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;


import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.budget.release.manager.IndexDetailMng;
import com.braker.icontrol.cockpit.manager.CockpitMng;

/**
 * 预算超额预警
 * @author shenfan
 * @createtime 2019-04-28
 * @updatetime 2019-04-28
 */

@Controller
@RequestMapping("/bExcess")
@SuppressWarnings("serial")
public class BudgetExcessController extends BaseController{
	
	@Autowired
	private BudgetData2Mng budgetData2Mng;
	@Autowired
	private TransmitMng transmitMng;
	@Autowired
	public CockpitMng cockpitMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private IndexDetailMng indexDetailMng;
	/**
	 * 跳转-预算超额预警
	 */
	@RequestMapping("/list2")
	public String list2(ModelMap model){
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		return "/WEB-INF/view/budget/data/budget-excess";
		
	}
	//分析 详情
		@RequestMapping("/analyse")
		public String tOutcome(ModelMap model, String code){		
			model.addAttribute("code", code);
			return "/WEB-INF/view/budget/data/budget-excess1";
		}
	/*
	 * 跳转预算超额预警指标支出信息列表页面
	 * @author 沈帆
	 * @createtime 2019-05-05
	 * @updatetime 2019-05-05
	 */
		@RequestMapping(value = "/zcmx")
		public String zcmx(ModelMap model, String code,String fType) {
			model.addAttribute("code", code);
			model.addAttribute("fType", fType);
			return "/WEB-INF/view/budget/data/budget-excess1-1";
		}
		
		
		
		
		
	//预算超额列表
	@RequestMapping("/excessList1")
	@ResponseBody
	public JsonPagination excessList(TBudgetIndexMgr bean,String orderColumn,String search) {
		if(StringUtil.isEmpty(search)){//点击导航菜单查询，默认查询当前年份
			bean.setYears(new SimpleDateFormat("yyyy").format(new Date()));
		}
		Pagination p = transmitMng.excesspageList(bean, null, 1, 10000, orderColumn, "asc", getUser());
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		if(li.size()!=0){
			//序号设置
			int index = 1;
			for(int x=0; x<li.size()-1; x++) {
				
					String name1 = li.get(x).getIndexName();
					String name2 = li.get(x+1).getIndexName();
					li.get(x).setNum(index);	
					if(name1 != null && !name1.equals(name2)){
						index++;
					
				}
			}
			li.get(li.size()-1).setNum(index++);

			Pagination p1 = new Pagination();
			p1.setList(li);
			
			return getJsonPagination(p1, 1);
		}
		return getJsonPagination(new Pagination(), 1);
	}
	/**
	 * 执行进度导出
	 */
	@RequestMapping("/exportData2")
	public String exportData2(ModelMap model, HttpServletResponse response, HttpServletRequest request,String index_indexCode,
			String index_indexName,String index_years,String dept_indexCode,String dept_indexName,String dept_deptName,String dept_years){
		OutputStream out =null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("预算超额预警报表".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\预算超额预警导出模板.xls";
			//按指标查询
			//获得数据
			TBudgetIndexMgr indexBean=new TBudgetIndexMgr();
			indexBean.setIndexCode(index_indexCode);
			indexBean.setIndexName(index_indexName);
			indexBean.setYears(index_years);
			Pagination index_p = transmitMng.excesspageList(indexBean, null, 1, 10000, "indexCode,indexName,deptName", "asc", getUser());
			List<TBudgetIndexMgr> index_dataList = (List<TBudgetIndexMgr>) index_p.getList();
			for(int x=0; x<index_dataList.size(); x++) {
				//序号设置	
				index_dataList.get(x).setNum(x+1);
			}
			
			
			//生成excel并导出
			HSSFWorkbook workbook = budgetData2Mng.exportExcel(index_dataList,null, filePath);
			
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
	//预算预警下钻图表
		@RequestMapping("/insideData1")
		@ResponseBody
		public Map<String,Double> insideData1(ModelMap model, String code){
			try {
				Map<String,Double> map = new HashMap<>();
				map = cockpitMng.getExcessData(code);
				return map;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		/*
		 * 预算超额预警指标支出信息列表	
		 * @author 沈帆		
		 * @createtime 2019-05-05
		 * @updatetime 2019-05-05
		 */
		@RequestMapping(value = "/zcmxPage")
		@ResponseBody
		public JsonPagination zcmxPage(String code,String userName,String searchTime1,String searchTime2, Integer page, Integer rows,String fType) {
			Pagination p = indexDetailMng.searchByFtype(code, userName, searchTime1, searchTime2,page,rows,fType);
			List<TIndexDetail> dataList =  (List<TIndexDetail>) p.getList();
			for (TIndexDetail list:dataList) {
				User user = userMng.findById(list.getUserId());
				list.setUsername(user.getName());
			}
			return getJsonPagination(p, page);
		}
		/*
		 * 预算超额预警指标支出信息列表	 Excel导出
		 * @author 沈帆
		 */
		@RequestMapping("/exportData3")
		public String exportData2(ModelMap model, HttpServletResponse response, HttpServletRequest request,
				String code,String userName,String searchTime1,String searchTime2,String fType){
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
				Pagination index_p =indexDetailMng.searchByFtype(code, userName, searchTime1, searchTime2,0,10000,fType);
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
}


