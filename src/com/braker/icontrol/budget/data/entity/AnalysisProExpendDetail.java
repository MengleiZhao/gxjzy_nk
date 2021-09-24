package com.braker.icontrol.budget.data.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 
 * <p>Description: 项目支出明细</p>
 * @author:陈睿超
 * @date： 2020年03月02日
 */

@Entity
@Table(name = "T_PRO_EXPEND_DETAIL_ANALYSIS")
@JsonIgnoreProperties(ignoreUnknown = true)
public class AnalysisProExpendDetail extends BaseEntityEmpty {

	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer FId;
	
	@Column(name = "F_EXP_ID")
	private Integer pid;				
	
	@Column(name = "F_EXP_CODE")
	private String expCode;				//支出明细编码
	
	@Column(name = "F_PRO_ID")
	private Integer FProId;				//项目id  
	
	@Column(name = "F_PRO_ACTIVITY")
	private String activity;			//项目活动

	@Column(name = "F_PRO_ACTIVITY_DESC")
	private String actDesc;				//摘要

	@Column(name = "F_P_S_ACTIVITE")
	private String sonActivity;			//子活动

	@Column(name = "F_P_S_ACTIVITY_DESC")
	private String sonActDesc; 			//对子活动的描述

	@Column(name = "F_NUM")
	private String number;				//数量/频率

	@Column(name = "F_SING_AMOUNT")
	private String standards;			//价格/标准

	@Column(name = "F_APPLI_AMOUNT")
	private double outAmount;			//支出计划（元）

	@Column(name = "F_EXPEND_AMOUNT")
	private Double expendAmount;		//已用金额（元）

	@Column(name = "F_REMARK")
	private String remark;				//备注

	@Column(name = "F_SUB_NUM")
	private String subCode;				//科目编码
	
	@Column(name = "F_SUB_NAME")
	private String subName;				//科目名称
	
	@Column(name = "F_ACCORDING")
	private String according;			//测算依据
	
	@Column(name = "F_XD_AMOUNT")
	private double xdAmount; 			//指标累计下达金额（元）
	
	@Column(name = "F_SY_AMOUNT")
	private double syAmount; 			//指标可用金额（元）
	
	@Column(name = "F_DJ_AMOUNT")
	private double djAmount; 			//指标冻结金额（元）
	
	@Column( name = "F_ANALYSIS_TYPE")
	private Integer FAnalysisType;//报表分析时数据类型     1-一上，2-项目评审，3-一下，4-二上，5-二下
	
	
	@Transient
	private String pageOrder;
	
	public Integer getFId() {
		return FId;
	}
	public void setFId(Integer fId) {
		this.FId = fId;
	}
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	
	public String getActDesc() {
		return actDesc;
	}
	public void setActDesc(String actDesc) {
		this.actDesc = actDesc;
	}
	
	public String getSonActivity() {
		return sonActivity;
	}
	public void setSonActivity(String sonActivity) {
		this.sonActivity = sonActivity;
	}
	
	public String getSonActDesc() {
		return sonActDesc;
	}
	public void setSonActDesc(String sonActDesc) {
		this.sonActDesc = sonActDesc;
	}
	
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	
	public String getStandards() {
		return standards;
	}
	public void setStandards(String standards) {
		this.standards = standards;
	}
	
	public double getOutAmount() {
		return outAmount;
	}
	public void setOutAmount(double outAmount) {
		this.outAmount = outAmount;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getSubCode() {
		return subCode;
	}
	public void setSubCode(String subCode) {
		this.subCode = subCode;
	}
	
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	
	public String getAccording() {
		return according;
	}
	public void setAccording(String according) {
		this.according = according;
	}
	
	
	public String getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(String pageOrder) {
		this.pageOrder = pageOrder;
	}
	
	public Double getExpendAmount() {
		return expendAmount;
	}
	public void setExpendAmount(Double expendAmount) {
		this.expendAmount = expendAmount;
	}
	public Integer getFProId() {
		return FProId;
	}
	public void setFProId(Integer fProId) {
		FProId = fProId;
	}
	public double getXdAmount() {
		return xdAmount;
	}
	public void setXdAmount(double xdAmount) {
		this.xdAmount = xdAmount;
	}
	public double getSyAmount() {
		return syAmount;
	}
	public void setSyAmount(double syAmount) {
		this.syAmount = syAmount;
	}
	public double getDjAmount() {
		return djAmount;
	}
	public void setDjAmount(double djAmount) {
		this.djAmount = djAmount;
	}
	public String getExpCode() {
		return expCode;
	}
	public void setExpCode(String expCode) {
		this.expCode = expCode;
	}
	public Integer getFAnalysisType() {
		return FAnalysisType;
	}
	public void setFAnalysisType(Integer fAnalysisType) {
		FAnalysisType = fAnalysisType;
	}
	
	
}
