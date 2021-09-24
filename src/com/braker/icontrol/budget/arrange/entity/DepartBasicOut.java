package com.braker.icontrol.budget.arrange.entity;

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

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 部门基本支出
 * @author zhangxun
 */
@Entity
@Table(name = "T_BASIC_EXPEND_DEPT")
public class DepartBasicOut  extends BaseEntityEmpty implements java.io.Serializable {

	// Fields

	private Integer FPId;//主键
	private DepartArrange arrange;//关联部门预算编制
	private TBasicExpend basicExpent;//关联控制数基本支出
	private String FDepartment;//归口部门名称
	private Double FControl;//金额
	private String FType;//类型 1-人员基本支出 2-公用基本支出
	private String name;//名称
	private String code;//编码
	private DepartBasicOut parentNode;//上级节点
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	private String FExt1;//年度
	private String FExt2;//是否已经发布 1-是 
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
	@JoinColumn(name = "F_DC_ID")
	public DepartArrange getArrange() {
		return arrange;
	}

	public void setArrange(DepartArrange arrange) {
		this.arrange = arrange;
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
	public DepartBasicOut getParentNode() {
		return parentNode;
	}

	public void setParentNode(DepartBasicOut parentNode) {
		this.parentNode = parentNode;
	}

	@ManyToOne
	@JoinColumn(name = "F_EXPEND_ID")
	public TBasicExpend getBasicExpent() {
		return basicExpent;
	}

	public void setBasicExpent(TBasicExpend basicExpent) {
		this.basicExpent = basicExpent;
	}
	

}
