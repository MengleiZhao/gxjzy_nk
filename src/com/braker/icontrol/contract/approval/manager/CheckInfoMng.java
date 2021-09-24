package com.braker.icontrol.contract.approval.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.approval.model.CheckInfo;
import com.braker.icontrol.contract.enforcing.model.Conclusion;

public interface CheckInfoMng extends BaseManager<CheckInfo> {

	/**
	 * 查询审批记录
	 * @param fcId
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	List<CheckInfo> query(Integer fcId);

	
	/**
	 * 根据合同号查询
	 * @param contractBasicInfo
	 * @param user
	 */
	Pagination findByContId(ContractBasicInfo contractBasicInfo,User user, int pageNo, int pageSize);
	
	/**
	 * 修改合同审批记录的状态
	 * @param id 合同的主键id
	 */
	void updateCheckStauts(Integer id);
	
	/**
	 * 查询合同审批记录里不同状态的合同
	 * @param id 合同的id
	 * @param stauts 要查的状态
	 * @return
	 */
	List<CheckInfo> checkHistory(Integer id ,String stauts);
}
