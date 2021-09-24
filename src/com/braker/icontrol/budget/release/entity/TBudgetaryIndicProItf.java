package com.braker.icontrol.budget.release.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;


/**
 * 预算支出预算指标下达明细model
 * @author 叶崇晖
 * @createtime 2018-07-13
 * @updatetime 2018-07-13
 */
@Entity
@Table(name = "T_BUDGETARY_INDIC_PRO_ITF")
public class TBudgetaryIndicProItf extends BaseEntityEmpty{
	@Id
	@Column(name = "F_B_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer biId;			//主键ID
	
	@Column(name = "F_B_ID")
	private Integer bId;			//项目预算指标下达（二下）的副键
	
	@Column(name = "F_PARENT_ID")
	private Integer parentId;		//父节点id
	
	@Column(name = "F_BUDGET_SUB_CODE")
	private String indexCode;		//本次下达预算科目编码
	
	@Column(name = "F_BUDGET_SUB_NAME")
	private String indexName;		//本次下达预算科目名称
	
	@Column(name = "F_BUDGET_SUB_AMOUNT")
	private Double subAmount;		//该科目预算总金额
	
	@Column(name = "F_SUB_ARRIVAL_AMOUNT")
	private Double amount;			//本次下达金额
	
	@Column(name = "F_SUB_RESID_AMOUNT")
	private Double residAmount;		//科目剩余金额
	
	@Column(name = "F_FREEZ_AMOUNT")
	private Double freezAmount;		//冻结金额
	
	@Transient
	private Double changeAmount;	//调整金额(数据库中没有)
	
	@Transient
	private String departName;		//指标归口部门（名称）
	

	public Integer getBiId() {
		return biId;
	}

	public void setBiId(Integer biId) {
		this.biId = biId;
	}

	public Integer getbId() {
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public Double getSubAmount() {
		return subAmount;
	}

	public void setSubAmount(Double subAmount) {
		this.subAmount = subAmount;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getResidAmount() {
		return residAmount;
	}

	public void setResidAmount(Double residAmount) {
		this.residAmount = residAmount;
	}

	public Double getChangeAmount() {
		return changeAmount;
	}

	public void setChangeAmount(Double changeAmount) {
		this.changeAmount = changeAmount;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public Double getFreezAmount() {
		return freezAmount;
	}

	public void setFreezAmount(Double freezAmount) {
		this.freezAmount = freezAmount;
	}

	
}
