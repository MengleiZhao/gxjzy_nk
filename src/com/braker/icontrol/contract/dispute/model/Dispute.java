package com.braker.icontrol.contract.dispute.model;

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
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 * 合同纠纷表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_CONTRACT_DISPUTE")
public class Dispute extends BaseEntity implements EntityDao{

	@Id
	@Column(name ="F_DIS_ID")
	private Integer fDisId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId_D;
	
	@Column (name ="F_REC_USER")
	private String fRecUser;//记录人
	
	@Column(name ="F_REC_TIME")
	private Date fRecTime;//记录时间
	
	@Column(name ="F_DIS_REMARK")
	private String fDisRemark;//争议描述
	
	@ManyToOne
	@JoinColumn(name ="F_DIS_TYPE",referencedColumnName="lookupscode")
	private Lookups fDisType;//解决方式
	
	@Column(name ="F_LAWYER")
	private String fLawyer;//是否外聘律师0-否1-是
	
	@Column(name ="F_DIS_RESULT")
	private String fDisResult;//处理结果
	
	@Column(name ="F_DIS_STATUS")
	private String fDisstatus;//是否删除
	@Transient
	private String fcCode;//合同编号（流水号）
	@Transient
	private String fcTitle;//合同名称
	@Transient
	private String fcAmount;//合同金额小写(万元)（收入、支出用）
	@Transient
	private String fOperator;//申请人
	@Transient
	private String fDeptName;//所属部门
	@Transient
	private Date fReqtIME;//申请时间
	@Transient
	private String fDisputeStatus;//合同纠纷状态 1-有纠纷	 0-没纠纷
	
	@Transient
	private int number;//序号
	@Transient
	private String disType;//解决方式	仲裁：JFJJFS-01 诉讼：JFJJFS-02 其他：JFJJFS-03
	
	
	
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
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

	public String getFcAmount() {
		return fcAmount;
	}

	public void setFcAmount(String fcAmount) {
		this.fcAmount = fcAmount;
	}

	public String getfOperator() {
		return fOperator;
	}

	public void setfOperator(String fOperator) {
		this.fOperator = fOperator;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public Date getfReqtIME() {
		return fReqtIME;
	}

	public void setfReqtIME(Date fReqtIME) {
		this.fReqtIME = fReqtIME;
	}

	public String getfDisputeStatus() {
		return fDisputeStatus;
	}

	public void setfDisputeStatus(String fDisputeStatus) {
		this.fDisputeStatus = fDisputeStatus;
	}

	public String getfDisstatus() {
		return fDisstatus;
	}

	public void setfDisstatus(String fDisstatus) {
		this.fDisstatus = fDisstatus;
	}

	public Integer getfDisId() {
		return fDisId;
	}

	public void setfDisId(Integer fDisId) {
		this.fDisId = fDisId;
	}

	public Integer getfContId_D() {
		return fContId_D;
	}

	public void setfContId_D(Integer fContId_D) {
		this.fContId_D = fContId_D;
	}

	public String getfRecUser() {
		return fRecUser;
	}

	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}

	public Date getfRecTime() {
		return fRecTime;
	}

	public void setfRecTime(Date fRecTime) {
		this.fRecTime = fRecTime;
	}

	public String getfDisRemark() {
		return fDisRemark;
	}

	public void setfDisRemark(String fDisRemark) {
		this.fDisRemark = fDisRemark;
	}

	public String getfDisResult() {
		return fDisResult;
	}

	public void setfDisResult(String fDisResult) {
		this.fDisResult = fDisResult;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_DISPUTE";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fDisId);
	}

	public Lookups getfDisType() {
		return fDisType;
	}

	public void setfDisType(Lookups fDisType) {
		this.fDisType = fDisType;
	}

	public String getfLawyer() {
		return fLawyer;
	}

	public void setfLawyer(String fLawyer) {
		this.fLawyer = fLawyer;
	}

	public String getDisType() {
		if(fDisType!=null){
			return fDisType.getName();
		}
		return disType;
	}

	public void setDisType(String disType) {
		this.disType = disType;
	}

	
	
}
