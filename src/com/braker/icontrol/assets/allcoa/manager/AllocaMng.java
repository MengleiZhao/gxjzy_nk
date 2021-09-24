package com.braker.icontrol.assets.allcoa.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.allcoa.model.Alloca;
import com.braker.workflow.entity.TProcessCheck;

public interface AllocaMng extends BaseManager<Alloca>{

	/**
	 * 调拨申请主页面数据
	 * @param allcoa
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination appJsonPagination(Alloca allcoa,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存调拨记录
	 * @param alloca
	 * @param user
	 */
	void save(Alloca alloca,User user,String allocaFlies,String planJson)  throws Exception;
	
	/**
	 * 修改调拨单状态为99
	 * @param id
	 */
	void deleteById(Integer id,User user);
	
	/**
	 * 调拨审批主页面数据
	 * @param allcoa
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination approvalJsonPagination(Alloca alloca,User user, Integer pageNo,Integer pageSize);
	
	/**
	 * 更新调拨单的状态（通过还是不通过）
	 * @param alloca
	 * @param user
	 * @param stauts
	 */
	void updateStauts(Alloca alloca,User user,String stauts,TProcessCheck checkBean,String file) throws Exception;
	
	/**
	 * 查询字典里资产类型
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked);
	
	/**
	 * 根据一个条件查询
	 * @param condition 条件 
	 * @param val 值
	 * @return
	 */
	Alloca findbyCondition(String condition,String val);
	
	/**
	 * 撤回表单，修改数据
	 * @param id
	 */
	String reCall(String id);
	
}
