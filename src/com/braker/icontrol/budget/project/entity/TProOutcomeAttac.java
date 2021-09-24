package com.braker.icontrol.budget.project.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.CascadeType;
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
 * 项目支出事项附件
 * TProOutcomeAttac entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_pro_outcome_attac")
public class TProOutcomeAttac implements java.io.Serializable {

	// Fields

	private Integer FNAId;
	private TProBudget TProBudget;
	private String FAttacName;
	private String FAttacType;
	private String FFileSrc;
	private Date FUploadTime;
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	private String FExt1;
	private String FExt2;
	private String FExt3;
	private String FExt4;
	private String FExt5;


	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_N_A_ID", unique = true, nullable = false)
	public Integer getFNAId() {
		return this.FNAId;
	}

	public void setFNAId(Integer FNAId) {
		this.FNAId = FNAId;
	}

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name = "F_BUD_ID")
	public TProBudget getTProBudget() {
		return this.TProBudget;
	}

	public void setTProBudget(TProBudget TProBudget) {
		this.TProBudget = TProBudget;
	}

	@Column(name = "F_ATTAC_NAME", length = 50)
	public String getFAttacName() {
		return this.FAttacName;
	}

	public void setFAttacName(String FAttacName) {
		this.FAttacName = FAttacName;
	}

	@Column(name = "F_ATTAC_TYPE", length = 2)
	public String getFAttacType() {
		return this.FAttacType;
	}

	public void setFAttacType(String FAttacType) {
		this.FAttacType = FAttacType;
	}

	@Column(name = "F_FILE_SRC", length = 100)
	public String getFFileSrc() {
		return this.FFileSrc;
	}

	public void setFFileSrc(String FFileSrc) {
		this.FFileSrc = FFileSrc;
	}

	@Column(name = "F_UPLOAD_TIME", length = 19)
	public Date getFUploadTime() {
		return this.FUploadTime;
	}

	public void setFUploadTime(Date FUploadTime) {
		this.FUploadTime = FUploadTime;
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