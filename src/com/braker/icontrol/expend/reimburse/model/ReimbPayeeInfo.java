package com.braker.icontrol.expend.reimburse.model;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.PayeeDao;

/**
 * 报销申请收款人信息表的model
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Entity
@Table(name = "T_REIMB_PAYEE_INFO")
public class ReimbPayeeInfo extends BaseEntityEmpty implements PayeeDao {
	
	
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer pId;			//主键ID
	
	@Column(name = "F_R_ID",updatable=false)
	private Integer rId;			//关联报销申请基本信息副键
	
	@Column(name = "F_D_R_ID",updatable=false)
	private Integer drId;			//直接报销申请基本信息副键
	
	@Column(name = "F_CONT_ID",updatable=false)
	private Integer contId;			//合同付款基本信息副键 2020-12-18 沈帆新增
	
	@Column(name = "F_PAYEE_ID")
	private String payeeId;			//收款人id
	
	@Column(name = "F_PAYEE_NAME")
	private String payeeName;		//收款人姓名
	
	@Column(name = "F_PAYMENT_TYPE")
	private String paymentType;		//收款方式（1、银行代发2、现金3、支票4、电汇5、公务卡）

	@Column(name = "F_PAYEE_ID_CARD")
	private String payeeIdCard;     //收款人身份证号    暂时不知道哪里用的
	
	@Column(name = "F_BANK")
	private String bank;			//开户银行
	
	@Column(name = "F_BANK_NAME")
	private String bankName;			//银行名称
	
	@Column(name = "F_BANK_ACCOUNT")
	private String bankAccount;		//银行账户
	
	@Column(name = "F_ZFB_ACCOUNT")
	private String zfbAccount;		//收款人个人卡开户行
	
	@Column(name = "F_WX_ACCOUNT")
	private String wxAccount;		//收款人个人卡账号
	
	@Column(name = "F_ZFB_QR")
	private String zfbQR;			//支付宝二维码地址
	
	@Column(name = "F_WX_QR")
	private String wxQR;			//微信二维码地址
	
	@Column(name = "F_AMOUNT")
	private BigDecimal payeeAmount;		//公务卡转账金额

	@Column(name = "F_AMOUNTGR")
	private BigDecimal payeeAmountGR;		//个人卡转账金额
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//收款人身份证号      报销里用的
	
	@Column(name = "F_SCLASS")
	private String sclass;			//班级名称
	
	@Column(name = "F_PRO_NAME")
	private String proName;			//项目名称
	
	@Column(name = "F_NUMBER_DAYS")
	private Integer numberDays;			//天数
	
	@Column(name = "F_EVERYONE_AMOUNT")
	private BigDecimal everyoneAmount;			//	金额/人

	@Column(name = "F_TEL")
	private String tel;			//联系电话
	
	@Column(name = "F_REMARK")
	private String remark;			//备注
	
	@Column(name = "F_COMPANY")
	private String company;			//单位
	
	@Column(name = "F_DUTY")
	private String duty;			//职务/职称
	
	@Column(name = "F_PLAN_AMOUNT")
	private BigDecimal planAmount;			//应发金额
	
	@Column(name = "F_DEDUCTION_AMOUNT")
	private BigDecimal deductionAmount;			//扣税金额
	
	@Transient
	private String fBankName;//银行名称 显示
	
	@Transient
	private String biddingName;//中标商名称 显示
	
	@Transient
	private String fCardNo;//银行账户 显示
	
	@Transient
	private Integer num;//序号
	
	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public BigDecimal getPayeeAmountGR() {
		return payeeAmountGR;
	}

	public void setPayeeAmountGR(BigDecimal payeeAmountGR) {
		this.payeeAmountGR = payeeAmountGR;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
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

	@Override
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public Integer getDrId() {
		return drId;
	}

	public void setDrId(Integer drId) {
		this.drId = drId;
	}

	public String getfBankName() {
		return fBankName;
	}

	public void setfBankName(String fBankName) {
		this.fBankName = fBankName;
	}

	public String getBiddingName() {
		return biddingName;
	}

	public void setBiddingName(String biddingName) {
		this.biddingName = biddingName;
	}

	public String getfCardNo() {
		return fCardNo;
	}

	public void setfCardNo(String fCardNo) {
		this.fCardNo = fCardNo;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getContId() {
		return contId;
	}

	public void setContId(Integer contId) {
		this.contId = contId;
	}

	public String getSclass() {
		return sclass;
	}

	public void setSclass(String sclass) {
		this.sclass = sclass;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public Integer getNumberDays() {
		return numberDays;
	}

	public void setNumberDays(Integer numberDays) {
		this.numberDays = numberDays;
	}

	public BigDecimal getEveryoneAmount() {
		return everyoneAmount;
	}

	public void setEveryoneAmount(BigDecimal everyoneAmount) {
		this.everyoneAmount = everyoneAmount;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	public BigDecimal getPlanAmount() {
		return planAmount;
	}

	public void setPlanAmount(BigDecimal planAmount) {
		this.planAmount = planAmount;
	}

	public BigDecimal getDeductionAmount() {
		return deductionAmount;
	}

	public void setDeductionAmount(BigDecimal deductionAmount) {
		this.deductionAmount = deductionAmount;
	}

	
	
}
