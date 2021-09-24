package com.braker.core.model;





public class ProjectDelay {

	private String fProCode;			//项目编号
	private String fProName;			//项目名称
	private Double fContAmount ;		//合同金额
	private Integer fcId;				//合同ID
	private String deptName ;			//所属部门
	
	private String fReceProperty;		//付款性质
	
	private Integer delayDays; 			//剩余天数
	private Integer dayNum; 			//预警天数
	private String fReceStage;			//付款阶段
	
	private String fRecePlanTime;		//计划付款时间
	
	private Integer num;				//序号
	
	public Integer getfcId() {
		return fcId;
	}
	public void setfcId(Integer fcId) {
		this.fcId = fcId;
	}
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getDayNum() {
		return dayNum;
	}
	public void setDayNum(Integer dayNum) {
		this.dayNum = dayNum;
	}
	public String getfReceStage() {
		return fReceStage;
	}
	public void setfReceStage(String fReceStage) {
		this.fReceStage = fReceStage;
	}
	public String getfRecePlanTime() {
		return fRecePlanTime;
	}
	public void setfRecePlanTime(String fRecePlanTime) {
		this.fRecePlanTime = fRecePlanTime;
	}
	public Double getfContAmount() {
		return fContAmount;
	}
	public void setfContAmount(Double fContAmount) {
		this.fContAmount = fContAmount;
	}
	public String getdeptName() {
		return deptName;
	}
	public void setdeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getfReceProperty() {
		return fReceProperty;
	}
	public void setfReceProperty(String fReceProperty) {
		this.fReceProperty = fReceProperty;
	}
	public String getfProCode() {
		return fProCode;
	}
	public void setfProCode(String fProCode) {
		this.fProCode = fProCode;
	}
	public String getfProName() {
		return fProName;
	}
	public void setfProName(String fProName) {
		this.fProName = fProName;
	}
	public int getdelayDays() {
		return delayDays;
	}
	public void setdelayDays(Integer delayDays) {
		this.delayDays = delayDays;
	}
}
