package com.braker.icontrol.contract.dispute.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.contract.dispute.model.DisputAttac;
import com.braker.icontrol.contract.dispute.model.Dispute;

public interface DisputAttacMng extends BaseManager<DisputAttac>{

	/**
	 * 保存合同纠纷附件
	 * @param disputFile
	 */
	void saveDisputFile(Dispute dispute,List<DisputAttac> disputFile,User user);
	
	/**
	 * 根据纠纷id来查纠纷附件
	 * @param dispute
	 * @return
	 */
	List<DisputAttac> findFile(String id);

	/**
	 * 根据附件名称来查纠纷附件
	 * @param dispute
	 * @return
	 */
	List<DisputAttac> findByName(String name);
	
	/**
	 * s删除
	 * @param disputAttac
	 */
	void delete(List<DisputAttac> disputAttac);
}
