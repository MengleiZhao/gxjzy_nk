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
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 项目预算支出科目表
 * TProBudget entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_pro_budget")
public class TProBudget extends BaseEntityEmpty implements java.io.Serializable {

	// Fields

	private Integer FPBId;//主键
	private TProBasicInfo TProBasicInfo;//关联项目
	private String FSubNum;//科目编码
	private String FSubName;//科目名称
	private String FUpperSubNum;//上级科目编码
	private String FLevel;//科目级别
	private Double FAppliAmount;//申报金额
	private String FFileSrc;//存放路径
	private Timestamp FUploadTime;//上传时间
	private String FAttacName;//附件名称
	private String FAccording;//测算依据
	
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	
	
	private String originFile;//页面传入的文件原路径
	
	private String FExt1;
	private String FExt2;
	private String FExt3;
	private String FExt4;
	private String FExt5;

	// Constructors

	/** default constructor */
	public TProBudget() {
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_P_B_ID", unique = true, nullable = false)
	public Integer getFPBId() {
		return this.FPBId;
	}

	public void setFPBId(Integer FPBId) {
		this.FPBId = FPBId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "F_PRO_ID")
	public TProBasicInfo getTProBasicInfo() {
		return this.TProBasicInfo;
	}

	public void setTProBasicInfo(TProBasicInfo TProBasicInfo) {
		this.TProBasicInfo = TProBasicInfo;
	}

	@Column(name = "F_SUB_NUM", length = 50)
	public String getFSubNum() {
		return this.FSubNum;
	}

	public void setFSubNum(String FSubNum) {
		this.FSubNum = FSubNum;
	}

	@Column(name = "F_SUB_NAME", length = 50)
	public String getFSubName() {
		return this.FSubName;
	}

	public void setFSubName(String FSubName) {
		this.FSubName = FSubName;
	}

	@Column(name = "F_UPPER_SUB_NUM")
	public String getFUpperSubNum() {
		return this.FUpperSubNum;
	}

	public void setFUpperSubNum(String FUpperSubNum) {
		this.FUpperSubNum = FUpperSubNum;
	}

	@Column(name = "F_APPLI_AMOUNT", precision = 22, scale = 0)
	public Double getFAppliAmount() {
		return this.FAppliAmount;
	}

	public void setFAppliAmount(Double FAppliAmount) {
		this.FAppliAmount = FAppliAmount;
	}

	@Column(name = "F_FILE_SRC", length = 100)
	public String getFFileSrc() {
		return this.FFileSrc;
	}

	public void setFFileSrc(String FFileSrc) {
		this.FFileSrc = FFileSrc;
	}

	@Column(name = "F_UPLOAD_TIME", length = 19)
	public Timestamp getFUploadTime() {
		return this.FUploadTime;
	}

	public void setFUploadTime(Timestamp FUploadTime) {
		this.FUploadTime = FUploadTime;
	}

	@Column(name = "F_ATTAC_NAME", length = 100)
	public String getFAttacName() {
		return this.FAttacName;
	}

	public void setFAttacName(String FAttacName) {
		this.FAttacName = FAttacName;
	}

	@Column(name = "F_ACCORDING", length = 50)
	public String getFAccording() {
		return this.FAccording;
	}

	public void setFAccording(String FAccording) {
		this.FAccording = FAccording;
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

	@Column(name = "F_LEVEL", length = 2)
	public String getFLevel() {
		return FLevel;
	}

	public void setFLevel(String fLevel) {
		FLevel = fLevel;
	}

	@Transient
	public String getOriginFile() {
		return originFile;
	}

	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}


}