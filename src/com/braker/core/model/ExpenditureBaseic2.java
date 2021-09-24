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

import com.braker.common.entity.BaseEntity;

/**
 * 支出明细事项表2
 * @author 陈睿超
 */
@Entity
@Table(name ="T_EXPENDITURE_BASIC2")
public class ExpenditureBaseic2 extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="T_EB_ID2")
	private Integer tEbId2;//主键
	
	@ManyToOne
	@JoinColumn(name ="T_EB_ID1")
	private ExpenditureBaseic1 eb1;
	
	@Column(name ="T_EB_NAME2")
	private String tEbName2;//明细科目（名称）
	
	@Column(name ="T_EB_CODE2")
	private String tEbCode2;//费用类型代码
	
	@Column(name ="T_EB_DIRECTIONS")
	private String tEbDirections;//费用说明
	
	@Column(name ="T_EB_REMARK")
	private String tEbRemark;//备注
	
	@Transient
	private Integer number;//序号
	@Transient
	private Integer tEbIdTemp;//用来临时传递数据，主要传输eb1的“tEbId”这个主键
	
	
	// 预留字段
	@Column(name = "F_EXT_1")
	private String fExt1;
	@Column(name = "F_EXT_2")
	private String fExt2;
	@Column(name = "F_EXT_3")
	private String fExt3;
	@Column(name = "F_EXT_4")
	private String fExt4;
	@Column(name = "F_EXT_5")
	private String fExt5;
	@Column(name = "F_EXT_6")
	private String fExt6;
	@Column(name = "F_EXT_7")
	private String fExt7;
	@Column(name = "F_EXT_8")
	private String fExt8;
	@Column(name = "F_EXT_9")
	private String fExt9;
	@Column(name = "F_EXT_10")
	private String fExt10;
	public Integer gettEbId2() {
		return tEbId2;
	}
	public void settEbId2(Integer tEbId2) {
		this.tEbId2 = tEbId2;
	}
	public ExpenditureBaseic1 getEb1() {
		return eb1;
	}
	public void setEb1(ExpenditureBaseic1 eb1) {
		this.eb1 = eb1;
	}
	public String gettEbName2() {
		return tEbName2;
	}
	public void settEbName2(String tEbName2) {
		this.tEbName2 = tEbName2;
	}
	public String gettEbCode2() {
		return tEbCode2;
	}
	public void settEbCode2(String tEbCode2) {
		this.tEbCode2 = tEbCode2;
	}
	public String gettEbDirections() {
		return tEbDirections;
	}
	public void settEbDirections(String tEbDirections) {
		this.tEbDirections = tEbDirections;
	}
	public String gettEbRemark() {
		return tEbRemark;
	}
	public void settEbRemark(String tEbRemark) {
		this.tEbRemark = tEbRemark;
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
	public Integer getTEbIdTemp() {
		return tEbIdTemp;
	}
	public void setTEbIdTemp(Integer tEbIdTemp) {
		this.tEbIdTemp = tEbIdTemp;
	}
	
	
}
