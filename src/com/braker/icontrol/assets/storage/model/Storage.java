package com.braker.icontrol.assets.storage.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Transient;

import org.springframework.web.bind.annotation.RequestMapping;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 * 资产入库登记表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_STORAGE")
public class Storage extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId_S;
	
	@Column(name ="F_ASS_STORAGE_CODE")
	private String fAssStorageCode;//资产入库单（流水号）
	
	@Column(name ="F_OPERATOR_ID")
	private String fOperatorID;//申请人ID
	
	@Column(name ="F_OPERATOR")
	private String fOperator;//申请人
	
	@Column(name ="F_DEPT_ID")
	private String fDeptID;//申请部门ID

	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//申请部门名称
	
	@Column(name ="F_REQ_TIME")
	private Date fReqTime;//申请时间
	
	@Column(name ="F_REMARK")
	private String fRemark_S;//备注
	
	@Column(name ="F_ASS_STAUTS")
	private String fAssStauts;//资产增加单状态1-正常99-删除
	
	@Column(name ="F_FLOW_STAUTS")
	private String fFlowStatus;//审批状态0：暂存1：提交，待审核-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核
	
	@Column(name ="F_SUM_AMOUNT")
	private Double fSumAmount;//合计金额（元）
	
	@Column(name ="F_NEXT_USER_NAME")
	private String fNextUserName;//下环节处理人 姓名
	
	@Column(name ="F_NEXT_USER_CODE")
	private String fNextUserCode;//下环节处理人 id
	
	@Column(name ="F_NEXT_CODE")
	private String fNextCode;//下节点节点编码
	
	@Transient
	private Integer number;//序号

	@Transient
	private Date fPurchaseDateStart;//登记日期开始时间
	
	@Transient
	private Date fPurchaseDateEnd;//登记日期结束时间

	public Integer getfId_S() {
		return fId_S;
	}

	public void setfId_S(Integer fId_S) {
		this.fId_S = fId_S;
	}

	public String getfAssStorageCode() {
		return fAssStorageCode;
	}

	public void setfAssStorageCode(String fAssStorageCode) {
		this.fAssStorageCode = fAssStorageCode;
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

	public String getfRemark_S() {
		return fRemark_S;
	}

	public void setfRemark_S(String fRemark_S) {
		this.fRemark_S = fRemark_S;
	}

	public String getfAssStauts() {
		return fAssStauts;
	}

	public void setfAssStauts(String fAssStauts) {
		this.fAssStauts = fAssStauts;
	}

	public String getfFlowStatus() {
		return fFlowStatus;
	}

	public void setfFlowStatus(String fFlowStatus) {
		this.fFlowStatus = fFlowStatus;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Date getfPurchaseDateStart() {
		return fPurchaseDateStart;
	}

	public void setfPurchaseDateStart(Date fPurchaseDateStart) {
		this.fPurchaseDateStart = fPurchaseDateStart;
	}

	public Date getfPurchaseDateEnd() {
		return fPurchaseDateEnd;
	}

	public void setfPurchaseDateEnd(Date fPurchaseDateEnd) {
		this.fPurchaseDateEnd = fPurchaseDateEnd;
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

	@Transient
	@Override
	public String getJoinTable() {
		return "T_ASSET_STORAGE";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fId_S);
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
		this.fFlowStatus=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fFlowStatus;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fAssStorageCode;
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fId_S;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fOperatorID;
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
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_ASS_STORAGE_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fNextUserCode;
	}

	
	
	
	
	
}
