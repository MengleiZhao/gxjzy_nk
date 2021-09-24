package com.braker.icontrol.cgmanage.cgpay.manager;


import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 付款申请审批的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
public interface CgPayCheckMng extends BaseManager<PurchaseApplyBasic>{
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user);


	
	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	public void saveCheckInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user, Role role,String files) throws Exception;
	
	/*
	 * 财务审定分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-18
	 * @updatetime 2018-08-18
	 */
	public Pagination auditPageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user);
	
	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public Pagination cashierPageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user, String type);
	
}
