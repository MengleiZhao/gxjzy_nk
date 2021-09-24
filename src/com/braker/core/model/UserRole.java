package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 用户和角色的关系的model
 * 是公告的model类
 * @author 叶崇晖
 * @createtime 2018-06-19
 * @updatetime 2018-06-19
 */
@Entity
@Table(name = "sys_user_role")
public class UserRole extends BaseEntity{
	@Id
	@Column(name = "PID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long pID;			//主键ID
	
	@Column(name = "USERID")
	private Long userId; 		//用户ID
	
	@Column(name = "ROLEID")
	private Long roleId; 		//角色ID

	public Long getpID() {
		return pID;
	}

	public void setpID(Long pID) {
		this.pID = pID;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	
}
