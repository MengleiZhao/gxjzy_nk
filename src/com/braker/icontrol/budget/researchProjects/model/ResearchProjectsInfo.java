package com.braker.icontrol.budget.researchProjects.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="T_RESEARCH_PROJECTS_INFO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ResearchProjectsInfo extends BaseEntity implements EntityDao,CheckEntity{
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_P_ID")
	private Integer fpId;	//主键Id
	
	@Column(name = "F_P_CODE")
	private String fpCode;	//登记单code
	
	@Column (name ="F_DEPT_NAME")
	private String fDeptName;//登记部门
	
	@Column (name ="F_DEPT_ID")
	private String fDeptId;//登记部门id
	
	@Column (name ="F_USER")
	private String fUser;//登记人id
	
	@Column (name ="F_USER_NAME")
	private String fUserName;//登记人
	
	@Column (name="F_REQ_TIME")
	private Date fReqTime;//登记日期
	
	@Column (name="F_PROJECT_CODE")
	private String projectCode;//项目编号
	
	@Column (name="F_PROJECT_NAME")
	private String projectName;//项目名称
	
	@Column (name="F_PROJECT_USER")
	private String projectUser;//项目负责人
	
	@Column (name="F_PROJECT_MEMBER")
	private String projectMember;//项目组成员
	
	@Column (name="F_PROJECT_MEMBER_ID")
	private String projectMemberId;//项目组成员Id
	
	@Column (name="F_AMOUNT")
	private BigDecimal amount;//金额
	
	@Column(name = "F_NEXT_USER_NAME")
	private String nextUserName;		//下环节处理人姓名
	
	@Column(name = "F_NEXT_USER_ID")
	private String nextUserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "FLOWSTATS")
	private String flowStatus;			//审批状态
	
	@Column(name = "STATUS")
	private String status;			//单据状态
	
	@Column(name = "F_OFF_CAMPUS_PERSONNEL")
	private String offCampusPersonnel;			//校外人员
	
	@Column(name = "F_RESEARCH_TYPE")
	private String researchType;			//科研类型
	
	@Transient
	private String researchTypeName;			//科研类型名称
	
	@Transient
	private int num;					//序号(数据库里没有的)
	
	@Transient
	private String userName;	//预算项目申报人
	
	
	
	public String getResearchTypeName() {
		return researchTypeName;
	}

	public void setResearchTypeName(String researchTypeName) {
		this.researchTypeName = researchTypeName;
	}

	public String getOffCampusPersonnel() {
		return offCampusPersonnel;
	}

	public void setOffCampusPersonnel(String offCampusPersonnel) {
		this.offCampusPersonnel = offCampusPersonnel;
	}

	public String getResearchType() {
		return researchType;
	}

	public void setResearchType(String researchType) {
		this.researchType = researchType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(String projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
	}

	public String getfUser() {
		return fUser;
	}

	public void setfUser(String fUser) {
		this.fUser = fUser;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectUser() {
		return projectUser;
	}

	public void setProjectUser(String projectUser) {
		this.projectUser = projectUser;
	}

	public String getProjectMember() {
		return projectMember;
	}

	public void setProjectMember(String projectMember) {
		this.projectMember = projectMember;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getNextUserName() {
		return nextUserName;
	}

	public void setNextUserName(String nextUserName) {
		this.nextUserName = nextUserName;
	}

	public String getNextUserId() {
		return nextUserId;
	}

	public void setNextUserId(String nextUserId) {
		this.nextUserId = nextUserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public String getFlowStatus() {
		return flowStatus;
	}

	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.nextUserName = userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.nextUserId = userId;
	}

	@Override
	public String getNextCheckUserId() {
		return nextUserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStatus=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		return flowStatus;
	}

	@Override
	public void setStauts(String status) {
		this.status = status;
	}

	@Override
	public void setCashierType(String status) {
		
	}

	@Override
	public String getBeanCode() {
		return fpCode;
	}

	@Override
	public String getBeanCodeField() {
		return "F_P_CODE";
	}

	@Override
	public Integer getBeanId() {
		return fpId;
	}

	@Override
	public String getUserId() {
		return fUser;
	}

	@Override
	public String getNextCheckKey() {
		return nCode;
	}

	@Override
	public String getJoinTable() {
		return "T_RESEARCH_PROJECTS_INFO";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(fpId);
	}

}
