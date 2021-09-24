package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 支出明细事项表1
 * @author 陈睿超
 */
@Entity
@Table(name ="T_EXPENDITURE_BASIC1")
public class ExpenditureBaseic1 extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="T_EB_ID1")
	private Integer tEbId;//主键
	
	@Column(name ="T_EB_NAME1")
	private String tEbName1;//费用类型（名称）
	
	@Column(name ="T_EB_CODE1")
	private String tEbCode1;//费用类型代码
	
	@Transient
	private Integer number;//序号
	
	//预留字段
	@Column(name ="F_EXT_1")
	private String fExt1;
	@Column(name ="F_EXT_2")
	private String fExt2;
	@Column(name ="F_EXT_3")
	private String fExt3;
	@Column(name ="F_EXT_4")
	private String fExt4;
	@Column(name ="F_EXT_5")
	private String fExt5;
	@Column(name ="F_EXT_6")
	private String fExt6;
	@Column(name ="F_EXT_7")
	private String fExt7;
	@Column(name ="F_EXT_8")
	private String fExt8;
	@Column(name ="F_EXT_9")
	private String fExt9;
	@Column(name ="F_EXT_10")
	private String fExt10;
	public Integer gettEbId() {
		return tEbId;
	}
	public void settEbId(Integer tEbId) {
		this.tEbId = tEbId;
	}
	public String gettEbName1() {
		return tEbName1;
	}
	public void settEbName1(String tEbName1) {
		this.tEbName1 = tEbName1;
	}
	public String gettEbCode1() {
		return tEbCode1;
	}
	public void settEbCode1(String tEbCode1) {
		this.tEbCode1 = tEbCode1;
	}
	public String getfExt1() {
		return fExt1;
	}
	public void setfExt1(String fExt1) {
		this.fExt1 = fExt1;
	}
	public String getfExt2() {
		return fExt2;
	}
	public void setfExt2(String fExt2) {
		this.fExt2 = fExt2;
	}
	public String getfExt3() {
		return fExt3;
	}
	public void setfExt3(String fExt3) {
		this.fExt3 = fExt3;
	}
	public String getfExt4() {
		return fExt4;
	}
	public void setfExt4(String fExt4) {
		this.fExt4 = fExt4;
	}
	public String getfExt5() {
		return fExt5;
	}
	public void setfExt5(String fExt5) {
		this.fExt5 = fExt5;
	}
	public String getfExt6() {
		return fExt6;
	}
	public void setfExt6(String fExt6) {
		this.fExt6 = fExt6;
	}
	public String getfExt7() {
		return fExt7;
	}
	public void setfExt7(String fExt7) {
		this.fExt7 = fExt7;
	}
	public String getfExt8() {
		return fExt8;
	}
	public void setfExt8(String fExt8) {
		this.fExt8 = fExt8;
	}
	public String getfExt9() {
		return fExt9;
	}
	public void setfExt9(String fExt9) {
		this.fExt9 = fExt9;
	}
	public String getfExt10() {
		return fExt10;
	}
	public void setfExt10(String fExt10) {
		this.fExt10 = fExt10;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	
	
}
