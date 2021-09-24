package com.braker.icontrol.expend.loan.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.workflow.entity.TProcessCheck;

public interface PaymentMng extends BaseManager<Payment> {

	//保存
	public Payment savePayment(Payment bean, String files, User user) throws Exception;
	
	//审批保存
	public void saveCheckPayment(TProcessCheck checkBean, Payment bean, User user, Role role, String file) throws Exception;
	
	//删除
	public void deletePayment(Payment bean, User user);
	
	//删除
	public void deletePayment(Integer id, User user,String fId);

	//分页
	public Pagination pageList(Payment bean, User user, String menuType, Integer pageNo, Integer pageSize);

	/**
	 * 
	 * @Description: 还款退回
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  paymentReCall(Integer id)  throws Exception ;


	public Payment findByLId(Integer id);
}
