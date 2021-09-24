package com.braker.icontrol.contract.filing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TProcessCheck;

public interface ProceedsPlanMng extends BaseManager<ProceedsPlan>{

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
	List<ProceedsPlan> findUnPay(Integer fContId_R);
	
	/**
	 * 根据合同主键查询现在所有付款状态
	 * @param id
	 * @return
	 */
	List<ProceedsPlan> queryMoney1(Integer id);
	
	/**
	 * 
	 * @param uptid
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年2月13日
	 */
	List<ProceedsPlan> findbyUptId(Integer uptid);
	/**
	 * 
	 * @param uptid
	 * @return
	 * @author 赵孟雷
	 * @createtime 2021年3月11日
	 */
	List<ProceedsPlan> findbyConId(Integer conId);
	
	/**
	 * 根据合同类型判断是否变更查询付款计划,有变更后的显示已付款+变更之后的付款计划，未变更显示原付款计划
	 * @param ctype
	 * @param cid
	 * @return List<ReceivPlan>
	 * @author 陈睿超
	 * @createtime 2020年2月14日
	 */
	List<ProceedsPlan> finduptandbase(String ctype,Integer cid);
	
	Pagination pagelist(ContractBasicInfo contractBasicInfo,ProceedsPlan bean, Integer page, Integer rows, User user);
	
	void editAffirm(ProceedsPlan bean);
	
	Pagination allProceedsPlan(Integer id,Integer pageNo, Integer pageSize);
	
	public void savesk(ContPay bean, ProceedsPlan receivPlanBean,  User user,String fhtzxFiles,ReimbPayeeInfo payee, String form1)  throws Exception;
	public String reCall(Integer id) throws Exception;
	
	public Pagination pagelistCkeck(ContractBasicInfo contractBasicInfo,ProceedsPlan bean, Integer page, Integer rows, User user);
	
	public void saveProCheckInfo(TProcessCheck checkBean, ContPay bean, ProceedsPlan proceedsPlan, User user,String files)  throws Exception;
}
