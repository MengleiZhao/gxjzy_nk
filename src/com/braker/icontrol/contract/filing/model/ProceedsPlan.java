package com.braker.icontrol.contract.filing.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntityEmpty;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 收款计划表
 * @author 赵孟雷
 *
 */
@Entity
@Table(name ="T_PROCEEDS_PLAN")
public class ProceedsPlan extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_P_ID")
	private Integer fPId;
	
	@Column(name ="F_CONT_ID")
	private Integer fContId;

	@Column(name ="F_UPT_ID")
	private Integer fUptId;
	
	@Column(name ="F_PROCEEDS_PROPERTY")
	private String fProceedsProperty;//收款性质
	
	@Column(name ="F_PROCEEDS_CONDITION")
	private String fProceedsCondition;//收款条件
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name ="F_PROCEEDS_TIME")
	private Date fProceedsTime;//预计收款时间
	
	@Column (name  ="F_PROCEEDS_AMOUNT")
	private Double fProceedsAmount;//预计收款金额
	
	@Column (name  ="F_PROCEEDS_AMOUNT_SJ")
	private Double fProceedsAmountsj;//实际收款金额
	
	@Column(name ="F_UPDATE_USER")
	private String fUpateUser_R;//修改人
	
	@Column(name ="F_UPDATE_TIME")
	private Date fUpateTime_R ;//修改时间
	
	@Column(name ="F_STAUTS")
	private String fStauts;//收款状态  0或null-未收款,1-已收款
	
	@Column(name ="F_PAY_STAUTS")
	private String payStauts;//收款申请状态      
	
	@Column(name ="F_DATA_TYPE")
	private Integer dataType;//数据类型 0-原合同数据  1-变更合同的数据
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name="F_RECE_TIME")
	private Date fReceTime ;//实际来款日期
	
	@Column(name="F_ACCOUNTANT_NUM")
	private String accountantNum ;//会计凭证号
	
	@Column(name="F_REMARKS")
	private String remarks ;//备注
	
	@Column(name ="F_PRO_ID")
	private Integer proId;//付款信息id 
	
	
	@Transient
	private Integer datenum;//剩余天数
	
	@Transient
	private String fcCode;//合同编号
	
	@Transient
	private String fcTitle;//合同名称
	
	@Transient
	private String fSignName;//对方单位名称
	
	@Transient
	private Double fNotAllAmountL;//未收款金额

	@Transient
	private String fcqyj;//收款性质
	
	
	public String getFcqyj() {
		return fcqyj;
	}

	public void setFcqyj(String fcqyj) {
		this.fcqyj = fcqyj;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public Double getfProceedsAmountsj() {
		return fProceedsAmountsj;
	}

	public void setfProceedsAmountsj(Double fProceedsAmountsj) {
		this.fProceedsAmountsj = fProceedsAmountsj;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getfProceedsProperty() {
		return fProceedsProperty;
	}

	public void setfProceedsProperty(String fProceedsProperty) {
		this.fProceedsProperty = fProceedsProperty;
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

	public String getfSignName() {
		return fSignName;
	}

	public void setfSignName(String fSignName) {
		this.fSignName = fSignName;
	}

	public Date getfReceTime() {
		return fReceTime;
	}

	public void setfReceTime(Date fReceTime) {
		this.fReceTime = fReceTime;
	}

	public String getAccountantNum() {
		return accountantNum;
	}

	public void setAccountantNum(String accountantNum) {
		this.accountantNum = accountantNum;
	}

	public Integer getfPId() {
		return fPId;
	}

	public void setfPId(Integer fPId) {
		this.fPId = fPId;
	}

	public Integer getfContId() {
		return fContId;
	}

	public void setfContId(Integer fContId) {
		this.fContId = fContId;
	}

	public Integer getfUptId() {
		return fUptId;
	}

	public void setfUptId(Integer fUptId) {
		this.fUptId = fUptId;
	}

	public Date getfProceedsTime() {
		return fProceedsTime;
	}

	public void setfProceedsTime(Date fProceedsTime) {
		this.fProceedsTime = fProceedsTime;
	}

	public Double getfProceedsAmount() {
		return fProceedsAmount;
	}

	public void setfProceedsAmount(Double fProceedsAmount) {
		this.fProceedsAmount = fProceedsAmount;
	}

	public String getfUpateUser_R() {
		return fUpateUser_R;
	}

	public void setfUpateUser_R(String fUpateUser_R) {
		this.fUpateUser_R = fUpateUser_R;
	}

	public Date getfUpateTime_R() {
		return fUpateTime_R;
	}

	public void setfUpateTime_R(Date fUpateTime_R) {
		this.fUpateTime_R = fUpateTime_R;
	}

	public String getfStauts() {
		return fStauts;
	}

	public void setfStauts(String fStauts) {
		this.fStauts = fStauts;
	}

	public String getPayStauts() {
		return payStauts;
	}

	public void setPayStauts(String payStauts) {
		this.payStauts = payStauts;
	}

	public Integer getDataType() {
		return dataType;
	}

	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}

	public Integer getDatenum() {
		return datenum;
	}

	public void setDatenum(Integer datenum) {
		this.datenum = datenum;
	}

	public Double getfNotAllAmountL() {
		return fNotAllAmountL;
	}

	public void setfNotAllAmountL(Double fNotAllAmountL) {
		this.fNotAllAmountL = fNotAllAmountL;
	}

	public String getfProceedsCondition() {
		return fProceedsCondition;
	}

	public void setfProceedsCondition(String fProceedsCondition) {
		this.fProceedsCondition = fProceedsCondition;
	}

	@Override
	public String toString() {
		return "ProceedsPlan [fPId=" + fPId + ", fContId=" + fContId
				+ ", fUptId=" + fUptId + ", fProceedsCondition="
				+ fProceedsCondition + ", fProceedsTime=" + fProceedsTime
				+ ", fProceedsAmount=" + fProceedsAmount + ", fUpateUser_R="
				+ fUpateUser_R + ", fUpateTime_R=" + fUpateTime_R
				+ ", fStauts=" + fStauts + ", payStauts=" + payStauts
				+ ", dataType=" + dataType + ", fReceTime=" + fReceTime
				+ ", accountantNum=" + accountantNum + ", datenum=" + datenum
				+ ", fcCode=" + fcCode + ", fcTitle=" + fcTitle
				+ ", fSignName=" + fSignName + ", fNotAllAmountL="
				+ fNotAllAmountL + "]";
	}


}
