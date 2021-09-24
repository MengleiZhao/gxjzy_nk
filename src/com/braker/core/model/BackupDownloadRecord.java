package com.braker.core.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 数据库还原下载记录实体类
 * @author: 焦广兴
 * @Date:2020年7月23日
 */
@Entity
@Table(name = "T_BACKUP_DOWNLOAD_RECORD")
public class BackupDownloadRecord implements Serializable{
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(generator = "hibernate-uuid")
    @GenericGenerator(name = "hibernate-uuid", strategy = "guid")
	private String fBId;	// 主键
	
	@Column(name = "F_NAME")
	private String fName; 	// 还原的文件名称
	
	@Column(name = "F_CREATE_USER_ID")
	private String fCreateUserId;	// 操作人Id
	
	@Column(name = "F_CREATE_USER")
	private String fCreateUser;	// 操作人
	
	@Column(name = "F_CREATE_TIME")
	private Date fCreateTime;	// 操作时间
	
	@Column(name = "F_TYPE")
	private String fType;	// 操作类型 restore\download

	public String getfBId() {
		return fBId;
	}

	public String getfName() {
		return fName;
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

	public void setfBId(String fBId) {
		this.fBId = fBId;
	}

	public void setfName(String fName) {
		this.fName = fName;
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
}
