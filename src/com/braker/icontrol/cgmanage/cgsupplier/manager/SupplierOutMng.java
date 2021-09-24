package com.braker.icontrol.cgmanage.cgsupplier.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.workflow.entity.TProcessCheck;

public interface SupplierOutMng extends BaseManager<SupplierOut>{
	//黑名单审核信息
	public void saveCheckOut(TProcessCheck checkBean, SupplierOut bean, User user,String files ) throws Exception;
	public List<SupplierOut> findCheckOut(String fwId, User user);
	public List<SupplierOut> findBySupplierOut(String fwId,String status);
	public void deleteSupplierOut(Integer fwId, Integer foId);
	/**
	 * 供应商出库申请撤回
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String outRecall(Integer id)  throws Exception ;
}