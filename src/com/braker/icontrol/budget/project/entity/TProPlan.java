package com.braker.icontrol.budget.project.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Transient;
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

/**
 * 项目实施计划
 * TProPlan entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_EXPEND_PLAN")
public class TProPlan extends BaseEntityEmpty implements java.io.Serializable {
	
	
	//主键
	private Integer pid;
	//项目id
	private TProBasicInfo project;
	//预算年度
	private String year;
	//支出计划额度
	private Double totalPlan;
	//年初预算小计
	private Double earlyTotal;
	//年初预算财政拨款
	private Double earlyAmount1;
	//年初预算结转资金
	private Double earlyAmount2;
	//执行调整小计
	private Double adjustTotal;
	//执行调整财政拨款
	private Double adjustAmount1;
	//执行调整结转资金
	private Double adjustAmount2;
	//全年预算小计
	private Double yearTotal;
	//全年预算财政拨款
	private Double yearAmount1;
	//全年预算结转资金
	private Double yearAmount2;
	//支出小计
	private Double outTotal;
	//支出财政拨款
	private Double outAmount1;
	//支出结转资金
	private Double outAmount2;
	//年度剩余小计
	private Double leastTotal;
	//年度剩余财政拨款
	private Double leastAmount1;
	//年度剩余结转资金
	private Double leastAmount2;
	//实际年度剩余小计
	private Double actualTotal;
	//实际年度剩余财政拨款
	private Double actualAmount1;
	//实际年度剩余结转资金
	private Double actualAmount2;
	
	//transien fields
	private String pageOrder;
	
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_E_ID", unique = true, nullable = false)
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	@ManyToOne
	@JoinColumn(name = "F_PRO_ID")
	public TProBasicInfo getProject() {
		return project;
	}
	public void setProject(TProBasicInfo project) {
		this.project = project;
	}
	@Column(name = "F_YEAR")
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	@Column(name = "F_LIMIT_EXP_PLAN")
	public Double getTotalPlan() {
		return totalPlan;
	}
	public void setTotalPlan(Double totalPlan) {
		this.totalPlan = totalPlan;
	}
	@Column(name = "F_BNY_BUDGET")
	public Double getEarlyTotal() {
		return earlyTotal;
	}
	public void setEarlyTotal(Double earlyTotal) {
		this.earlyTotal = earlyTotal;
	}
	@Column(name = "F_BNY_BUDGET_APPRO")
	public Double getEarlyAmount1() {
		return earlyAmount1;
	}
	public void setEarlyAmount1(Double earlyAmount1) {
		this.earlyAmount1 = earlyAmount1;
	}
	@Column(name = "F_BNY_BUDGET_TRANSFER")
	public Double getEarlyAmount2() {
		return earlyAmount2;
	}
	public void setEarlyAmount2(Double earlyAmount2) {
		this.earlyAmount2 = earlyAmount2;
	}
	@Column(name = "F_EXE_BUDGET")
	public Double getAdjustTotal() {
		return adjustTotal;
	}
	public void setAdjustTotal(Double adjustTotal) {
		this.adjustTotal = adjustTotal;
	}
	@Column(name = "F_EXE_BUDGET_APPRO")
	public Double getAdjustAmount1() {
		return adjustAmount1;
	}
	public void setAdjustAmount1(Double adjustAmount1) {
		this.adjustAmount1 = adjustAmount1;
	}
	@Column(name = "F_EXE_BUDGET_TRANSFER")
	public Double getAdjustAmount2() {
		return adjustAmount2;
	}
	public void setAdjustAmount2(Double adjustAmount2) {
		this.adjustAmount2 = adjustAmount2;
	}
	@Column(name = "F_FULL_BUDGET")
	public Double getYearTotal() {
		return yearTotal;
	}
	public void setYearTotal(Double yearTotal) {
		this.yearTotal = yearTotal;
	}
	@Column(name = "F_FULL_BUDGET_APPRO")
	public Double getYearAmount1() {
		return yearAmount1;
	}
	public void setYearAmount1(Double yearAmount1) {
		this.yearAmount1 = yearAmount1;
	}
	@Column(name = "F_FULL_BUDGET_TRANSFER")
	public Double getYearAmount2() {
		return yearAmount2;
	}
	public void setYearAmount2(Double yearAmount2) {
		this.yearAmount2 = yearAmount2;
	}
	@Column(name = "F_EXP_BUDGET")
	public Double getOutTotal() {
		return outTotal;
	}
	public void setOutTotal(Double outTotal) {
		this.outTotal = outTotal;
	}
	@Column(name = "F_EXP_BUDGET_APPRO")
	public Double getOutAmount1() {
		return outAmount1;
	}
	public void setOutAmount1(Double outAmount1) {
		this.outAmount1 = outAmount1;
	}
	@Column(name = "F_EXP_BUDGET_TRANSFER")
	public Double getOutAmount2() {
		return outAmount2;
	}
	public void setOutAmount2(Double outAmount2) {
		this.outAmount2 = outAmount2;
	}
	@Column(name = "F_SURPLUS_BUDGET")
	public Double getLeastTotal() {
		return leastTotal;
	}
	public void setLeastTotal(Double leastTotal) {
		this.leastTotal = leastTotal;
	}
	@Column(name = "F_SURPLUS_BUDGET_APPRO")
	public Double getLeastAmount1() {
		return leastAmount1;
	}
	public void setLeastAmount1(Double leastAmount1) {
		this.leastAmount1 = leastAmount1;
	}
	@Column(name = "F_SURPLUS_BUDGET_TRANSFER")
	public Double getLeastAmount2() {
		return leastAmount2;
	}
	public void setLeastAmount2(Double leastAmount2) {
		this.leastAmount2 = leastAmount2;
	}
	@Column(name = "F_ACT_BUDGET")
	public Double getActualTotal() {
		return actualTotal;
	}
	public void setActualTotal(Double actualTotal) {
		this.actualTotal = actualTotal;
	}
	@Column(name = "F_ACT_BUDGET_APPRO")
	public Double getActualAmount1() {
		return actualAmount1;
	}
	public void setActualAmount1(Double actualAmount1) {
		this.actualAmount1 = actualAmount1;
	}
	@Column(name = "F_ACT_BUDGET_TRANSFER")
	public Double getActualAmount2() {
		return actualAmount2;
	}
	public void setActualAmount2(Double actualAmount2) {
		this.actualAmount2 = actualAmount2;
	}
	@Transient
	public String getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(String pageOrder) {
		this.pageOrder = pageOrder;
	}
	
}