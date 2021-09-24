package com.braker.icontrol.contract.approval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

@Entity
@Table(name ="T_BUDGETARY_INDIC_BASIC")
public class BudgetaryIndic extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_B_B_ID")
	private Integer fbbId;
	
	@Column (name ="F_YEARS")
	private String fYears;//预算年度
	
	@Column (name ="F_DEPT_CODE")
	private String fDeptCode;//归口部门编码
	
	@Column (name ="F_DEPT_NAME")
	private String fDeptName;//归口部门名称
	
	@Column (name ="F_ARRIVAL_TYPE")
	private String fArrivalType;//下达方式
	
	@Column (name ="F_PERCENT")
	private String fPercent;//本次下达百分比
	
	@Column (name ="F_DEPT_ARRIVAL_AMOUNT")
	private Float fDeptArrivalAmount;//该部门下达金额
	
	@Column (name ="F_DEPT_BUDGET_AMOUNT")
	private Float fDeptBudgetAmount;//该部门预算总额
	
	@Column (name ="F_DEPT_RESID_AMOUNT")
	private Float fDeptResidAmount;//该部门剩余金额
	
	@Column (name ="F_OP_USER")
	private String fOpUser;//下达人
	
	@Column (name ="F_OP_TIME")
	private Date fOpTime;//下达时间
	
	@Transient
	private Integer number;

	public Integer getFbbId() {
		return fbbId;
	}

	public void setFbbId(Integer fbbId) {
		this.fbbId = fbbId;
	}

	public String getfYears() {
		return fYears;
	}

	public void setfYears(String fYears) {
		this.fYears = fYears;
	}

	public String getfDeptCode() {
		return fDeptCode;
	}

	public void setfDeptCode(String fDeptCode) {
		this.fDeptCode = fDeptCode;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfArrivalType() {
		return fArrivalType;
	}

	public void setfArrivalType(String fArrivalType) {
		this.fArrivalType = fArrivalType;
	}

	public String getfPercent() {
		return fPercent;
	}

	public void setfPercent(String fPercent) {
		this.fPercent = fPercent;
	}

	public Float getfDeptArrivalAmount() {
		return fDeptArrivalAmount;
	}

	public void setfDeptArrivalAmount(Float fDeptArrivalAmount) {
		this.fDeptArrivalAmount = fDeptArrivalAmount;
	}

	public Float getfDeptBudgetAmount() {
		return fDeptBudgetAmount;
	}

	public void setfDeptBudgetAmount(Float fDeptBudgetAmount) {
		this.fDeptBudgetAmount = fDeptBudgetAmount;
	}

	public Float getfDeptResidAmount() {
		return fDeptResidAmount;
	}

	public void setfDeptResidAmount(Float fDeptResidAmount) {
		this.fDeptResidAmount = fDeptResidAmount;
	}

	public String getfOpUser() {
		return fOpUser;
	}

	public void setfOpUser(String fOpUser) {
		this.fOpUser = fOpUser;
	}

	public Date getfOpTime() {
		return fOpTime;
	}

	public void setfOpTime(Date fOpTime) {
		this.fOpTime = fOpTime;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	
	

}
