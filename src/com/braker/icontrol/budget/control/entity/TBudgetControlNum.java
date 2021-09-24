package com.braker.icontrol.budget.control.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.YearsBasic;

/**
 * 预算控制数（一下）
 * @author 陈睿超
 */
@Entity
@Table(name = "T_BUDGET_CONTROL_NUM")
public class TBudgetControlNum extends BaseEntity implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_C_ID")
	private Integer fCId;//主键
	
	@Column(name ="F_BUDGET_CONTROL_NUM")
	private String fBudgetControlBum;//预算控制编号;
	
	@Column(name ="F_BUDGET_YEAR")
	private String fBudgetYear;//预算年份
	
	@Column(name ="F_ALL_AMOUNT")
	private Double fAllAmount;//收入预算总额（万元）
	
	@Column(name ="F_BASIC_EXP_AMOUNT")
	private Double fBasicExpAmount;//基本支出总额（万元）
	
	@Column(name ="F_PRO_EXP_AMOUNT")
	private Double fProExpAmount;//项目支出总额（万元）
	
	@Column(name ="F_USER")
	private String fUser;//编制人

	@Column(name ="F_TIME")
	private Date fTime;//编制时间
	
	@Column(name ="F_USER_NAME")
	private String fNextUserName;//下环节处理人姓名
	
	@Column(name ="F_USER_CODE")
	private String fNextUserCode;//下环节处理人编码
	
	@Column(name ="F_N_CODE")
	private String fNextCode;//下环节节点编码
	
	@Column(name ="F_CHECK_STAUTS")
	private String fCheckStauts;//审批状态
	
	@Column(name ="F_CHECK_USER")
	private String fCheckUser;//审批人
	
	@Column(name ="F_CHECK_TIME")
	private Date fCheckTime;//审批时间
	
	@Transient
	private Integer number;//序号

	public Integer getfCId() {
		return fCId;
	}

	public void setfCId(Integer fCId) {
		this.fCId = fCId;
	}

	public String getfBudgetControlBum() {
		return fBudgetControlBum;
	}

	public void setfBudgetControlBum(String fBudgetControlBum) {
		this.fBudgetControlBum = fBudgetControlBum;
	}

	public String getfBudgetYear() {
		return fBudgetYear;
	}

	public void setfBudgetYear(String fBudgetYear) {
		this.fBudgetYear = fBudgetYear;
	}

	public Double getfAllAmount() {
		return fAllAmount;
	}

	public void setfAllAmount(Double fAllAmount) {
		this.fAllAmount = fAllAmount;
	}

	public Double getfBasicExpAmount() {
		return fBasicExpAmount;
	}

	public void setfBasicExpAmount(Double fBasicExpAmount) {
		this.fBasicExpAmount = fBasicExpAmount;
	}

	public Double getfProExpAmount() {
		return fProExpAmount;
	}

	public void setfProExpAmount(Double fProExpAmount) {
		this.fProExpAmount = fProExpAmount;
	}

	public String getfUser() {
		return fUser;
	}

	public void setfUser(String fUser) {
		this.fUser = fUser;
	}

	public Date getfTime() {
		return fTime;
	}

	public void setfTime(Date fTime) {
		this.fTime = fTime;
	}

	public String getfNextUserName() {
		return fNextUserName;
	}

	public void setfNextUserName(String fNextUserName) {
		this.fNextUserName = fNextUserName;
	}

	public String getfNextUserCode() {
		return fNextUserCode;
	}

	public void setfNextUserCode(String fNextUserCode) {
		this.fNextUserCode = fNextUserCode;
	}

	public String getfNextCode() {
		return fNextCode;
	}

	public void setfNextCode(String fNextCode) {
		this.fNextCode = fNextCode;
	}

	public String getfCheckStauts() {
		return fCheckStauts;
	}

	public void setfCheckStauts(String fCheckStauts) {
		this.fCheckStauts = fCheckStauts;
	}

	public String getfCheckUser() {
		return fCheckUser;
	}

	public void setfCheckUser(String fCheckUser) {
		this.fCheckUser = fCheckUser;
	}

	public Date getfCheckTime() {
		return fCheckTime;
	}

	public void setfCheckTime(Date fCheckTime) {
		this.fCheckTime = fCheckTime;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	

	
}