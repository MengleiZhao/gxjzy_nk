package com.braker.icontrol.contract.ending.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.ending.model.Ending;
import com.braker.workflow.entity.TProcessCheck;

public interface EndingMng extends BaseManager<Ending> {

	/**
	 * 查询合同终止list页面的数据
	 * @param ending
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(Ending ending,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 查询合同终止审批list页面数据
	 * @param ending
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination appList(Ending ending,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存
	 * @param ending
	 * @param user
	 */
	void save(Ending ending,User user,String file) throws Exception;
	
	/**
	 * 根据相应条件查询
	 * @param condition1
	 * @param val1
	 * @return
	 */
	List<Ending> find1(String condition1,String val1,String stauts);
	
	/**
	 * 根据合同主键来查询
	 * @param fcId
	 * @return
	 */
	Ending findByfcId(String fcId);
	
	/**
	 * 更新终止单的状态，修改合同已付款项的钱，合同状态改为终止
	 * @param id 合同主键id
	 * @param checkInfo 审批信息
	 * @param stauts 通过不通过意见
	 * @param endingId 终止单Id
	 * @param user
	 */
	void updateCheck(String id,TProcessCheck checkBean,String endingId,User user,String files) throws Exception;
	
	/**
	 * 撤回表单，修改数据
	 * @param id
	 */
	String reCall(String id);
}
