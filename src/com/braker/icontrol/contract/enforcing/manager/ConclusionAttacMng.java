package com.braker.icontrol.contract.enforcing.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.contract.enforcing.model.Conclusion;
import com.braker.icontrol.contract.enforcing.model.ConclusionAttac;

public interface ConclusionAttacMng extends BaseManager<ConclusionAttac>{

	/**
	 * 保存合同结项的附件
	 * @param conclusion
	 * @param user
	 * @param conclusionAttac
	 */
	void save(Conclusion conclusion, User user,List<ConclusionAttac> conclusionAttac);

	/**
	 * 查询所有合同结项的附件
	 * @param conclusion
	 * @return
	 */
	List<ConclusionAttac> findAllFile(String id);
	
	/**
	 * 根据附件名称查询
	 * @param name
	 * @return
	 */
	List<ConclusionAttac> findByFileName(String name);
	
	/**
	 * 根据附件查询删除
	 * @param conclusionAttac
	 */
	void deleteByName(List<ConclusionAttac> conclusionAttac);

}
