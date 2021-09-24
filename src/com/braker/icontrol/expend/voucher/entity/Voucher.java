package com.braker.icontrol.expend.voucher.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 记账凭证表
 * @author 陈睿超
 * @createTime 2019-06-28
 */
@Entity
@Table(name ="T_VOUCHER")
public class Voucher extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fid;//主键

	@Column(name ="F_VOUCHER_SUMMARY")
	private String fVoucherSummary;//摘要
	
	@Column(name ="F_BEAN_CODE")
	private String fBeanCode;//相关单据编号
	
	@Column(name ="F_VOUCHER_CODE")
	private String fVoucher;//凭证号
	
	@Column(name ="F_DEBIT_ALL_AMOUNT")
	private Double fDebitAllAMount;//合计借方金额
	
	@Column(name ="F_CREDIT_ALL_AMOUNT")
	private Double fCreditAllAmoount;//合计贷方金额
	
	@Transient
	private Integer number;//序号

	
	
	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public String getfVoucher() {
		return fVoucher;
	}

	public void setfVoucher(String fVoucher) {
		this.fVoucher = fVoucher;
	}

	public Double getfDebitAllAMount() {
		return fDebitAllAMount;
	}

	public void setfDebitAllAMount(Double fDebitAllAMount) {
		this.fDebitAllAMount = fDebitAllAMount;
	}

	public Double getfCreditAllAmoount() {
		return fCreditAllAmoount;
	}

	public void setfCreditAllAmoount(Double fCreditAllAmoount) {
		this.fCreditAllAmoount = fCreditAllAmoount;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getfVoucherSummary() {
		return fVoucherSummary;
	}

	public void setfVoucherSummary(String fVoucherSummary) {
		this.fVoucherSummary = fVoucherSummary;
	}

	public String getfBeanCode() {
		return fBeanCode;
	}

	public void setfBeanCode(String fBeanCode) {
		this.fBeanCode = fBeanCode;
	}
	
	
	
	
}
