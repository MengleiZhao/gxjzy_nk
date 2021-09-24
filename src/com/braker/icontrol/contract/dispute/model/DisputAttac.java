package com.braker.icontrol.contract.dispute.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 合同纠纷附件表
 * @author 陈睿超
 *
 */
@Entity 
@Table(name ="T_CONTRACT_DISPUTE_ATTAC")
public class DisputAttac extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_ATTAC_DISPUTE_ID")
	private Integer fAttacDisputId;
	
	@Column(name ="F_DIS_ID")
	private Integer fDisId_A;
	
	@Column(name ="F_ATTAC_NAME")
	private String fAttacName_DA;//附件名称
	
	@Column(name ="F_ATTAC_TYPE")
	private String fAttacType_DA;//附件类型
	
	@Column(name ="F_FILE_SRC")
	private String fFileSrc_DA;//存放路径
	
	@Column(name = "F_UPLOAD_TIME")
	private Date fUploadTime_DA;//上传时间
	
	@Column(name = "F_UPDATE_USER")
	private String updator_DA;
    
    @Column(name = "F_UPDATE_TIME")
    private Date updateTime_DA;

	public Integer getfAttacDisputId() {
		return fAttacDisputId;
	}

	public void setfAttacDisputId(Integer fAttacDisputId) {
		this.fAttacDisputId = fAttacDisputId;
	}

	public Integer getfDisId_A() {
		return fDisId_A;
	}

	public void setfDisId_A(Integer fDisId_A) {
		this.fDisId_A = fDisId_A;
	}

	public String getfAttacName_DA() {
		return fAttacName_DA;
	}

	public void setfAttacName_DA(String fAttacName_DA) {
		this.fAttacName_DA = fAttacName_DA;
	}

	public String getfAttacType_DA() {
		return fAttacType_DA;
	}

	public void setfAttacType_DA(String fAttacType_DA) {
		this.fAttacType_DA = fAttacType_DA;
	}

	public String getfFileSrc_DA() {
		return fFileSrc_DA;
	}

	public void setfFileSrc_DA(String fFileSrc_DA) {
		this.fFileSrc_DA = fFileSrc_DA;
	}

	public Date getfUploadTime_DA() {
		return fUploadTime_DA;
	}

	public void setfUploadTime_DA(Date fUploadTime_DA) {
		this.fUploadTime_DA = fUploadTime_DA;
	}

	public String getUpdator_DA() {
		return updator_DA;
	}

	public void setUpdator_DA(String updator_DA) {
		this.updator_DA = updator_DA;
	}

	public Date getUpdateTime_DA() {
		return updateTime_DA;
	}

	public void setUpdateTime_DA(Date updateTime_DA) {
		this.updateTime_DA = updateTime_DA;
	}

    

}
