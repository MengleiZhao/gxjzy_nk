package com.braker.icontrol.contract.Formulation.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.workflow.entity.TProcessCheck;

public interface ApprovalMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 显示审批主页数据
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination queryList(ContractBasicInfo contractBasicInfo,User user, int pageNo, int pageSize);
	
	/**
	 * 变更合同状态
	 * @param stauts
	 * @param fcId
	 * @param checkInfo
	 * @param user
	 * @param Id
	 */
	void updatefFlowStauts(String fcId,TProcessCheck checkBean,User user,String Id,String files,String fsyjsfiles) throws Exception;
	void updatefFlowStautsbg(String fcId,TProcessCheck checkBean,User user,String Id,String files,String fsyjsfiles) throws Exception;
	
}
