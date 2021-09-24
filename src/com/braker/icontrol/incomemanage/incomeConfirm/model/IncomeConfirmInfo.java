package com.braker.icontrol.incomemanage.incomeConfirm.model;

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

/**
 * 非合同收入登记确认的model
 * @author 方淳洲
 * @createtime 2021-06-10
 * @updatetime 2021-06-10
 */
@Entity
@Table(name = "T_INCOME_CONFIRM_INFO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class IncomeConfirmInfo extends BaseEntity implements EntityDao,CheckEntity{
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fpId;					//主键ID
	
	@Column(name = "F_P_CODE")
	private String fpCode;					//登记单号
	
	@Column(name = "F_INCOME_ID")
	private Integer fincomeId;				//登记单Id
	
	@Column(name = "F_INCOME_CODE")
	private String fincomeCode;					//登记单号
	
	@Column(name = "F_INCOME_NAME")
	private String fincomeName;					//立项项目名称
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;					//应收款金额
	
	@Column(name = "F_PAY_AMOUNT")
	private BigDecimal payAmount;				//已收款金额
	
	@Column(name = "F_NOT_PAY_AMOUNT")
	private BigDecimal notPayAmount;			//未收款金额
	
	@Column(name = "F_CONFIRM_TIME")
	private Date confirmTime;				//登记时间
	
	@Column(name = "F_CONFIRM_STATUS")
	private String confirmStatus;			//确认状态
	
	@Column(name = "F_FLOW_STATUS")
	private String flowStatus;				//审批状态
	
	@Column(name = "F_STATUS")
	private String status;			//删除状态
	
	@Column(name ="F_INCOME_TIME")
	private Date fReqTime;						//申请时间
	
	@Column(name ="F_INCOME_DEPT_ID")
	private String fReqDeptID;					//申请部门ID

	@Column(name ="F_INCOME_DEPT")
	private String fReqDept;					//申请部门
	
	@Column(name ="F_INCOME_USER_ID")
	private String fReqUserid;					//申请人的ID
	
	@Column(name ="F_INCOME_USER")
	private String fReqUser;					//申请人
	
	@Column(name ="F_NEXT_USER_NAME")
	private String fUserName;					//下环节处理人 姓名
	
	@Column (name ="F_NEXT_USER_CODE")
	private String fUserCode;					//下环节处理人 编码
	
	@Column(name ="F_NEXT_CODE")
	private String fNCode;						//下节点节点编码
	
	
	@Transient
	private Integer num;						//序号(数据库中没有)

	
	
	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	public String getfReqDeptID() {
		return fReqDeptID;
	}

	public void setfReqDeptID(String fReqDeptID) {
		this.fReqDeptID = fReqDeptID;
	}

	public String getfReqDept() {
		return fReqDept;
	}

	public void setfReqDept(String fReqDept) {
		this.fReqDept = fReqDept;
	}

	public String getfReqUserid() {
		return fReqUserid;
	}

	public void setfReqUserid(String fReqUserid) {
		this.fReqUserid = fReqUserid;
	}

	public String getfReqUser() {
		return fReqUser;
	}

	public void setfReqUser(String fReqUser) {
		this.fReqUser = fReqUser;
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

	public String getFincomeCode() {
		return fincomeCode;
	}

	public void setFincomeCode(String fincomeCode) {
		this.fincomeCode = fincomeCode;
	}

	public String getFincomeName() {
		return fincomeName;
	}

	public void setFincomeName(String fincomeName) {
		this.fincomeName = fincomeName;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(BigDecimal payAmount) {
		this.payAmount = payAmount;
	}

	public BigDecimal getNotPayAmount() {
		return notPayAmount;
	}

	public void setNotPayAmount(BigDecimal notPayAmount) {
		this.notPayAmount = notPayAmount;
	}

	public Date getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = confirmTime;
	}

	public String getConfirmStatus() {
		return confirmStatus;
	}

	public void setConfirmStatus(String confirmStatus) {
		this.confirmStatus = confirmStatus;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getFincomeId() {
		return fincomeId;
	}

	public void setFincomeId(Integer fincomeId) {
		this.fincomeId = fincomeId;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.fUserName = userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fUserCode = userId;
	}

	@Override
	public String getNextCheckUserId() {
		return fUserCode;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.fNCode = nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStatus = checkStatus;
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
		// TODO Auto-generated method stub
		
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
		return fReqUserid;
	}

	@Override
	public String getNextCheckKey() {
		return fNCode;
	}

	@Override
	public String getJoinTable() {
		return "T_INCOME_CONFIRM_INFO";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(fpId);
	}
	
	
}
