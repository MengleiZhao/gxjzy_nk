package com.braker.icontrol.budget.release.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.icontrol.budget.release.entity.TIndexDetailRegister;

/**
 * 指标（支出）流水service抽象类
 * @author 叶崇晖
 *
 */
public interface IndexDetailRegisterMng extends BaseManager<TIndexDetailRegister> {
	
	public List<TIndexDetailRegister> findByIndexCode(String indexCode);
	//查询
	public Pagination jsonPagination(TIndexDetailRegister bean,Integer page,Integer rows);
	
	/**
	 * 导出excel
	 * @param dataList
	 * @param filePath
	 * @return
	 */
	HSSFWorkbook exportExcel(List<TIndexDetailRegister> index_dataList, String filePath);
	
	/*
	 * 指标支出信息	
	 * @author 焦广兴		
	 * @createtime 2019-03-26
	 * @updatetime 2019-03-26
	 * fType:费用类型     1、收入	2、还款	3、直接报销	4、申请报销	5、借款	6、采购支付	7、合同报销
	 */
	public Pagination indexDetailData1(Depart depart, String year,String fType,String type, int pageNo, int pageSize,String searchIndexName, String searchDeptName);
	
	
	/*
	 * 预算超额预警指标支出信息	
	 * @author 沈帆		
	 * @createtime 2019-05-05
	 * @updatetime 2019-05-05
	 * fType:费用类型     1、收入	2、还款	3、直接报销	4、申请报销	5、借款	6、采购支付	7、合同报销
	 */
	public Pagination searchByFtype(String indexCode,String userName,String time1,String time2,int pageNo, int pageSize,String fType );
	
	
	/**
	 * 
	* <p>Description: 保存项目明细登记信息</p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月4日
	 */
	public void saveProDetailRegister(TIndexDetailRegister bean) throws Exception;
}
