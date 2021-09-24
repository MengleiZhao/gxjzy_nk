package com.braker.icontrol.expend.cashier.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 出纳受理基本信息model
 * @author 叶崇晖
 * @createtime 2018-08-22
 * @updatetime 2018-08-22
 */
@Entity
@Table(name = "T_CASHIER_ACCEPT_INFO")
public class CashierAcceptInfo extends BaseEntity {
	@Id
	@Column(name = "F_ACCEPT_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer acceptId;		//主键ID
	
	@Column(name = "F_C_ID")
	private Integer cId;			//借款外键
	
	@Column(name = "F_P_ID")
	private Integer pId;			//采购外键
	
	@Column(name = "F_DR_ID")
	private Integer drId;			//直接报销外键
	
	@Column(name = "F_R_ID")
	private Integer rId;			//申请报销外键
	
	@Column(name = "F_CONT_ID")
	private Integer contId;			//合同外键
	
	@Column(name = "F_USER_ID")
	private String userId;			//受理人
	
	@Column(name = "F_RESULT")
	private String result;			//受理结果0不通过、1通过
	
	@Column(name = "F_REMARK")
	private String remark;			//备注
	
	@Column(name = "F_ACCEPT_TIME")
	private Date acceptTime;		//受理时间
	
	@Column(name = "F_PAYEE")
	private String payee;			//收款人
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证
	
	@Column(name = "F_ACCOUNT")
	private String account;			//账户
	
	@Column(name = "F_BANK")
	private String bank;			//开户银行
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;			//应付金额
	
	@Column(name = "F_SETTLEMENT")
	private String settleMent;		//结算方式
	
	@Column(name = "F_STAUTS")
	private String stauts;			//受理信息状态
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String userName;		//受理人名字

	public Integer getAcceptId() {
		return acceptId;
	}

	public void setAcceptId(Integer acceptId) {
		this.acceptId = acceptId;
	}

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public Integer getDrId() {
		return drId;
	}

	public void setDrId(Integer drId) {
		this.drId = drId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getContId() {
		return contId;
	}

	public void setContId(Integer contId) {
		this.contId = contId;
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(Date acceptTime) {
		this.acceptTime = acceptTime;
	}

	public String getPayee() {
		return payee;
	}

	public void setPayee(String payee) {
		this.payee = payee;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getSettleMent() {
		return settleMent;
	}

	public void setSettleMent(String settleMent) {
		this.settleMent = settleMent;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	
	
}
