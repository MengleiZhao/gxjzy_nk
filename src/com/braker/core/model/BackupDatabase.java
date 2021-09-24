package com.braker.core.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 数据库备份记录实体类
 * @author: 焦广兴
 * @Date:2020年7月23日
 */
@Entity
@Table(name = "T_BACKUP_DATABASE")
public class BackupDatabase implements Serializable{
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(generator = "hibernate-uuid")
    @GenericGenerator(name = "hibernate-uuid", strategy = "guid")
	private String fBId;	// 主键
	
	@Column(name = "F_NAME")
	private String fName; 	// 名称
	
	@Column(name = "F_PATH")
	private String fPath; 	// 路径
	
	@Column(name = "F_URL")
	private String fUrl;	// url
	
	@Column(name = "F_SIZE")
	private String fSize;	// 大小
	
	@Column(name = "F_CREATE_USER_ID")
	private String fCreateUserId;	// 创建人Id
	
	@Column(name = "F_CREATE_USER")
	private String fCreateUser;	// 创建人
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name = "F_CREATE_TIME")
	private Date fCreateTime;	// 创建时间
	
	@Column(name = "F_TYPE")
	private String fType;	// 备份类型 手动备份、自动备份
	
	@Column(name = "F_YEAR")
	private String fYear;	// 年度
	
	@Column(name = "F_DESCRIBE")
	private String fDescribe;	// 描述

	
	
	public String getfBId() {
		return fBId;
	}

	public String getfName() {
		return fName;
	}

	public String getfPath() {
		return fPath;
	}

	public String getfUrl() {
		return fUrl;
	}

	public String getfSize() {
		return fSize;
	}

	public String getfCreateUserId() {
		return fCreateUserId;
	}

	public String getfCreateUser() {
		return fCreateUser;
	}

	public Date getfCreateTime() {
		return fCreateTime;
	}

	public String getfType() {
		return fType;
	}

	public String getfYear() {
		return fYear;
	}

	public void setfBId(String fBId) {
		this.fBId = fBId;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public void setfPath(String fPath) {
		this.fPath = fPath;
	}

	public void setfUrl(String fUrl) {
		this.fUrl = fUrl;
	}

	public void setfSize(String fSize) {
		this.fSize = fSize;
	}

	public void setfCreateUserId(String fCreateUserId) {
		this.fCreateUserId = fCreateUserId;
	}

	public void setfCreateUser(String fCreateUser) {
		this.fCreateUser = fCreateUser;
	}

	public void setfCreateTime(Date fCreateTime) {
		this.fCreateTime = fCreateTime;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public void setfYear(String fYear) {
		this.fYear = fYear;
	}

	public String getfDescribe() {
		return fDescribe;
	}

	public void setfDescribe(String fDescribe) {
		this.fDescribe = fDescribe;
	}
	

}
