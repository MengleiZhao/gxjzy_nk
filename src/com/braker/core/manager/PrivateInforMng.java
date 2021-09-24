package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.PrivateInformation;
import com.braker.core.model.User;

public interface PrivateInforMng extends BaseManager<PrivateInformation>{

	/**
	 * 用户的所有消息数据
	 * @param user 
	 * @return
	 */
	List<PrivateInformation> countInformation(User user);
	
	/**
	 * 用户的未读消息数据
	 * @param user 
	 * @return
	 */
	List<PrivateInformation> unread(String userId);
	
	/**
	 * 根据搜索条件和用户加载相应消息数据
	 * @param bean
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination queryList(PrivateInformation bean,User user, Integer pageNo, Integer pageSize);
	
	/**
	 * 所有未读消息（首页）
	 * @param bean
	 * @param user
	 * @return
	 */
	List<PrivateInformation> allunRead(PrivateInformation bean,User user);
	
	/**
	 * 修改查看状态为已阅或未读
	 * @param str 需要修改主键的数组
	 * @param user
	 */
	void updateReadStauts(String[] str ,String readStauts);
	
	/**
	 * 批量删除
	 * @param str
	 */
	void deletePart(String[] str);
	
	/**
	 * 修改星标状态
	 * @param id 
	 * @param MessageStauts
	 */
	void updateMessageStauts(String id ,String MessageStauts);
	
	/**
	 * 
	* @author:安达
	* @Title: setMsg 
	* @Description: 发送消息
	* @param title  消息标题
	* @param msg   消息内容
	* @param userId   消息接收人
	* @return void    返回类型 
	* @date： 2019年5月28日下午9:51:36 
	* @throws
	 */
	void setMsg(String title,String msg,String userId,String type);
}
