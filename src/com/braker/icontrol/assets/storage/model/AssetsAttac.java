package com.braker.icontrol.assets.storage.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

@Table(name ="T_ASSETS_ATTAC")
@Entity
public class AssetsAttac extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ATTAC_ID")
	private Integer fAttacId;
	
	@Column(name ="F_ASS_STORAGE_CODE")
	private String fStorageCode_A;//资产入库单
	
	@Column(name ="F_ATTAC_NAME")
	private String fAttacName;//附件名称
	
	@Column(name ="F_ATTAC_TYPE")
	private String fAttacType;//附件类型“1：低值易耗品，2：固定资产，3：无形资产”

	@Column(name ="F_FILE_SRC")
	private String fFileSrc;//附件路径
	
	@Column(name ="F_UPLOAD_TIME")
	private Date fUploadTime;//上传时间
	
	@Column(name ="F_UPDATE_USER")
	private String fUpdateUser;//修改人
	
	@Column(name ="F_UPDATE_TIME")
	private Date fUpdateTime;//修改时间

	public Integer getfAttacId() {
		return fAttacId;
	}

	public void setfAttacId(Integer fAttacId) {
		this.fAttacId = fAttacId;
	}

	public String getfStorageCode_A() {
		return fStorageCode_A;
	}

	public void setfStorageCode_A(String fStorageCode_A) {
		this.fStorageCode_A = fStorageCode_A;
	}

	public String getfAttacName() {
		return fAttacName;
	}

	public void setfAttacName(String fAttacName) {
		this.fAttacName = fAttacName;
	}

	public String getfAttacType() {
		return fAttacType;
	}

	public void setfAttacType(String fAttacType) {
		this.fAttacType = fAttacType;
	}

	public String getfFileSrc() {
		return fFileSrc;
	}

	public void setfFileSrc(String fFileSrc) {
		this.fFileSrc = fFileSrc;
	}

	public Date getfUploadTime() {
		return fUploadTime;
	}

	public void setfUploadTime(Date fUploadTime) {
		this.fUploadTime = fUploadTime;
	}

	public String getfUpdateUser() {
		return fUpdateUser;
	}

	public void setfUpdateUser(String fUpdateUser) {
		this.fUpdateUser = fUpdateUser;
	}

	public Date getfUpdateTime() {
		return fUpdateTime;
	}

	public void setfUpdateTime(Date fUpdateTime) {
		this.fUpdateTime = fUpdateTime;
	}
	
}
