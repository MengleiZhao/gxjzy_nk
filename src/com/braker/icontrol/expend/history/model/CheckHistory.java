package com.braker.icontrol.expend.history.model;

import java.util.Date;

public class CheckHistory {
	private String name;		//审批人姓名
	
	private String result;		//审批结果
	
	private Date time;			//审批时间
	
	private String remake;		//审批内容（备注）

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getRemake() {
		return remake;
	}

	public void setRemake(String remake) {
		this.remake = remake;
	}
	
	public CheckHistory(String name, String result, Date time, String remake) {
		this.name = name;
		this.result = result;
		this.time = time;
		this.remake =remake;
	}
}
