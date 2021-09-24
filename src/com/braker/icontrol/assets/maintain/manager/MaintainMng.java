package com.braker.icontrol.assets.maintain.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.maintain.model.Maintain;
import com.braker.workflow.entity.TProcessCheck;

public interface MaintainMng extends BaseManager<Maintain>{

	/**
	 * 查询维修申请数据
	 * @param maintain
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(Maintain maintain,User user,String sort,String order,Integer pageNo, Integer pageSize);
	
	/***
	 * 查字典
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked); 
	
	/**
	 * 保存维修申请单
	 * @param maintain
	 * @param files
	 * @param storageFiles
	 * @param user
	 */
	void save(Maintain maintain,String files,String storageFiles,User user) throws Exception;
	
	/**
	 * 根据id删除(逻辑删除)
	 * @param id
	 */
	void delete(Integer id);
	
	/**
	 * 加载待审批数据
	 * @param maintain
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination approvalList(Maintain maintain,User user,String sort,String order,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存更新审批信息
	 * @param stauts
	 * @param id
	 * @param user
	 */
	void approveMaintain(String id ,User user,TProcessCheck checkBean,String files) throws Exception;
	
	/**
	 * 加载维修登记时选择维修单数据
	 * @param maintain
	 * @param user
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination regList(Maintain maintain,User user,String sort,String order,Integer pageNo, Integer pageSize);
}
