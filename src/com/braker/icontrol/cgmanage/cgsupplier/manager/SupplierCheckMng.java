package com.braker.icontrol.cgmanage.cgsupplier.manager;


import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 供应商审核的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
public interface SupplierCheckMng extends BaseManager<WinningBidder>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	public Pagination pageList(WinningBidder bean, int pageNo, int pageSize, User user);
	
	
	
	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	public void saveCheckInfo(TProcessCheck checkBean, WinningBidder bean, User user,String files)  throws Exception;
	
	
	/**
	 * 供应商入库申请撤回
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String inRecall(Integer id)  throws Exception ;
	
}
