package com.braker.icontrol.incomemanage.businessService.model;

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
 * 
 * @Description 经营性服务项目的model
 * @author 汪耀
 * @date : 2019年11月4日 下午5:18:39
 */
@Entity
@Table(name = "T_BUSINESS_SERVICE_INFO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BusinessServiceInfo extends BaseEntity implements EntityDao,
		CheckEntity {
	@Id
	@Column(name = "F_BUSI_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer fBusiId;			//立项id
	
	@Column(name = "F_BUSI_CODE")
	private String fBusiCode;			//立项单号
	
	@Column(name = "F_PRO_NAME")
	private String fProName;			//项目名称
	
	@Column(name = "F_PLAN_PRICE")
	private String fPlanPrice;			//收费标准及标准说明
	
	@Column(name = "F_OPERATOR_ID")
	private String fOperatorId;			//申请人id
	
	@Column(name = "F_OPERATOR_NAME")
	private String fOperatorName;		//申请人姓名
	
	@Column(name = "F_DEPT_ID")
	private String fDeptId;				//申请部门id
	
	@Column(name = "F_DEPT_NAME")
	private String fDeptName;			//申请部门名称
	
	@Column(name = "F_BUSI_TIME")
	private Date fBusiTime;				//申请时间
	
	@Column(name = "F_REMARK")
	private String fRemark;				//论证资料及内容说明
	
	@Column(name = "F_PRO_PLAN")
	private String fProPlan;			//收费依据及内容说明
	
	@Column(name = "F_STATUS")
	private String fStatus;				//数据状态
	
	@Column(name = "F_FLOW_STATUS")
	private String fFlowStatus;			//审批状态
	
	@Column(name = "F_NEXT_USER_ID")
	private String fNextUserId;			//下环节处理人 id
	
	@Column(name = "F_NEXT_USER_NAME")
	private String fNextUserName;		//下环节处理人 姓名
	
	@Column(name = "F_NEXT_CODE")
	private String fNextCode;			//下节点节点编码
	
	@Column(name = "MEETING_SUMMARY_YEAR1")
	private String meetingSummaryYear1;   //校长办公会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME1")
	private String meetingSummaryTime1; //校长办公会会议纪要次数
	
	@Column(name = "MEETING_SUMMARY_YEAR2")
	private String meetingSummaryYear2;   //党委会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME2")
	private String meetingSummaryTime2;  //党委会会议纪要次数
	
	@Column(name = "REGISTER_STATUS")
	private String registerStatus;  //登记状态
	
	@Transient
	private Integer num;				//序号

	@Transient
	private BigDecimal incomeMoney;          //收款金额
	
	@Transient
	private BigDecimal paymentMoney;          //付款金额
	
	public BigDecimal getIncomeMoney() {
		return incomeMoney;
	}

	public void setIncomeMoney(BigDecimal incomeMoney) {
		this.incomeMoney = incomeMoney;
	}

	public BigDecimal getPaymentMoney() {
		return paymentMoney;
	}

	public void setPaymentMoney(BigDecimal paymentMoney) {
		this.paymentMoney = paymentMoney;
	}

	public Integer getfBusiId() {
		return fBusiId;
	}

	public void setfBusiId(Integer fBusiId) {
		this.fBusiId = fBusiId;
	}

	public String getfBusiCode() {
		return fBusiCode;
	}

	public void setfBusiCode(String fBusiCode) {
		this.fBusiCode = fBusiCode;
	}

	public String getfProName() {
		return fProName;
	}

	public void setfProName(String fProName) {
		this.fProName = fProName;
	}

	public String getfPlanPrice() {
		return fPlanPrice;
	}

	public void setfPlanPrice(String fPlanPrice) {
		this.fPlanPrice = fPlanPrice;
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

	public Date getfBusiTime() {
		return fBusiTime;
	}

	public void setfBusiTime(Date fBusiTime) {
		this.fBusiTime = fBusiTime;
	}

	public String getfRemark() {
		return fRemark;
	}

	public String getfProPlan() {
		return fProPlan;
	}

	public void setfProPlan(String fProPlan) {
		this.fProPlan = fProPlan;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	public String getfFlowStatus() {
		return fFlowStatus;
	}

	public void setfFlowStatus(String fFlowStatus) {
		this.fFlowStatus = fFlowStatus;
	}

	public String getfNextUserId() {
		return fNextUserId;
	}

	public void setfNextUserId(String fNextUserId) {
		this.fNextUserId = fNextUserId;
	}

	public String getfNextUserName() {
		return fNextUserName;
	}

	public void setfNextUserName(String fNextUserName) {
		this.fNextUserName = fNextUserName;
	}

	public String getfNextCode() {
		return fNextCode;
	}

	public void setfNextCode(String fNextCode) {
		this.fNextCode = fNextCode;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
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
		
	}

	@Override
	public String getBeanCode() {
		return fBusiCode;
	}

	@Override
	public String getBeanCodeField() {
		return "F_BUSI_CODE";
	}

	@Override
	public Integer getBeanId() {
		return fBusiId;
	}

	@Override
	public String getUserId() {
		return fOperatorId;
	}

	@Override
	public String getNextCheckKey() {
		return fNextCode;
	}
	
	@Transient
	@Override
	public String getJoinTable() {
		return "T_BUSINESS_SERVICE_INFO";
	}
	
	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fBusiId);
	}

	public String getMeetingSummaryYear1() {
		return meetingSummaryYear1;
	}

	public void setMeetingSummaryYear1(String meetingSummaryYear1) {
		this.meetingSummaryYear1 = meetingSummaryYear1;
	}

	public String getMeetingSummaryTime1() {
		return meetingSummaryTime1;
	}

	public void setMeetingSummaryTime1(String meetingSummaryTime1) {
		this.meetingSummaryTime1 = meetingSummaryTime1;
	}

	public String getMeetingSummaryYear2() {
		return meetingSummaryYear2;
	}

	public void setMeetingSummaryYear2(String meetingSummaryYear2) {
		this.meetingSummaryYear2 = meetingSummaryYear2;
	}

	public String getMeetingSummaryTime2() {
		return meetingSummaryTime2;
	}

	public void setMeetingSummaryTime2(String meetingSummaryTime2) {
		this.meetingSummaryTime2 = meetingSummaryTime2;
	}

	public String getRegisterStatus() {
		return registerStatus;
	}

	public void setRegisterStatus(String registerStatus) {
		this.registerStatus = registerStatus;
	}

	
}
