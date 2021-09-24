package com.braker.icontrol.budget.manager.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 指标计划下达表model
 * @author 叶崇晖
 * @createtime 2019-03-14
 * @updatetime 2019-03-14
 */
@Entity
@Table(name = "T_INDEX_RELEASE_PLAN")
public class TIndexReleasePlan extends BaseEntityEmpty {
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer pId;				//主键ID
	
	@Column(name = "F_INDEX_CODE")
	private String indexCode;			//预算指标编码
	
	@Column(name = "F_RELEASE_TIME")
	private Date releaseTime;			//计划下达时间
	
	@Column(name = "F_RELEASE_TYPE")
	private String releaseType;			//指标下达方式1、一次性全部下达2、分批次下达3、定时自动下达(与指标表的对应)
	
	@Column(name = "F_RELEASE_AMOUNT")
	private BigDecimal releaseAmount;		//下达金额
	
	@Column(name = "F_RELEASE_SURPLUS_AMOUNT")
	private BigDecimal releaseSurplusAmount;//下达后剩余金额（为填表的时候当时的剩余金额，只做记录用，不会改变）
	
	@Column(name = "F_TYPE")
	private String type;				//状态(0、未执行	1、已执行)
	
	@Column(name = "F_TRIGGER_NAME")
	private String triggerName;			//保存定时任务的key（用于立即下达完成时删除定时任务用）

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}

	public BigDecimal getReleaseAmount() {
		return releaseAmount;
	}

	public void setReleaseAmount(BigDecimal releaseAmount) {
		this.releaseAmount = releaseAmount;
	}

	public BigDecimal getReleaseSurplusAmount() {
		return releaseSurplusAmount;
	}

	public void setReleaseSurplusAmount(BigDecimal releaseSurplusAmount) {
		this.releaseSurplusAmount = releaseSurplusAmount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getReleaseType() {
		return releaseType;
	}

	public void setReleaseType(String releaseType) {
		this.releaseType = releaseType;
	}

	public String getTriggerName() {
		return triggerName;
	}

	public void setTriggerName(String triggerName) {
		this.triggerName = triggerName;
	}
	
	

	
}
