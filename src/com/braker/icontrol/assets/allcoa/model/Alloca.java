package com.braker.icontrol.assets.allcoa.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 * 资产调拨表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_ALLOCA")
public class Alloca extends BaseEntity implements CheckEntity,EntityDao{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId_A;
	
	@Column(name="F_ASS_ALLOCA_CODE")
	private String fAssAllcoaCode;//资产调拨单号
	
	@Column(name ="F_REQ_TIME")
	private Date fReqTime;//申请时间
	
	@Column(name ="F_REC_DEPT")
	private String fRecDept;//申请部门
	
	@Column(name ="F_REC_DEPT_ID")
	private String fRecDeptId;//申请部门ID
	
	@Column(name ="F_REC_USER")
	private String fRecUser;//申请人
	
	@Column(name ="F_REC_USER_ID")
	private String fRecUserId;//申请人ID
	
	@Column(name ="F_SUM_NUMBER")
	private Double fSumNumber;//合计总数
	
	@Column(name ="F_SUM_AMOUNT")
	private Double fSumAmount;//总金额(元)
	
	@Column(name="F_OUT_DEPT_ID")
	private String fOutDeptId;//资产调出部门ID
	
	@Column(name ="F_OUT_DEPT")
	private String fOutDept;//资产调出部门
	
	@Column(name ="F_OUT_TIME")
	private Date fOutTime;//调出日期
	
	@Column(name ="F_OUT_USER")
	private String fOutUser;//调出经办人
	
	@Column(name ="F_OUT_USER_ID")
	private String fOutUserID;//调出经办人
	
	@Column(name="F_IN_DEPT")
	private String fInDept;//资产调入部门
	
	@Column(name ="F_IN_USER")
	private String fInUser;//调入经办人
	
	@Column(name ="F_IN_USER_ID")
	private String fInUserID;//调入经办人
	
	@Column(name ="F_IN_DEPT_ID")
	private String fInDeptID;//资产调入部门ID
	
	@Column(name ="F_IN_TIME")
	private Date fInTime;//调入日期
	
	@Column(name ="F_ALLOCA_REMARK")
	private String fAllocaRemark;//资产内部转移原因
	
	@Column(name ="F_NEXT_USER_NAME")
	private String fNextUserName;//下环节处理人姓名
	
	@Column(name ="F_NEXT_USER_CODE")
	private String fNextUserCode;//下环节处理人编码
	
	@Column(name ="F_NEXT_CODE")
	private String fNextCode;//下环节节点编码
	
	@Column(name ="F_FLOW_STAUTS")
	private String fFlowStauts;//审批状态0：暂存1：待审核-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核
	
	@Column(name ="F_ALLOCA_STAUTS")
	private String fAllocaStauts;//调拨单状态1-正常99-删除
	
	@Transient
	private Integer number;//序号
	
	@Transient
	private Date fReqTimeBegin;//申请时间区间开始
	
	@Transient
	private Date fReqTimeEnd;//申请时间区间截止
	
	
	public Integer getfId_A() {
		return fId_A;
	}

	public void setfId_A(Integer fId_A) {
		this.fId_A = fId_A;
	}

	public String getfAssAllcoaCode() {
		return fAssAllcoaCode;
	}

	public void setfAssAllcoaCode(String fAssAllcoaCode) {
		this.fAssAllcoaCode = fAssAllcoaCode;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	public String getfFlowStauts() {
		return fFlowStauts;
	}

	public void setfFlowStauts(String fFlowStauts) {
		this.fFlowStauts = fFlowStauts;
	}

	public String getfAllocaStauts() {
		return fAllocaStauts;
	}

	public void setfAllocaStauts(String fAllocaStauts) {
		this.fAllocaStauts = fAllocaStauts;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Date getfOutTime() {
		return fOutTime;
	}

	public void setfOutTime(Date fOutTime) {
		this.fOutTime = fOutTime;
	}

	public Double getfSumNumber() {
		return fSumNumber;
	}

	public void setfSumNumber(Double fSumNumber) {
		this.fSumNumber = fSumNumber;
	}

	public Double getfSumAmount() {
		return fSumAmount;
	}

	public void setfSumAmount(Double fSumAmount) {
		this.fSumAmount = fSumAmount;
	}

	public String getfOutDeptId() {
		return fOutDeptId;
	}

	public void setfOutDeptId(String fOutDeptId) {
		this.fOutDeptId = fOutDeptId;
	}

	public String getfOutDept() {
		return fOutDept;
	}

	public void setfOutDept(String fOutDept) {
		this.fOutDept = fOutDept;
	}

	public String getfInDept() {
		return fInDept;
	}

	public void setfInDept(String fInDept) {
		this.fInDept = fInDept;
	}

	public String getfInDeptID() {
		return fInDeptID;
	}

	public void setfInDeptID(String fInDeptID) {
		this.fInDeptID = fInDeptID;
	}

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}

	public String getfRecDeptId() {
		return fRecDeptId;
	}

	public void setfRecDeptId(String fRecDeptId) {
		this.fRecDeptId = fRecDeptId;
	}

	public String getfRecUser() {
		return fRecUser;
	}

	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}

	public String getfAllocaRemark() {
		return fAllocaRemark;
	}

	public void setfAllocaRemark(String fAllocaRemark) {
		this.fAllocaRemark = fAllocaRemark;
	}

	public String getfNextUserName() {
		return fNextUserName;
	}

	public void setfNextUserName(String fNextUserName) {
		this.fNextUserName = fNextUserName;
	}

	public String getfNextUserCode() {
		return fNextUserCode;
	}

	public void setfNextUserCode(String fNextUserCode) {
		this.fNextUserCode = fNextUserCode;
	}

	public String getfNextCode() {
		return fNextCode;
	}

	public void setfNextCode(String fNextCode) {
		this.fNextCode = fNextCode;
	}

	public String getfRecUserId() {
		return fRecUserId;
	}

	public void setfRecUserId(String fRecUserId) {
		this.fRecUserId = fRecUserId;
	}

	public Date getfReqTimeBegin() {
		return fReqTimeBegin;
	}

	public void setfReqTimeBegin(Date fReqTimeBegin) {
		this.fReqTimeBegin = fReqTimeBegin;
	}

	public Date getfReqTimeEnd() {
		return fReqTimeEnd;
	}

	public void setfReqTimeEnd(Date fReqTimeEnd) {
		this.fReqTimeEnd = fReqTimeEnd;
	}

	public Date getfInTime() {
		return fInTime;
	}

	public void setfInTime(Date fInTime) {
		this.fInTime = fInTime;
	}

	public String getfOutUser() {
		return fOutUser;
	}

	public void setfOutUser(String fOutUser) {
		this.fOutUser = fOutUser;
	}

	public String getfOutUserID() {
		return fOutUserID;
	}

	public void setfOutUserID(String fOutUserID) {
		this.fOutUserID = fOutUserID;
	}

	public String getfInUser() {
		return fInUser;
	}

	public void setfInUser(String fInUser) {
		this.fInUser = fInUser;
	}

	public String getfInUserID() {
		return fInUserID;
	}

	public void setfInUserID(String fInUserID) {
		this.fInUserID = fInUserID;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.fNextUserName=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fNextUserCode=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.fNextCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fFlowStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fFlowStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fAllocaStauts=status;
		
	}
	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fAssAllcoaCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fId_A;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fRecUserId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNextCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_ASSET_ALLOCA";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(fId_A);
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_ASS_ALLOCA_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fNextUserCode;
	}
	
	
	
	
}
