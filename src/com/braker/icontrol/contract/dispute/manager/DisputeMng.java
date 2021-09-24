package com.braker.icontrol.contract.dispute.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.dispute.model.DisputAttac;
import com.braker.icontrol.contract.dispute.model.Dispute;

public interface DisputeMng extends BaseManager<Dispute>{

	/**
	 * 查询已备案完成的合同信息
	 * @param ContractBasicInfo
	 * @return
	 * @createtime 2018-07-03
	 * @author crc
	 */
	Pagination list(ContractBasicInfo ContractBasicInfo,User user ,Integer pageNo, Integer pageSize);
	
	/**
	 * 新增时保存纠纷记录
	 * @param dispute
	 * @param user
	 * @createtime 2018-07-03
	 * @author crc
	 */
	void save(Dispute dispute,String fhtjffiles,User user,ContractBasicInfo contractBasicInfo);
	
	/**
	 * 根据合同id查询是否有该条记录
	 * @param id
	 * @return
	 * @createtime 2018-07-03
	 * @author crc
	 */
	int findD(String id);
	
	/**
	 * 根据合同id查纠纷
	 * @param id
	 * @return
	 */
	List<Dispute> findByContId(String id);

	void deletejf(Integer id, User user, String fId);

	
}
