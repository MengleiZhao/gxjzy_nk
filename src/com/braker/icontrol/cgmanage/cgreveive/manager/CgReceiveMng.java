package com.braker.icontrol.cgmanage.cgreveive.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 采购验收的service抽象类
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */
public interface CgReceiveMng extends BaseManager<AcceptCheck>{
	
	
	/*
	 * 保存验收信息
	 * @author 冉德茂
	 * @createtime 2018-07-18
	 * @updatetime 2018-07-18
	 */
	public void saveReceive(AcceptCheck acptbean, PurchaseApplyBasic bean, String file1,String file2,User user) throws Exception;
	
	/*
	 * 历史验收记录
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	public List<AcceptCheck> checkHistory(Integer id);
	
	/**
	 * 
	 * @Description: 保存审核信息
	 * @author 汪耀
	 * @param @param checkBean
	 * @param @param acptbean
	 * @param @param user
	 * @param @param files
	 * @param @throws Exception    
	 * @return void
	 */
	public void saveCheck(TProcessCheck checkBean, AcceptCheck acptbean, PurchaseApplyBasic bean, String files, User user,String zjyjfiles) throws Exception;

	public String reCall(Integer id)  throws Exception ;
	
	/**
	 * 采购验收获取采购明细
	 */
	
	List<Object> mingxi(PurchaseApplyBasic bean,String type);
	
	/*
	 * 采购验收删除
	 * @author 赵孟雷
	 * @createtime 2021-02-01
	 * @updatetime 2021-02-01
	 */
	public void delete(Integer id,User user,String fId);
}
