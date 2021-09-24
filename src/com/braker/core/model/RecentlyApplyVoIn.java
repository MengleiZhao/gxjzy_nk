package com.braker.core.model;



public class RecentlyApplyVoIn {

	private String stauts;			//报销状态
	private String user;			//报销人id
	private String fReqTime;//报销日期
	
	private Double fAmount; //报销金额
	
	private String dName ;//报销类型
	
	private String id;//报销人Id
	
	private String countId;//报销笔数
	
	private String sumAmount;//报销总金额
	
	private String applyName;//报销摘要
	
	
	public String getApplyName() {
		return applyName;
	}
	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}
	public String getCountId() {
		return countId;
	}
	public void setCountId(String countId) {
		this.countId = countId;
	}
	public String getSumAmount() {
		return sumAmount;
	}
	public void setSumAmount(String sumAmount) {
		this.sumAmount = sumAmount;
	}
	public String getfReqTime() {
		return fReqTime;
	}
	public void setfReqTime(String fReqTime) {
		this.fReqTime = fReqTime;
	}
	public Double getfAmount() {
		return fAmount;
	}
	public void setfAmount(Double fAmount) {
		this.fAmount = fAmount;
	}
	public String getdName() {
		return dName;
	}
	public void setdName(String dName) {
		this.dName = dName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStauts() {
		return stauts;
	}
	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	
}
