package com.braker.icontrol.budget.adjust.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.Query;

import com.braker.common.entity.BaseEntityEmpty;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 内部指标调整明细表的model
 * @author 叶崇晖
 * @createtime 2018-07-23
 * @updatetime 2018-07-23
 */
@Entity
@Table(name = "T_INDEX_AD_ITF")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TIndexAdItf extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer iId;			//主键ID
	
	@Column(name = "F_EXP_ID")
	private Integer pid;			//项目支出明细表id
	
	@Column(name = "F_B_ID")
	private Integer bid;			//项目指标表id
	
	@Column(name = "F_IN_ID")
	private Integer inId;			//关联内部指标调整的副键ID
	
	@Column(name = "F_B_INDEX_NAME")
	private String indexName;		//调整项目名称
	
	@Column(name = "F_B_INDEX_CODE")
	private String indexCode;		//调整项目编码
	
	@Column(name = "F_PRO_ACTIVITY")
	private String activity;	//调整指标名称
	
	@Column(name = "F_EXP_CODE")
	private String expCode;	//调整指标编码
	
	@Column(name = "F_PF_AMOUNT")
	private BigDecimal pfAmount;		//指标批复总额
	
	@Column(name = "F_SY_AMOUNT")
	private BigDecimal syAmount;		//指标可用金额
	
	@Column(name = "F_INDEX_AMOUNT_INCR")
	private BigDecimal changeAmount;	//指标调整金额
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;		//指标归口部门（名称）
	
	@Column(name = "F_DEPT_CODE")
	private String deptCode;		//指标归口部门（编码）
	
	@Column(name = "F_EFFEC_TIME")
	private Date effecTime;			//调整生效日期
	
	@Column(name = "F_AD_TYPE")
	private String adType;			//调整类型IN-调入，OUT-调出
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType;		//指标类型 0、基本支出1、项目支出
	
	@Column(name = "F_INDEX_AMOUNT_COUNT")
	private BigDecimal changeAmountCount;	//指标调整金额(用来计算 有正负值)
	
	@Column(name = "T_PRO_USE_TYPE")
	private String proUseType;	 //预算使用类型
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	public String getProUseType() {
		return proUseType;
	}

	public void setProUseType(String proUseType) {
		this.proUseType = proUseType;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getBid() {
		return bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getExpCode() {
		return expCode;
	}

	public void setExpCode(String expCode) {
		this.expCode = expCode;
	}

	public Integer getiId() {
		return iId;
	}

	public void setiId(Integer iId) {
		this.iId = iId;
	}

	public Integer getInId() {
		return inId;
	}

	public void setInId(Integer inId) {
		this.inId = inId;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public BigDecimal getPfAmount() {
		return pfAmount;
	}

	public void setPfAmount(BigDecimal pfAmount) {
		this.pfAmount = pfAmount;
	}

	public BigDecimal getSyAmount() {
		return syAmount;
	}

	public void setSyAmount(BigDecimal syAmount) {
		this.syAmount = syAmount;
	}

	public BigDecimal getChangeAmount() {
		return changeAmount;
	}

	public void setChangeAmount(BigDecimal changeAmount) {
		this.changeAmount = changeAmount;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public Date getEffecTime() {
		return effecTime;
	}

	public void setEffecTime(Date effecTime) {
		this.effecTime = effecTime;
	}

	public String getAdType() {
		return adType;
	}

	public void setAdType(String adType) {
		this.adType = adType;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	@Override
	public String toString() {
		return "TIndexAdItf [iId=" + iId + ", inId=" + inId + ", indexName="
				+ indexName + ", indexCode=" + indexCode + ", pfAmount="
				+ pfAmount + ", syAmount=" + syAmount + ", changeAmount="
				+ changeAmount + ", deptName=" + deptName + ", deptCode="
				+ deptCode + ", effecTime=" + effecTime + ", adType=" + adType
				+ ", indexType=" + indexType + "]";
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public BigDecimal getChangeAmountCount() {
		return changeAmountCount;
	}

	public void setChangeAmountCount(BigDecimal changeAmountCount) {
		this.changeAmountCount = changeAmountCount;
	}
	
	
}
