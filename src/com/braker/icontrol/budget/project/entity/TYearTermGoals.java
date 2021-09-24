package com.braker.icontrol.budget.project.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 年度目标
 * TYearTermGoals entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_year_term_goals")
public class TYearTermGoals implements java.io.Serializable {

	// Fields

	private Integer FMId;//key
	private TProBasicInfo TProBasicInfo;//项目key
	private String FNum;//序号
	private String FPlan;//目标名称
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	private String FExt1;
	private String FExt2;
	private String FExt3;
	private String FExt4;
	private String FExt5;

	// Constructors

	/** default constructor */
	public TYearTermGoals() {
	}


	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_M_ID", unique = true, nullable = false)
	public Integer getFMId() {
		return this.FMId;
	}

	public void setFMId(Integer FMId) {
		this.FMId = FMId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "F_PRO_ID")
	public TProBasicInfo getTProBasicInfo() {
		return this.TProBasicInfo;
	}

	public void setTProBasicInfo(TProBasicInfo TProBasicInfo) {
		this.TProBasicInfo = TProBasicInfo;
	}

	@Column(name = "F_NUM", length = 30)
	public String getFNum() {
		return this.FNum;
	}

	public void setFNum(String FNum) {
		this.FNum = FNum;
	}

	@Column(name = "F_PLAN", length = 200)
	public String getFPlan() {
		return this.FPlan;
	}

	public void setFPlan(String FPlan) {
		this.FPlan = FPlan;
	}

	@Column(name = "F_CREATE_USER", length = 20)
	public String getFCreateUser() {
		return this.FCreateUser;
	}

	public void setFCreateUser(String FCreateUser) {
		this.FCreateUser = FCreateUser;
	}

	@Column(name = "F_CREATE_TIME", length = 19)
	public Date getFCreateTime() {
		return this.FCreateTime;
	}

	public void setFCreateTime(Date FCreateTime) {
		this.FCreateTime = FCreateTime;
	}

	@Column(name = "F_UPDATE_USER", length = 20)
	public String getFUpdateUser() {
		return this.FUpdateUser;
	}

	public void setFUpdateUser(String FUpdateUser) {
		this.FUpdateUser = FUpdateUser;
	}

	@Column(name = "F_UPDATE_TIME", length = 19)
	public Date getFUpdateTime() {
		return this.FUpdateTime;
	}

	public void setFUpdateTime(Date FUpdateTime) {
		this.FUpdateTime = FUpdateTime;
	}

	@Column(name = "F_EXT_1", length = 50)
	public String getFExt1() {
		return this.FExt1;
	}

	public void setFExt1(String FExt1) {
		this.FExt1 = FExt1;
	}

	@Column(name = "F_EXT_2", length = 50)
	public String getFExt2() {
		return this.FExt2;
	}

	public void setFExt2(String FExt2) {
		this.FExt2 = FExt2;
	}

	@Column(name = "F_EXT_3", length = 50)
	public String getFExt3() {
		return this.FExt3;
	}

	public void setFExt3(String FExt3) {
		this.FExt3 = FExt3;
	}

	@Column(name = "F_EXT_4", length = 50)
	public String getFExt4() {
		return this.FExt4;
	}

	public void setFExt4(String FExt4) {
		this.FExt4 = FExt4;
	}

	@Column(name = "F_EXT_5", length = 50)
	public String getFExt5() {
		return this.FExt5;
	}

	public void setFExt5(String FExt5) {
		this.FExt5 = FExt5;
	}

}