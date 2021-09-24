package com.braker.icontrol.assets.allcoa.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 	调拨资产清单
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_ALLOCA_LIST")
public class AllocaList extends BaseEntity {

	
	@Id
	@Column(name ="F_LIST_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer FListId;//主键
	
	@ManyToOne
	@JoinColumn(name ="F_ID", referencedColumnName="F_ID")
	private Alloca alloca;//Alloca外键
	
	@Column(name ="F_ASS_ALLOCA_CODE")
	private String fAssAllocaCode;//资产调拨单号（流水号）
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode;//资产编码
	
	@Column(name ="F_ASS_NAME")
	private String fAssName;//资产名称
	
	@Column(name ="F_ASS_SPECIF")
	private String fAssSpecif;//规格型号
	
	@Column(name ="F_ASS_NUM")
	private String fAssNum;//数量
	
	@Column(name ="F_MEAS_UNIT")
	private String fMeasUnit;//计量单位
	
	@Column(name ="F_SIGN_PRICE")
	private Double fSignPrice;//单价（元）
	
	@Column(name ="F_AMOUNT")
	private Double fAmount;//总金额（元）
	
	@Column(name ="F_NEW_ADDRESS")
	private String fNewAddress;//现存放地点
	
	@Column(name ="F_NEW_USER")
	private String fNewUser;//现资产管理人
	
	@Column(name ="F_OLD_ADDRESS")
	private String fOldAddress;//原存放地点
	
	@Column(name ="F_OLD_USER")
	private String fOldUser;//原资产管理人
	
	@Column(name ="F_REMARK")
	private String fRemark;//资产内部转移原因
	
	@Column(name ="F_SPECIFICATION")
	private String fSpecification;//规格
	
	@Column(name ="F_MODEL")
	private String fModel;//型号
	
	
	@Transient
	private Integer number;//序号

	public Integer getFListId() {
		return FListId;
	}

	public void setFListId(Integer fListId) {
		FListId = fListId;
	}

	public Alloca getAlloca() {
		return alloca;
	}

	public void setAlloca(Alloca alloca) {
		this.alloca = alloca;
	}

	public String getfAssAllocaCode() {
		return fAssAllocaCode;
	}

	public void setfAssAllocaCode(String fAssAllocaCode) {
		this.fAssAllocaCode = fAssAllocaCode;
	}

	public String getfAssCode() {
		return fAssCode;
	}

	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}

	public String getfAssName() {
		return fAssName;
	}

	public void setfAssName(String fAssName) {
		this.fAssName = fAssName;
	}

	public String getfAssSpecif() {
		return fAssSpecif;
	}

	public void setfAssSpecif(String fAssSpecif) {
		this.fAssSpecif = fAssSpecif;
	}

	public String getfAssNum() {
		return fAssNum;
	}

	public void setfAssNum(String fAssNum) {
		this.fAssNum = fAssNum;
	}

	public String getfMeasUnit() {
		return fMeasUnit;
	}

	public void setfMeasUnit(String fMeasUnit) {
		this.fMeasUnit = fMeasUnit;
	}

	public Double getfSignPrice() {
		return fSignPrice;
	}

	public void setfSignPrice(Double fSignPrice) {
		this.fSignPrice = fSignPrice;
	}

	public Double getfAmount() {
		return fAmount;
	}

	public void setfAmount(Double fAmount) {
		this.fAmount = fAmount;
	}

	public String getfNewAddress() {
		return fNewAddress;
	}

	public void setfNewAddress(String fNewAddress) {
		this.fNewAddress = fNewAddress;
	}

	public String getfNewUser() {
		return fNewUser;
	}

	public void setfNewUser(String fNewUser) {
		this.fNewUser = fNewUser;
	}

	public String getfOldAddress() {
		return fOldAddress;
	}

	public void setfOldAddress(String fOldAddress) {
		this.fOldAddress = fOldAddress;
	}

	public String getfOldUser() {
		return fOldUser;
	}

	public void setfOldUser(String fOldUser) {
		this.fOldUser = fOldUser;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getfSpecification() {
		return fSpecification;
	}

	public void setfSpecification(String fSpecification) {
		this.fSpecification = fSpecification;
	}

	public String getfModel() {
		return fModel;
	}

	public void setfModel(String fModel) {
		this.fModel = fModel;
	}
	
	
	
	
	
	
}
