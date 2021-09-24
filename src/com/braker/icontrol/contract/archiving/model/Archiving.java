package com.braker.icontrol.contract.archiving.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 合同归档信息表
 * @author 陈睿超
 *
 */
@Entity
@Table(name = "T_CONTRACT_TOFILE")
public class Archiving extends BaseEntity implements EntityDao,CheckEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_TO_ID")
	private Integer fToId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId_tofile;
	
	@Column(name ="F_TO_CODE")
	private String fToCode;//归档编号
	
	@Column(name ="F_TO_POSITION")
	private String fToPosition;//归档位置
	
	@Column(name ="F_TO_USER")
	private String fToUser;//归档人
	
	@Column(name ="F_TO_TIME")
	private Date fToTime;//归档时间
	
	@Column(name ="F_NextCheckUserName")
	private String FNextCheckUserName;//下一审批人姓名
	
	@Column(name ="F_NextCheckUserId")
	private String FNextCheckUserId;//下一审批人ID
	
	@Column(name ="F_NextCheckKey")
	private String FNextCheckKey;//下一审批节点key
	
	@Column(name ="F_CheckStauts")
	private String FCheckStauts;//设置审批状态  0：暂存1：提交，待审-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核 
	
	@Column(name ="F_Stauts")
	private String FStauts;//申请状态
	
	@Column(name ="F_UserId")
	private String FUserId;//申请人ID
	
	@Column(name ="F_BeforeUser")
	private String FBeforeUser;//任务提交人姓名
	
	@Column(name ="F_BeforeDepart")
	private String FBeforeDepart;//任务提交人所属部门名称
	
	@Column(name ="F_BeforeDepartid")
	private String FBeforeDepartid;//任务提交人所属部门id
	
	@Column(name ="F_BeforeTime")
	private Date FBeforeTime;//任务提交时间
	
	@Column(name ="F_qdTime")
	private Date fqdTime;//签订日期
	
	
	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_TOFILE";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fToId);
	}
	
	public Date getFqdTime() {
		return fqdTime;
	}

	public void setFqdTime(Date fqdTime) {
		this.fqdTime = fqdTime;
	}

	public String getFNextCheckKey() {
		return FNextCheckKey;
	}

	public void setFNextCheckKey(String fNextCheckKey) {
		FNextCheckKey = fNextCheckKey;
	}

	public String getFBeforeDepartid() {
		return FBeforeDepartid;
	}

	public void setFBeforeDepartid(String fBeforeDepartid) {
		FBeforeDepartid = fBeforeDepartid;
	}

	public String getFNextCheckUserName() {
		return FNextCheckUserName;
	}

	public void setFNextCheckUserName(String fNextCheckUserName) {
		FNextCheckUserName = fNextCheckUserName;
	}

	public String getFNextCheckUserId() {
		return FNextCheckUserId;
	}

	public void setFNextCheckUserId(String fNextCheckUserId) {
		FNextCheckUserId = fNextCheckUserId;
	}

	public String getF_NextCheckKey() {
		return FNextCheckKey;
	}

	public void setF_NextCheckKey(String fNextCheckKey) {
		FNextCheckKey = fNextCheckKey;
	}

	public String getFCheckStauts() {
		return FCheckStauts;
	}

	public void setFCheckStauts(String fCheckStauts) {
		FCheckStauts = fCheckStauts;
	}

	public String getFStauts() {
		return FStauts;
	}

	public void setFStauts(String fStauts) {
		FStauts = fStauts;
	}

	public String getFUserId() {
		return FUserId;
	}

	public void setFUserId(String fUserId) {
		FUserId = fUserId;
	}

	public String getFBeforeUser() {
		return FBeforeUser;
	}

	public void setFBeforeUser(String fBeforeUser) {
		FBeforeUser = fBeforeUser;
	}

	public String getFBeforeDepart() {
		return FBeforeDepart;
	}

	public void setFBeforeDepart(String fBeforeDepart) {
		FBeforeDepart = fBeforeDepart;
	}

	public Date getFBeforeTime() {
		return FBeforeTime;
	}

	public void setFBeforeTime(Date fBeforeTime) {
		FBeforeTime = fBeforeTime;
	}

	public Integer getfToId() {
		return fToId;
	}

	public void setfToId(Integer fToId) {
		this.fToId = fToId;
	}

	public Integer getfContId_tofile() {
		return fContId_tofile;
	}

	public void setfContId_tofile(Integer fContId_tofile) {
		this.fContId_tofile = fContId_tofile;
	}

	public String getfToCode() {
		return fToCode;
	}

	public void setfToCode(String fToCode) {
		this.fToCode = fToCode;
	}

	public String getfToPosition() {
		return fToPosition;
	}

	public void setfToPosition(String fToPosition) {
		this.fToPosition = fToPosition;
	}

	public String getfToUser() {
		return fToUser;
	}

	public void setfToUser(String fToUser) {
		this.fToUser = fToUser;
	}

	public Date getfToTime() {
		return fToTime;
	}

	public void setfToTime(Date fToTime) {
		this.fToTime = fToTime;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.FNextCheckUserName = userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.FNextCheckUserId  = userId;
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return FNextCheckUserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.FNextCheckKey = nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.FCheckStauts = checkStatus;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return FCheckStauts;
	}

	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.FStauts = status;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fToCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_TO_CODE";
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fToId;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return FUserId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return FNextCheckKey;
	}
}
