package com.braker.icontrol.budget.data.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.entity.TreeEntity;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.ProMgrLevel2Mng;
import com.braker.core.manager.SysDepartEconomicMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.ProMgrLevel1;
import com.braker.core.model.ProMgrLevel2;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.data.manager.BudgetData1Mng;
import com.braker.icontrol.budget.data.manager.BudgetData2Mng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexDetailMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;

/**
 * 预算模块统计
 * @author zhanxun
 * @createtime 2018-09-03
 * @updatetime 2018-11-05
 */
@Controller
@RequestMapping("/bData")
@SuppressWarnings("serial")
public class BudgetDataController extends BaseController {

	@Autowired
	private BudgetData1Mng budgetData1Mng;
	@Autowired
	private BudgetData2Mng budgetData2Mng;
	@Autowired
	private BudgetIndexDetailMng budgetIndexDetailMng;
	@Autowired
	private TransmitMng transmitMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private SysDepartEconomicMng sysDepartEconomicMng;
	@Autowired
	private ProMgrLevel2Mng proMgrLevel2Mng;
	/**
	 * 跳转-指标执行情况报表 
	 */
	@RequestMapping("/list1")
	public String list1(ModelMap model){
		
		String[] years = DateUtil.getLastThreeYears();
		model.addAttribute("yearNum1", years[0]);
		model.addAttribute("yearNum2", years[1]);
		model.addAttribute("yearNum3", years[2]);
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		return "/WEB-INF/view/budget/data/data-list1";
	}
	
	/**
	 * 跳转-指标执行进度总表
	 */
	@RequestMapping("/list2")
	public String list2(ModelMap model){
		model.addAttribute("currentYear", new SimpleDateFormat("yyyy").format(new Date()));
		return "/WEB-INF/view/budget/data/data-list2";
	}
	
	/**
	 * 指标执行情况-年度报表
	 */
	@RequestMapping("/dataList1")
	@ResponseBody
	public JsonPagination dataList1(ModelMap model, String indexType, String currentYear, String departName,
			TBudgetIndexMgr bean){
		
		//如果需要分页，pagesize由10000改为rows，返回值p1改为p
		/*if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}*/
		Pagination p = transmitMng.pageList(bean, null, 1, 10000, null, null, getUser());
		List<TBudgetIndexMgr> list1 = (List<TBudgetIndexMgr>) p.getList();
		List<Object[]> list2 = transmitMng.groupByYear();
		List<BudgetData1> list = budgetData1Mng.getYearList(list1,list2,DateUtil.getLastThreeYears());
		p.setList(list);
		return getJsonPagination(p, 1);
	}
	
