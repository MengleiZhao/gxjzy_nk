package com.braker.icontrol.cgmanage.cgsupplier.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.workflow.entity.TProcessCheck;

public interface SupplierBlackInfoMng extends BaseManager<SupplierBlackInfo>{
	
	
	//黑名单审核list
	public Pagination blackCheckPageList(SupplierBlackInfo sb, int pageNo, int pageSize,User user);
	
	//黑名单审核信息
	public void saveCheckBlack(TProcessCheck checkBean, SupplierBlackInfo bean, User user,String files ) throws Exception;
	
	//获取要审核的黑名单
	public List<SupplierBlackInfo> findCheckBlack(String fwId,User user);
	
	public List<SupplierBlackInfo> findBySupplierBlack(String fwId,String status);
	
	public void deleteSupplierBlack(String fwId, String fwBId);
	/**
	 * 供应商黑名单申请撤回
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String blackRecall(Integer id)  throws Exception ;
}
