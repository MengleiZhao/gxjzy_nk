package com.braker.icontrol.incomemanage.accountsCurrent.model;
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
 * 来款登记
 * @author 赵孟雷
 */
@Entity
@Table(name = "T_MONEY_REGISTER")
@JsonIgnoreProperties(ignoreUnknown = true)
public class AccountsRegister extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@Column(name = "F_M_S_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer fMSId;
	
	@Column(name = "F_A_C_A_ID")
	private Integer fAcaId;
	
	@Column(name = "F_REGISTER_CODE")
	private String registerCode;		//登记单号
	
	@Column(name = "F_PRO_NAME")
	private String proName;				//项目名称   来款项目名称
	
	@Column(name = "F_PRO_CODE")
	private String proCode;				//项目编号
	
	@Column(name = "F_CONTEN_EXPLAIN")
	private String contenExplain;		//内容说明    依据及简要说明
	
	@Column(name = "F_USER")
	private String userId;				//申请人id
	
	@Column(name = "F_USER_NAME")
	private String userName;			//申请人姓名  登记人
	
	@Column(name = "F_DEPT_ID")
	private String deptId;				//申请人所属部门的id
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;			//申请人所属部门名称   登记部门
	
	@Column(name = "F_REQ_TIME")
	private Date reqTime;				//登记时间

	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;			//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;				//申请状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;			//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;				//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;				//下节点节点编码
	
	@Column(name = "F_CONTRACT_ID")
	private Integer conId;				//合同ID
	
	@Column(name = "F_CONTRACT_CODE")
	private String conCode;				//合同编号
	
	@Column(name = "F_CONTRACT_NAME")
	private String conName;				//合同名称

	@Column(name = "F_REGISTER_STAUTS")
	private String rStauts;				//登记状态
	
	@Column(name = "F_AFFIRM_STAUTS")
	private String aStauts;				//确认状态
	
	@Column(name = "F_ACC_DOC_NUMBER")
	private String accDocNumber;		//会计凭证号
	
	@Column(name = "F_REALITY_DATE")
	private Date realityDate;				//实际来款日期

	@Column(name = "F_AFF_TIME")
	private Date affTime;				//确认时间

	@Column(name = "F_AFFIRM_USER")
	private String affirmUserId;		//确认人id
	
	@Column(name = "F_AFFIRM_USER_NAME")
	private String affirmUserName;			//确认人姓名

	@Column(name = "F_REGISTER_MONEY")
	private BigDecimal registerMoney;		//登记金额
	
	@Transient
	private String registerMoneyCapital;		//登记金额大写
	
	@Transient
	private String oppositeUnit;        //对方单位
	
	@Transient
	private BigDecimal planMoney;          //预计来款金额
	
	public String getRegisterMoneyCapital() {
		return registerMoneyCapital;
	}

	public void setRegisterMoneyCapital(String registerMoneyCapital) {
		this.registerMoneyCapital = registerMoneyCapital;
	}

	public BigDecimal getRegisterMoney() {
		return registerMoney;
	}

	public void setRegisterMoney(BigDecimal registerMoney) {
		this.registerMoney = registerMoney;
	}

	public String getAffirmUserId() {
		return affirmUserId;
	}

	public void setAffirmUserId(String affirmUserId) {
		this.affirmUserId = affirmUserId;
	}

	public String getAffirmUserName() {
		return affirmUserName;
	}

	public void setAffirmUserName(String affirmUserName) {
		this.affirmUserName = affirmUserName;
	}

	public String getAccDocNumber() {
		return accDocNumber;
	}

	public void setAccDocNumber(String accDocNumber) {
		this.accDocNumber = accDocNumber;
	}

	public Date getRealityDate() {
		return realityDate;
	}

	public void setRealityDate(Date realityDate) {
		this.realityDate = realityDate;
	}

	public Date getAffTime() {
		return affTime;
	}

	public void setAffTime(Date affTime) {
		this.affTime = affTime;
	}

	public String getrStauts() {
		return rStauts;
	}

	public void setrStauts(String rStauts) {
		this.rStauts = rStauts;
	}

	public String getaStauts() {
		return aStauts;
	}

	public void setaStauts(String aStauts) {
		this.aStauts = aStauts;
	}

	public String getOppositeUnit() {
		return oppositeUnit;
	}

	public void setOppositeUnit(String oppositeUnit) {
		this.oppositeUnit = oppositeUnit;
	}

	public BigDecimal getPlanMoney() {
		return planMoney;
	}

	public void setPlanMoney(BigDecimal planMoney) {
		this.planMoney = planMoney;
	}

	public Integer getfMSId() {
		return fMSId;
	}

	public void setfMSId(Integer fMSId) {
		this.fMSId = fMSId;
	}

	public Integer getfAcaId() {
		return fAcaId;
	}

	public void setfAcaId(Integer fAcaId) {
		this.fAcaId = fAcaId;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public String getContenExplain() {
		return contenExplain;
	}

	public void setContenExplain(String contenExplain) {
		this.contenExplain = contenExplain;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
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

	public Integer getConId() {
		return conId;
	}

	public void setConId(Integer conId) {
		this.conId = conId;
	}

	public String getConCode() {
		return conCode;
	}

	public void setConCode(String conCode) {
		this.conCode = conCode;
	}

	public String getConName() {
		return conName;
	}

	public void setConName(String conName) {
		this.conName = conName;
	}

	public String getStauts() {
		return stauts;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRegisterCode() {
		return registerCode;
	}

	public void setRegisterCode(String registerCode) {
		this.registerCode = registerCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.userName2=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fuserId=userId;
	}

	@Override
	public String getNextCheckUserId() {
		return fuserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStauts=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		return flowStauts;
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
		return "F_REGISTER_CODE";
	}

	@Override
	public Integer getBeanId() {
		return fMSId;
	}

	@Override
	public String getNextCheckKey() {
		return nCode;
	}

	@Override
	public String getJoinTable() {
		return "T_MONEY_REGISTER";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(getfMSId());
	}

}
