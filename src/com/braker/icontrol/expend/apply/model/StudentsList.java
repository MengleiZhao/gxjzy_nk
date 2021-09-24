/**
 * <p>Title: StudentsList.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年10月13日
 */
package com.braker.icontrol.expend.apply.model;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.criteria.CriteriaBuilder.In;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.databind.deser.Deserializers.Base;

/**
 * <p>Title: StudentsList</p>  
 * <p>Description: 出差随行学生信息</p>  
 * @author 陈睿超
 * @date 2020年10月13日  
 */
@Entity
@Table(name ="T_TRAVEL_STUDENTS_LIST")
public class StudentsList extends BaseEntity{

	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_TS_ID")
	private Integer ftsId; 
	
	@Column(name = "F_G_ID")
	private Integer gId;//申请ID
	
	@Column(name = "F_R_ID")
	private Integer rId;//报销ID
	
	@Column(name = "F_NAME")
	private String fName;//学生名字
	
	@Column(name = "F_GENDER")
	private String fGender;//学生性别 1-男，0-女
	
	@Column(name = "F_IDENTITY_NUMBER")
	private String fIdentityNumber;//身份证号
	
	@Column(name = "F_TEL")
	private String  fTel;//联系电话
	
	
	@Transient
	private Integer number;//序号


	public Integer getFtsId() {
		return ftsId;
	}


	public void setFtsId(Integer ftsId) {
		this.ftsId = ftsId;
	}


	public Integer getgId() {
		return gId;
	}


	public void setgId(Integer gId) {
		this.gId = gId;
	}


	public Integer getrId() {
		return rId;
	}


	public void setrId(Integer rId) {
		this.rId = rId;
	}


	public String getfName() {
		return fName;
	}


	public void setfName(String fName) {
		this.fName = fName;
	}


	public String getfGender() {
		return fGender;
	}


	public void setfGender(String fGender) {
		this.fGender = fGender;
	}


	public String getfIdentityNumber() {
		return fIdentityNumber;
	}


	public void setfIdentityNumber(String fIdentityNumber) {
		this.fIdentityNumber = fIdentityNumber;
	}


	public String getfTel() {
		return fTel;
	}


	public void setfTel(String fTel) {
		this.fTel = fTel;
	}


	public Integer getNumber() {
		return number;
	}


	public void setNumber(Integer number) {
		this.number = number;
	}
	
	
	
	
}
