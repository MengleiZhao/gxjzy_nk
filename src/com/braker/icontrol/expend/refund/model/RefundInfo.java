package com.braker.icontrol.expend.refund.model;

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

/**
 * 学生退费申请表
 * @author 陈睿超
 * @createTime 2019-11-27
 */
@Entity
@Table(name = "T_REFUND_INFO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class RefundInfo extends BaseEntity implements EntityDao,CheckEntity {
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fRID;				//主键
	
	@Column(name = "F_INFO_CODE")
	private String fInfoCode;			//申请单编码
	
	@Column(name = "F_NEW_OR_OLD")
	private Integer fNewOrOld;			//新老学生	0-新生，1-老生
	
	@Column(name = "F_USER_NAME")
	private String fUserName;			//申请人名称
	
	@Column(name = "F_USER_ID")
	private String fUserId;				//申请人ID
	
	@Column(name = "F_DEPT_ID")
	private String fDeptId;				//申请部门ID
	
	@Column(name = "F_DEPT_NAME")
	private String fDeptName;			//申请部门名称
	
	@Column(name = "F_REQ_TIME")
	private Date fReqTime;				//申请时间
	
	@Column(name = "F_STAUTS")
	private String stauts;				//申请状态 1正常，99删除
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;			//审批状态-1删除， 0暂存，1送审，9审批完成，
	
	@Column(name = "F_USER_ID2")
	private String fUserId2;			//下环节处理人编码
	
	@Column(name = "F_USER_NAME2")
	private String userName2;			//下环节处理人姓名
	
	@Column(name = "F_N_CODE")
	private String nCode;				//下节点节点编码
	
	@Transient
	private Integer num;				//序号
	
	public Integer getfRID() {
		return fRID;
	}

	public void setfRID(Integer fRID) {
		this.fRID = fRID;
	}

	public String getfInfoCode() {
		return fInfoCode;
	}

	public void setfInfoCode(String fInfoCode) {
		this.fInfoCode = fInfoCode;
	}

	public String getfUserId() {
		return fUserId;
	}

	public void setfUserId(String fUserId) {
		this.fUserId = fUserId;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getfUserId2() {
		return fUserId2;
	}

	public void setfUserId2(String fUserId2) {
		this.fUserId2 = fUserId2;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStauts() {
		return stauts;
	}

	public Integer getfNewOrOld() {
		return fNewOrOld;
	}

	public void setfNewOrOld(Integer fNewOrOld) {
		this.fNewOrOld = fNewOrOld;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.userName2 = userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fUserId2 = userId;
	}

	@Override
	public String getNextCheckUserId() {
		return fUserId2;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.nCode = nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStauts = checkStatus;
	}

	@Override
	public String getCheckStauts() {
		return flowStauts;
	}

	@Override
	public void setStauts(String status) {
		this.stauts = status;
	}

	@Override
	public void setCashierType(String status) {
		
	}

	@Override
	public String getBeanCode() {
		return fInfoCode;
	}

	@Override
	public String getBeanCodeField() {
		return "T_REFUND_INFO";
	}

	@Override
	public Integer getBeanId() {
		return fRID;
	}

	@Override
	public String getUserId() {
		return fUserId;
	}

	@Override
	public String getNextCheckKey() {
		return nCode;
	}

	@Override
	public String getJoinTable() {
		return "T_REFUND_INFO";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(fRID);
	}

}
