package com.braker.icontrol.budget.data.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.SysDepartEconomic;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;

/**
 * 指标执行情况年报接口  
 *
 */
public interface BudgetData1Mng extends BaseManager<BudgetData1> {

	/**
	 * 整合生成指标年度统计数据
	 * @param list1 指标列表
	 * @param list2 指标明细列表
	 * @param years 年度列表
	 * @return
	 */
	public List<BudgetData1> getYearList(List<TBudgetIndexMgr> list1, List<Object[]> list2, String[] years);

	/**
	 * 整合生成指标月度统计数据
	 * @param list1 指标列表
	 * @param list2 指标明细列表
	 * @param years 月度列表
	 * @return
	 */
	public List<BudgetData2> getMonthList(List<TBudgetIndexMgr> list1,
			List<Object[]> list2, List<Object[]> list3, String[] months);

	
	/**
	 * 生成需要导出的年报+月报表
	 */
	public HSSFWorkbook exportExcel(List<BudgetData1> yearList,
			List<BudgetData2> monthList, String filePath);
	
	public List<Object[]> sjfxList(List<Object[]> departEconomicList,List<Depart> departList, List<Economic> economicList);
	
	/**
	 * 拼装数据
	 * @param data	查询的数据
	 * @param deptList 部门数据
	 * @param economicList	所有经济科目
	 * @param typeList	所有项目类型
	 * @return
	 */
	public List<Object[]> twoReport(List<Object[]> data,List<Object[]> deptList, List<Economic> economicList,List<ProMgrLevel2> typeList,String deptArr);
	/**
	 * 拼装数据
	 * @param data	查询的数据
	 * @param deptList 部门数据
	 * @param economicList	所有经济科目
	 * @param typeList	所有项目类型
	 * @return
	 */
	public List<Object[]> threeReport(String year,String deptArr,String sign);
	/**
	 * 拼装数据
	 * @param data	查询的数据
	 * @param deptList 部门数据
	 * @param economicList	所有经济科目
	 * @param typeList	所有项目类型
	 * @return
	 */
	public List<Object[]> findDepartCodeAndName(List<Object[]> data,String year);

	/**
	 * 报表三拼装数据
	 * @param year
	 * @param deptArr
	 * @param sign
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> threeReportByType(String year, String deptArr, String sign, String analysisType, String dataType);

	/**
	 * 比较分析报表
	 * @param departEconomicList
	 * @param departList
	 * @param economicAllList
	 * @return
	 */
	public List<Object[]> sjfxAllList(List<Object[]> departEconomicList, List<Depart> departList,
			List<String> economicAllList);

	/**
	 * 执行过程报表一数据组装
	 * @param departEconomicList
	 * @param departList
	 * @param economicList
	 * @return
	 */
	public List<Object[]> sjfxExecuteList(List<Object[]> departEconomicList, List<Depart> departList,
			List<Economic> economicList);

	/**
	 * 执行过程报表二数据组装
	 * @param data
	 * @param deptList
	 * @param economicList
	 * @param typeList
	 * @param deptArr
	 * @return
	 */
	public List<Object[]> twoExecuteReport(List<Object[]> data, List<Object[]> deptList, List<Economic> economicList,
			List<ProMgrLevel2> typeList, String deptArr);
}
