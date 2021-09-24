package com.braker.workflow.manager;

import java.util.List;

import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.workflow.entity.TProcessDefin;

public interface TProcessDefinMng extends BaseManager<TProcessDefin> {

	/**
	 * 加载流程定义list页面的数据
	 * @param tProcessDefin 搜索条件
	 * @param pageNo	
	 * @param pageSize
	 * @return
	 */
	Pagination list(TProcessDefin tProcessDefin,Integer pageNo,Integer pageSize);
	
	/**
	 * 查询字典里相应数据
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked);
	
	/**
	 * 保存工作流
	 * @param tProcessDefin
	 * @param user
	 */
	void save(TProcessDefin tProcessDefin,User user);
	
	/**
	 * 根据id删除
	 * @param id
	 */
	void deleteById(String id)throws Exception;
	
	/**
	 * 加载流程监控list页面的数据
	 * @param tProcessDefin 搜索条件
	 * @param pageNo	
	 * @param pageSize
	 * @return
	 */
	Pagination PMlist(TProcessDefin tProcessDefin,Integer pageNo,Integer pageSize)throws Exception;
	
	/**
	 * 根据资源名称和当前登陆者所属部门查询对应工作流
	 * @param FBusiArea
	 * @param departCode
	 * @return
	 */
	TProcessDefin getByBusiAndDpcode(String FBusiArea,String departCode);
	
	/**
	 * 根据资源名称获得流程集合
	 * @param FBusiArea
	 * @return
	 */
	List<TProcessDefin> findTProcessDefinsByFBusiArea(String FBusiArea);
	/**
	 * 根据多個资源名称获得流程集合
	 * @param FBusiArea
	 * @return
	 */
	List<TProcessDefin> findTProcessDefinsByFBusiAreas(String FBusiAreas);
}
