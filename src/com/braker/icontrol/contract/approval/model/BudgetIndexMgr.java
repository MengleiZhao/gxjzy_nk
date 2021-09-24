package com.braker.icontrol.contract.approval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

@Entity
@Table(name ="T_BUDGET_INDEX_MGR")//---------废弃的表----------
public class BudgetIndexMgr extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column (name ="F_B_ID")
	private Integer fbId;
	
	@Column (name ="F_B_INDEX_CODE")
	private String fbIndexCode;//预算指标编码
	
	@Column (name="F_B_INDEX_NAME")
	private String fbIndexName;//预算指标名称
	
	@Column (name ="F_INDEX_TYPE")
	private String fIndexType;//指标类型
	
	@Column (name ="F_DEPT_NAME")
	private String fDeptName;//使用部门
	
	@Column (name ="F_CONTROL_TYPE")
	private String fControlType;//控制方式
	
	@Column (name ="F_IS_OPEN")
	private String fIsOpen;//是否公开指标
	
	@Column (name ="F_APP_DATE")
	private Date fAppDate;//批复日期
	
	@Column (name ="F_EC_CODE")
	private String fEcCode;//父级科目编号
	
	@Column (name ="F_EC_NAME")
	private String fEcName;//父级科目名称
	
	@Column (name ="F_YEARS")
	private String fYears;//预算年度

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public String getFbIndexCode() {
		return fbIndexCode;
	}

	public void setFbIndexCode(String fbIndexCode) {
		this.fbIndexCode = fbIndexCode;
	}

	public String getFbIndexName() {
		return fbIndexName;
	}

	public void setFbIndexName(String fbIndexName) {
		this.fbIndexName = fbIndexName;
	}

	public String getfIndexType() {
		return fIndexType;
	}

	public void setfIndexType(String fIndexType) {
		this.fIndexType = fIndexType;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfControlType() {
		return fControlType;
	}

	public void setfControlType(String fControlType) {
		this.fControlType = fControlType;
	}

	public String getfIsOpen() {
		return fIsOpen;
	}

	public void setfIsOpen(String fIsOpen) {
		this.fIsOpen = fIsOpen;
	}

	public Date getfAppDate() {
		return fAppDate;
	}

	public void setfAppDate(Date fAppDate) {
		this.fAppDate = fAppDate;
	}

	public String getfEcCode() {
		return fEcCode;
	}

	public void setfEcCode(String fEcCode) {
		this.fEcCode = fEcCode;
	}

	public String getfEcName() {
		return fEcName;
	}

	public void setfEcName(String fEcName) {
		this.fEcName = fEcName;
	}

	public String getfYears() {
		return fYears;
	}

	public void setfYears(String fYears) {
		this.fYears = fYears;
	}
	
	
}
