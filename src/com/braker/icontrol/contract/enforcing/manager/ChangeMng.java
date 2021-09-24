package com.braker.icontrol.contract.enforcing.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;

public interface ChangeMng extends BaseManager<ContractBasicInfo>{

	/**
	 * 主页面的信息带查询
	 * @param contractBasicInfo
	 * @param user
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	Pagination queryList(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	
	
}
