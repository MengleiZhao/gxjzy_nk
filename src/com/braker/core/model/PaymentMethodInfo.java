package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;


/**
 * 个人收款方式信息model
 * 是个人收款方式信息的model类
 * @author 叶崇晖
 * @createtime 2018-11-19
 * @updatetime 2018-11-19
 */
@Entity
@Table(name = "T_PAYMENT_METHOD_INFO")
public class PaymentMethodInfo extends BaseEntityEmpty {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;			//主键ID
	
	@Column(name = "F_PAYEE_ID")
	private String payeeId;			//收款人id
	
	@Column(name = "F_PAYEE_NAME")
	private String payeeName;		//收款人姓名
	
	@Column(name = "F_PAYEE_ID_CARD")
	private String payeeIdCard;     //收款人身份证号
	
	@Column(name = "F_BANK")
	private String bank;			//开户银行
	
	@Column(name = "F_BANK_NAME")
	private String bankName;			//开户银行名称
	
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
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证号

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
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

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPayeeIdCard() {
		return payeeIdCard;
	}

	public void setPayeeIdCard(String payeeIdCard) {
		this.payeeIdCard = payeeIdCard;
	}


	
}
