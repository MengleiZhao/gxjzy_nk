package com.braker.icontrol.contract.enforcing.model;

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

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 合同变更记录表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_CONTRACT_UPT")
public class Upt extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId_U;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId_U;
	
	@Column(name ="F_UPT_CODE")
	private String fUptCode;//变更单单号
	
	@Column(name ="F_CONT_NAME")
	private String fContName;//新合同名称
	
	@Column(name ="F_CONT_NAME_OLD")
	private String fContNameOld;//原合同名称
	
	@Column(name ="F_CONT_UPT_TYPE")
	private String fContUptType;//合同变更类型：HTFL-01 采购类合同,HTFL-02 收入类合同,HTFL-03 非经济类合同(陈睿超2020.12.17修改)
	
	@Column(name ="F_CONT_CODE_OLD")
	private String fContCodeOld;//原合同号
	
	@Column(name ="F_CONT_CODE")
	private String fContCode;//新合同号
	
	@Column(name ="F_CO_OLD")
	private String fCoOld;//预变更内容
	
	@Column(name="F_CO_NEW")
	private String fCoNew;//变更后内容 
	
	@Column(name ="F_UPT_REASON")
	private String fUptReason;//变更原因
	
	@Column(name ="F_UPT_DATE")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date fUptdate;//变更签约日期
	
	@Column(name ="F_FLOW_STAUTS")
	private String fUptFlowStauts;//审批状态 0：暂存1：提交，待审-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核 
	
	@Column(name ="F_UPT_STAUTS")
	private String fUptStatus;//变更单状态1-正常99-删除
	
	@Column(name ="F_OPERATOR_ID")
	private String fOperatorID;//申请人id
	
	@Column(name ="F_OPERATOR")
	private String fOperator;//申请人名称
	
	@Column(name ="F_DEPT_ID")
	private String fDeptID;//所属部门ID
	
	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//所属部门名称
	
	@Column(name ="F_REQ_TIME")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date fReqTime;//申请日期
	
	@Column(name ="F_USER_NAME")
	private String fUserName;//下环节处理人 姓名
	
	@Column(name ="F_USER_CODE")
	private String fUserCode;//下环节处理人 编码
	
	@Column(name ="F_N_CODE")
	private String fNCode;//下下节点节点编码

	@Column(name ="F_AMOUNT")
	private Double fAmount;//新金额和旧金额比较，选取最新金额（走流程使用）
	
	@Column(name = "F_ASSIS_DEPT_ID")
	private String assisDeptId;	//协调部门id
	
	@Column(name = "F_ASSIS_DEPT_NAME")
	private String assisDeptName;//协调部门名称
	
	@Column(name = "F_STANDARD")
	private Integer standard;//是否制式合同 0:否，1：是
	
	@Column(name ="F_GDSTATUS")
	private String fgdstatus;//归档状态 0未归档1已归档
	
	@Column(name = "F_SEALED_STATUS")
	private String fsealedStatus;//是否盖章	0-未盖章	 	1-已盖章  2021-02-01沈帆加
	
	@Column(name ="F_SIGN_TIME")
	private Date fSignTime;//合同签署时间
	
	@Column(name = "F_IF_FJJHT")
	private Integer ifFjjht;//是否非经济合同	0-是	 	1-否 2021-02-04 沈帆加
	
	@Column(name = "F_IF_REIM")
	private String ifReim;		//是否报销		1-是	 	0-否 2021-03-11 赵孟雷加
	
	@Transient
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date fReqTimeStart;//报修时间开始(查询用)
	
	@Transient
	private String fContractor;//签约方名称
	
	@Transient
	private String Gdbgspstatus;//归档审批状态0：未审批1：提交，待审9：已审核 
	
	@Transient
	private String fAllAmount;//已付总额		2021.2.1 方淳洲加
	
	@Transient
	private String fNotAllAmountL;//未付总额	2021.2.1 方淳洲加
	
	@Transient
	private String percentage;//执行百分比		2021.2.1 方淳洲加
	
	@Transient
	private String fId_Us;//批量合同ID     2021.3.10 赵孟雷加 
	

	public String getGdbgspstatus() {
		return Gdbgspstatus;
	}

	public void setGdbgspstatus(String gdbgspstatus) {
		Gdbgspstatus = gdbgspstatus;
	}

	public String getfContractor() {
		return fContractor;
	}

	public void setfContractor(String fContractor) {
		this.fContractor = fContractor;
	}

	public String getFgdstatus() {
		return fgdstatus;
	}

	public void setFgdstatus(String fgdstatus) {
		this.fgdstatus = fgdstatus;
	}

	@Transient
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date fReqTimeEnd;//报修时间结束(查询用)
	
	@Transient
	private int number;//序号
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	
	
	public Integer getfId_U() {
		return fId_U;
	}

	public void setfId_U(Integer fId_U) {
		this.fId_U = fId_U;
	}

	public Integer getfContId_U() {
		return fContId_U;
	}

	public void setfContId_U(Integer fContId_U) {
		this.fContId_U = fContId_U;
	}

	public String getfContUptType() {
		return fContUptType;
	}

	public void setfContUptType(String fContUptType) {
		this.fContUptType = fContUptType;
	}

	public String getfContCodeOld() {
		return fContCodeOld;
	}

	public void setfContCodeOld(String fContCodeOld) {
		this.fContCodeOld = fContCodeOld;
	}

	public String getfContCode() {
		return fContCode;
	}

	public void setfContCode(String fContCode) {
		this.fContCode = fContCode;
	}

	public String getfCoOld() {
		return fCoOld;
	}

	public void setfCoOld(String fCoOld) {
		this.fCoOld = fCoOld;
	}

	public String getfCoNew() {
		return fCoNew;
	}

	public void setfCoNew(String fCoNew) {
		this.fCoNew = fCoNew;
	}

	public String getfUptFlowStauts() {
		return fUptFlowStauts;
	}

	public void setfUptFlowStauts(String fUptFlowStauts) {
		this.fUptFlowStauts = fUptFlowStauts;
	}

	public String getfContName() {
		return fContName;
	}

	public void setfContName(String fContName) {
		this.fContName = fContName;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_UPT";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fId_U);
	}

	public String getfUptReason() {
		return fUptReason;
	}

	public void setfUptReason(String fUptReason) {
		this.fUptReason = fUptReason;
	}

	public Date getfUptdate() {
		return fUptdate;
	}

	public void setfUptdate(Date fUptdate) {
		this.fUptdate = fUptdate;
	}

	public String getfUptStatus() {
		return fUptStatus;
	}

	public void setfUptStatus(String fUptStatus) {
		this.fUptStatus = fUptStatus;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfUserCode() {
		return fUserCode;
	}

	public void setfUserCode(String fUserCode) {
		this.fUserCode = fUserCode;
	}

	public String getfNCode() {
		return fNCode;
	}

	public void setfNCode(String fNCode) {
		this.fNCode = fNCode;
	}

	public String getfOperatorID() {
		return fOperatorID;
	}

	public void setfOperatorID(String fOperatorID) {
		this.fOperatorID = fOperatorID;
	}

	public String getfOperator() {
		return fOperator;
	}

	public void setfOperator(String fOperator) {
		this.fOperator = fOperator;
	}

	public String getfDeptID() {
		return fDeptID;
	}

	public void setfDeptID(String fDeptID) {
		this.fDeptID = fDeptID;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	
	public String getfUptCode() {
		return fUptCode;
	}

	public void setfUptCode(String fUptCode) {
		this.fUptCode = fUptCode;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.fUserName=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fUserCode=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.fNCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.fUptFlowStauts=checkStatus;
	}
	public Double getfAmount() {
		return fAmount;
	}

	public void setfAmount(Double fAmount) {
		this.fAmount = fAmount;
	}

	public String getAssisDeptId() {
		return assisDeptId;
	}

	public void setAssisDeptId(String assisDeptId) {
		this.assisDeptId = assisDeptId;
	}

	public String getAssisDeptName() {
		return assisDeptName;
	}

	public void setAssisDeptName(String assisDeptName) {
		this.assisDeptName = assisDeptName;
	}

	public Integer getStandard() {
		return standard;
	}

	public void setStandard(Integer standard) {
		this.standard = standard;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfContNameOld() {
		return fContNameOld;
	}

	public void setfContNameOld(String fContNameOld) {
		this.fContNameOld = fContNameOld;
	}

	public Date getfSignTime() {
		return fSignTime;
	}

	public void setfSignTime(Date fSignTime) {
		this.fSignTime = fSignTime;
	}

	public String getfId_Us() {
		return fId_Us;
	}

	public void setfId_Us(String fId_Us) {
		this.fId_Us = fId_Us;
	}

	public String getIfReim() {
		return ifReim;
	}

	public void setIfReim(String ifReim) {
		this.ifReim = ifReim;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fUptFlowStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fUptCode;
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fId_U;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fOperatorID;
	}

	@Override
	public String getNextCheckKey() {
		return fNCode;
	}

	public Date getfReqTimeStart() {
		return fReqTimeStart;
	}

	public void setfReqTimeStart(Date fReqTimeStart) {
		this.fReqTimeStart = fReqTimeStart;
	}

	public Date getfReqTimeEnd() {
		return fReqTimeEnd;
	}

	public void setfReqTimeEnd(Date fReqTimeEnd) {
		this.fReqTimeEnd = fReqTimeEnd;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_UPT_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fUserCode;
	}

	public String getfAllAmount() {
		return fAllAmount;
	}

	public void setfAllAmount(String fAllAmount) {
		this.fAllAmount = fAllAmount;
	}

	public String getfNotAllAmountL() {
		return fNotAllAmountL;
	}

	public void setfNotAllAmountL(String fNotAllAmountL) {
		this.fNotAllAmountL = fNotAllAmountL;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	public String getFsealedStatus() {
		return fsealedStatus;
	}

	public void setFsealedStatus(String fsealedStatus) {
		this.fsealedStatus = fsealedStatus;
	}

	public Integer getIfFjjht() {
		return ifFjjht;
	}

	public void setIfFjjht(Integer ifFjjht) {
		this.ifFjjht = ifFjjht;
	}

	
	
	
}
