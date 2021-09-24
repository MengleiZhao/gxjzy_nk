package com.braker.icontrol.incomemanage.appropriation.model;

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
 * 拨款类收入model
 * @author wanping
 *
 */
@Entity
@Table(name = "T_APPROPRIATION_INFO")
public class AppropriationInfo extends BaseEntity implements EntityDao,CheckEntity {
	@Id
	@Column(name = "F_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	//主键ID
	private Integer aId;
	
	//登记单号
	@Column(name = "F_REGISTER_CODE")
	private String registerCode;
	
	//登记人id
	@Column(name = "F_OPERATOR_ID")
	private String fOperatorId;
	
	//登记人姓名
	@Column(name = "F_OPERATOR_NAME")
	private String fOperatorName;
	
	//登记部门id
	@Column(name = "F_DEPT_ID")
	private String fDeptId;
	
	//登记部门名称
	@Column(name = "F_DEPT_NAME")
	private String fDeptName;
	
	//登记时间
	@Column(name = "F_APPLY_DATE")
	private Date fApplyDate;
	
	//项目名称
	@Column(name = "F_PROJECT_NAME")
	private String projectName;
	
	//拨款类型
	@Column(name = "F_FUND_TYPE")
	private String fundType;
	
	//依据及简要说明
	@Column(name = "F_REMARK")
	private String remark;
	
	//对方单位名称
	@Column(name = "F_UNIT_NAME")
	private String unitName;
	
	//金额
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;
	
	//来款日期
	@Column(name = "F_PAYMENT_DATE")
	private Date paymentDate;
	
	//开票种类
	@Column(name = "F_INVOICE_TYPE")
	private String invoiceType;
	
	//数据状态
	@Column(name = "F_STATUS")
	private String fStatus;
	
	//下环节处理人 姓名
	@Column(name = "F_NEXT_USER_NAME")
	private String fNextUserName;
	
	//下环节处理人 id
	@Column(name = "F_NEXT_USER_ID")
	private String fNextUserId;
	
	//下节点节点编码
	@Column(name = "F_NEXT_CODE")
	private String fNextCode;
	
	//审批状态
	@Column(name = "F_FLOW_STATUS")
	private String fFlowStatus;
	
	//确认状态  0-未确认，1-已确认
	@Column(name = "F_CONFIRM_STATUS")
	private String fConfirmStatus;
	
	//实际来款日期
	@Column(name = "F_PAYMENT_ACTUAL_DATE")
	private Date paymentActualDate;
	
	//会计凭证号
	@Column(name = "F_ACCOUNTING_DOCUMENT")
	private String accountingDocument;
	
	//序号
	@Transient
	private Integer num;

	public Integer getaId() {
		return aId;
	}

	public void setaId(Integer aId) {
		this.aId = aId;
	}

	public String getRegisterCode() {
		return registerCode;
	}

	public void setRegisterCode(String registerCode) {
		this.registerCode = registerCode;
	}

	public String getfOperatorId() {
		return fOperatorId;
	}

	public void setfOperatorId(String fOperatorId) {
		this.fOperatorId = fOperatorId;
	}

	public String getfOperatorName() {
		return fOperatorName;
	}

	public void setfOperatorName(String fOperatorName) {
		this.fOperatorName = fOperatorName;
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

	public Date getfApplyDate() {
		return fApplyDate;
	}

	public void setfApplyDate(Date fApplyDate) {
		this.fApplyDate = fApplyDate;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getFundType() {
		return fundType;
	}

	public void setFundType(String fundType) {
		this.fundType = fundType;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
	}

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	public String getfNextUserName() {
		return fNextUserName;
	}

	public void setfNextUserName(String fNextUserName) {
		this.fNextUserName = fNextUserName;
	}

	public String getfNextUserId() {
		return fNextUserId;
	}

	public void setfNextUserId(String fNextUserId) {
		this.fNextUserId = fNextUserId;
	}

	public String getfNextCode() {
		return fNextCode;
	}

	public void setfNextCode(String fNextCode) {
		this.fNextCode = fNextCode;
	}

	public String getfFlowStatus() {
		return fFlowStatus;
	}

	public void setfFlowStatus(String fFlowStatus) {
		this.fFlowStatus = fFlowStatus;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.fNextUserName = userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fNextUserId = userId;
	}

	@Override
	public String getNextCheckUserId() {
		return fNextUserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.fNextCode = nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.fFlowStatus = checkStatus;
	}

	@Override
	public String getCheckStauts() {
		return fFlowStatus;
	}

	@Override
	public void setStauts(String status) {
		this.fStatus = status;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		return registerCode;
	}

	@Override
	public String getBeanCodeField() {
		return "T_APPROPRIATION_INFO";
	}

	@Override
	public Integer getBeanId() {
		return aId;
	}

	@Override
	public String getUserId() {
		return fOperatorId;
	}

	@Override
	public String getNextCheckKey() {
		return fNextCode;
	}

	@Override
	public String getJoinTable() {
		return "T_APPROPRIATION_INFO";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(aId);
	}

	public String getfConfirmStatus() {
		return fConfirmStatus;
	}

	public void setfConfirmStatus(String fConfirmStatus) {
		this.fConfirmStatus = fConfirmStatus;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Date getPaymentActualDate() {
		return paymentActualDate;
	}

	public void setPaymentActualDate(Date paymentActualDate) {
		this.paymentActualDate = paymentActualDate;
	}

	public String getAccountingDocument() {
		return accountingDocument;
	}

	public void setAccountingDocument(String accountingDocument) {
		this.accountingDocument = accountingDocument;
	}
	
}
