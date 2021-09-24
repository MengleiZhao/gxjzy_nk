package com.braker.icontrol.budget.control.entity;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预算控制数明细表（一下）
 * @author 陈睿超
 */
@Entity
@Table(name = "T_BUDGET_CONTROL_NUM_DETAIL")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TProExpend extends BaseEntityEmpty implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_D_ID")
	private Integer fDId;//主键
	
	@ManyToOne
	@JoinColumn(name ="F_C_ID")
	private TBudgetControlNum fCId;//外键
	
	@Column(name ="F_PRO_NAME")
	private String fProName;//项目名称
	
	@Column(name ="F_PRO_CODE")
	private String fProCode;//项目编号
	
	@Column(name ="F_LEV_NAME")
	private String fLevName;//一级分类名称
	
	@Column(name ="F_PRO_TYPE")
	private String fProType;//项目类别
	
	@Column(name ="F_FUNCTION_CLASS")
	private String fFunctionClass;//功能分类
	
	@Column(name ="F_PRO_APPLI_DEPART")
	private String fProAppliDepart;//申报部门
	
	@Column(name ="F_PRO_HEAD")
	private String fProHead;//项目负责人
	
	@Column(name ="F_PRO_APP_TIME")
	private Date fProAppTime;//申报时间
	
	@Column(name ="F_PRO_BUDGET_AMOUNT")
	private BigDecimal fProBudgetAmount;//项目申报金额
	
	@Column(name ="F_CONTROL_AMOUNT")
	private BigDecimal fControlAmount;//一下控制数
	
	@Column(name ="F_REMARK")
	private String fRemark;//控制原因

	public Integer getfDId() {
		return fDId;
	}

	public void setfDId(Integer fDId) {
		this.fDId = fDId;
	}

	public TBudgetControlNum getfCId() {
		return fCId;
	}

	public void setfCId(TBudgetControlNum fCId) {
		this.fCId = fCId;
	}

	public String getfProName() {
		return fProName;
	}

	public void setfProName(String fProName) {
		this.fProName = fProName;
	}

	public String getfProCode() {
		return fProCode;
	}

	public void setfProCode(String fProCode) {
		this.fProCode = fProCode;
	}

	public String getfLevName() {
		return fLevName;
	}

	public void setfLevName(String fLevName) {
		this.fLevName = fLevName;
	}

	public String getfProType() {
		return fProType;
	}

	public void setfProType(String fProType) {
		this.fProType = fProType;
	}

	public String getfFunctionClass() {
		return fFunctionClass;
	}

	public void setfFunctionClass(String fFunctionClass) {
		this.fFunctionClass = fFunctionClass;
	}

	public String getfProAppliDepart() {
		return fProAppliDepart;
	}

	public void setfProAppliDepart(String fProAppliDepart) {
		this.fProAppliDepart = fProAppliDepart;
	}

	public String getfProHead() {
		return fProHead;
	}

	public void setfProHead(String fProHead) {
		this.fProHead = fProHead;
	}

	public Date getfProAppTime() {
		return fProAppTime;
	}

	public void setfProAppTime(Date fProAppTime) {
		this.fProAppTime = fProAppTime;
	}

	public BigDecimal getfProBudgetAmount() {
		return fProBudgetAmount;
	}

	public void setfProBudgetAmount(BigDecimal fProBudgetAmount) {
		this.fProBudgetAmount = fProBudgetAmount;
	}

	public BigDecimal getfControlAmount() {
		return fControlAmount;
	}

	public void setfControlAmount(BigDecimal fControlAmount) {
		this.fControlAmount = fControlAmount;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}
	
	
	
}