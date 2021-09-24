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

/**
 * 预算指标管理信息model
 * @author 叶崇晖
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Entity
@Table(name = "T_BUDGET_INDEX_MGR")
public class TBudgetIndexMgr extends BaseEntityEmpty {
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer bId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer FProId;           //项目基本信息的外键
	
	@Column(name = "F_B_INDEX_CODE")
	private String indexCode; 		//预算指标编码
	
	@Column(name = "F_B_INDEX_NAME")
	private String indexName; 		//预算指标名称
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType; 		//指标类型(0-基本指标；1-项目指标；)
	
	@Column(name = "F_EXP_ITEM_NAME")
	private String expItemName; 	//二级分类名称
	
	@Column(name = "F_EXP_ITEM_CODE")
	private String expItemCode; 	//二级分类编码
	
	@Column(name = "F_EXP_ITEM_CODE2")
	private String expItemCode2; 	//支出事项上级编码
	
	@Column(name = "F_DEPT_NAME")
	private String deptName; 		//使用部门名称
	
	@Column(name = "F_DEPT_CODE")
	private String deptCode; 		//使用部门编码
	
	@Column(name = "F_CONTROL_TYPE")
	private String controlType; 	//控制方式(1-刚性控制（不允许超额支出）2-合理范围内控制（在一定范围内允许用户超额支出）)
	
	@Column(name = "F_EXCESS_RANGE")
	private String excessRange; 	//超额范围（万元）
	
	@Column(name = "F_APP_DATE")
	private Date appDate; 			//批复日期
	
	@Column(name = "F_YEARS")
	private String years; 			//预算年度
	
	@Column(name = "F_YS_AMOUNT")
	private BigDecimal ysAmount; 		//指标预算金额（万元）
	
	@Column(name = "F_PFZ_AMOUNT")
	private BigDecimal pfzAmount; 		//指标批复总金额（万元）基本指标用
	
	@Column(name = "F_PF_AMOUNT")
	private BigDecimal pfAmount; 		//指标批复金额（万元）
	
	@Column(name = "F_XD_AMOUNT")
	private BigDecimal xdAmount; 		//指标累计下达金额（万元）
	
	@Column(name = "F_SY_AMOUNT")
	private BigDecimal syAmount; 		//指标可用金额（万元）
	
	@Column(name = "F_DJ_AMOUNT")
	private BigDecimal djAmount; 		//指标冻结金额（万元）
	
	@Column(name = "F_RELEASE_STAUTS")
	private String releaseStauts;	// 0:未下达   1：已下达  指标下达状态0-未生成（新增记录时，默认为0）1-已生成在项目列表二下之后，此指标可进行生成操作，状态更新为1已生成的指标才可以被支出金额！！！
	
	@Column(name = "F_RELEASE_TYPE")
	private String releaseType;		//指标下达方式1、一次性全部下达2、分批次下达3、定时自动下达
	
	@Column(name = "F_STAUTS")
	private String stauts; 			//指标生成状态(0-未生成（新增记录时，默认为0） 1-已生成在项目列表二下之后，此指标可进行生成操作，状态更新为1已生成的指标才可以被支出金额)
	
	@Column(name = "F_GENERATE_TIME")
	private Date generateTime; 		//指标生成时间
	
	@Column(name = "F_SOURCE")
	private String source; 			//预算来源(1、本年预算2、往年预算 )
	
	@Column(name = "F_FUNCTION")
	private String function; 		//功能分类
	
	@Column(name = "F_EXT_1")
	private String fext1; 			//项目ID
	
	@Column(name = "F_PROPERTY")
	private String property; 		//资金性质(0: 财政性资金、1:非财政性资金 )
	
	@Column(name = "F_PRO_CHARGER")
	private String proCharger;		//项目负责人
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private BigDecimal changeAmount;	//指标修改金额（指标内部外部调整时使用）
	
	@Transient
	private BigDecimal xdjd1;			//指标下达进度(查询用)
	
	@Transient
	private BigDecimal xdjd2;			//指标下达进度(查询用)
	
	@Transient
	private String pids;			//选择的指标id串
	
	@Transient
	private String activitys;			//选择的指标名称串
	
	@Column(name = "F_FIRST_AMOUNT")
	private BigDecimal firstAmount;		//年初预算数

	@Column(name = "T_PRO_USE_TYPE")
	private String proUseType;	 //预算使用类型
	
	public String getProUseType() {
		return proUseType;
	}

	public void setProUseType(String proUseType) {
		this.proUseType = proUseType;
	}

	public String getPids() {
		return pids;
	}

	public void setPids(String pids) {
		this.pids = pids;
	}

	public String getActivitys() {
		return activitys;
	}

	public void setActivitys(String activitys) {
		this.activitys = activitys;
	}

	public Integer getFProId() {
		return FProId;
	}

	public void setFProId(Integer fProId) {
		FProId = fProId;
	}

	public Integer getbId() {
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	public String getExpItemName() {
		return expItemName;
	}

	public void setExpItemName(String expItemName) {
		this.expItemName = expItemName;
	}

	public String getExpItemCode() {
		return expItemCode;
	}

	public void setExpItemCode(String expItemCode) {
		this.expItemCode = expItemCode;
	}

	public String getExpItemCode2() {
		return expItemCode2;
	}

	public void setExpItemCode2(String expItemCode2) {
		this.expItemCode2 = expItemCode2;
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

	public String getControlType() {
		return controlType;
	}

	public void setControlType(String controlType) {
		this.controlType = controlType;
	}

	public String getExcessRange() {
		return excessRange;
	}

	public void setExcessRange(String excessRange) {
		this.excessRange = excessRange;
	}

	public Date getAppDate() {
		return appDate;
	}

	public void setAppDate(Date appDate) {
		this.appDate = appDate;
	}

	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}

	public BigDecimal getYsAmount() {
		return ysAmount;
	}

	public void setYsAmount(BigDecimal ysAmount) {
		this.ysAmount = ysAmount;
	}

	
	public BigDecimal getPfzAmount() {
		return pfzAmount;
	}

	public void setPfzAmount(BigDecimal pfzAmount) {
		this.pfzAmount = pfzAmount;
	}

	public BigDecimal getPfAmount() {
		return pfAmount;
	}

	public void setPfAmount(BigDecimal pfAmount) {
		this.pfAmount = pfAmount;
	}
	

	public BigDecimal getXdAmount() {
		return xdAmount;
	}

	public void setXdAmount(BigDecimal xdAmount) {
		this.xdAmount = xdAmount;
	}

	public BigDecimal getSyAmount() {
		return syAmount;
	}

	public void setSyAmount(BigDecimal syAmount) {
		this.syAmount = syAmount;
	}

	public BigDecimal getDjAmount() {
		return djAmount;
	}

	public void setDjAmount(BigDecimal djAmount) {
		this.djAmount = djAmount;
	}

	
	public String getReleaseStauts() {
		return releaseStauts;
	}

	public void setReleaseStauts(String releaseStauts) {
		this.releaseStauts = releaseStauts;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public Date getGenerateTime() {
		return generateTime;
	}

	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getFext1() {
		return fext1;
	}

	public void setFext1(String fext1) {
		this.fext1 = fext1;
	}

	public BigDecimal getChangeAmount() {
		return changeAmount;
	}

	public void setChangeAmount(BigDecimal changeAmount) {
		this.changeAmount = changeAmount;
	}

	public BigDecimal getXdjd1() {
		return xdjd1;
	}

	public void setXdjd1(BigDecimal xdjd1) {
		this.xdjd1 = xdjd1;
	}

	public BigDecimal getXdjd2() {
		return xdjd2;
	}

	public void setXdjd2(BigDecimal xdjd2) {
		this.xdjd2 = xdjd2;
	}

	public String getReleaseType() {
		return releaseType;
	}

	public void setReleaseType(String releaseType) {
		this.releaseType = releaseType;
	}

	public String getProCharger() {
		return proCharger;
	}

	public void setProCharger(String proCharger) {
		this.proCharger = proCharger;
	}

	public BigDecimal getFirstAmount() {
		return firstAmount;
	}

	public void setFirstAmount(BigDecimal firstAmount) {
		this.firstAmount = firstAmount;
	}


}
