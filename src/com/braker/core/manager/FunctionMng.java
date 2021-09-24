package com.braker.core.manager;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Function;
import com.braker.core.model.Role;

public interface FunctionMng extends BaseManager<Function> {

	/**
	 * 
	* @author:安达
	* @Title: init 
	* @Description: 初始化数据
	* @return void    返回类型 
	* @date： 2019年5月27日上午11:32:13 
	* @throws
	 */
	public  void init();
	/**
	 * 获得管理员权限
	 * 
	 * @param adminId
	 * @return
	 */
	public List<Function> getFunctions(String userId);

	/**
	 * 获得管理员权限项集合
	 * 
	 * @param adminId
	 * @return
	 */
	public Set<String> getFunctionItems(String userId);

	/**
	 * 获得所有根节点
	 * 
	 * @return
	 */
	public List<Function> getRoots();

	/**
	 * 获得子节点
	 * 
	 * @param pid
	 * @return
	 */
	public List<Function> getChild(Long pid);
	
	/**
	 * 更新
	 * @param bean
	 */
	public void update(Function bean);
	
	/**
	 * 返回一个全部节点的json格式的字符串
	 * @param roleId 角色id
	 * @return
	 */
	public String getTree(String roleId);
	
	public Function findById(Long id);
	
	/**
	 * 返回用户的权限
	 * @author 叶崇晖
	 * @createtime 2018-06-19
	 * @updatetime 2018-06-19
	 */
	public List<Function> getUserMenu(Role role);
	
	/**
	 * 返回用户子菜单的目录
	 * @author 叶崇晖
	 * @createtime 2018-06-20
	 * @updatetime 2018-06-20
	 */
	public List<Function> getChildByUser(Long pid, String userId);
	
	/**
	 * 返回用户底层子菜单的目录(本来想用Long接收的，可是hibernate返回的是Double)
	 * @author 安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public List<Double> getFunctionIdList();
	
	/*
	 * 把集合转换成Map， 以ID为Key，Id为value
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public Map<Long,Long> getFunctionIdMap(List<Double> list);
	
	
	
	
	
	
	
	
	
	
	
}