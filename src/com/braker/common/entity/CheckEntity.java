package com.braker.common.entity;

/**
 * 审批接口
 * @author 李安达
 *
 */
public interface CheckEntity {
	/**
	 * 下一审批人姓名
	 * @param userName
	 */
	public void setNextCheckUserName(String userName);
	/**
	 * 下一审批人Id
	 * @param userId
	 */
	public void setNextCheckUserId(String userId);
	/**
	 * 下一审批人Id
	 * @param userId
	 */
	public String getNextCheckUserId();
	/**
	 * 下一审批节点
	 * @param nCode
	 */
	public void setNextCheckKey(String nCode);
	/**
	 * 设置审批状态
	 * @param checkStatus
	 */
	public void setCheckStauts(String checkStatus);
	
	/**
	 * 获取审批状态
	 * @param checkStatus
	 */
	public String getCheckStauts();
	
	/**
	 * 申请状态
	 * @param status
	 */
	public void setStauts(String status);
	/**
	 * 出纳受理状态
	 * @param status
	 */
	public void setCashierType(String status);
	
	/**
	 * 编号
	 * @return
	 */
	public String getBeanCode();
	/**
	 * 编码对应的字段名
	 * @return
	 */
	public String getBeanCodeField();
	/**
	 * 主键id
	 * @return
	 */
	public Integer getBeanId();
	
	/**
	 * 申请人id
	 * @return
	 */
	public String getUserId();
	
	/**
	 * 下一审批节点的key
	 * @return
	 */
	public String getNextCheckKey();
	
	/**
	 * 
	* @Description: 对应数据库表
	 */
	public String getJoinTable();
}
