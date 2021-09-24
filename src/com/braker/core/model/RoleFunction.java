package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 角色和权限的关系的model
 * 是公告的model类
 * @author 叶崇晖
 * @createtime 2018-06-19
 * @updatetime 2018-06-19
 */
@Entity
@Table(name = "sys_role_function")
public class RoleFunction extends BaseEntity{
	@Id
	@Column(name = "ROLE_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer roleId;			//主键ID
	
	@Column(name = "FUNCTION_ID")
	private Integer functionId;		//functionId

	
	
	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getFunctionId() {
		return functionId;
	}

	public void setFunctionId(Integer functionId) {
		this.functionId = functionId;
	}
	
}
