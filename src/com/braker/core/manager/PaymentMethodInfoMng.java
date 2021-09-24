package com.braker.core.manager;

import java.util.List;

import com.braker.common.entity.PayeeDao;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.User;

/**
 * 个人收款方式信息的service抽象类
 * @author 叶崇晖
 * @createtime 2018-11-19
 * @updatetime 2018-11-19
 */
public interface PaymentMethodInfoMng extends BaseManager<PaymentMethodInfo> {
	
	/**
	 * 根据付款人id查询相应的信息
	 * @author 叶崇晖
	 * @param payeeId为付款人id
	 * @return 付款人信息集合
	 */
	public List<PaymentMethodInfo> findByPayeeId(String payeeId);
	
	/**
	 * 新增或修改个人收款信息
	 * @author 叶崇晖
	 * @param bean实现payeeDao的收款人类
	 * @param payee收款人
	 */
	public void saveInfo(PayeeDao bean, User payee);
}
