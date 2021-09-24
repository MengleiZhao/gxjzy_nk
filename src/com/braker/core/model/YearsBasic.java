package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

@Entity
@Table(name="T_YEARS_BASIC")
public class YearsBasic extends BaseEntity{

	@Id
	@Column(name ="F_Y_B_ID")
	private Integer fbId;//主键
	
	@Column(name ="F_TEMP_NAME")
	private String ftName;//模板名称（年份）
	
	@Column(name ="F_PERIOD")
	private String fPeriod;//期次维度
	
	@Column(name ="F_REMARK")
	private String fRemark;//备注
	
	@Transient
	private Integer number;//序号

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public String getFtName() {
		return ftName;
	}

	public void setFtName(String ftName) {
		this.ftName = ftName;
	}

	public String getfPeriod() {
		return fPeriod;
	}

	public void setfPeriod(String fPeriod) {
		this.fPeriod = fPeriod;
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
	
	
}
