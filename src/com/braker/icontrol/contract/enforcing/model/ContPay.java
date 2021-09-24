package com.braker.icontrol.contract.enforcing.model;


import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;

/**
 * 合同付款申请基本信息model
 * @author 叶崇晖
 * @createtime 2018-08-20
 * @updatetime 2018-08-20
 */
@Entity
@Table(name = "T_CONT_PAY")
public class ContPay extends BaseEntityEmpty implements EntityDao,CheckEntity {

	@Id
	@Column(name = "T_PAY_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer payId;			//主键ID
	
	@Column(name = "F_PLAN_ID")
	private Integer planId;			//副键ID（关联付款计划）
	
	@Column(name = "T_PAY_CODE")
	private String payCode;			//合同付款申请编号
	
	@Column(name ="F_AMOUNT")
	private BigDecimal fReceAmount;		//实际付款金额
	
	@Column(name ="F_REAMOUNT")
	private BigDecimal fReAmount;		//实际付款金额(因字段名重复，新加一个)
	
	@Column(name = "F_OPERATOR")
	private String userName;		//申请人
	
	@Column(name = "F_OPERATOR_ID")
	private String userNameID;		//申请人ID
	
	@Column(name = "F_OPERATOR_DEPT_NAME")
	private String depateName;      //申请人部门名称
	
	@Column(name = "F_OPERATOR_DEPT_ID")
	private String depateID;      //申请人部门ID
	
	@Column(name = "F_REQ_TIME")
	private Date reqTime;			//申请时间
	
	@Column(name = "F_PAY_STAUTS")
	private String stauts;			//申请单状态
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_CASHIER_TYPE")
	private String cashierType;		//出纳受理状态0未受理1已受理
	
	@Column(name = "F_IS_SAME")
	private String isSame;		//收款人信息和签约方信息是否一致（0 不一致 1一致） 2020-12-18 沈帆加
	
	@Column(name = "F_REMARKS")
	private String remarks;		//合同付款依据及情况说明2021.01.07陈睿超加
	
	@Column(name = "F_PAYMENT_TYPE")
	private String paymentType;		//收款方式（1、银行代发2、现金3、支票4、电汇5、公务卡）2020.12.15应马经理要求调整
	
	@Column(name = "F_IF_CFO")
	private String ifCfo;			//部门主管校长是否财务校长（若为部门主管校长，需审批至校长）0：否     1：是
	
	@Transient
	private String fcCode;			//合同编号（流水号）
	
	@Transient
	private String fcTitle;			//合同名称
	
	
	@Transient
	private Integer num;			//序号

	@Transient
	private String isLedger;			//是否为合同报销台账
	
	public String getIfCfo() {
		return ifCfo;
	}
	public BigDecimal getfReAmount() {
		return fReAmount;
	}
	public void setfReAmount(BigDecimal fReAmount) {
		this.fReAmount = fReAmount;
	}
	public BigDecimal getfReceAmount() {
		return fReceAmount;
	}

	public void setfReceAmount(BigDecimal fReceAmount) {
		this.fReceAmount = fReceAmount;
	}

	public void setIfCfo(String ifCfo) {
		this.ifCfo = ifCfo;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public Integer getPayId() {
		return payId;
	}

	public void setPayId(Integer payId) {
		this.payId = payId;
	}

	public Integer getPlanId() {
		return planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}

	public String getFUserId() {
		return fuserId;
	}

	public void setFUserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public String getFcCode() {
		return fcCode;
	}

	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}

	public String getFcTitle() {
		return fcTitle;
	}

	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}


	public String getCashierType() {
		return cashierType;
	}


	public String getUserNameID() {
		return userNameID;
	}

	public void setUserNameID(String userNameID) {
		this.userNameID = userNameID;
	}

	public String getDepateName() {
		return depateName;
	}

	public void setDepateName(String depateName) {
		this.depateName = depateName;
	}

	public String getDepateID() {
		return depateID;
	}

	public void setDepateID(String depateID) {
		this.depateID = depateID;
	}
	

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONT_PAY";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(payId);
	}
	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.userName2=userName;
	}
	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.flowStauts=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return flowStauts;
	}
	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return payCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return payId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		this.cashierType = status;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return userNameID;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "T_PAY_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getIsSame() {
		return isSame;
	}

	public void setIsSame(String isSame) {
		this.isSame = isSame;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getIsLedger() {
		return isLedger;
	}

	public void setIsLedger(String isLedger) {
		this.isLedger = isLedger;
	}
	
	
	
}
