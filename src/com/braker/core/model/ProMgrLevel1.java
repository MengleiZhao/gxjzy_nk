package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 一级分类
 * @author 陈睿超
 */
@Entity
@Table(name ="T_PRO_MGR_LEVEL_1")
public class ProMgrLevel1 extends BaseEntityEmpty implements Combobox{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_LV_ID1")
	private Integer fLvId1;
	
	@Column(name ="F_YEAR")
	private String fYear1;//年度
	
	@Column(name ="F_LEV_CODE")
	private String fLevCode1;//一级分类代码
	
	@Column(name ="F_LEV_NAME")
	private String fLevName1;//一级分类名称
	
	@Transient
	private Integer number;//序号 

	public Integer getfLvId1() {
		return fLvId1;
	}

	public void setfLvId1(Integer fLvId1) {
		this.fLvId1 = fLvId1;
	}

	public String getfYear1() {
		return fYear1;
	}

	public void setfYear1(String fYear1) {
		this.fYear1 = fYear1;
	}

	public String getfLevCode1() {
		return fLevCode1;
	}

	public void setfLevCode1(String fLevCode1) {
		this.fLevCode1 = fLevCode1;
	}

	public String getfLevName1() {
		return fLevName1;
	}

	public void setfLevName1(String fLevName1) {
		this.fLevName1 = fLevName1;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	
	@Override
	public String getId() {
		return String.valueOf(fLvId1);
	}

	@Override
	public String getCode() {
		return fLevCode1;
	}

	@Override
	public String getGridCode() {
		return null;
	}

	@Override
	public String getSftjCode() {
		return null;
	}

	@Override
	public String getText() {
		return fLevName1;
	}

	@Override
	public String getDesc() {
		return null;
	}
	
	
}
