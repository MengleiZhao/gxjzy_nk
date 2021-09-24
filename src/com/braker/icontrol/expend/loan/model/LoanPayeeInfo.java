package com.braker.icontrol.expend.loan.model;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.PayeeDao;

/**
 * 借款申请借款人信息model
 * 是借款申请借款人信息的model类
 * @author 叶崇晖
 * @createtime 2018-07-07
 * @updatetime 2018-07-07
 */
@Entity
@Table(name = "T_LOAN_PAYEE_INFO")
public class LoanPayeeInfo extends BaseEntityEmpty implements PayeeDao {
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer rId;			//主键ID
	
	@Column(name = "F_L_ID")
	private Integer lId;			//关联借款信息的副键	

	@Column(name = "F_PAYEE_ID")
	private String payeeId;			//收款人id
	
	@Column(name = "F_PAYEE_NAME")
	private String payeeName;		//收款人姓名
	
	@Column(name = "F_PAYMENT_TYPE")
	private String paymentType;		//收款方式（1、银行转账2、现金3、支票4、电汇5、公务卡6、其他）

	@Column(name = "F_PAYEE_ID_CARD")
	private String payeeIdCard;     //收款人身份证号
	
	@Column(name = "F_BANK")
	private String bank;			//开户银行
	
	@Column(name = "F_BANK_NAME")
	private String bankName;			//银行名称
	
	@Column(name = "F_BANK_ACCOUNT")
	private String bankAccount;		//银行账户
	
	@Column(name = "F_ZFB_ACCOUNT")
	private String zfbAccount;		//支付宝账户
	
	@Column(name = "F_WX_ACCOUNT")
	private String wxAccount;		//微信账户
	
	@Column(name = "F_ZFB_QR")
	private String zfbQR;			//支付宝二维码地址
	
	@Column(name = "F_WX_QR")
	private String wxQR;			//微信二维码地址
	
	@Column(name = "F_AMOUNT")
	private BigDecimal payeeAmount;		//应付金额

	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证号
	
	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getlId() {
		return lId;
	}

	public void setlId(Integer lId) {
		this.lId = lId;
	}

	public String getPayeeId() {
		return payeeId;
	}

	public void setPayeeId(String payeeId) {
		this.payeeId = payeeId;
	}

	public String getPayeeName() {
		return payeeName;
	}

	public void setPayeeName(String payeeName) {
		this.payeeName = payeeName;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getZfbAccount() {
		return zfbAccount;
	}

	public void setZfbAccount(String zfbAccount) {
		this.zfbAccount = zfbAccount;
	}

	public String getWxAccount() {
		return wxAccount;
	}

	public void setWxAccount(String wxAccount) {
		this.wxAccount = wxAccount;
	}

	public String getZfbQR() {
		return zfbQR;
	}

	public void setZfbQR(String zfbQR) {
		this.zfbQR = zfbQR;
	}

	public String getWxQR() {
		return wxQR;
	}

	public void setWxQR(String wxQR) {
		this.wxQR = wxQR;
	}

	public BigDecimal getPayeeAmount() {
		return payeeAmount;
	}

	public void setPayeeAmount(BigDecimal payeeAmount) {
		this.payeeAmount = payeeAmount;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getPayeeIdCard() {
		return payeeIdCard;
	}

	public void setPayeeIdCard(String payeeIdCard) {
		this.payeeIdCard = payeeIdCard;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	
	
}
