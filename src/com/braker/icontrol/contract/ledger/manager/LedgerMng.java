package com.braker.icontrol.contract.ledger.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;

public interface LedgerMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 查询所有已审核合同
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination findAllCBI(ContractBasicInfo contractBasicInfo,boolean selfDepart,User user,Integer pageNo, Integer pageSize);
	/**
	 * 获取所有已审核合同的数据统计
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Object[]> findAllStatistics(ContractBasicInfo contractBasicInfo,boolean selfDepart,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 查询所有的合同信息（分部门）
	 * @return
	 */
	List<ContractBasicInfo> ledger(ContractBasicInfo cb,User user);
	/**
	 * 查询合同信息导出信息
	 * @return
	 */
	List<ContractBasicInfo> ledgerExport(ContractBasicInfo cb,User user);
	
	/**
	 * 导出excel转换原合同台账
	 * @param cbi 转换数据
	 * @param filePath
	 * @return
	 */
	HSSFWorkbook exportExcel(List<ContractBasicInfo> cbi, String filePath);
	/**
	 * 导出excel转换变更合同台账
	 * @param cbi 转换数据
	 * @param filePath
	 * @return
	 */
	HSSFWorkbook exportExcelUpt(List<Upt> cbi, String filePath);
	
	/**
	 * 查询变更合同数据
	 * @param upt
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年12月21日
	 * @updator 赵孟雷
	 * @updatetime 2020年12月21日
	 */
	Pagination uptList(Upt upt, User user, Integer pageNo, Integer pageSize);
	/**
	 * 查询变更合同导出数据
	 * @param upt
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年12月21日
	 * @updator 赵孟雷
	 * @updatetime 2020年12月21日
	 */
	List<Upt> uptListExport(Upt upt, User user, Integer pageNo, Integer pageSize);
}
