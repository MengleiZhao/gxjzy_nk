package com.braker.icontrol.budget.performancemanage.selfeval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 *预算自评结果的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-31
 * @updatetime 2018-08-31
 */
@Entity
@Table(name = "T_BUDGET_RESULT")
public class BudgetResult extends BaseEntityEmpty{
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fbId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;			//外键    项目表的id
	
	@Column(name = "F_PRO_AMOUNT")
	private Double  fproAmount;			//项目总预算
	
	@Column(name = "F_PRO_AMOUNT_YEAR")
	private Double  fproAmountYear;			//本年度预算
	
	@Column(name = "F_PRO_AMOUNT_YEAR_ACTUAL")
	private Double  fproAmountYearActual;			//本年度实际执行数
	
	@Column(name = "F_EXEC_RATE")
	private Double  fexecRate;			//执行率
	
	@Column(name = "F_DEVIATION")
	private Double  fdeviation;			//实际偏差

	@Column(name = "F_DEVIATION_DESC")
	private String  fdeviationDesc;			//偏差原因分析
	
	@Column(name = "F_REMARK")
	private String  fremark;			//备注
	
	@Column(name = "F_USER_NAME")
	private String  fuserName;			//自评负责人
	
	@Column(name = "F_EVAL_TYPE")
	private String  fevalType;			//自评方式
	
	@Column(name = "F_EVAL_TIME")
	private Date  fevalTime;			//自评提交时间

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public Integer getFproId() {
		return fproId;
	}

	public void setFproId(Integer fproId) {
		this.fproId = fproId;
	}

	public Double getFproAmount() {
		return fproAmount;
	}

	public void setFproAmount(Double fproAmount) {
		this.fproAmount = fproAmount;
	}

	public Double getFproAmountYear() {
		return fproAmountYear;
	}

	public void setFproAmountYear(Double fproAmountYear) {
		this.fproAmountYear = fproAmountYear;
	}

	public Double getFproAmountYearActual() {
		return fproAmountYearActual;
	}

	public void setFproAmountYearActual(Double fproAmountYearActual) {
		this.fproAmountYearActual = fproAmountYearActual;
	}

	public Double getFexecRate() {
		return fexecRate;
	}

	public void setFexecRate(Double fexecRate) {
		this.fexecRate = fexecRate;
	}

	public Double getFdeviation() {
		return fdeviation;
	}

	public void setFdeviation(Double fdeviation) {
		this.fdeviation = fdeviation;
	}

	public String getFdeviationDesc() {
		return fdeviationDesc;
	}

	public void setFdeviationDesc(String fdeviationDesc) {
		this.fdeviationDesc = fdeviationDesc;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public String getFuserName() {
		return fuserName;
	}

	public void setFuserName(String fuserName) {
		this.fuserName = fuserName;
	}

	public String getFevalType() {
		return fevalType;
	}

	public void setFevalType(String fevalType) {
		this.fevalType = fevalType;
	}

	public Date getFevalTime() {
		return fevalTime;
	}

	public void setFevalTime(Date fevalTime) {
		this.fevalTime = fevalTime;
	}

	@Override
	public String toString() {
		return "BudgetResult [fbId=" + fbId + ", fproId=" + fproId
				+ ", fproAmount=" + fproAmount + ", fproAmountYear="
				+ fproAmountYear + ", fproAmountYearActual="
				+ fproAmountYearActual + ", fexecRate=" + fexecRate
				+ ", fdeviation=" + fdeviation + ", fdeviationDesc="
				+ fdeviationDesc + ", fremark=" + fremark + ", fuserName="
				+ fuserName + ", fevalType=" + fevalType + ", fevalTime="
				+ fevalTime + "]";
	}

	
	
	
	
	
}
