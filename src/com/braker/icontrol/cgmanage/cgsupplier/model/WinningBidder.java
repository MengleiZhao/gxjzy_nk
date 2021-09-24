package com.braker.icontrol.cgmanage.cgsupplier.model;

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
import com.braker.core.model.Lookups;

/**
 * 供应商的model
 * @author 冉德茂
 * @createtime 2018-09-10
 * @updatetime 2020-12-11
 */

@Entity
@Table(name="T_WINNING_BIDDER")
public class WinningBidder extends BaseEntity implements CheckEntity{
	
	@Id
	@Column(name = "F_W_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   
	private Integer fwId;							//主键ID
	
	@Column(name = "F_P_ID")							
	private Integer fpabId;							//外键ID  PurchaseApplyBasic (F_P_ID);
	
	@Column(name = "F_B_ID")	
	private Integer fbId;							//外键ID  BiddingRegist的主键ID
	
	@Column(name = "F_W_NAME")
	private String fwName;							//供应商名称
	
	@Column(name = "F_W_CODE")
	private String fwCode;							//供应商编码
	
	@Column(name = "F_W_NAME_SHORT")
	private String fwNameShort;						//供应商简称
	
	@Column(name = "F_INDUSTRY")
	private String findustry;						//行业
	
	@ManyToOne
	@JoinColumn(name = "F_COMPANY_SIZE",referencedColumnName="lookupscode")
	private Lookups fcompanySize;          			//公司规模
	
	@ManyToOne
	@JoinColumn(name = "F_COMPANY_NATURE",referencedColumnName="lookupscode")
	private Lookups fcompanyNature;          		//公司性质
	
	@Column(name = "F_LEGAL_REP")
	private String fLegalRep;						//法人代表
	
	@Column(name = "F_ESTABLISH_DATE")
	private Date festablistDate;					//成立日期
	
	@Column(name = "F_REGIST_CAPITAL")
	private String fregistCapital;					//注册资本
	
	@Column(name = "F_REGIST_NUMBER")
	private String fregistNumber;					//工商登记号
	
	@Column(name = "F_BUSINESS_SCOPE")
	private String fbusinessScope;					//经营范围
	
	@Column(name = "F_W_ADDR")
	private String fwAddr;							//公司所在地
	
	@Column(name = "F_USER_NAME")
	private String fwuserName;						//联系人
	
	@Column(name = "F_TEL")
	private String fwTel;							//联系电话
	
	@Column(name = "F_STORAGE_TEL")
	private String fwStorageTel;					//固定电话
	
	@Column(name = "F_LAST_DEAL_TIME")
	private Date flastDealTime;						//最近一次成交时间   6.3改为成交日期
	
	@Column(name = "F_DEAL_AMOUNT")
	private Double dealAmount;						//成交金额
	
	@Column(name = "F_FLOAT_AMOUNT")
	private Double floatAmount;						//可浮动金额
	
	@Column(name = "F_REMARK")
	private String fwRemark;						//备注
	
	@Column(name = "F_PAYEE_NAME")
	private String fpayeeName;						//收款人
	
	@Column(name = "F_PAYEE_IDCARD")
	private String fpayeeIdCard;					//收款人身份证
	
	@Column(name = "F_PAYEE_BANK")
	private String fpayeeBank;						//开户行
	
	@Column(name = "F_PAYEE_ACCOUNT")
	private String fpayeeAccount;					//收款账号

	@Column(name = "F_STAUTS")
	private String fstauts;							//数据状态  99：删除 ，1：默认，2：出库
	
	@Column(name = "F_CHECK_TYPE")
	private String fcheckType;						//数据审批类型   in：入库；out：出库；black：黑名单
	
	@Column(name ="F_EXT_3")
	private String fisOutStatus;					//出库审批状态
	
	@Column(name ="F_OUT_TIME")
	private Date foutTime;							//出库时间
	
	@Column(name ="F_OUT_MSG")
	private String foutMsg;							//出库原因描述
	
	@Column(name = "F_IS_BLACK")
	private String fisBlack;						//是否黑名单
	
	@Column(name ="F_EXT_2")
	private String fisBlackStatus;					//黑名单审批状态
	
	@Column(name = "F_BLACK_TIME")
	private Date fblackTime;						//移入黑名单时间
	
	@Column(name = "F_ACC_FREQ")
	private Integer faccFreq;						//累计移入黑名单次数
	
	@Column(name = "F_BLACK_DESC")
	private String fblackDesc;						//移入黑名单原因描述
	
	@Column(name = "F_OP_NAME")
	private String fopName;							//操作人
	
	@Column(name = "F_CHECK_STAUTS")
	private String fcheckStauts;					//供应商审批状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;						//下环节处理人姓名
	
	@Column(name = "F_USER_CODE")
	private String fuserId;							//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;							//下节点节点编码
	
	@Column(name ="F_REC_USER")
	private String fRecUser;						//申請人
	
	@Column(name ="F_EXT_1")
	private String fRecUserId;						//申请人id
	
	@Column(name ="F_REC_DEPT")
	private String fRecDept;						//申请部门
	
	@Column(name ="F_REC_DEPT_ID")
	private String fRecDeptId;						//申请部门编码
	
	@Column(name ="F_REQ_TIME")
	private Date fRecTime;							//申请时间
	
	
	
	public String getFwStorageTel() {
		return fwStorageTel;
	}

	public void setFwStorageTel(String fwStorageTel) {
		this.fwStorageTel = fwStorageTel;
	}

	public Double getDealAmount() {
		return dealAmount;
	}

	public void setDealAmount(Double dealAmount) {
		this.dealAmount = dealAmount;
	}

	public Double getFloatAmount() {
		return floatAmount;
	}

	public void setFloatAmount(Double floatAmount) {
		this.floatAmount = floatAmount;
	}

	@Transient
	private Integer num;							//序号(数据库中没有)
	
	@Transient
	private String  companysize;					//公司规模
	
	@Transient
	private String  companynature;					//公司性质
	
	@Transient
	private String  fpId;							//采购id
	
	
	public String getFcheckType() {
		return fcheckType;
	}

	public void setFcheckType(String fcheckType) {
		this.fcheckType = fcheckType;
	}

	public String getFpId() {
		return fpId;
	}


	public void setFpId(String fpId) {
		this.fpId = fpId;
	}


	public String getCompanysize() {
		if (fcompanySize != null) {
			return fcompanySize.getName();
		}
		return companysize;
	}

	public void setCompanysize(String companysize) {
		this.companysize = companysize;
	}
	
	public String getFisBlackStatus() {
		return fisBlackStatus;
	}


	public void setFisBlackStatus(String fisBlackStatus) {
		this.fisBlackStatus = fisBlackStatus;
	}
	
	
	public String getCompanynature() {
		if (fcompanyNature != null) {
			return fcompanyNature.getName();
		}
		return companynature;
	}


	public void setCompanynature(String companynature) {
		this.companynature = companynature;
	}


	public Integer getFwId() {
		return fwId;
	}


	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}


