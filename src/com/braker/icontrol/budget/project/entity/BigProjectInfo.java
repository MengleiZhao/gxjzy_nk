package com.braker.icontrol.budget.project.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 
 * 大项目信息
 * @author:沈帆
 * @date：2020-09-27
 */

@Entity
@Table(name = "T_BIG_PROJECT_INFO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BigProjectInfo extends BaseEntity implements EntityDao,CheckEntity {

	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer pid;				//主键
	
	@Column(name = "F_P_CODE")
	private String pCode;				//大项目编码
	
	@Column(name = "F_P_NAME")
	private String pName;			//项目名称

	@Column(name = "F_START_YEAR")
	private String startYear;				//项目起始年度

	@Column(name = "F_END_YEAR")
	private String endYear;			//项目终止年度
	
	@Column(name = "F_DEPART_ID")
	private String departId; 			//部门id
	
	@Column(name = "F_DEPART_NAME")
	private String departName;				//部门名称

	@Column(name = "F_USER_ID")
	private String userId;			//申请人id

	@Column(name = "F_USER_NAME")
	private String userName;			//申请人
	
	@Column(name = "F_AMOUNT")
	private Double amount;			//项目总金额

	@Column(name = "F_P_DESCRIPTION ")
	private Double pDescription;		//项目情况概述

	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;			//申请状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_NEXT_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_REQ_TIME")
	private Date reqTime;			//申请时间

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getStartYear() {
		return startYear;
	}

	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	public String getEndYear() {
		return endYear;
	}

	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}

	public String getDepartId() {
		return departId;
	}

	public void setDepartId(String departId) {
		this.departId = departId;
	}

	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public String getUserID() {
		return userId;
	}

	public void setUserID(String userID) {
		this.userId = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Double getpDescription() {
		return pDescription;
	}

	public void setpDescription(Double pDescription) {
		this.pDescription = pDescription;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}

	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}
	
	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_P_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}
	
	
	@Override
	@Transient
	public String getJoinTable() {
		return "T_BIG_PROJECT_INFO";
	}

	@Override
	@Transient
	public String getEntryId() {
		return String.valueOf(pid);
	}
	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.userName2=userName;
	}
	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.flowStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return flowStauts;
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return pCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return pid;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return userId;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}
}
