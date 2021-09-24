package com.braker.icontrol.expend.cashier.model;

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
 * 出纳采集信息model
 * @author 叶崇晖
 * @createtime 2018-08-27
 * @updatetime 2018-08-27
 */
@Entity
@Table(name = "T_CASHIER_COLLECT_INFO")
public class CashierCollectInfo extends BaseEntity {
	@Id
	@Column(name = "F_COLLECT_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer collectId;		//主键ID
	
	@Column(name = "F_USER")
	private String user;			//受理人
	
	@Column(name = "F_TIME")
	private Date time;				//受理时间
	
	@Column(name = "F_PAYEE")
	private String payee;			//收款人
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证
	
	@Column(name = "F_ACCOUNT")
	private String account;			//账户
	
	@Column(name = "F_BANK")
	private String bank;			//开户银行
	
	@Column(name = "F_AMOUNT")
	private Double amount;			//流水金额
	
	@Column(name = "F_SETTLEMENT")
	private String settleMent;		//结算方式
	
	@Column(name = "F_STAUTS")
	private String status;			//流水状态
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private Double amount1;			//流水金额(查询用)
	
	@Transient
	private Double amount2;			//流水金额(查询用)

	public Integer getCollectId() {
		return collectId;
	}

	public void setCollectId(Integer collectId) {
		this.collectId = collectId;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
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

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getSettleMent() {
		return settleMent;
	}

	public void setSettleMent(String settleMent) {
		this.settleMent = settleMent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getAmount1() {
		return amount1;
	}

	public void setAmount1(Double amount1) {
		this.amount1 = amount1;
	}

	public Double getAmount2() {
		return amount2;
	}

	public void setAmount2(Double amount2) {
		this.amount2 = amount2;
	}

	
	
	
}
