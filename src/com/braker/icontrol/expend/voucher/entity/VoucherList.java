package com.braker.icontrol.expend.voucher.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
/**
 * 记账凭证清单表
 * @author 陈睿超
 * @createTime 2019-06-28
 */
@Entity
@Table(name ="T_VOUCHER_LIST")
public class VoucherList extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_VL_ID")
	private Integer fvlID;//主键
	
	@ManyToOne
	@JoinColumn(name ="F_ID" , referencedColumnName="F_ID")
	private Voucher voucher;//外键关联凭证表
	
	@Column(name ="F_VOUCHER_CODE")
	private String fListVoucher;//凭证号
	
	@Column(name ="F_SUMMARY")
	private String fSummary;//摘要
	
	@Column(name ="F_SUBJECT_CODEANDNAME")
	private String fSubjectCodeAndName;//科目编号及名称
	
	@Column(name ="F_ECONOMIC_NAME")
	private String fEconomicName;//经济分类科目名称
	
	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//部门名称
	
	@Column(name ="F_PROJECT_NAME")
	private String fProjectName;//项目名称
	
	@Column(name ="F_DEBIT_AMOUNT")
	private Double fDebitAmount;//借方金额
	
	@Column(name ="F_CREDIT_AMOUNT")
	private Double fCreditAmount;//贷方金额

	@Transient
	private Integer fVid;//加载页面传voucher主键ID使用
	
	public Integer getFvlID() {
		return fvlID;
	}

	public void setFvlID(Integer fvlID) {
		this.fvlID = fvlID;
	}

	public String getfListVoucher() {
		return fListVoucher;
	}

	public void setfListVoucher(String fListVoucher) {
		this.fListVoucher = fListVoucher;
	}

	public Voucher getVoucher() {
		return voucher;
	}

	public void setVoucher(Voucher voucher) {
		this.voucher = voucher;
	}

	public String getfSummary() {
		return fSummary;
	}

	public void setfSummary(String fSummary) {
		this.fSummary = fSummary;
	}

	public String getfSubjectCodeAndName() {
		return fSubjectCodeAndName;
	}

	public void setfSubjectCodeAndName(String fSubjectCodeAndName) {
		this.fSubjectCodeAndName = fSubjectCodeAndName;
	}

	public String getfEconomicName() {
		return fEconomicName;
	}

	public void setfEconomicName(String fEconomicName) {
		this.fEconomicName = fEconomicName;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfProjectName() {
		return fProjectName;
	}

	public void setfProjectName(String fProjectName) {
		this.fProjectName = fProjectName;
	}

	public Double getfDebitAmount() {
		return fDebitAmount;
	}

	public void setfDebitAmount(Double fDebitAmount) {
		this.fDebitAmount = fDebitAmount;
	}

	public Double getfCreditAmount() {
		return fCreditAmount;
	}

	public void setfCreditAmount(Double fCreditAmount) {
		this.fCreditAmount = fCreditAmount;
	}

	public Integer getfVid() {
		return fVid;
	}

	public void setfVid(Integer fVid) {
		this.fVid = fVid;
	}
	
	
	
	
	
}
