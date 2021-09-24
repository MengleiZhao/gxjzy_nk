package com.braker.icontrol.budget.release.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 基本支出预算指标下达（二下）model
 * @author 叶崇晖
 * @createtime 2018-07-24
 * @updatetime 2018-07-24
 */
@Entity
@Table(name = "T_BUDGETARY_INDIC_BASIC")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TBudgetaryIndicBasic extends BaseEntityEmpty{
	@Id
	@Column(name = "F_B_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer bbId;			//主键ID
	
	@Column(name = "F_YEARS")
	private String yaers;			//预算年度
	
	@Column(name = "F_DEPT_CODE")
	private String departCode;		//归口部门编码
	
	@Column(name = "F_DEPT_NAME")
	private String departName;		//归口部门名称
	
	@Column(name = "F_ARRIVAL_TYPE")
	private String arrivalType;		//下达方式
	
	@Column(name = "F_PERCENT")
	private String percent;			//本次下达百分比
	
	@Column(name = "F_DEPT_ARRIVAL_AMOUNT")
	private Double amount;			//该部门下达金额
	
	@Column(name = "F_DEPT_BUDGET_AMOUNT")
	private Double budgetAmount;	//该部门预算总额
	
	@Column(name = "F_DEPT_RESID_AMOUNT")
	private Double residAmount;		//该部门剩余金额
	
	@ManyToOne
	@JoinColumn(name = "F_OP_USER")
	private User userId;			//下达人ID
	
	@Column(name = "F_OP_TIME")
	private Date opTime;			//下达时间

	public Integer getBbId() {
		return bbId;
	}

	public void setBbId(Integer bbId) {
		this.bbId = bbId;
	}

	public String getYaers() {
		return yaers;
	}

	public void setYaers(String yaers) {
		this.yaers = yaers;
	}

	public String getDepartCode() {
		return departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getArrivalType() {
		return arrivalType;
	}

	public void setArrivalType(String arrivalType) {
		this.arrivalType = arrivalType;
	}

	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getBudgetAmount() {
		return budgetAmount;
	}

	public void setBudgetAmount(Double budgetAmount) {
		this.budgetAmount = budgetAmount;
	}

	public Double getResidAmount() {
		return residAmount;
	}

	public void setResidAmount(Double residAmount) {
		this.residAmount = residAmount;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	
	

}
