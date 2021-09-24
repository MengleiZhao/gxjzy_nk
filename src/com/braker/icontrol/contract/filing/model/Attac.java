package com.braker.icontrol.contract.filing.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;
/**
 * 合同附件表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_CONTRACT_ATTAC")
public class Attac extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_ATTAC_ID")
	private Integer fAttacId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId;
	
	@Column(name ="F_ATTAC_NAME")
	private String fAttacName;//附件名称
	
	@Column(name ="F_ATTAC_TYPE")
	private String fAttacType;//附件类型
	
	@Column(name ="F_FILE_SRC")
	private String fFileSrc;//存放路径
	
	@Column(name="F_UPLOAD_TIME")
	private Date fUploadTime ;//上传时间
	
	@Column(name ="F_UPDATE_USER")
	private String fUpdateUser;//修改人
	
	@Column(name ="F_UPDATE_TIME")
	private Date fUpdateTime;//修改时间
	
	@Column(name ="F_CONT_CODE")
	private String fContCode_A;//合同编号

	
	public String getfContCode_A() {
		return fContCode_A;
	}

	public void setfContCode_A(String fContCode_A) {
		this.fContCode_A = fContCode_A;
	}

	public Integer getfAttacId() {
		return fAttacId;
	}

	public void setfAttacId(Integer fAttacId) {
		this.fAttacId = fAttacId;
	}

	public Integer getfContId() {
		return fContId;
	}

	public void setfContId(Integer fContId) {
		this.fContId = fContId;
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