	/**
	 * 指标执行情况-月度报表
	 */
	@RequestMapping("/dataList2")
	@ResponseBody
	public JsonPagination dataList2(ModelMap model, String currentYear, String departName,
			TBudgetIndexMgr bean){

		//如果需要分页，pagesize由10000改为rows，返回值p1改为p
		/*if(page==null){page=1;}
    	if(rows==null){rows=SimplePage.DEF_COUNT;}*/
		Pagination p = transmitMng.pageList(bean, null, 1, 10000, null, null, getUser());
		List<TBudgetIndexMgr> list1 = (List<TBudgetIndexMgr>) p.getList();
		List<Object[]> list2 = null;
		List<Object[]> list3 = null;
		if (!StringUtil.isEmpty(bean.getYears())) {
			list2 = budgetIndexDetailMng.groupByMonth(bean.getYears());
			list3 = budgetIndexDetailMng.groupByMonth(String.valueOf(Integer.valueOf(bean.getYears()) - 1));
		}
		List<BudgetData2> list = budgetData1Mng.getMonthList(list1,list2,list3,new String[]{"1","2","3","4","5","6","7","8","9","10","11","12"});
		p.setList(list);
		
		Pagination p1 = new Pagination();
		p1.setList(list);
		
		return getJsonPagination(p1, 1);
	}
	/**
	 * 情况报表导出
	 */
	@RequestMapping("/exportData1")
	public String exportData1(ModelMap model, HttpServletResponse response, HttpServletRequest request,  String year_indexName, String year_departName,  String month_indexName, String month_departName, String month_years){
		OutputStream out = null;
		try {
			//初始化
			response.setHeader("Content-Disposition","attachment; filename="+new String("指标执行情况报表".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\指标执行情况报表.xls";
			//获得年报数据
			TBudgetIndexMgr yearBean=new TBudgetIndexMgr();
			yearBean.setIndexName(year_indexName);
			yearBean.setDeptName(year_departName);
			Pagination p1 = transmitMng.pageList(yearBean, null, 1, 10000, null, null, getUser());
			List<TBudgetIndexMgr> yearList1 = (List<TBudgetIndexMgr>) p1.getList();
			List<Object[]> yearList2 = transmitMng.groupByYear();
			List<BudgetData1> yearList = budgetData1Mng.getYearList(yearList1,yearList2,DateUtil.getLastThreeYears());
			//获得月报数据
			TBudgetIndexMgr monthBean=new TBudgetIndexMgr();
			monthBean.setIndexName(month_indexName);
			monthBean.setDeptName(month_departName);
			monthBean.setYears(month_years);
			Pagination p2 = transmitMng.pageList(monthBean, null, 1, 10000, null, null, getUser());
			List<TBudgetIndexMgr> list1 = (List<TBudgetIndexMgr>) p2.getList();
			List<Object[]> monthList1 = null;
			List<Object[]> monthList2 = null;
			if (!StringUtil.isEmpty(month_years)) {
				monthList1 = budgetIndexDetailMng.groupByMonth(month_years);
				monthList2 = budgetIndexDetailMng.groupByMonth(String.valueOf(Integer.valueOf(month_years) - 1));
			}
			List<BudgetData2> monthList = budgetData1Mng.getMonthList(list1,monthList1,monthList2,new String[]{"1","2","3","4","5","6","7","8","9","10","11","12"});
			
			//生成excel并导出
			HSSFWorkbook workbook = budgetData1Mng.exportExcel(yearList, monthList, filePath);
			
			if(workbook==null){
				out.flush();   
				return null;
			}
			workbook.write(out);   
			out.flush();   
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	//----------------------------
	/**
	 * 指标执行进度趋势分析 界面
	 */
	@RequestMapping("/trendAnalyzeJsp")
	public String trendAnalyzeJsp(ModelMap model, String departId, String year,String indexCode,String indexName,String deptName){
		model.addAttribute("departId", departId);
		model.addAttribute("year", year);
		model.addAttribute("indexCode", indexCode);
		model.addAttribute("indexName", indexName);
		model.addAttribute("deptName", deptName);
		
		return "/WEB-INF/view/budget/data/trendAnalyze";
	}
	
	/**
	 * 指标执行进度趋势分析 数据
	 */
	@RequestMapping("/trendAnalyzeList")
	@ResponseBody
	public List<Object[]> trendAnalyzeList(TBudgetIndexMgr bean,String orderColumn,String search){
		List<Object[]> list = new ArrayList<>();
		
		if(!StringUtil.isEmpty(search)){//点击导航菜单查询，默认查询当前年份
			bean.setYears(new SimpleDateFormat("yyyy").format(new Date()));
		}
		Pagination p = transmitMng.pageList(bean, null, 1, 10000, orderColumn, "asc", getUser());
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		try {
			for(int x=0; x<li.size(); x++) {
				Object [] obj=new Object[7];
				if(li.get(x).getXdAmount()!=null ){	//判断  下达金额是否为空
					if(li.get(x).getXdAmount().compareTo(BigDecimal.ZERO)!=0){  //判断  下达金额是否为0
						BigDecimal pfNum=li.get(x).getPfAmount();
						BigDecimal xdNum=li.get(x).getXdAmount();
						BigDecimal syNum=li.get(x).getSyAmount();
						BigDecimal djNum=li.get(x).getDjAmount();
						obj[0]=xdNum;	//下达金额
						BigDecimal d=(xdNum.subtract(syNum)).subtract(djNum);	//使用金额=下达-剩余-冻结
						if(d.compareTo(BigDecimal.ZERO)  == 1){ //BigDecimal判断d是否为0
							obj[1]=d.divide(pfNum,4,BigDecimal.ROUND_HALF_UP);	//执行进度/百分比=使用/下达
						}else{
							obj[1]=0.00;
						}
						
							obj[2]=d; //使用金额;
					}else{
						obj[0]=0.00;
						obj[1]=0.00;
						obj[2]=0.00;
					}
					
				}else{
					obj[0]=0.00;	//下达金额
					obj[1]=0.00;	//执行进度
					obj[2]=0.00;	//使用金额;
				}
				obj[3]=li.get(x).getIndexCode();	//指标编码
				obj[4]=li.get(x).getIndexName();	//指标名称
				obj[5]=li.get(x).getDeptName();	//使用部门
				
				obj[6]=li.get(x).getYears();	//使用年度
				list.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return list;
	}
	
	//----------------------------
	/**
	 * 指标执行进度
	 */
	@RequestMapping("/progList1")
	@ResponseBody
	public JsonPagination progList(TBudgetIndexMgr bean, String indexType,String orderColumn,String search) {
		if(StringUtil.isEmpty(search)){//点击导航菜单查询，默认查询当前年份
			bean.setYears(new SimpleDateFormat("yyyy").format(new Date()));
		}
		Pagination p = transmitMng.pageList(bean, null, 1, 10000, orderColumn, "asc", getUser());
		List<TBudgetIndexMgr> li = (List<TBudgetIndexMgr>) p.getList();
		if(li.size()!=0){
			//序号设置
			int index = 1;
			for(int x=0; x<li.size()-1; x++) {
				if("indexCode,indexName,deptName".equals(orderColumn)){//按指标名称
					String name1 = li.get(x).getIndexName();
					String name2 = li.get(x+1).getIndexName();
					li.get(x).setNum(index);	
					if(name1 != null && !name1.equals(name2)){
						index++;
					}
				}else{//按部门名称
					String name1 = li.get(x).getDeptName();
					String name2 = li.get(x+1).getDeptName();
					li.get(x).setNum(index);	
					if(name1 != null && !name1.equals(name2)){
						index++;
					}
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
			response.setHeader("Content-Disposition","attachment; filename="+new String("指标执行进度总表".getBytes("gbk"), "iso8859-1")+".xls");   
			out = new BufferedOutputStream(response.getOutputStream());   
			response.setContentType("application/octet-stream");   
			String path = request.getSession().getServletContext().getRealPath("/resource");
			String filePath=path+"\\download\\指标执行进度总表(1).xls";
			//按指标查询
			//获得数据
			TBudgetIndexMgr indexBean=new TBudgetIndexMgr();
			indexBean.setIndexCode(index_indexCode);
			indexBean.setIndexName(index_indexName);
			indexBean.setYears(index_years);
//			Pagination index_p = transmitMng.pageList(indexBean, "1", 1, 10000, "indexCode,indexName,deptName", "asc", getUser());
			Pagination index_p = transmitMng.pageList(indexBean, null, 1, 10000, "indexCode,indexName,deptName", "asc", getUser());
			List<TBudgetIndexMgr> index_dataList = (List<TBudgetIndexMgr>) index_p.getList();
			for(int x=0; x<index_dataList.size(); x++) {
				//序号设置	
				index_dataList.get(x).setNum(x+1);
			}
			//按部门查询
			//获得数据
			TBudgetIndexMgr deptBean=new TBudgetIndexMgr();
			deptBean.setIndexCode(dept_indexCode);
			deptBean.setIndexName(dept_indexName);
			deptBean.setDeptName(dept_deptName);
			deptBean.setYears(dept_years);
//			Pagination dept_p = transmitMng.pageList(deptBean, "1", 1, 10000, "deptName,indexCode,indexName", "asc", getUser());
			Pagination dept_p = transmitMng.pageList(deptBean, null, 1, 10000, "deptName,indexCode,indexName", "asc", getUser());
			List<TBudgetIndexMgr> dept_dataList = (List<TBudgetIndexMgr>) dept_p.getList();
			for(int x=0; x<dept_dataList.size(); x++) {
				//序号设置	
				dept_dataList.get(x).setNum(x+1);	
			}
			
			//生成excel并导出
			HSSFWorkbook workbook = budgetData2Mng.exportExcel(index_dataList,dept_dataList, filePath);
			
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
	 * 报表1JSP（申报过程
	 */
	@RequestMapping("/dataAnalysisJsp")
	public String dataAnalysisJsp(ModelMap model,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectList", economicList);
		return "/WEB-INF/view/budget/report_forms/data_analysis";
	}
	
	/**
	 * 报表1（申报过程）
	 * @param year
	 * @param secondLevelCode
	 * @return
	 */
	@RequestMapping("/sjfxlist")
	@ResponseBody
	public List<Object[]> sjfxlist(String year, @RequestParam(value = "secondLevelCode[]", required = false)String[] secondLevelCode){
		List<Object[]> departEconomicList = transmitMng.departEconomicList(year,secondLevelCode, getUser());
		//部门
		List<Depart> departList=departMng.getAllDeptsParts(null);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
//		//组装
		List<Object[]> list = budgetData1Mng.sjfxList(departEconomicList,departList,economicList);
		return list;
	}
	
	/**
	 * 报表1（根据类型统计）
	 * @param year
	 * @param secondLevelCode
	 * @param analysisType
	 * @return
	 */
	@RequestMapping("/sjfxlistByType")
	@ResponseBody
	public List<Object[]> sjfxlistByType(String year, @RequestParam(value = "secondLevelCode[]", required = false)String[] secondLevelCode,
			String analysisType,String dataType){
		//默认查一上
		if (StringUtil.isEmpty(analysisType)) {
			analysisType = "1";
		}
		if (StringUtil.isEmpty(dataType)) {
			dataType = "1";
		}
		List<Object[]> departEconomicList = transmitMng.departEconomicListByType(year,secondLevelCode, getUser(), analysisType,dataType);
		//部门
		List<Depart> departList=departMng.getAllDeptsParts(null);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		//组装
		List<Object[]> list = budgetData1Mng.sjfxList(departEconomicList,departList,economicList);
		return list;
	}
	
	@RequestMapping("/sjfxJsp")
	public String sjfxJsp(ModelMap model,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectListAll", economicList);
		return "/WEB-INF/view/budget/report_forms/data_analysis_compare";
	}
	
	/**
	 * 报表一类型比较分析
	 * @param year
	 * @param secondLevelCode
	 * @param analysisType
	 * @return
	 */
	@RequestMapping("/sjfxlistAll")
	@ResponseBody
	public Map<String, Object> sjfxlistAll(String year, @RequestParam(value = "secondLevelCode[]", required = false)String[] secondLevelCode){
		List<Object[]> departEconomicList = transmitMng.departEconomicAllList(year,secondLevelCode, getUser());
		//部门
		List<Depart> departList=departMng.getAllDeptsParts(null);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		//经济科目（包含一上、一下、二上、二下）
		List<String> economicAllList = new ArrayList<String>();
		String[] anaType = {"ys","yx","es","ex"};
		for (Economic e : economicList) {
			for (int i = 0; i < anaType.length; i++) {
				economicAllList.add(anaType[i] + e.getCode());
			}
		}
		//组装
		List<Object[]> list = null;
		try {
			list = budgetData1Mng.sjfxAllList(departEconomicList,departList,economicAllList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("header",economicList);
		resultMap.put("list",list);
		return resultMap;
	}

	/**
	 * 报表2JSP（申报过程
	 */
	@RequestMapping("/reportCollectJsp")
	public String ReportCollectJsp(ModelMap model,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectList", economicList);
		return "/WEB-INF/view/budget/report_forms/report_forms_collect";
	}
	
	/**
	 * 报表2Data（申报过程
	 * @param currentYear
	 * @param secondLevelCode
	 * @return
	 */
	@RequestMapping("/reportCollectData")
	@ResponseBody
	public List<Object[]> bbsblist(String year,String deptArr){
		//经济科目所有
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		/*-------基本支出所有数据---------*/
		List<Object[]> data=transmitMng.basicExpendData(year,deptArr, getUser());
		/*-------项目支出所有数据---------*/
		List<Object[]> data2=transmitMng.proExpendData(year, deptArr, getUser());
		data.addAll(data2);
		//项目支出 有多少条项目
		List<Object[]> data3=transmitMng.proNameData(year, deptArr, getUser());
		//基本支出部门数据
		List<Object[]>deptList=transmitMng.deptNameData(year, deptArr, getUser());
		//项目支出数据添加到部门数据内
		deptList.addAll(data3);		//所有部门数据
		//所有的项目类型
		List<ProMgrLevel2> typeList = proMgrLevel2Mng.basicTypeList();
		ProMgrLevel1 e1=new ProMgrLevel1();
		e1.setId("2");
		for (int i = 0; i < data3.size(); i++) {
			ProMgrLevel2 e=new ProMgrLevel2();
			e.setfLevCode2((String) data3.get(i)[2]);
			e.setfProType((String) data3.get(i)[2]);
			e.setfLevName2((String) data3.get(i)[1]);
			e.setPml(e1);
			typeList.add(e);
		}
		//组装
		List<Object[]> list = budgetData1Mng.twoReport(data, deptList, economicList,typeList,deptArr);
		
		return list;
	}
	
	/**
	 * 报表2（根据类型统计）
	 * @param year
	 * @param deptArr
	 * @param analysisType
	 * @return
	 */
	@RequestMapping("/reportCollectDataByType")
	@ResponseBody
	public List<Object[]> reportCollectDataByType(String year,String deptArr, String analysisType,String dataType){
		//默认查一上
		if (StringUtil.isEmpty(analysisType)) {
			analysisType = "1";
		}
		if (StringUtil.isEmpty(dataType)) {
			dataType = "1";
		}
		//经济科目所有
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		/*-------基本支出所有数据---------*/
		List<Object[]> data=transmitMng.basicExpendDataByType(year,deptArr, getUser(), analysisType,dataType);
		/*-------项目支出所有数据---------*/
		List<Object[]> data2=transmitMng.proExpendDataByType(year, deptArr, getUser(), analysisType,dataType);
		data.addAll(data2);
		//项目支出 有多少条项目
		List<Object[]> data3=transmitMng.proNameDataByType(year, deptArr, getUser(), analysisType,dataType);
		//基本支出部门数据
		List<Object[]>deptList=transmitMng.deptNameDataByType(year, deptArr, getUser(), analysisType,dataType);
		//项目支出数据添加到部门数据内
		deptList.addAll(data3);		//所有部门数据
		//所有的项目类型
		List<ProMgrLevel2> typeList = proMgrLevel2Mng.basicTypeList();
		ProMgrLevel1 e1=new ProMgrLevel1();
		e1.setId("2");
		for (int i = 0; i < data3.size(); i++) {
			ProMgrLevel2 e=new ProMgrLevel2();
			e.setfLevCode2((String) data3.get(i)[2]);
			e.setfProType((String) data3.get(i)[2]);
			e.setfLevName2((String) data3.get(i)[1]);
			e.setFproCode((String) data3.get(i)[4]);
			e.setPml(e1);
			typeList.add(e);
		}
		//组装
		List<Object[]> list = null;
		try {
			list = budgetData1Mng.twoReport(data, deptList, economicList,typeList,deptArr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	

	/**
	 * 报表3JSP 申报过程和执行过程
	 */
	@RequestMapping("/threeCollectJsp")
	public String threeCollectJsp(ModelMap model,String sign,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectList", economicList);
		model.addAttribute("sign", sign);
		return "/WEB-INF/view/budget/report_forms/collect_three";
	}
	
	
	/**
	 * 报表3Data（申报过程和执行过程
	 * @param currentYear
	 * @param secondLevelCode
	 * @return
	 */
	@RequestMapping("/threeCollectData")
	@ResponseBody
	public List<Object[]> threeCollectData(String year,String sign,String deptArr){
		//组装
		List<Object[]> list = budgetData1Mng.threeReport(year,deptArr,sign);
		
		return list;
	}
	
	/**
	 * 报表三
	 * @param year
	 * @param sign
	 * @param deptArr
	 * @param analysisType
	 * @return
	 */
	@RequestMapping("/threeCollectDataByType")
	@ResponseBody
	public List<Object[]> threeCollectDataByType(String year,String sign,String deptArr, String analysisType,String dataType){
		//默认查一上
		if(sign.equals("0")){
			if (StringUtil.isEmpty(analysisType)) {
				analysisType = "1";
			}
			if (StringUtil.isEmpty(dataType)) {
				dataType = "1";
			}
		}
		//组装
		List<Object[]> list = budgetData1Mng.threeReportByType(year,deptArr,sign,analysisType,dataType);
		
		return list;
	}
	
	/**
	 * 报表二查询条件部门的数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/deptTree")
	@ResponseBody
	public List<TreeEntity> deptTree(ModelMap model) {
		List<Depart>listDepart=departMng.getAllDeptsParts(null);
		List<TreeEntity> list=new ArrayList<TreeEntity>();
		if(null!=listDepart && listDepart.size()>0){
			for(Depart d:listDepart){
				TreeEntity ft=new TreeEntity();
				ft.setId(d.getId());
				ft.setText(d.getName());
				ft.setLeaf(true);
				list.add(ft);
			}
		}
		TreeEntity t=new TreeEntity();
		t.setId("-1");
		t.setText("所有部门");
		t.setLeaf(true);
		list.add(0,t);
		return list;
	}
	
	/*----------分界线-----------------------执行过程 报表--------------------------begin------------*/
	/**
	 * 报表1 执行过程jsp
	 * @param model
	 * @return
	 */
	@RequestMapping("/firstExecuteJsp")
	public String firstExecuteJsp(ModelMap model,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectList", economicList);
		return "/WEB-INF/view/budget/report_forms/execute_first";
	}
	
	/**
	 * 报表1（执行过程）
	 * @param currentYear
	 * @param secondLevelCode
	 * @return
	 */
	@RequestMapping("/firstExecuteData")
	@ResponseBody
	public List<Object[]> firstExecuteData(String year, String appStartTime, String appEndTime,
			@RequestParam(value = "secondLevelCode[]", required = false)String[] secondLevelCode){
		List<Object[]> departEconomicList = transmitMng.firstStatementExecute(year, appStartTime, appEndTime,
			secondLevelCode, getUser());
		//部门
		List<Depart> departList=departMng.getAllDeptsParts(null);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
//		//组装
		List<Object[]> list = budgetData1Mng.sjfxExecuteList(departEconomicList,departList,economicList);
		return list;
	}
	

	/**
	 * 报表2JSP 执行过程
	 */
	@RequestMapping("/secondExecuteJsp")
	public String secondExecuteJsp(ModelMap model,String year){
		//查询框-5年
		int cYear = Integer.valueOf(DateUtil.getCurrentYear());
		List<Integer> yearList = new ArrayList<>();
		for (int i = cYear + 1; i>2015; i--) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		if(StringUtil.isEmpty(year)){
			year=DateUtil.getCurrentYear();
		}
		model.addAttribute("year", year);
		//经济科目
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		model.addAttribute("subjectList", economicList);
		return "/WEB-INF/view/budget/report_forms/execute_second";
	}
	
	/**
	 * 报表2Data（执行过程
	 * @param currentYear
	 * @param secondLevelCode
	 * @return
	 */
	@RequestMapping("/secondExecuteData")
	@ResponseBody
	public List<Object[]> secondExecuteData(String year,String deptArr, String appStartTime, String appEndTime){
		//经济科目所有
		List<Economic> economicList = economicMng.findByEjLeve("KMJB-02",year);
		/*-------基本支出所有数据---------*/
		List<Object[]> data=transmitMng.basicExpendDataExecute(year,deptArr, getUser(), appStartTime, appEndTime);
		/*-------项目支出所有数据---------*/
		List<Object[]> data2=transmitMng.proExpendDataExecute(year, deptArr, getUser(), appStartTime, appEndTime);
		data.addAll(data2);
		//项目支出 有多少条项目
		List<Object[]> data3=transmitMng.proNameDataExecute(year, deptArr, getUser(), appStartTime, appEndTime);
		//基本支出部门数据
		List<Object[]>deptList=transmitMng.deptNameDataExecute(year, deptArr, getUser(), appStartTime, appEndTime);
		//项目支出数据添加到部门数据内
		deptList.addAll(data3);		//所有部门数据
		//所有的项目类型
		List<ProMgrLevel2> typeList = proMgrLevel2Mng.basicTypeList();
		ProMgrLevel1 e1=new ProMgrLevel1();
		e1.setId("2");
		for (int i = 0; i < data3.size(); i++) {
			ProMgrLevel2 e=new ProMgrLevel2();
			e.setfLevCode2((String) data3.get(i)[2]);
			e.setfProType((String) data3.get(i)[2]);
			e.setfLevName2((String) data3.get(i)[1]);
			e.setPml(e1);
			typeList.add(e);
		}
		//组装
		List<Object[]> list = budgetData1Mng.twoExecuteReport(data, deptList, economicList,typeList,deptArr);
		
		return list;
	}
	
	
	
	/*----------分界线-----------------------执行过程 报表--------------------------end------------*/
	
	/**
	 * 根据年份获取经济科目
	 * @param year
	 * @return
	 */
	@RequestMapping(value="/economicData")
	@ResponseBody
	public List<Economic> economicData(String year) {
		List<Economic> list = economicMng.findByEjLeve("KMJB-02",year);
		return list;
	}
}
