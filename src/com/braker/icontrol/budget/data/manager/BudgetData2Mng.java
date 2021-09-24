package com.braker.icontrol.budget.data.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;

/**
 * 指标执行情况月报接口 
 *
 */
public interface BudgetData2Mng extends BaseManager<BudgetData2> {

	/**
	 * 导出excel
	 * @param dataList
	 * @param filePath
	 * @return
	 */
	HSSFWorkbook exportExcel(List<TBudgetIndexMgr> index_dataList,List<TBudgetIndexMgr> dept_dataList, String filePath);

	/**
	 * 导出表三的Excel
	 * @param list
	 * @param filePath
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月5日
	 * @updateTime2019年11月5日
	 */
	HSSFWorkbook exportExcelThree(List<Object[]> list, String filePath);
}
