package com.braker.core.model;

import java.util.Date;

/**
 * 审批流程结果信息model
 * 用于左侧流程审批结果信息与工作流绑定时带入前台使用
 * @author 叶崇晖
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
public class LeftCheckInfo {
	private String checkResult;		//审批意见（0-未通过1-通过）
	
	private String checkRemake;		//审批内容
	
	private Date checkTime;			//审批时间

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	public String getCheckRemake() {
		return checkRemake;
	}

	public void setCheckRemake(String checkRemake) {
		this.checkRemake = checkRemake;
	}
	
	
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	
	public LeftCheckInfo(String checkResult, String checkRemake, Date checkTime) {
		this.checkResult = checkResult;
		this.checkRemake = checkRemake;
		this.checkTime = checkTime;
	}
	
}