	public String getFwName() {
		return fwName;
	}


	public void setFwName(String fwName) {
		this.fwName = fwName;
	}


	public String getFwCode() {
		return fwCode;
	}


	public void setFwCode(String fwCode) {
		this.fwCode = fwCode;
	}


	public String getFwNameShort() {
		return fwNameShort;
	}


	public void setFwNameShort(String fwNameShort) {
		this.fwNameShort = fwNameShort;
	}


	public String getFindustry() {
		return findustry;
	}


	public void setFindustry(String findustry) {
		this.findustry = findustry;
	}


	public Lookups getFcompanySize() {
		return fcompanySize;
	}


	public void setFcompanySize(Lookups fcompanySize) {
		this.fcompanySize = fcompanySize;
	}


	public Lookups getFcompanyNature() {
		return fcompanyNature;
	}


	public void setFcompanyNature(Lookups fcompanyNature) {
		this.fcompanyNature = fcompanyNature;
	}


	public String getfLegalRep() {
		return fLegalRep;
	}


	public void setfLegalRep(String fLegalRep) {
		this.fLegalRep = fLegalRep;
	}


	public Date getFestablistDate() {
		return festablistDate;
	}


	public void setFestablistDate(Date festablistDate) {
		this.festablistDate = festablistDate;
	}


	public String getFregistCapital() {
		return fregistCapital;
	}


	public void setFregistCapital(String fregistCapital) {
		this.fregistCapital = fregistCapital;
	}


	public String getFregistNumber() {
		return fregistNumber;
	}


	public void setFregistNumber(String fregistNumber) {
		this.fregistNumber = fregistNumber;
	}


	public String getFbusinessScope() {
		return fbusinessScope;
	}


	public void setFbusinessScope(String fbusinessScope) {
		this.fbusinessScope = fbusinessScope;
	}


