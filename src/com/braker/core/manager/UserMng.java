package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.common.security.BadCredentialsException;
import com.braker.common.security.LockedException;
import com.braker.common.security.UserNameNotFoundException;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.Role;
import com.braker.core.model.RoleDepartUser;
import com.braker.core.model.User;

public interface UserMng extends BaseManager<User>{
	public User login(String accountNo,String password) throws UserNameNotFoundException,BadCredentialsException,LockedException;
	public User SSOLogin(String accountNo) throws UserNameNotFoundException,BadCredentialsException,LockedException;
	public Pagination list(User user,String departId,String sort, String order,int pageNo,int pageSize);
	
	/**
	 * 巡查责任人
	 * @param bean
	 * @param sort
	 * @param order
	 * @param pageIndex
	 * @param pageSize
	 * @param isQuRole
	 * @param isStreetRole
	 * @param user
	 * @return
	 */
	public Pagination refInspectorList(User bean,String sort, String order,
			int pageIndex, int pageSize,boolean isQuRole,boolean isStreetRole,User user);
	
	/**
	 * 巡查责任人
	 * @param isQuRole
	 * @param isStreetRole
	 * @param user
	 * @return
	 */
	public List<User> inspectorList(boolean isQuRole,boolean isStreetRole,User user);
	
	/**
	 * 重置密码
	 * @param userId
	 * @param user 操作用户
	 */
	public void reSetPwd(String userId,User user);
	
	/**
	 * 验证用户是否已存在
	 * @param user
	 * @return
	 */
	public boolean isExist(User user);
	
	/**
	 * 保存
	 * @param bean
	 * @param roleIds
	 * @param user 操作用户
	 */
	public void save(User bean,String roleIds,User user);
	
	/**
	 * 根据条件获取用户
	 * @param uId 用户Id
	 * @param depart 用户所在部门
	 * @param roleCode 角色代码
	 * @return
	 */
	public List<User> list(String uId,Depart depart,String roleCode);
	
	
	public List<Lookups> getXiangMuJueSe();
	public List<User> getUserInfo();
	/**
	 * 获取某个部门下所有用户
	 * @param departCode
	 * @return
	 */
	public List<User> getUserByDepartCode(String departCode);
	/**
	 * 获取所有用户
	 * @param 
	 * @return
	 */
	public List<User> getALL();
	public List<RoleDepartUser> getALL(User user);
	
	public List<User> getByIds(String ids);
	
	
	public User getByAccount(String account);
	/**
	 * 获取责任人
	 * @param 
	 * @return
	 */
	public List<User> getChildByJwhCode(String jwhId);
	
	
	public  boolean findByAccount(String account);
	/**
	 * 获取责任人
	 * @param jwhId  居委会id
	 * @param hasqu  区权限判断
	 * @param hasStreet  街道判断
	 * @return
	 */
	public List<User> findChild(String streetId,String jwhId,String liablePerson,boolean hasqu,boolean hasStreet,User user);
	
	public Pagination liablelist(User user,boolean isQuRole,boolean isStreetRole,String sort, String order,int pageNo,int pageSize,User u);

	public User zzwwlogin(String accountNo, String password) throws UserNameNotFoundException, BadCredentialsException, LockedException;
	
	/**
	 * 获取有某个角色的人员
	 * @param roleCode
	 * @return
	 */
	public List<User> listAuditor(String roleCode);
	
	/**
	 * 检查手机号唯一
	 * @return
	 */
	public boolean checkMobileNo(String mobileNo,String id);
	
	/**
	 * 返回用户的角色
	 * @author 叶崇晖
	 * @createtime 2018-06-19
	 * @updatetime 2018-06-19
	 */
	public List<Role> getUserRole(String userId); 
	
	/**
	 * 返回用户信息
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public Pagination getNameAndDept(User user,Integer pageNo,Integer pageSize);
	
	/**
	 * 根据角色id和部门id获取用户
	 * @param roleId
	 * @param departId
	 * @return
	 */
	public User getUserByRoleIdAndDepartId(String roleId,String departId);
	
	/**
	 * 
	* @author:安达
	* @Title: wfNameAndDepart 
	* @Description: 流程配置的时候，选择角色 
	* @return
	* @return List<Object[]>    返回类型 
	* @date： 2019年7月3日下午10:19:07 
	* @throws
	 */
	public  List<RoleDepartUser> wfNameAndDepart(String roleName,String departName);
	
	/**
	 * 
	 * @Description: 查看当前部门下是否有其他人员
	 * @author 汪耀
	 * @param @param departId
	 * @param @return    
	 * @return boolean
	 */
	public boolean checkUsersByDepartId(String departId);
	
	/**
	 * 
	 * @Description: 根据角色name和部门name获取用户
	 * @author 汪耀
	 * @param @param roleName
	 * @param @param departName
	 * @param @return    
	 * @return User
	 */
	public User getUserByRoleNameAndDepartName(String roleName,String departName);
	
	
	public void updateUserFlow (String UserId,String userName,String userById,String departName)throws Exception;
	
	Pagination listTravel(User user,String departId,String sort,String order,int pageNo, int pageSize) ;
	
	/**
	 * 根据ids查询用户
	 * @param ids
	 * @return
	 */
	public Pagination getUserByIds(String ids);
	
}
