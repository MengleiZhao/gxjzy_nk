package com.braker.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 首页个人工作台model
 * @author 叶崇晖
 * @createtime 2018-08-31
 * @updatetime 2018-08-31
 */
@Entity
@Table(name = "T_PERSONAL_WORKTABLE")
public class PersonalWork extends BaseEntityEmpty {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;			//主键ID
	
	@Column(name = "F_USER_ID")
	private String userId;			//任务处理人ID
	
	@Column(name = "F_TASK_ID")
	private Integer taskId;			//任务ID
	
	@Column(name = "F_TASK_CODE")
	private String taskCode;		//任务编号
	
	@Column(name = "F_TASK_NAME")
	private String taskName;		//任务名称
	
	@Column(name = "F_URL")
	private String url;				//跳转地址
	
	@Column(name = "F_URL1")
	private String url1;			//备用跳转地址1
	
	@Column(name = "F_URL2")
	private String url2;			//备用跳转地址2
	
	@Column(name = "F_TASK_STAUTS")
	private String taskStauts;		//任务状态0-待办：等待当前用户审批              2-已办：当前用户审批后                    4-办结：流程最终用户审批后
	
	@Column(name = "F_BEFORE_USER")
	private String beforeUser;		//任务提交人姓名
	
	@Column(name = "F_BEFORE_DEPART")
	private String beforeDepart;	//任务提交人所属部门名称
	
	@Column(name = "F_BEFORE_TIME")
	private Date beforeTime;				//任务开始时间--------任务发起人的提交时间（申请人的申请时间）
	
	@Column(name = "F_REFER_TIME",updatable=false)
	private Date referTime = new Date();	//本环节任务开始时间----上一节点处理人提交的时间
	
	@Column(name = "F_FINISH_TIME")
	private Date finishTime;				//本环节任务完成时间----当前环节的任务完成时间
	
	@Column(name = "F_OVER_TIME")
	private Date overTime;					//任务结束时间--------任务全部完成时的完成时间（审批结束时的时间）
	
	@Column(name = "F_TYPE")
	private String type;			//任务类型	（0、删除 	1、审批	2、查看	3、退回修改）
	
	@Column(name = "F_STAUTS")
	private String fStauts;			//任务单状态	（0、删除 	1、正常）
	
	@Column(name = "F_TASK_TYPE")
	private String taskType;			//判断这条任务是发起人还是审批人的	（0、发起人 	1、审批人）
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String userName;		//任务处理人名字
	
	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTaskStauts() {
		return taskStauts;
	}

	public void setTaskStauts(String taskStauts) {
		this.taskStauts = taskStauts;
	}

	public String getBeforeUser() {
		return beforeUser;
	}

	public void setBeforeUser(String beforeUser) {
		this.beforeUser = beforeUser;
	}
	
	public String getBeforeDepart() {
		return beforeDepart;
	}

	public void setBeforeDepart(String beforeDepart) {
		this.beforeDepart = beforeDepart;
	}

	public Date getBeforeTime() {
		return beforeTime;
	}

	public void setBeforeTime(Date beforeTime) {
		this.beforeTime = beforeTime;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUrl1() {
		return url1;
	}

	public void setUrl1(String url1) {
		this.url1 = url1;
	}

	public String getUrl2() {
		return url2;
	}

	public void setUrl2(String url2) {
		this.url2 = url2;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getReferTime() {
		return referTime;
	}

	public void setReferTime(Date referTime) {
		this.referTime = referTime;
	}

	public Date getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}

	public Date getOverTime() {
		return overTime;
	}

	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}

	public String getfStauts() {
		return fStauts;
	}

	public void setfStauts(String fStauts) {
		this.fStauts = fStauts;
	}

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	
}
