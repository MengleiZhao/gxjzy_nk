package com.braker.icontrol.budget.arrange.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.Depart;
import com.braker.core.model.User;

/**
 * 部门预算编制
 * @author zhangxun
 */
@Entity
@Table(name = "T_DEPT_BUDGET_CONTROL_NUM")
public class DepartArrange extends BaseEntityEmpty implements java.io.Serializable  {

	// Fields

	private Integer FDCId;//主键
	private String FBudgetControlNum;//预算编制编号
	private Date FBudgetYear;//预算年度
	private Double FBudgetControlSum;//控制数总额
	private Depart depart;//编制部门
	private String FUser;//编制人
	private Date FTime;//编制时间
	private User FCreateUser;
	private Date FCreateTime;
	private User FUpdateUser;
	private Date FUpdateTime;
	private Integer FDel = 1;//是否删除 0-删除
	private String FExt1;
	private String FExt2;
	private String FExt3;
	private String FExt4;
	private String FExt5;
	private String flowStatus;//审批状态
	private User nextAssigner;//下一阶段审核人
	
	// Transient Fields
	private int pageOrder; //页面显示排序
	private String departName;//查询部门名称
	private String departStr;//列表上显示部门名称

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_DC_ID", unique = true, nullable = false)
	public Integer getFDCId() {
		return this.FDCId;
	}

	public void setFDCId(Integer FDCId) {
		this.FDCId = FDCId;
	}


	@Column(name = "F_BUDGET_CONTROL_NUM", length = 30)
	public String getFBudgetControlNum() {
		return this.FBudgetControlNum;
	}

	public void setFBudgetControlNum(String FBudgetControlNum) {
		this.FBudgetControlNum = FBudgetControlNum;
	}

	@Column(name = "F_BUDGET_YEAR", length = 19)
	public Date getFBudgetYear() {
		return this.FBudgetYear;
	}

	public void setFBudgetYear(Date FBudgetYear) {
		this.FBudgetYear = FBudgetYear;
	}

	@Column(name = "F_BUDGET_CONTROL_SUM", precision = 22, scale = 0)
	public Double getFBudgetControlSum() {
		return this.FBudgetControlSum;
	}

	public void setFBudgetControlSum(Double FBudgetControlSum) {
		this.FBudgetControlSum = FBudgetControlSum;
	}

	@Column(name = "F_USER", length = 20)
	public String getFUser() {
		return this.FUser;
	}

	public void setFUser(String FUser) {
		this.FUser = FUser;
	}

	@Column(name = "F_TIME", length = 19)
	public Date getFTime() {
		return this.FTime;
	}

	public void setFTime(Date FTime) {
		this.FTime = FTime;
	}


	@Column(name = "F_CREATE_TIME", length = 19)
	public Date getFCreateTime() {
		return this.FCreateTime;
	}

	public void setFCreateTime(Date FCreateTime) {
		this.FCreateTime = FCreateTime;
	}

	@ManyToOne
	@JoinColumn(name = "F_CREATE_USER")
	public User getFCreateUser() {
		return FCreateUser;
	}

	public void setFCreateUser(User fCreateUser) {
		FCreateUser = fCreateUser;
	}

	@ManyToOne
	@JoinColumn(name = "F_UPDATE_USER")
	public User getFUpdateUser() {
		return FUpdateUser;
	}

	public void setFUpdateUser(User fUpdateUser) {
		FUpdateUser = fUpdateUser;
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

	@Column(name = "F_DEL")
	public Integer getFDel() {
		return FDel;
	}

	public void setFDel(Integer fDel) {
		FDel = fDel;
	}

	@Transient
	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	@Column(name = "F_FLOW_STAUTS")
	public String getFlowStatus() {
		return flowStatus;
	}

	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}

	@ManyToOne
	@JoinColumn(name = "F_DEPART_ID")
	public Depart getDepart() {
		return depart;
	}

	public void setDepart(Depart depart) {
		this.depart = depart;
	}

	@Transient
	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	@Transient
	public String getDepartStr() {
		if (depart != null) {
			return depart.getName();
		}
		return "";
	}

	public void setDepartStr(String departStr) {
		this.departStr = departStr;
	}
	
	@ManyToOne
	@JoinColumn(name = "F_NEXT_ASSIGNER_ID")
	public User getNextAssigner() {
		return nextAssigner;
	}

	public void setNextAssigner(User nextAssigner) {
		this.nextAssigner = nextAssigner;
	}

}
