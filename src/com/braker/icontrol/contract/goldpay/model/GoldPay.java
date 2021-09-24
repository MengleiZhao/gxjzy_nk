package com.braker.icontrol.contract.goldpay.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;

/**
 * 合同质保金（付款）
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_WARRANTY_GOLD_P")
public class GoldPay extends BaseEntity implements EntityDao{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_WAR_ID")
	private Integer fWarId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId_GP;
	
	@Column(name ="F_REC_USER")
	private String fRecUser;//登记人
	
	@Column(name = "F_REC_TIME")
	private Date fRecTime;//登记时间
	
	@Column(name ="F_PAY_REMARK")
	private String fPayRemark;//付款说明
	
	@Column(name ="F_WAR_TYPE")
	private String fWarType;//保证金类型
	
	@Column(name ="F_AMOUNT")
	private String fPayAmount;//付款金额

	
	
	public Integer getfWarId() {
		return fWarId;
	}

	public void setfWarId(Integer fWarId) {
		this.fWarId = fWarId;
	}

	public Integer getfContId_GP() {
		return fContId_GP;
	}

	public void setfContId_GP(Integer fContId_GP) {
		this.fContId_GP = fContId_GP;
	}

	public String getfRecUser() {
		return fRecUser;
	}

	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}

	public Date getfRecTime() {
		return fRecTime;
	}

	public void setfRecTime(Date fRecTime) {
		this.fRecTime = fRecTime;
	}

	public String getfPayRemark() {
		return fPayRemark;
	}

	public void setfPayRemark(String fPayRemark) {
		this.fPayRemark = fPayRemark;
	}

	public String getfWarType() {
		return fWarType;
	}

	public void setfWarType(String fWarType) {
		this.fWarType = fWarType;
	}

	public String getfPayAmount() {
		return fPayAmount;
	}

	public void setfPayAmount(String fPayAmount) {
		this.fPayAmount = fPayAmount;
	}

	@Override
	public String getJoinTable() {
		return "T_WARRANTY_GOLD_P";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(fWarId);
	}
	
	
	
	
}
