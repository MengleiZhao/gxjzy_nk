package com.braker.icontrol.cgmanage.cgconfplan.mananger;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 采购配置计划申请的service抽象类
 * @author 冉德茂
 * @createtime 2018-10-11
 * @updatetime 2018-10-11
 */
public interface CgConPlanMng extends BaseManager<ProcurementPlan>{
	/**
	 * 
	 * @Description 分页查询
	 * @author 陈睿超
	 * @param bean
	 * @param pageNo
	 * @param pageSize
	 * @param user
	 * @return
	 * @return Pagination
	 * @throws
	 * @date 2019年12月5日
	 */
	public Pagination pageList(ProcurementPlan bean, Integer pageNo, Integer pageSize, User user);
	
	/**
	 * 
	 * @Description 审批分页查询
	 * @author 汪耀
	 * @param bean
	 * @param page
	 * @param rows
	 * @param user
	 * @return
	 * @return Pagination
	 * @throws
	 * @date 2019年12月6日
	 */
	public Pagination checkPageList(ProcurementPlan bean, Integer page, Integer rows, User user);
	
	/**
	 * 
	 * @Description: 下达分页查询
	 * @author : 汪耀
	 * @param : bean
	 * @param : pageNo
	 * @param : pageSize
	 * @param : user
	 * @return
	 * @return : Pagination
	 * @throws
	 * @date : 2019年12月13日
	 */
	public Pagination resolvePageList(ProcurementPlan bean, String status, Integer pageNo, Integer pageSize, User user);
	
	/**
	 * 
	 * @Description 年度台账分页查询
	 * @author 汪耀
	 * @param bean
	 * @param status
	 * @param pageNo
	 * @param pageSize
	 * @param user
	 * @return
	 * @return Pagination
	 * @throws
	 * @date 2020年1月6日
	 */
	public Pagination ledgerPageList(ProcurementPlan bean, Integer pageNo, Integer pageSize, User user);
	
	/**
	 * 
	 * @Description 一上保存
	 * @author 陈睿超
	 * @param bean
	 * @param mingxi
	 * @param files
	 * @param user
	 * @throws Exception
	 * @return void
	 * @throws
	 * @date 2019年12月5日
	 */
	public void save(ProcurementPlan bean, String mingxi, String files, User user) throws Exception;
	
	/**
	 * 
	 * @Description 根据id删除
	 * @author 陈睿超
	 * @param id
	 * @return void
	 * @throws
	 * @date 2019年12月5日
	 */
	public void delete(Integer id);
	
	/**
	 * 
	 * @Description 采购计划明细
	 * @author 陈睿超
	 * @param tableName
	 * @param idName
	 * @param id
	 * @return
	 * @return List<Object>
	 * @throws
	 * @date 2019年12月5日
	 */
	public List<Object> getMingxi(String tableName, String idName, Integer id);
	
	/**
	 * 
	 * @Description 采购计划明细json
	 * @author 陈睿超
	 * @param mingxi
	 * @param tableClass
	 * @return
	 * @return List
	 * @throws
	 * @date 2019年12月5日
	 */
	public List getMingXiJson(String mingxi, Class tableClass);
	
	/**
	 * 
	 * @Description 查询采购年度计划表中已关联的项目支出明细id
	 * @author 汪耀
	 * @return
	 * @return List<Integer>
	 * @throws
	 * @date 2019年12月6日
	 */
	public List<Integer> getPidList();
	
	/**
	 * 
	 * @Description 一上审批保存
	 * @author 汪耀
	 * @param checkBean
	 * @param bean
	 * @param files
	 * @param user
	 * @throws Exception
	 * @return void
	 * @throws
	 * @date 2019年12月6日
	 */
	public void saveCheck(TProcessCheck checkBean, ProcurementPlan bean, String files, User user) throws Exception;
	
	/**
	 * 
	 * @Description: 一下下达保存
	 * @author : 汪耀
	 * @param : bean
	 * @return : void
	 * @throws
	 * @date : 2019年12月13日
	 */
	public void resolveSave(ProcurementPlan bean);
	
	/**
	 * 
	 * @Description 二上保存
	 * @author 汪耀
	 * @param planBean
	 * @param mingxi
	 * @param files
	 * @param user
	 * @throws Exception
	 * @return void
	 * @throws
	 * @date 2020年1月14日
	 */
	public void secondSave(ProcurementPlan planBean, String mingxi, String files, User user) throws Exception;
	
	/**
	 * 
	 * @Description 获得指标树一级节点
	 * @author 汪耀
	 * @param indexType
	 * @param user
	 * @return
	 * @return List<TreeEntity>
	 * @throws
	 * @date 2020年1月6日
	 */
	public List<TreeEntity> getIndexTreeOne(String indexType, User user);
	
	/**
	 * 
	 * @Description 获得一级指标
	 * @author 汪耀
	 * @param indexName
	 * @param indexType
	 * @param departId
	 * @return
	 * @return List<Object[]>
	 * @throws
	 * @date 2020年1月6日
	 */
	public List<Object[]> getFirstIndex(String indexType, String departId);
	
	/**
	 * 
	 * @Description 获得存在对应支出明细（子节点）的项目id
	 * @author 汪耀
	 * @param parentCodes
	 * @return
	 * @return Map<String,Integer>
	 * @throws
	 * @date 2020年1月6日
	 */
	public Map<String, Integer> getProIdMap(String parentCodes);
	
	/**
	 * 
	 * @Description 根据项目id查询是否存在对应支出明细（子节点）
	 * @author 汪耀
	 * @param parentCodes
	 * @return
	 * @return List<Integer>
	 * @throws
	 * @date 2020年1月6日
	 */
	public List<Integer> getProIdsByparentCodes(String parentCodes);
	
	/**
	 * 
	 * @Description 根据项目id查询二级指标明细
	 * @author 汪耀
	 * @param proId
	 * @return
	 * @return List<Object[]>
	 * @throws
	 * @date 2020年1月6日
	 */
	public List<Object[]> getOutDetailByProId(String proId);
	
	/**
	 * 
	 * @Description 获得指标树二级节点
	 * @author 汪耀
	 * @param id
	 * @return
	 * @return List<TreeEntity>
	 * @throws
	 * @date 2020年1月6日
	 */
	public List<TreeEntity> getIndexTreeTwo(String id);
	
	/**
	 * 
	 * @Description 设置二上申报金额并返回对象（二上流程随明细赋值金额改变）
	 * @author 汪耀
	 * @param id
	 * @param amount
	 * @return
	 * @return ProcurementPlan
	 * @throws
	 * @date 2020年1月11日
	 */
	public ProcurementPlan setPurSecondAmount(Integer id, Double amount);
	
	/**
	 * 
	 * @Description 二上审批保存
	 * @author 汪耀
	 * @param checkBean
	 * @param bean
	 * @param files
	 * @param user
	 * @throws Exception
	 * @return void
	 * @throws
	 * @date 2019年12月17日
	 */
	public void secondSaveCheck(TProcessCheck checkBean, ProcurementPlan bean, String files, User user) throws Exception;
	
}
