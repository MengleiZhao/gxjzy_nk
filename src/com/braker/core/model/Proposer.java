package com.braker.core.model;

import java.util.Date;


/**
 * 工作流发起人的model
 * @author 叶崇晖
 * @createtime 2018-09-10
 * @updatetime 2018-09-10
 */
public class Proposer {
	private String userName;
	
	private String departName;
	
	private Date upTime;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public Date getUpTime() {
		return upTime;
	}

	public void setUpTime(Date upTime) {
		this.upTime = upTime;
	}
	
	public Proposer (String userName, String departName, Date upTime) {
		this.userName = userName;
		this.departName = departName;
		this.upTime = upTime;
	}
}
