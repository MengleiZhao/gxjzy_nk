package com.braker.icontrol.contract.approval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

@Entity
@Table(name="T_CONTRACT_CHECK_INFO")
public class CheckInfo extends BaseEntityEmpty{

	@Column(name ="F_C_ID")
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fcId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId;
	
	@Column(name="F_P_ID")
	private Integer fpId;
	
	@Column(name="F_USER_ID")
	private String fUserId;//审批人id
	
	@Column (name ="F_USER_NAME")
	private String fUserName;//审批人名字
	
	@Column(name ="F_ROLE_NAME")
	private String fRoleName;//审批人岗位
	
	@Column (name ="F_LEVEL")
	private String fLevel;//审批人级别
	
	@Column(name ="F_RESULT")
	private String fResult;//审批意见
	
	@Column(name ="F_CHECK_TIME")
	private Date fCheckTimel;//审批时间
	
	@Column (name ="F_REMARK")
	private String fremark;//备注
	
	@Column(name ="STAUTS")
	private String CheckStauts;//状态
	
	@Column(name ="F_TYPE")
	private String ftype;//审批类型   1-合同拟定审批,3-合同终止审批

	
	
	public String getCheckStauts() {
		return CheckStauts;
	}

	public void setCheckStauts(String checkStauts) {
		CheckStauts = checkStauts;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public Integer getfContId() {
		return fContId;
	}

	public void setfContId(Integer fContId) {
		this.fContId = fContId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public String getfUserId() {
		return fUserId;
	}

	public void setfUserId(String fUserId) {
		this.fUserId = fUserId;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfRoleName() {
		return fRoleName;
	}

	public void setfRoleName(String fRoleName) {
		this.fRoleName = fRoleName;
	}

	public String getfLevel() {
		return fLevel;
	}

	public void setfLevel(String fLevel) {
		this.fLevel = fLevel;
	}

	public String getfResult() {
		return fResult;
	}

	public void setfResult(String fResult) {
		this.fResult = fResult;
	}

	public Date getfCheckTimel() {
		return fCheckTimel;
	}

	public void setfCheckTimel(Date fCheckTimel) {
		this.fCheckTimel = fCheckTimel;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public String getFtype() {
		return ftype;
	}

	public void setFtype(String ftype) {
		this.ftype = ftype;
	}

	
}
