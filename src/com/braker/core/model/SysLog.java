package com.braker.core.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.GenericEntityNow;

/**
 * 系统操作日志
 * @author administrator
 *
 */
@Entity
@Table(name="SYS_OPERATE_LOG")
public class SysLog extends GenericEntityNow implements Serializable{
	private static final long serialVersionUID = 2005335674290610420L;
	
	@Column(name="operate_url")
	private String operateUrl;//操作路径
	
	@Column(name="operate_content")
	private String operateContent;//操作内容
	
	@Column(name="macaddress")
	private String macaddress;//mac地址
	
	@Column(name="ipaddress")
	private String ipaddress;//IP地址

	@Transient
	private String userName;
	
	@Transient
	private String createDateStr;
	@Transient
	private String logName;
	@Transient
	private String startTime;
	@Transient
	private String endTime;
	@Transient
	private String jwhId;
	
	public String getLogName() {
		return logName;
	}

	public void setLogName(String logName) {
		this.logName = logName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getOperateUrl() {
		return operateUrl;
	}

	public void setOperateUrl(String operateUrl) {
		this.operateUrl = operateUrl;
	}

	public String getOperateContent() {
		return operateContent;
	}

	public void setOperateContent(String operateContent) {
		this.operateContent = operateContent;
	}

	public String getCreateDateStr() {
		createDateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(this.getCreateTime());
		return createDateStr;
	}

	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}

	public String getUserName() {
		userName = this.getCreator().getName();
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getJwhId() {
		return jwhId;
	}

	public void setJwhId(String jwhId) {
		this.jwhId = jwhId;
	}

	public String getMacaddress() {
		return macaddress;
	}

	public void setMacaddress(String macaddress) {
		this.macaddress = macaddress;
	}

	public String getIpaddress() {
		return ipaddress;
	}

	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}


	
	
	
}
