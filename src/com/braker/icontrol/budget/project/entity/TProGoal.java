package com.braker.icontrol.budget.project.entity;

import java.text.SimpleDateFormat;

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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 项目支出绩效目标总表
 * @author zhangxun
 *
 */
@Entity
@Table(name = "T_PRO_PERF_GOAL_LIST")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TProGoal extends BaseEntityEmpty {

	//主键
	private Integer pid;
	//关联项目
	private TProBasicInfo project;
	//项目中期资金总额
	private Double midTotal;
	//中期其中财政拨款
	private Double midAmount1;
	//中期其他资金
	private Double midAmount2;
	//中期目标
	private String midGoal;
	//项目长期资金总额
	private Double longTotal;
	//长期其中财政拨款
	private Double longAmount1;
	//长期其他资金
	private Double longAmount2;
	//长期目标
	private String longGoal;
	
	//项目绩效监测  陈睿超
	//当前已执行资金总额
	private Double fCurrentAmount;
	
	//当前已执行一般公共预算拨款额
	private Double fCurrentApproAmount;
	
	//当前已执行其他资金
	private Double fCurrentOtherAmount;
	
	//全年预计执行资金总额
	private Double fYearAmount;
	
	//全年预计执行一般公共预算拨款额
	private Double fYearApproAmount;
	
	//全年预计其他资金
	private Double fYearOtherAmount;

	
	//transient fields
	private int pageOrder;

	// Property accessors
	
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_G_ID", unique = true, nullable = false)
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

	@Column(name = "F_MATE_AMOUNT")
	public Double getMidTotal() {
		return midTotal;
	}

	public void setMidTotal(Double midTotal) {
		this.midTotal = midTotal;
	}

	@Column(name = "F_MATE_APPRO_AMOUNT")
	public Double getMidAmount1() {
		return midAmount1;
	}

	public void setMidAmount1(Double midAmount1) {
		this.midAmount1 = midAmount1;
	}

	@Column(name = "F_MATE_OTH_AMOUNT")
	public Double getMidAmount2() {
		return midAmount2;
	}

	public void setMidAmount2(Double midAmount2) {
		this.midAmount2 = midAmount2;
	}

	@Column(name = "F_MATE_GOAL")
	public String getMidGoal() {
		return midGoal;
	}

	public void setMidGoal(String midGoal) {
		this.midGoal = midGoal;
	}

	@Column(name = "F_LONG_AMOUNT")
	public Double getLongTotal() {
		return longTotal;
	}

	public void setLongTotal(Double longTotal) {
		this.longTotal = longTotal;
	}

	@Column(name = "F_LONG_APPRO_AMOUNT")
	public Double getLongAmount1() {
		return longAmount1;
	}

	public void setLongAmount1(Double longAmount1) {
		this.longAmount1 = longAmount1;
	}

	@Column(name = "F_LONG_OTH_AMOUNT")
	public Double getLongAmount2() {
		return longAmount2;
	}

	public void setLongAmount2(Double longAmount2) {
		this.longAmount2 = longAmount2;
	}

	@Column(name = "F_LONG_GOAL")
	public String getLongGoal() {
		return longGoal;
	}

	public void setLongGoal(String longGoal) {
		this.longGoal = longGoal;
	}

	@Transient
	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	@Column(name ="F_CURRENT_AMOUNT")
	public Double getfCurrentAmount() {
		return fCurrentAmount;
	}

	public void setfCurrentAmount(Double fCurrentAmount) {
		this.fCurrentAmount = fCurrentAmount;
	}

	@Column(name ="F_CURRENT_APPRO_AMOUNT")
	public Double getfCurrentApproAmount() {
		return fCurrentApproAmount;
	}

	public void setfCurrentApproAmount(Double fCurrentApproAmount) {
		this.fCurrentApproAmount = fCurrentApproAmount;
	}

	@Column(name ="F_CURRENT_OTH_AMOUNT")
	public Double getfCurrentOtherAmount() {
		return fCurrentOtherAmount;
	}

	public void setfCurrentOtherAmount(Double fCurrentOtherAmount) {
		this.fCurrentOtherAmount = fCurrentOtherAmount;
	}

	@Column(name ="F_YEAR_AMOUNT")
	public Double getfYearAmount() {
		return fYearAmount;
	}

	public void setfYearAmount(Double fYearAmount) {
		this.fYearAmount = fYearAmount;
	}

	@Column(name ="F_YEAR_APPRO_AMOUNT")
	public Double getfYearApproAmount() {
		return fYearApproAmount;
	}

	public void setfYearApproAmount(Double fYearApproAmount) {
		this.fYearApproAmount = fYearApproAmount;
	}

	@Column(name ="F_YEAR_OTH_AMOUNT")
	public Double getfYearOtherAmount() {
		return fYearOtherAmount;
	}

	public void setfYearOtherAmount(Double fYearOtherAmount) {
		this.fYearOtherAmount = fYearOtherAmount;
	}
	
	/** start:绩效台账列表显示 **/
	@Transient
	public Integer getProId(){
		if (project != null) {
			return project.getFProId();
		}
		return null;
	}
	@Transient
	public String getProCode(){
		if (project != null) {
			return project.getFProCode();
		}
		return "";
	}
	@Transient
	public String getProName(){
		if (project != null) {
			return project.getFProName();
		}
		return "";
	}
	@Transient
	public String getProHeader(){
		if (project != null) {
			return "";
		}
		return "";
	}
	@Transient
	public String getProSbr(){
		if (project != null) {
			return "";
		}
		return "";
	}
	@Transient
	public String getProSbbm(){
		if (project != null) {
			return "";
		}
		return "";
	}
	@Transient
	public String getProSbsj(){
		if (project != null) {
			return "";
		}
		return "";
	}
	@Transient
	public String getProYear(){
		if (project != null && project.getFProAppliTime() != null) {
			return new SimpleDateFormat("yyyy").format(project.getFProAppliTime());
		}
		return "";
	}
	/** end:绩效台账列表显示 **/
	
}
