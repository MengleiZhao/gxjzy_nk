package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 
 * <p>Description: 角色，部门，人员类   流程配置的时候需要用到</p>
 * @author:安达
 * @date： 2019年7月3日下午10:35:31
 */
public class RoleDepartUser {
	
	private String  userName; 		//用户名
	private String  userId; 		//用户Id
	private String  departId; 		//部门id
	private String  departName; 	//部门名称
	private String  roleName; 		//角色名称
	private String  roleId; 		//角色id
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDepartId() {
		return departId;
	}
	public void setDepartId(String departId) {
		this.departId = departId;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	
}
