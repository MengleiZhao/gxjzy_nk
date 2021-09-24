package com.braker.icontrol.expend.reimburse.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Transient;

/**
 * 合同报销信息类用于页面列表显示
 * @author 叶崇晖
 * @createtime 2018-08-21
 * @updatetime 2018-08-21
 */
public class ContractReimburseInfo {
	private Integer fcId;			//合同主键ID
	
	private Integer payId;			//合同付款申请主键ID
	
	private Integer fPlanId;		//合同付款计划主键ID
	
	private String fReceProperty;	//付款性质（付款名称）
	
	private String userName;		//申请人
	
	private Date reqTime;			//申请时间
	
	private String stauts;			//申请单状态
	
	private String flowStauts;		//审批状态
	
	private String fcCode;			//合同编号（流水号）
	
	private String payCode;			//合同付款申请编号
	
	private String fcTitle;			//合同名称
	
	private Date fRecePlanTime;		//预计付款时间
	
	private Double fRecePlanAmount;	//预计付款金额
	
	private Integer num;			//序号

	private String payStauts;       //付款状态0-未付款,1-已付款
	

	private String deptName;       //申请部门
	

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public Integer getPayId() {
		return payId;
	}

	public void setPayId(Integer payId) {
		this.payId = payId;
	}
	
	public Integer getfPlanId() {
		return fPlanId;
	}

	public void setfPlanId(Integer fPlanId) {
		this.fPlanId = fPlanId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getFcCode() {
		return fcCode;
	}

	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}

	public String getFcTitle() {
		return fcTitle;
	}

	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}

	public Date getfRecePlanTime() {
		return fRecePlanTime;
	}

	public void setfRecePlanTime(Date fRecePlanTime) {
		this.fRecePlanTime = fRecePlanTime;
	}

	public Double getfRecePlanAmount() {
		return fRecePlanAmount;
	}

	public void setfRecePlanAmount(Double fRecePlanAmount) {
		this.fRecePlanAmount = fRecePlanAmount;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getfReceProperty() {
		return fReceProperty;
	}

	public void setfReceProperty(String fReceProperty) {
		this.fReceProperty = fReceProperty;
	}

	public String getPayStauts() {
		return payStauts;
	}

	public void setPayStauts(String payStauts) {
		this.payStauts = payStauts;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	
}
