package com.braker.icontrol.contract.filing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.model.ReceivPlan;

public interface ReceivPlanMng extends BaseManager<ReceivPlan>{

	/**
	 * 查询已付款金额，未付款金额，
	 * @param li
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	List<ContractBasicInfo> query_Amount(List<ContractBasicInfo> li);
	
	/**
	 * 加载付款计划表
	 * @param ContractBasicInfo
	 * @return
	 */
	Pagination allPlan(Integer id,Integer pageNo, Integer pageSize);
	
	/**
	 * 查询合同未付款的记录
	 * @param fContId_R 合同主键
	 * @return
	 */
	List<ReceivPlan> findUnPay(Integer fContId_R);
	
	/**
	 * 根据合同主键查询现在所有付款状态
	 * @param id
	 * @return
	 */
	List<ReceivPlan> queryMoney1(Integer id);
	
	/**
	 * 
	 * @param uptid
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年2月13日
	 */
	List<ReceivPlan> findbyUptId(Integer uptid);
	/**
	 * 
	 * 赵孟雷
	 * @param fcId
	 * @return
	 */
	List<ReceivPlan> findbyConId(Integer fcId);
	
	/**
	 * 根据合同类型判断是否变更查询付款计划,有变更后的显示已付款+变更之后的付款计划，未变更显示原付款计划
	 * @param ctype
	 * @param cid
	 * @return List<ReceivPlan>
	 * @author 陈睿超
	 * @createtime 2020年2月14日
	 */
	List<ReceivPlan> finduptandbase(String ctype,Integer cid);

	List<ReceivPlan> finduptandbaseNew(ContractBasicInfo cbi);
}
