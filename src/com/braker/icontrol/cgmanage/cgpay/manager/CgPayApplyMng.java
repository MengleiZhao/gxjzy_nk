package com.braker.icontrol.cgmanage.cgpay.manager;


import java.util.List;












import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 付款申请审批的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
public interface CgPayApplyMng extends BaseManager<PurchaseApplyBasic>{
	
	
	/*
	 * 采购申请的保存
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public void save(PurchaseApplyBasic bean,User user) throws Exception;
	
	/*
	 * 保存采购审定信息
	 * @author 李安达
	 * @createtime 2019-05-7
	 * @updatetime 2019-05-7
	 */
	public void savePurchaseAuditInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user,String files) throws Exception;
	
}
