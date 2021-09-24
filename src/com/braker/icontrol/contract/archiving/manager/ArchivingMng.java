package com.braker.icontrol.contract.archiving.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.workflow.entity.TProcessCheck;

public interface ArchivingMng extends BaseManager<Archiving>{

	/**
	 * 查询合同信息列表
	 * @param contractBasicInfo
	 * @return
	 * @author crc
	 * @createtime 2018-06-26
	 */
	Pagination query_CBI(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存一条合同归档信息
	 * @param contractBasicInfo
	 * @param archiving
	 * @param user
	 * @author crc
	 * @throws Exception 
	 * @createtime 2018-06-28
	 */
	void save(ContractBasicInfo contractBasicInfo,Archiving archiving,User user,String files) throws Exception;
	
	List<Archiving> findByContId(String id);
	
	/**
	 * 查询可以归档的合同
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination query_CBI_Archiving(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize);
	/**
	 * 查询変更合同
	 * @param upt
	 * @param user
	 * @param page
	 * @param rows
	 * @param string
	 * @return
	 */

	Pagination query_CBIupt(Upt upt, User user, Integer pageNo, Integer pageSize);

	List<ContractBasicInfo> findByContIds(String id);

	Pagination query_CBIsp(ContractBasicInfo contractBasicInfo, User user,
			Integer pageNo, Integer pageSize);

	Pagination query_CBIuptsp(Upt upt, User user, Integer pageNo,
			Integer pageSize);

	Pagination query_CBIspcb(ContractBasicInfo contractBasicInfo, User user,
			Integer pageNo, Integer pageSize);

	void savebg(ContractBasicInfo contractBasicInfo, Archiving archiving,
			User user,Upt upt,String files) throws Exception;

	void saveCheckInfo(TProcessCheck checkBean, Archiving bean,User user,String files,String stauts,String type)throws Exception;

	void saveCheckInfobg(TProcessCheck checkBean, Archiving bean,User user,String files,String stauts)throws Exception;

	void delete_CBI(String id, User user);
	
	String reCall(String id);
}
