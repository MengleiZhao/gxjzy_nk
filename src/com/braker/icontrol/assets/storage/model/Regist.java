package com.braker.icontrol.assets.storage.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name ="T_ASSET_REGIST_LIST")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Regist extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_LIST_ID")
	private Integer fListId;
	
	@Column(name ="F_ASS_STORAGE_CODE")
	private String fAssStorageCodeR;//Storage 的单号
	
	@Column(name ="F_ASS_CODE")
	private String fAssCodeR;//固定资产标签编号(资产编号)
	
	@Column(name ="F_SYS_CODE")
	private String fSysCodeR;//资产名称系统编号
	
	@Column(name ="F_FINANCIAL_CODE")
	private String fFinancialCodeR;//国资分类号
	
	@Column(name ="F_ASS_NAME")
	private String fAssNameR;//物资名称

	@Column(name ="F_M_MODE")
	private String fmMode;//型号
	
	@Column(name ="F_M_SPECIF")
	private String fmSpecif;//规格
	
	@Column(name ="F_MEAS_UNIT")
	private String fMeasUnitR;//单位
	
	@Column(name ="F_INS_NUM")
	private String fInsNumR;//数量
	
	@Column(name ="F_ACTION_DATE")
	private Date fActionDate;//资产验收日期
	
	@Column(name ="F_SIGN_PRICE")
	private Double fSignPrice;//单价(元)
	
	@Column(name ="F_AMOUNT")
	private Double fAmount;//总金额(元)
	
	@Column(name ="F_REMARK")
	private String fRemarkR;//备注
	
	@Transient
	private String fActionDateLIin;//资产验收日期(列表用)

	@Transient
	private Integer number;//序号(列表用)
	
	
	public Integer getfListId() {
		return fListId;
	}

	public void setfListId(Integer fListId) {
		this.fListId = fListId;
	}

	public String getfAssStorageCodeR() {
		return fAssStorageCodeR;
	}

	public void setfAssStorageCodeR(String fAssStorageCodeR) {
		this.fAssStorageCodeR = fAssStorageCodeR;
	}

	public String getfAssCodeR() {
		return fAssCodeR;
	}

	public void setfAssCodeR(String fAssCodeR) {
		this.fAssCodeR = fAssCodeR;
	}

	public String getfSysCodeR() {
		return fSysCodeR;
	}

	public void setfSysCodeR(String fSysCodeR) {
		this.fSysCodeR = fSysCodeR;
	}

	public String getfFinancialCodeR() {
		return fFinancialCodeR;
	}

	public void setfFinancialCodeR(String fFinancialCodeR) {
		this.fFinancialCodeR = fFinancialCodeR;
	}

	public String getfAssNameR() {
		return fAssNameR;
	}

	public void setfAssNameR(String fAssNameR) {
		this.fAssNameR = fAssNameR;
	}

	public String getFmMode() {
		return fmMode;
	}

	public void setFmMode(String fmMode) {
		this.fmMode = fmMode;
	}

	public String getFmSpecif() {
		return fmSpecif;
	}

	public void setFmSpecif(String fmSpecif) {
		this.fmSpecif = fmSpecif;
	}

	public String getfMeasUnitR() {
		return fMeasUnitR;
	}

	public void setfMeasUnitR(String fMeasUnitR) {
		this.fMeasUnitR = fMeasUnitR;
	}

	public String getfInsNumR() {
		return fInsNumR;
	}

	public void setfInsNumR(String fInsNumR) {
		this.fInsNumR = fInsNumR;
	}

	public Date getfActionDate() {
		return fActionDate;
	}

	public void setfActionDate(Date fActionDate) {
		this.fActionDate = fActionDate;
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

	public String getfRemarkR() {
		return fRemarkR;
	}

	public void setfRemarkR(String fRemarkR) {
		this.fRemarkR = fRemarkR;
	}

	public String getfActionDateLIin() {
		return fActionDateLIin;
	}

	public void setfActionDateLIin(String fActionDateLIin) {
		this.fActionDateLIin = fActionDateLIin;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}


	
	
	
	
}
