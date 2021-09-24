package com.braker.icontrol.contract.filing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.model.SignInfo;

public interface SignInfoMng extends BaseManager<SignInfo>{

	/**
	 * 根据合同号查询
	 * @param contractBasicInfo
	 * @return
	 */
	List<SignInfo> find_Sign(ContractBasicInfo contractBasicInfo);
	
	/**
	 * 根据合同号查询是否有信息
	 * @param contractBasicInfo
	 * @return
	 */
	int find_Sign_number(ContractBasicInfo contractBasicInfo); 
}
