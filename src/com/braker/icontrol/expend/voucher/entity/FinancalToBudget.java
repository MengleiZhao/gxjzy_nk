package com.braker.icontrol.expend.voucher.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 财务会计科目对应预算会计科目表
 * @author 陈睿超
 * @createTime 2019-06-28
 */
@Entity
@Table(name ="T_FINANCIAL_TO_BUDGET")
public class FinancalToBudget extends BaseEntity{

	
	@Id
	@Column(name ="F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;//主键
	
	@Column(name ="F_FINANCIAL_CODE")
	private String fFinancialCode;//财务会计科目编号
	
	@Column(name ="F_FINANCIAL_NAME")
	private String fFinancialName;//财务会计科目名称
	
	@Column(name ="F_BUDGET_CODE")
	private String fBudgeyCode;//预算会计科目编号
	
	@Column(name ="F_BUDGET_NAME")
	private String fBudgeyName;//预算会计科目名称

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getfFinancialCode() {
		return fFinancialCode;
	}

	public void setfFinancialCode(String fFinancialCode) {
		this.fFinancialCode = fFinancialCode;
	}

	public String getfFinancialName() {
		return fFinancialName;
	}

	public void setfFinancialName(String fFinancialName) {
		this.fFinancialName = fFinancialName;
	}

	public String getfBudgeyCode() {
		return fBudgeyCode;
	}

	public void setfBudgeyCode(String fBudgeyCode) {
		this.fBudgeyCode = fBudgeyCode;
	}

	public String getfBudgeyName() {
		return fBudgeyName;
	}

	public void setfBudgeyName(String fBudgeyName) {
		this.fBudgeyName = fBudgeyName;
	}
	
	
	
	
}
