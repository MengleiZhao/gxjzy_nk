package com.braker.icontrol.budget.manager.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.User;

/**
 * 预算指标下达流水表model
 * @author 叶崇晖
 * @createtime 2018-10-09
 * @updatetime 2018-10-09
 */
@Entity
@Table(name = "T_BUDGET_INDEX_DETAIL")
public class TBudgetIndexDetail extends BaseEntityEmpty {
	@Id
	@Column(name = "F_D_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer dId;			//主键ID
	
	@Column(name = "F_B_ID")
	private Integer bId; 			//关联预算指标管理的副键
	
	@Column(name = "F_RELEASE_TIME")
	private Date releaseTime; 		//指标下达时间
	
	@Column(name = "F_RELEASE_TYPE")
	private String releaseType;		//指标下达方式1、一次性全部下达2、分批次下达3、定时自动下达(与指标表的对应)
	
	@Column(name = "F_RELEASE_USER")
	private String releaseUser;		//指标下达人
	
	@Column(name = "F_BC_RELEASE_AMOUNT")
	private BigDecimal bcReleaseAmount;	//本次下达金额
	
	@Transient
	private String indexName;		//执行事项名称(指标名称)
	
	@Transient
	private String releaseDepart;	//下达人部门
	
	@Transient
	private String releaseUserName;		//指标下达人姓名前台用
	
	@Transient
	private BigDecimal amount;			//金额
	
	
	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}

	public Integer getbId() {
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
	}

	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}

	public String getReleaseUser() {
		return releaseUser;
	}

	public void setReleaseUser(String releaseUser) {
		this.releaseUser = releaseUser;
	}

	public BigDecimal getBcReleaseAmount() {
		return bcReleaseAmount;
	}

	public void setBcReleaseAmount(BigDecimal bcReleaseAmount) {
		this.bcReleaseAmount = bcReleaseAmount;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getReleaseDepart() {
		return releaseDepart;
	}

	public void setReleaseDepart(String releaseDepart) {
		this.releaseDepart = releaseDepart;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getReleaseType() {
		return releaseType;
	}

	public void setReleaseType(String releaseType) {
		this.releaseType = releaseType;
	}

	public String getReleaseUserName() {
		return releaseUserName;
	}

	public void setReleaseUserName(String releaseUserName) {
		this.releaseUserName = releaseUserName;
	}
	
	
}
