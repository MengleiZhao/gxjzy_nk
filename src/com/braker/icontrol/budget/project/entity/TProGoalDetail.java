package com.braker.icontrol.budget.project.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.core.model.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "T_PRO_PERF_GOAL_DETAIL")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TProGoalDetail extends BaseEntityEmpty {

	//主键
	private Integer pid;
	//关联目标总表
	private TProGoal goal;
	//中期一级指标名称
	private String midName1;
	//中期一级指标编码
	private String midCode1;
	//中期二级指标名称
	private String midName2;
	//中期二级指标编码
	private String midCode2;
	//中期三级指标名称
	private String midName3;
	//中期三级指标值
	private String midAmount3;
	//长期一级指标名称
	private String longName1;
	//长期一级指标编码
	private String longCode1;
	//长期二级指标名称
	private String longName2;
	//长期二级指标编码
	private String longCode2;
	//长期三级指标名称
	private String longName3;
	//长期三级指标值
	private String longAmount3;
	//创建人
	private User creator;
	//创建时间
	private Date createTime;
	//修改人
	private User updator;
	//修改时间
	private Date updateTime;
	//实际完成指标值  冉
	private Double factFinish;
	//分值   冉
	private Double factGoal;
	//得分  冉
	private Double factScore;
	//未完成原因分析  冉
	private String factRemark;
	
	
	//指标监控  陈睿超
	//当前月执行情况
	private String fmonthRemark;
	//全年预计完成情况
	private String fYearRemark;
	//经费保障偏差原因
	private String fFundingDeviation;
	//制度保障偏差原因
	private String fGuarantee;
	//人员保障偏差原因
	private String fPersonnelProtection;
	//硬件保障偏差目标
	private String fHardwareProtection;
	//其他偏差原因
	private String fOtherProtection;
	//完成目标可能性
	private String fAchieveGoals;
	//偏差原因备注
	private String fProtectionRemark;

	
	
	//transient fields
	private String pageOrder;
	
	//property accessors
	
	@Column(name = "F_ACT_FINISH")
	public Double getFactFinish() {
		return factFinish;
	}
	public void setFactFinish(Double factFinish) {
		this.factFinish = factFinish;
	}
	@Column(name = "F_ACT_GOAL")
	public Double getFactGoal() {
		return factGoal;
	}
	public void setFactGoal(Double factGoal) {
		this.factGoal = factGoal;
	}
	@Column(name = "F_ACT_SCORE")
	public Double getFactScore() {
		return factScore;
	}
	public void setFactScore(Double factScore) {
		this.factScore = factScore;
	}
	@Column(name = "F_ACT_REMARK")
	public String getFactRemark() {
		return factRemark;
	}
	public void setFactRemark(String factRemark) {
		this.factRemark = factRemark;
	}
	
	
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_Z_ID", unique = true, nullable = false)
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	@ManyToOne
	@JoinColumn(name = "F_G_ID")
	public TProGoal getGoal() {
		return goal;
	}
	public void setGoal(TProGoal goal) {
		this.goal = goal;
	}
	@Column(name = "F_M_INDEX_NAME_1")
	public String getMidName1() {
		return midName1;
	}
	public void setMidName1(String midName1) {
		this.midName1 = midName1;
	}
	@Column(name = "F_M_INDEX_CODE_1")
	public String getMidCode1() {
		return midCode1;
	}
	public void setMidCode1(String midCode1) {
		this.midCode1 = midCode1;
	}
	@Column(name = "F_M_INDEX_NAME_2")
	public String getMidName2() {
		return midName2;
	}
	public void setMidName2(String midName2) {
		this.midName2 = midName2;
	}
	@Column(name = "F_M_INDEX_CODE_2")
	public String getMidCode2() {
		return midCode2;
	}
	public void setMidCode2(String midCode2) {
		this.midCode2 = midCode2;
	}
	@Column(name = "F_M_INDEX_NAME_3")
	public String getMidName3() {
		return midName3;
	}
	public void setMidName3(String midName3) {
		this.midName3 = midName3;
	}
	@Column(name = "F_M_INDEX_VAL_3")
	public String getMidAmount3() {
		return midAmount3;
	}
	public void setMidAmount3(String midAmount3) {
		this.midAmount3 = midAmount3;
	}
	@Column(name = "F_L_INDEX_NAME_2")
	public String getLongName2() {
		return longName2;
	}
	public void setLongName2(String longName2) {
		this.longName2 = longName2;
	}
	@Column(name = "F_L_INDEX_CODE_2")
	public String getLongCode2() {
		return longCode2;
	}
	public void setLongCode2(String longCode2) {
		this.longCode2 = longCode2;
	}
	@Column(name = "F_L_INDEX_NAME_3")
	public String getLongName3() {
		return longName3;
	}
	public void setLongName3(String longName3) {
		this.longName3 = longName3;
	}
	@Column(name = "F_L_INDEX_VAL_3")
	public String getLongAmount3() {
		return longAmount3;
	}
	public void setLongAmount3(String longAmount3) {
		this.longAmount3 = longAmount3;
	}
	@ManyToOne
	@JoinColumn(name = "F_CREATE_USER")
	public User getCreator() {
		return creator;
	}
	public void setCreator(User creator) {
		this.creator = creator;
	}
	@Column(name = "F_CREATE_TIME")
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	@ManyToOne
	@JoinColumn(name = "F_UPDATE_USER")
	public User getUpdator() {
		return updator;
	}
	public void setUpdator(User updator) {
		this.updator = updator;
	}
	@Column(name = "F_UPDATE_TIME")
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	@Transient
	public String getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(String pageOrder) {
		this.pageOrder = pageOrder;
	}
	@Column(name ="F_MONTH_REMARK")
	public String getFmonthRemark() {
		return fmonthRemark;
	}
	public void setFmonthRemark(String fmonthRemark) {
		this.fmonthRemark = fmonthRemark;
	}
	@Column(name ="F_YEAR_REMARK")
	public String getfYearRemark() {
		return fYearRemark;
	}
	public void setfYearRemark(String fYearRemark) {
		this.fYearRemark = fYearRemark;
	}
	@Column(name ="F_FUNDING_DEVIATION")
	public String getfFundingDeviation() {
		return fFundingDeviation;
	}
	public void setfFundingDeviation(String fFundingDeviation) {
		this.fFundingDeviation = fFundingDeviation;
	}
	@Column(name ="F_GUARANTEE")
	public String getfGuarantee() {
		return fGuarantee;
	}
	public void setfGuarantee(String fGuarantee) {
		this.fGuarantee = fGuarantee;
	}
	@Column(name ="F_PERSONNEL_PROTECTION")
	public String getfPersonnelProtection() {
		return fPersonnelProtection;
	}
	public void setfPersonnelProtection(String fPersonnelProtection) {
		this.fPersonnelProtection = fPersonnelProtection;
	}
	@Column(name ="F_HARDWARE_PROTECTION")
	public String getfHardwareProtection() {
		return fHardwareProtection;
	}
	public void setfHardwareProtection(String fHardwareProtection) {
		this.fHardwareProtection = fHardwareProtection;
	}
	@Column(name ="F_OTHER_PROTECTION")
	public String getfOtherProtection() {
		return fOtherProtection;
	}
	public void setfOtherProtection(String fOtherProtection) {
		this.fOtherProtection = fOtherProtection;
	}
	@Column(name ="F_ACHIEVE_GOALS")
	public String getfAchieveGoals() {
		return fAchieveGoals;
	}
	public void setfAchieveGoals(String fAchieveGoals) {
		this.fAchieveGoals = fAchieveGoals;
	}
	@Column(name ="F_PROTECTION_REMARK")
	public String getfProtectionRemark() {
		return fProtectionRemark;
	}
	public void setfProtectionRemark(String fProtectionRemark) {
		this.fProtectionRemark = fProtectionRemark;
	}
	@Column(name ="F_L_INDEX_NAME_1")
	public String getLongName1() {
		return longName1;
	}
	public void setLongName1(String longName1) {
		this.longName1 = longName1;
	}
	@Column(name ="F_L_INDEX_CODE_1")
	public String getLongCode1() {
		return longCode1;
	}
	public void setLongCode1(String longCode1) {
		this.longCode1 = longCode1;
	}
	
	
}