	public String getFwAddr() {
		return fwAddr;
	}


	public void setFwAddr(String fwAddr) {
		this.fwAddr = fwAddr;
	}


	public String getFwuserName() {
		return fwuserName;
	}


	public void setFwuserName(String fwuserName) {
		this.fwuserName = fwuserName;
	}


	public String getFwTel() {
		return fwTel;
	}


	public void setFwTel(String fwTel) {
		this.fwTel = fwTel;
	}


	public Date getFlastDealTime() {
		return flastDealTime;
	}


	public void setFlastDealTime(Date flastDealTime) {
		this.flastDealTime = flastDealTime;
	}


	public String getFwRemark() {
		return fwRemark;
	}


	public void setFwRemark(String fwRemark) {
		this.fwRemark = fwRemark;
	}


	public String getFpayeeName() {
		return fpayeeName;
	}


	public void setFpayeeName(String fpayeeName) {
		this.fpayeeName = fpayeeName;
	}


	public String getFpayeeIdCard() {
		return fpayeeIdCard;
	}


	public void setFpayeeIdCard(String fpayeeIdCard) {
		this.fpayeeIdCard = fpayeeIdCard;
	}


	public String getFpayeeBank() {
		return fpayeeBank;
	}


	public void setFpayeeBank(String fpayeeBank) {
		this.fpayeeBank = fpayeeBank;
	}


	public String getFpayeeAccount() {
		return fpayeeAccount;
	}


	public void setFpayeeAccount(String fpayeeAccount) {
		this.fpayeeAccount = fpayeeAccount;
	}


	public String getFstauts() {
		return fstauts;
	}


	public void setFstauts(String fstauts) {
		this.fstauts = fstauts;
	}


	public String getFisBlack() {
		return fisBlack;
	}


	public void setFisBlack(String fisBlack) {
		this.fisBlack = fisBlack;
	}


	public Date getFblackTime() {
		return fblackTime;
	}


	public void setFblackTime(Date fblackTime) {
		this.fblackTime = fblackTime;
	}

	public String getFisOutStatus() {
		return fisOutStatus;
	}


	public void setFisOutStatus(String fisOutStatus) {
		this.fisOutStatus = fisOutStatus;
	}


	public Date getFoutTime() {
		return foutTime;
	}


	public void setFoutTime(Date foutTime) {
		this.foutTime = foutTime;
	}


	public String getFoutMsg() {
		return foutMsg;
	}


	public void setFoutMsg(String foutMsg) {
		this.foutMsg = foutMsg;
	}


	public Integer getFaccFreq() {
		return faccFreq;
	}


	public void setFaccFreq(Integer faccFreq) {
		this.faccFreq = faccFreq;
	}


	public String getFblackDesc() {
		return fblackDesc;
	}


	public void setFblackDesc(String fblackDesc) {
		this.fblackDesc = fblackDesc;
	}


	public String getFopName() {
		return fopName;
	}


	public void setFopName(String fopName) {
		this.fopName = fopName;
	}


	public String getFcheckStauts() {
		return fcheckStauts;
	}


	public void setFcheckStauts(String fcheckStauts) {
		this.fcheckStauts = fcheckStauts;
	}


	public String getFuserId() {
		return fuserId;
	}


	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}


	public Integer getNum() {
		return num;
	}


	public void setNum(Integer num) {
		this.num = num;
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


	public String getfRecUser() {
		return fRecUser;
	}


	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}


	public String getfRecDept() {
		return fRecDept;
	}


	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}


	public Date getfRecTime() {
		return fRecTime;
	}


	public void setfRecTime(Date fRecTime) {
		this.fRecTime = fRecTime;
	}


	public String getfRecDeptId() {
		return fRecDeptId;
	}


	public void setfRecDeptId(String fRecDeptId) {
		this.fRecDeptId = fRecDeptId;
	}


	public String getfRecUserId() {
		return fRecUserId;
	}


	public void setfRecUserId(String fRecUserId) {
		this.fRecUserId = fRecUserId;
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
		this.fcheckStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fcheckStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fstauts=status;
	}
	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fwCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fwId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fRecUserId;
	}
	@Override
	public String getJoinTable() {
		return "T_WINNING_BIDDER";
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_W_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	public Integer getFpabId() {
		return fpabId;
	}

	public void setFpabId(Integer fpabId) {
		this.fpabId = fpabId;
	}

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}
	
	

}
