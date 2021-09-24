package com.braker.icontrol.budget.manager.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;

/**
 * 指标下达的service抽象类
 * @author 叶崇晖
 * @createtime 2018-10-08
 * @updatetime 2018-10-08
 */
public interface TransmitMng extends BaseManager<TBudgetIndexMgr> {
	
	/*
	 * 指标分页查询
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	public Pagination pageList(TBudgetIndexMgr bean, String indexType, int pageNo, int pageSize, String orderColumn, String order, User user);
	
	/*
	 * 指标下达保存
	 * @author 叶崇晖
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	public void saveIndex(Integer bId);
	
	/**
	 * 立即下达计划
	 * @author 叶崇晖
	 * @createtime 2019-03-20
	 * @updatetime 2019-03-20
	 * @param id
	 */
	public void ljxd(Integer id, User user);
	
	/**
	 * 总预算    各类基本指标额度  数据列表	
	 * @author 焦广兴		
	 * @createtime 2019-03-?
	 * @updatetime 2019-03-28
	 */
	public Pagination getData15(Depart depart, String year, String indexType, int pageNo, int pageSize,String searchIndexName, String searchDeptName);
	
	/**
	 * 指标管理信息	
	 * @author 焦广兴		
	 * @createtime 2019-03-25
	 * @updatetime 2019-03-25
	 */
	public Pagination indexMgrData1(Depart depart,String indexName, String year,int pageNo, int pageSize);
	
	/**
	 * 各部门指标管理信息	
	 * @author 焦广兴		
	 * @createtime 2019-03-25
	 * @updatetime 2019-03-25
	 */
	public Pagination indexMgrData2(Depart depart,String indexType, String year,int pageNo, int pageSize,String searchIndexName, String searchIndexCode);
	
	/*
	 * 预算超额预警指标分页查询
	 * @author 沈帆
	 * @createtime 2019-4-29
	 * @updatetime 2018-4-29
	 */
	public Pagination excesspageList(TBudgetIndexMgr bean, String indexType, int pageNo, int pageSize, String orderColumn, String order, User user);
	
	/*
	 * 指标执行报表分页查询
	 * @author 沈帆
	 * @createtime 2019-7-11
	 * @updatetime 2019-7-11
	 */
	List<Object[]> groupByYear();
	
	/**
	 * 申报过程 报表1
	 * @author:安达
	 * @param currentYear
	 * @param secondLevelCode
	 * @param user
	 * @return
	 */
	public List<Object[]> departEconomicList(String currentYear, String secondLevelCode[], User user);
	
	/**
	 * 执行过程 报表1
	 * @author:焦广兴
	 * @param currentYear
	 * @param appEndTime 
	 * @param appStartTime 
	 * @param secondLevelCode
	 * @param user
	 * @return
	 */
	public List<Object[]> firstStatementExecute (String currentYear, String appStartTime, String appEndTime, String secondLevelCode[], User user);
	
	/**
	 * 申报过程 报表二 基本数据
	 * @author:焦广兴
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @return
	 */
	public List<Object[]> basicExpendData(String currentYear, String dept, User user);
	/**
	 * 执行过程 报表二 基本数据
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @param appEndTime 
	 * @param appStartTime 
	 * @return
	 */
	public List<Object[]> basicExpendDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime);
	/**
	 * 申报过程 报表二 项目数据
	 * @author:焦广兴
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @return
	 */
	public List<Object[]> proExpendData(String currentYear, String dept, User user);
	
	/**
	 * 执行过程 报表二 项目数据
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @param appEndTime 
	 * @param appStartTime 
	 * @return
	 */
	public List<Object[]> proExpendDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime);
	
	/**
	 * 申报过程 报表二 项目支出的项目名称
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @return
	 */
	public List<Object[]> proNameData(String currentYear, String dept, User user);
	/**
	 * 执行过程 报表二 项目支出的项目名称
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @param appEndTime 
	 * @param appStartTime 
	 * @return
	 */
	public List<Object[]> proNameDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime);
	
	/**
	 * 申报过程  报表二 基本支出的部门名称
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @return
	 */
	public List<Object[]> deptNameData(String currentYear, String dept, User user);
	
	/**
	 * 执行过程  报表二 基本支出的部门名称
	 * @param currentYear
	 * @param dept
	 * @param user
	 * @param appEndTime 
	 * @param appStartTime 
	 * @return
	 */
	public List<Object[]> deptNameDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime);

	/**
	 * 根据类型统计报表一
	 * @param year
	 * @param secondLevelCode
	 * @param user
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> departEconomicListByType(String year, String[] secondLevelCode, User user,
			String analysisType, String dataType);

	/**
	 * 基本支出所有数据（报表二）
	 * @param year
	 * @param deptArr
	 * @param user
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> basicExpendDataByType(String year, String deptArr, User user, String analysisType, String dataType);

	/**
	 * 项目支出所有数据（报表二）
	 * @param year
	 * @param deptArr
	 * @param user
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> proExpendDataByType(String year, String deptArr, User user, String analysisType, String dataType);

	/**
	 * 项目支出 有多少条项目
	 * @param year
	 * @param deptArr
	 * @param user
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> proNameDataByType(String year, String deptArr, User user, String analysisType, String dataType);

	/**
	 * 基本支出部门数据
	 * @param year
	 * @param deptArr
	 * @param user
	 * @param analysisType
	 * @param dataType 
	 * @return
	 */
	public List<Object[]> deptNameDataByType(String year, String deptArr, User user, String analysisType, String dataType);

	/**
	 * 报表比较分析
	 * @param year
	 * @param secondLevelCode
	 * @param user
	 * @return
	 */
	public List<Object[]> departEconomicAllList(String year, String[] secondLevelCode, User user);
}
