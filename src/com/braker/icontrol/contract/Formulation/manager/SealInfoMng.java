package com.braker.icontrol.contract.Formulation.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.Formulation.model.SealInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;

public interface SealInfoMng extends BaseManager<SealInfo> {
	/**
	 * 
	 * @Title save 
	 * @Description 保存盖章信息
	 * @author 汪耀
	 * @Date 2020年3月1日 
	 * @param bean
	 * @param id
	 * @param user
	 * @return void
	 * @throws
	 */
	public void save(SealInfo bean, Integer id, User user,String type,ContractBasicInfo cbiBean,Upt uptbean ,String files,String ygzhtwbfiles,String bgygzhtwbfiles);
	
	/**
	 * 
	 * @Title findSealByFcId 
	 * @Description 根据合同主键查询盖章信息主键
	 * @author 汪耀
	 * @Date 2020年3月1日 
	 * @param id
	 * @return
	 * @return SealInfo
	 * @throws
	 */
	public Integer findFsIdByFcId(Integer id);
}
