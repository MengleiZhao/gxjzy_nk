package com.braker.icontrol.contract.enforcing.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;

public interface EnforcingMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 查询已完成审批和备案的合同
	 * @param contractBasicInfo
	 * @param user
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	Pagination queryList_E(ContractBasicInfo contractBasicInfo, User user, Integer pageNo, Integer pageSize);
	
	/*
	 * 送审合同付款申请信息
	 * @author 叶崇晖
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	public void save(ContPay bean, ReceivPlan receivPlanBean, User user,String fhtzxFiles, ReimbPayeeInfo payee, String form1)  throws Exception;
	
	/**
	 * 
	 * @Description: 合同付款退回
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  contractReCall(Integer id)  throws Exception ;
}
