package com.braker.icontrol.budget.control.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 基本支出
 * @author zhangxun
 */
@Entity
@Table(name = "t_basic_expend")
public class TBasicExpend implements java.io.Serializable {

	// Fields

	private Integer FPId;//主键
	private TBudgetControlNum TBudgetControlNum;//关联预算控制数
	private String FDepartment;//归口部门名称
	private Double FControl;//控制数
	private String FType;//类型 1-人员基本支出 2-公用基本支出
	private String name;//名称
	private String code;//编码
	private TBasicExpend parentNode;//上级节点
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	private String FExt1;//年度
	private String FExt2;
	private String FExt3;
	private String FExt4;
	private String FExt5;


	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_P_ID", unique = true, nullable = false)
	public Integer getFPId() {
		return this.FPId;
	}

	public void setFPId(Integer FPId) {
		this.FPId = FPId;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "F_B_C_ID")
	public TBudgetControlNum getTBudgetControlNum() {
		return this.TBudgetControlNum;
	}

	public void setTBudgetControlNum(TBudgetControlNum TBudgetControlNum) {
		this.TBudgetControlNum = TBudgetControlNum;
	}


	@Column(name = "F_DEPARTMENT", length = 50)
	public String getFDepartment() {
		return this.FDepartment;
	}

	public void setFDepartment(String FDepartment) {
		this.FDepartment = FDepartment;
	}

	@Column(name = "F_CONTROL", precision = 22, scale = 0)
	public Double getFControl() {
		return this.FControl;
	}

	public void setFControl(Double FControl) {
		this.FControl = FControl;
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

	@Column(name = "F_TYPE")
	public String getFType() {
		return FType;
	}

	public void setFType(String fType) {
		FType = fType;
	}

	@Column(name = "F_NAME")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "F_CODE")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@ManyToOne
	@JoinColumn(name = "F_PARENT_ID")
	public TBasicExpend getParentNode() {
		return parentNode;
	}

	public void setParentNode(TBasicExpend parentNode) {
		this.parentNode = parentNode;
	}
	

}