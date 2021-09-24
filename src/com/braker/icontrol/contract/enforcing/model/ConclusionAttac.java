package com.braker.icontrol.contract.enforcing.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 合同结项附件表
 * @author 陈睿超
 *
 */
@Entity
@Table(name="T_CONTRACT_FINISH_ATTAC")
public class ConclusionAttac extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ATTAC_FINISH_ID")
	private Integer fAttacFinishId;
	
	@Column(name="F_FI_ID")
	private Integer fFiId_A;
	
	@Column(name ="F_ATTAC_NAME")
	private String fAttacName_C;//附件名称
	
	@Column(name ="F_ATTAC_TYPE")
	private String fAttacType_C;//附件类型
	
	@Column(name ="F_FILE_SRC")
	private String fFileSrc_C;//存放路径
	
	@Column(name = "F_UPLOAD_TIME")
	private Date fUploadTime;//上传时间
	
	@Column(name = "F_UPDATE_USER")
	private String updator_FA;
    
    @Column(name = "F_UPDATE_TIME")
    private Date updateTime_FA;

    
	public Integer getfAttacFinishId() {
		return fAttacFinishId;
	}

	public void setfAttacFinishId(Integer fAttacFinishId) {
		this.fAttacFinishId = fAttacFinishId;
	}

	public Integer getfFiId_A() {
		return fFiId_A;
	}

	public void setfFiId_A(Integer fFiId_A) {
		this.fFiId_A = fFiId_A;
	}

	public String getfAttacName_C() {
		return fAttacName_C;
	}

	public void setfAttacName_C(String fAttacName_C) {
		this.fAttacName_C = fAttacName_C;
	}


	public String getfAttacType_C() {
		return fAttacType_C;
	}

	public void setfAttacType_C(String fAttacType_C) {
		this.fAttacType_C = fAttacType_C;
	}

	public String getfFileSrc_C() {
		return fFileSrc_C;
	}

	public void setfFileSrc_C(String fFileSrc_C) {
		this.fFileSrc_C = fFileSrc_C;
	}

	public Date getfUploadTime() {
		return fUploadTime;
	}

	public void setfUploadTime(Date fUploadTime) {
		this.fUploadTime = fUploadTime;
	}

	public String getUpdator_FA() {
		return updator_FA;
	}

	public void setUpdator_FA(String updator_FA) {
		this.updator_FA = updator_FA;
	}

	public Date getUpdateTime_FA() {
		return updateTime_FA;
	}

	public void setUpdateTime_FA(Date updateTime_FA) {
		this.updateTime_FA = updateTime_FA;
	}
    
}
