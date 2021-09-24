package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

@Entity
@Table(name="T_EXPEND_STAND_CONF")
public class ExpendStandConf extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_EXP_ID")
	private Integer feId;
	
	@Column(name="F_POST_NAME")
	private String fpName;//岗位名称
	
	@Column(name="F_POST_LEVEL")
	private String fpLevel;//岗位级别
	
	@Column(name ="F_STAND_AMOUNT_D")
	private Float fStandAmountD;//开支标准 下限
	
	@Column(name ="F_STAND_AMOUNT_U")
	private Float fStandAmountU;//开支标准 上限
	
	@Column(name ="F_REMARK")
	private String fRemark;//备注

	public Integer getFeId() {
		return feId;
	}

	public void setFeId(Integer feId) {
		this.feId = feId;
	}

	public String getFpName() {
		return fpName;
	}

	public void setFpName(String fpName) {
		this.fpName = fpName;
	}

	public String getFpLevel() {
		return fpLevel;
	}

	public void setFpLevel(String fpLevel) {
		this.fpLevel = fpLevel;
	}

	public Float getfStandAmountD() {
		return fStandAmountD;
	}

	public void setfStandAmountD(Float fStandAmountD) {
		this.fStandAmountD = fStandAmountD;
	}

	public Float getfStandAmountU() {
		return fStandAmountU;
	}

	public void setfStandAmountU(Float fStandAmountU) {
		this.fStandAmountU = fStandAmountU;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}
	
	
	
}
