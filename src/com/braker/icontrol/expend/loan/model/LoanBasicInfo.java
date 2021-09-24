package com.braker.icontrol.expend.loan.model;

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

/**
 * 借款申请基本信息model
 * 是借款申请基本信息的model类
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
@Entity
@Table(name = "T_LOAN_BASIC_INFO")
public class LoanBasicInfo extends BaseEntity implements EntityDao,CheckEntity {
	@Id
	@Column(name = "F_L_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer lId;			//主键ID
	
	@Column(name = "F_L_CODE")
	private String lCode;			//借款单编号
	
	@Column(name = "F_AMOUNT")
	private BigDecimal lAmount;			//借款金额
	
	@Column(name = "F_USER")
	private String user;			//借款人id
	
	@Column(name = "F_DEPT")
	private String dept;			//所属部门id
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;		//所属部门名称
	
	@Column(name = "F_REQ_TIME")
	private Date reqTime;			//申请时间
	
	@Column(name = "F_EST_CHARGE_TIME")
	private Date estChargeTime;		//预计冲账时间
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;		//预算指标
	
	@Column(name = "F_INDEX_ID")
	private Integer indexId;		//预算指标Id
	
	@Column(name = "F_PRO_DETAIL_ID")
	private Integer proDetailId;	//项目支出明细id
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType;		//预算指标类型1位基本支出指标，2位项目支出指标
	
	@Column(name = "F_INDEX_AMOUNT")
	private BigDecimal indexAmount;		//可用预算金额
	
	@Column(name = "F_ECONOMIC_CODE")
	private String economicCode;	//资金来源：经济科目支出主键
	
	@Column(name = "F_PURPOSE")
	private String loanPurpose;		//用途（19.12.11改为 摘要）
	
	@Column(name = "F_REASON")
	private String loanReason;		//申请事由
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;			//申请状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_CASHIER_TYPE")
	private String cashierType;		//出纳受理状态0未受理1已受理
	
	@Column(name = "F_LEAST_AMOUNT")
	private BigDecimal leastAmount;		//剩余还款金额
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String userName;		//借款人
	
	@Transient
	private Date estChargeTime1;	//预计冲账时间开始(查询用)
	
	@Transient
	private Date estChargeTime2;	//预计冲账时间结束(查询用)
	
	@Transient
	private BigDecimal lAmount1;		//借款金额(查询用)
	
	@Transient
	private BigDecimal lAmount2;		//借款金额(查询用)

	@Column(name = "F_REPAY_STATUS")
	private String frepayStatus;	//还款（归垫）状态        0待还款  1待审定 -1已退回  9已还款
	
	@Column(name = "F_FUND_SOURCE")
	private String fundSource;		//资金来源：0-财政拨款收入、1-教育事业收入、2-科研事业收入、3-非同级拨款收入、4-其他收入、5-利息收入
	
	@Column(name = "F_BANK_ID")
	private String bankAccountId;	//银行账户字典id
	
	@Column(name = "F_BANK_NAME")
	private String bankAccountName;	//银行账户字典名称
	
	@Column(name = "F_PAYMENT_ID") 
	private String paymentId;			//还款单ID

	@Transient
	private String payflowStauts;		//还款审批状态
	
	@Transient
	private String paymentCode;		//还款单号
	
	@Transient
	private String dxLamount;		//大写金额
	
	@Transient
	private String paymentType;		//还款方式
	
	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
	}

	public BigDecimal getLeastAmount() {
		return leastAmount;
	}

	public void setLeastAmount(BigDecimal leastAmount) {
		this.leastAmount = leastAmount;
	}

	public Integer getlId() {
		return lId;
	}

	public void setlId(Integer lId) {
		this.lId = lId;
	}

	public String getlCode() {
		return lCode;
	}

	public void setlCode(String lCode) {
		this.lCode = lCode;
	}

	public BigDecimal getlAmount() {
		return lAmount;
	}

	public void setlAmount(BigDecimal lAmount) {
		this.lAmount = lAmount;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
	}

	public Date getEstChargeTime() {
		return estChargeTime;
	}

	public void setEstChargeTime(Date estChargeTime) {
		this.estChargeTime = estChargeTime;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public Integer getIndexId() {
		return indexId;
	}

	public void setIndexId(Integer indexId) {
		this.indexId = indexId;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	public BigDecimal getIndexAmount() {
		return indexAmount;
	}

	public void setIndexAmount(BigDecimal indexAmount) {
		this.indexAmount = indexAmount;
	}

	public String getLoanPurpose() {
		return loanPurpose;
	}

	public void setLoanPurpose(String loanPurpose) {
		this.loanPurpose = loanPurpose;
	}

	public String getLoanReason() {
		return loanReason;
	}

	public void setLoanReason(String loanReason) {
		this.loanReason = loanReason;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}




	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public String getCashierType() {
		return cashierType;
	}


	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFrepayStatus() {
		return frepayStatus;
	}

	public void setFrepayStatus(String frepayStatus) {
		this.frepayStatus = frepayStatus;
	}
	
	public Date getEstChargeTime1() {
		return estChargeTime1;
	}

	public void setEstChargeTime1(Date estChargeTime1) {
		this.estChargeTime1 = estChargeTime1;
	}

	public Date getEstChargeTime2() {
		return estChargeTime2;
	}

	public void setEstChargeTime2(Date estChargeTime2) {
		this.estChargeTime2 = estChargeTime2;
	}

	public BigDecimal getlAmount1() {
		return lAmount1;
	}

	public void setlAmount1(BigDecimal lAmount1) {
		this.lAmount1 = lAmount1;
	}

	public BigDecimal getlAmount2() {
		return lAmount2;
	}

	public void setlAmount2(BigDecimal lAmount2) {
		this.lAmount2 = lAmount2;
	}

	@Override
	@Transient
	public String getJoinTable() {
		return "T_LOAN_BASIC_INFO";
	}

	@Override
	@Transient
	public String getEntryId() {
		return String.valueOf(lId);
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
		return lCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return lId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		this.cashierType=status;
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return user;
	}

	public String getFundSource() {
		return fundSource;
	}

	public void setFundSource(String fundSource) {
		this.fundSource = fundSource;
	}

	public String getBankAccountId() {
		return bankAccountId;
	}

	public void setBankAccountId(String bankAccountId) {
		this.bankAccountId = bankAccountId;
	}

	public String getBankAccountName() {
		return bankAccountName;
	}

	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}

	public String getEconomicCode() {
		return economicCode;
	}

	public void setEconomicCode(String economicCode) {
		this.economicCode = economicCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_L_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	public String getPayflowStauts() {
		return payflowStauts;
	}

	public void setPayflowStauts(String payflowStauts) {
		this.payflowStauts = payflowStauts;
	}


	public String getPaymentCode() {
		return paymentCode;
	}

	public void setPaymentCode(String paymentCode) {
		this.paymentCode = paymentCode;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getDxLamount() {
		return dxLamount;
	}

	public void setDxLamount(String dxLamount) {
		this.dxLamount = dxLamount;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	
	
}
