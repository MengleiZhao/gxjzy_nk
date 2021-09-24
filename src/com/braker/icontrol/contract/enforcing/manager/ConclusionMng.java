package com.braker.icontrol.contract.enforcing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Conclusion;
import com.braker.icontrol.contract.enforcing.model.ConclusionAttac;

public interface ConclusionMng extends BaseManager<Conclusion>{

	 /**
	 * 保存结项信息
	 * @param contractBasicInfo
	 * @param conclusion
	 * @param user
	 */
	void saveConclusion(ContractBasicInfo contractBasicInfo,Conclusion conclusion, User user,List<ConclusionAttac> conclusionAttac);
	
	List<Conclusion> findByfContId(String id);
}
