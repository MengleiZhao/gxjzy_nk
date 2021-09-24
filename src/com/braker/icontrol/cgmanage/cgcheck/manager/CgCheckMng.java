package com.braker.icontrol.cgmanage.cgcheck.manager;


import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgcheck.model.PurchaseCheckInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 采购审核的service抽象类
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */
public interface CgCheckMng extends BaseManager<PurchaseApplyBasic>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-16
	 * @updatetime 2018-07-16
	 */
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user, String timea, String timeb, String amounta, String amountb);
	
	/*
	 * 历史审批记录
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-17
	 */
	public List<PurchaseCheckInfo> checkHistory(Integer id, String stauts);
	
	
	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-07-17
	 * @updatetime 2018-07-1
	 */
	public void saveCheckInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user,String files) throws Exception ;

	public Pagination updatePageList(PurchaseApplyBasic bean, Integer page, Integer rows, User user);
	
}
