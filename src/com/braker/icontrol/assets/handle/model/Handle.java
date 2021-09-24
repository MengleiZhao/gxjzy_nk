package com.braker.icontrol.assets.handle.model;

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
 * 资产处置信息表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_HANDLE")
public class Handle extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId;
	
	@Column(name ="F_ASS_HANDLE_CODE")
	private String fAssHandleCode;//资产处置单号（流水号）
	
	@ManyToOne
	@JoinColumn(name ="F_ASS_TYPE",referencedColumnName="lookupscode")
	private Lookups fAssType;//资产类型 
	
	@Column(name ="F_REQ_TIME")
	private Date fReqTime;//申请时间
	
	@Column(name ="F_REC_DEPT_ID")
	private String fRecDeptID;//申请部门ID

	@Column(name ="F_REC_DEPT")
	private String fRecDept;//申请部门
	
	@Column(name ="F_REC_USER")
	private String fReqUser;//申请人
	
	@Column(name ="F_REC_USER_ID")
	private String fReqUserid;//申请人的ID
	
	@Column(name ="F_HANDLE_REMARK")
	private String fHandleRemark;//处置原因
	
	@Column(name ="F_SUM_AMOUNT")
	private Double fSumAmount;//总金额(元)
	
	@Column(name ="F_FLOW_STAUTS")
	private String fFlowStauts;//审批状态0：暂存1：待审核-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核
	
	@Column(name="F_HANDLE_STAUTS")
	private String fHandleStauts;//处置单状态
	
	@Column(name="F_NEXT_USER_NAME")
	private String fNextUserName;//下环节处理人姓名
	
	@Column(name ="F_NEXT_USER_CODE")
	private String fNextUserCode;//下环节处理人 编码
	
	@Column(name="F_NEXT_CODE")
	private String fNextCode;//下环节节点编码
	
	@Transient
	private Integer number;//序号
	@Transient
	private String assType;//资产类型（显示用）
	
	

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getfAssHandleCode() {
		return fAssHandleCode;
	}

	public void setfAssHandleCode(String fAssHandleCode) {
		this.fAssHandleCode = fAssHandleCode;
	}


	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}


	public String getfHandleRemark() {
		return fHandleRemark;
	}

	public void setfHandleRemark(String fHandleRemark) {
		this.fHandleRemark = fHandleRemark;
	}

	public String getfFlowStauts() {
		return fFlowStauts;
	}

	public void setfFlowStauts(String fFlowStauts) {
		this.fFlowStauts = fFlowStauts;
	}

	public String getfHandleStauts() {
		return fHandleStauts;
	}

	public void setfHandleStauts(String fHandleStauts) {
		this.fHandleStauts = fHandleStauts;
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

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}


	public Lookups getfAssType() {
		return fAssType;
	}

	public void setfAssType(Lookups fAssType) {
		this.fAssType = fAssType;
	}

	public String getfRecDeptID() {
		return fRecDeptID;
	}

	public void setfRecDeptID(String fRecDeptID) {
		this.fRecDeptID = fRecDeptID;
	}

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}

	public String getfReqUser() {
		return fReqUser;
	}

	public void setfReqUser(String fReqUser) {
		this.fReqUser = fReqUser;
	}


	public String getfReqUserid() {
		return fReqUserid;
	}

	public void setfReqUserid(String fReqUserid) {
		this.fReqUserid = fReqUserid;
	}

	public String getAssType() {
		if(fAssType!=null){
			return fAssType.getName();
		}
		return assType;
	}

	public void setAssType(String assType) {
		this.assType = assType;
	}

	public Double getfSumAmount() {
		return fSumAmount;
	}

	public void setfSumAmount(Double fSumAmount) {
		this.fSumAmount = fSumAmount;
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
		this.fHandleStauts=status;
	}
	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fAssHandleCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fId;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fReqUserid;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNextCode;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_ASSET_HANDL";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(fId);
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_ASS_HANDLE_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fNextUserCode;
	}
	
	
	
	
}
