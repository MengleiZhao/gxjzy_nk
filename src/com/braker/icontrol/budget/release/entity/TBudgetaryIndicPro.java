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
import com.braker.icontrol.budget.arrange.entity.DepartIndexInfo;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 项目预算指标下达（二下）model
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Entity
@Table(name = "T_BUDGETARY_INDIC_PRO")
public class TBudgetaryIndicPro extends BaseEntityEmpty{
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer bId;			//主键ID
	
	@JoinColumn(name = "F_PRO_ID")
	@ManyToOne
	private TProBasicInfo proId;	//关联项目库管理的外键
	
	@Column(name = "F_YEARS")
	private String yaers;			//预算年度
	
	@JoinColumn(name = "F_INFO_ID")
	@ManyToOne
	private DepartIndexInfo info;	//关联部门总编制信息
	
	@Column(name = "F_ARRIVAL_TYPE")
	private String arrivalType;		//下达方式
	
	@Column(name = "F_PERCENT")
	private String percent;			//本次下达百分比
	
	@Column(name = "F_PRO_ARRIVAL_AMOUNT")
	private Double amount;			//该部门下达金额
	
	@Column(name = "F_PRO_BUDGET_AMOUNT")
	private Double budgetAmount;	//该部门预算总额
	
	@Column(name = "F_PRO_RESID_AMOUNT")
	private Double residAmount;		//该部门剩余金额
	
	@Column(name = "F_OP_USER")
	private String userId;			//下达人ID
	
	@Column(name = "F_OP_TIME")
	private Date opTime;			//下达时间

	public Integer getbId() {
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
	}

	public TProBasicInfo getProId() {
		return proId;
	}

	public void setProId(TProBasicInfo proId) {
		this.proId = proId;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public String getYaers() {
		return yaers;
	}

	public void setYaers(String yaers) {
		this.yaers = yaers;
	}

	public DepartIndexInfo getInfo() {
		return info;
	}

	public void setInfo(DepartIndexInfo info) {
		this.info = info;
	}

	
}
