package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Role;
import com.braker.core.model.User;

public interface RoleMng extends BaseManager<Role>{
	
	
	public Pagination list(Role bean,String sort,String order,int pageIndex,int pageSize);
	public void save(Role bean,String funcIds,User user);
	/**
	 * 拿到所有的角色
	 * @return
	 */
	public List<Role> getAll(String departId);
	
	/**
	 * 
	* @author:安达
	* @Title: getRolesByUserId 
	* @Description: 根据用户id得到所有角色 使用 | 分割
	* @param userId
	* @return
	* @return String    返回类型 
	* @date： 2019年5月28日上午11:11:27 
	* @throws
	 */
	public String getRolesByUserId(String userId);
	
	/**
	 * 
	 * @Description: 根据部门Id和角色岗位名称获得相应的用户id
	 * @author 汪耀
	 * @param @param departId
	 * @param @param roleName
	 * @param @return    
	 * @return String
	 */
	public String getUserIdByDepartIdAndRoleName(String departId, String roleName);
	
	/**
	 * 
	 * @Description: 根据部门名称和角色岗位名称获得相应的用户id
	 * @author 汪耀
	 * @param @param departName
	 * @param @param roleName
	 * @param @return    
	 * @return String
	 */
	public String getUserIdByDepartNameAndRoleName(String departName, String roleName);
	
	/**
	 * 
	 * @Description: 根据角色岗位名称获得相应的用户id
	 * @author 汪耀
	 * @param @param roleName
	 * @param @return    
	 * @return String
	 */
	public String getUserIdByRoleName(String roleName);
	
	/**
	 * 
	 * @Description: 根据用户id查到其主管校长id
	 * @author 汪耀
	 * @param @param userId
	 * @param @return    
	 * @return String
	 */
	public String getManagerIdByUserId(String userId);
	
	/**
	 * 验证角色是否已存在
	 * @param role
	 * @return
	 */
	public boolean isExist(Role role);
}
