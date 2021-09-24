package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 二级分类
 * @author 陈睿超
 */
@Entity
@Table(name ="T_PRO_MGR_LEVEL_2")
public class ProMgrLevel2 extends BaseEntityEmpty implements Combobox{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_LV_ID2")
	private Integer fLvId2;
	
	@ManyToOne
	@JoinColumn(name = "F_LV_ID1")
	private ProMgrLevel1 pml;//上级分类
	
	@Column(name ="F_LEV_CODE")
	private String fLevCode2;//二级分类代码
	
	@Column(name ="F_LEV_NAME")
	private String fLevName2;//二级分类名称
	
	@Column(name ="F_FUNCTION_CLASS")
	private String fFunctionClass;//功能科目代码
	
	@Column(name ="F_PRO_TYPE")
	private String fProType;//项目分类
	
	@Column(name ="F_SECRECY_GRADE")
	private String fSecrecyGrade;//密级
	
	@Column(name ="F_EC_NAME")
	private String fEcName;//功能科目名称

	@Transient
	private Integer number;//序号 
	
	@Transient
	private Integer a;// 暂存数据：pml.fLvId1 外键
	
	@Transient
	private String fproCode;// 暂存数据：fproCode
	
	
	public Integer getA() {
		return a;
	}

	public void setA(Integer a) {
		this.a = a;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getfLvId2() {
		return fLvId2;
	}

	public void setfLvId2(Integer fLvId2) {
		this.fLvId2 = fLvId2;
	}

	public ProMgrLevel1 getPml() {
		return pml;
	}

	public void setPml(ProMgrLevel1 pml) {
		this.pml = pml;
	}

	public String getfLevCode2() {
		return fLevCode2;
	}

	public void setfLevCode2(String fLevCode2) {
		this.fLevCode2 = fLevCode2;
	}

	public String getfLevName2() {
		return fLevName2;
	}

	public void setfLevName2(String fLevName2) {
		this.fLevName2 = fLevName2;
	}

	public String getfFunctionClass() {
		return fFunctionClass;
	}

	public void setfFunctionClass(String fFunctionClass) {
		this.fFunctionClass = fFunctionClass;
	}

	public String getfProType() {
		return fProType;
	}

	public void setfProType(String fProType) {
		this.fProType = fProType;
	}

	public String getfSecrecyGrade() {
		return fSecrecyGrade;
	}

	public void setfSecrecyGrade(String fSecrecyGrade) {
		this.fSecrecyGrade = fSecrecyGrade;
	}

	public String getfEcName() {
		return fEcName;
	}

	public void setfEcName(String fEcName) {
		this.fEcName = fEcName;
	}
	
	@Override
	public String getId(){
		return String.valueOf(fLvId2);
	}

	@Override
	public String getCode() {
		return fLevCode2;
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
		return fLevName2;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getFproCode() {
		return fproCode;
	}

	public void setFproCode(String fproCode) {
		this.fproCode = fproCode;
	}
	
}
