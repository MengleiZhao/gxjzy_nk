package com.braker.icontrol.expend.loan.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.DefaultEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 还款申请
 * @author 张迅
 * @createtime 2019-06-14
 * @updatetime 2019-06-14
 */
@Entity
@Table(name = "t_payment")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Payment extends DefaultEntity implements EntityDao,CheckEntity {

	//还款人
	@Column(name ="F_PAY_PERSON")
	private String payPerson;
	//还款时间
	@Column(name ="F_PAY_TIME")
	private Date payTime;
	//还款金额
	@Column(name ="F_AMOUNT")
	private Double payAmount;
	//上传附件
	@Column(name ="F_FILE_NAME")
	private String fileName;
	//审批状态0：暂存1：提交，待审核-1：已退回（所有流程如驳回，则直接回退至申请人）2：审核中（2->8 系统支持8级审批）9：已审核
	@Column(name ="F_FLOW_STATUS")
	private String flowStatus;
	//还款编号
	@Column(name ="F_CODE")
	private String code;
	//借款id
	@Column(name = "F_L_ID")
	private Integer lId;			//借款ID
	
	@Column(name = "F_PAYMENT_TYPE")
	private String paymentType;	//还款方式
	
	/** 工作流字段 **/
	
	//下环节处理人 姓名
	@Column(name ="F_NEXT_USER_NAME")
	private String nextUserName;
	//下环节处理人 id
	@Column(name ="F_NEXT_USER_CODE")
	private String nextUserId;
	//下节点节点编码
	@Column(name ="F_NEXT_NODE_CODE")
	private String nextNodeCode;
	//申请人名称
	@Column(name ="F_APPLIER_NAME")
	private String applier;
	//申请人ID
	@Column(name ="F_APPLIER_ID")
	private String applierId;
	//申请部门ID
	@Column(name ="F_APPLI_DEPT_ID")
	private String applyDepId;
	//申请部门名称
	@Column(name ="F_APPLI_DEPT_NAME")
	private String applyDepName;
	
	//序号
	@Transient
	private Integer orderNum;
	//还款时间s
	@Transient
	private Date payTimes;
	//还款时间e
	@Transient
	private Date payTimee;
	
	public String getPayPerson() {
		return payPerson;
	}
	public void setPayPerson(String payPerson) {
		this.payPerson = payPerson;
	}
	public Date getPayTime() {
		return payTime;
	}
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	public Double getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(Double payAmount) {
		this.payAmount = payAmount;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	public String getFlowStatus() {
		return flowStatus;
	}
	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}
	@Override
	public String getJoinTable() {

		return "t_payment";
	}
	@Override
	public String getEntryId() {
		return super.getId();
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
	public void setNextCheckKey(String nCode) {
		this.nextNodeCode = nCode;
	}
	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStatus = checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return flowStatus;
	}
	@Override
	public void setStauts(String status) {
		
	}
	@Override
	public void setCashierType(String status) {
		
	}
	@Override
	public String getBeanCode() {
		return getCode();
	}
	@Override
	public Integer getBeanId() {
		return Integer.valueOf(getId());
	}
	@Override
	public String getUserId() {
		return getApplierId();
	}
	@Override
	public String getNextCheckKey() {
		return getNextNodeCode();
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
	public String getNextNodeCode() {
		return nextNodeCode;
	}
	public void setNextNodeCode(String nextNodeCode) {
		this.nextNodeCode = nextNodeCode;
	}
	public String getApplier() {
		return applier;
	}
	public void setApplier(String applier) {
		this.applier = applier;
	}
	public String getApplyDepId() {
		return applyDepId;
	}
	public void setApplyDepId(String applyDepId) {
		this.applyDepId = applyDepId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Date getPayTimes() {
		return payTimes;
	}
	public void setPayTimes(Date payTimes) {
		this.payTimes = payTimes;
	}
	public Date getPayTimee() {
		return payTimee;
	}
	public void setPayTimee(Date payTimee) {
		this.payTimee = payTimee;
	}
	public String getApplyDepName() {
		return applyDepName;
	}
	public void setApplyDepName(String applyDepName) {
		this.applyDepName = applyDepName;
	}
	public String getApplierId() {
		return applierId;
	}
	public void setApplierId(String applierId) {
		this.applierId = applierId;
	}
	public Integer getlId() {
		return lId;
	}
	public void setlId(Integer lId) {
		this.lId = lId;
	}
	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_CODE";
	}
	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return nextUserId;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	
	
}
