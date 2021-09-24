package com.braker.icontrol.budget.data.entity;

import java.util.Date;
import java.util.List;

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
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.workflow.entity.TProcessCheck;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 项目基本信息（做数据分析用）
 * @author 陈睿超
 */
@Entity
@Table(name = "t_pro_basic_info_analysis")
@JsonIgnoreProperties(ignoreUnknown = true)
public class AnalysisProBasicInfo extends BaseEntityEmpty implements java.io.Serializable,EntityDao,CheckEntity {

	// Fields
	private Integer FId;//主键
	private Integer FProId;
	private String FProName;//项目名称
	private String FProCode;//项目编号
	private Lookups FProType;//项目类型
	private String FProLibType;//所属库 1：备选库 2：上报库   3：执行中 4：已完结
	private Double FProBudgetAmount;//项目预算金额
	private String FProcurementYn;//是否采购项目
	private Double FProcurementAmount;//采购金额
	private String FProHead;//项目负责人
	private String FProAppliPeople;//项目申报人
	private String FProAppliPeopleId;//项目申报人id
	private String FProAppliDepart;//申报部门
	private String FProAppliDepartId;//申报部门id
	private Date FProAppliTime;//项目申报时间
	private String FContinuousYn;//是否持续性项目
	private String FProAttribute;//项目属性
	private String FProBudgetCycle;//项目预算周期
	private String FProRollingCycle;//项目滚动周期
	private String FProClass;//项目类别
	private String FProNum;//项目序号
	private String FProAccording;//立项依据
	private String FExplain;//实施方案说明
	private String FPerGoal;//项目支出绩效目标
	/*审批状态     0：暂存    11：提交，待审核       -11：已退回（所有流程如驳回，则直接回退至申请人）      19：已审核
	上报库 一上   21：提交，待审核                 -21：已退回（所有流程如驳回，则直接回退至申请人）            29：已审核
	上报库 二上   31：提交，待审核                -31：已退回（所有流程如驳回，则直接回退至申请人）             39：已审核*/
	private String FFlowStauts;//审批状态
	private String FIsExecute;//是否开始执行  判定项目是否进入执行库： 0-未执行（默认为0，当二下发生时变成1，表示项目正式开始执行）1-已执行（当二下的时候，更新该字段为1）
	private String FAccoAttName;//立项依据 附件名称
	private String FPlanAttName;//实施方案 附件名称
	private String updator;
    private Date updateTime=new Date();
	private String creator;
	private Date createTime;
	private Date finishDate;//结项日期
	private String FExt1;//结项说明
	private String FExt2;//项目排序
	private String FExt3;//项目周期
	private String FExt4;//上报状态   10、一上未申报   11、一上已申报    20、二上未申报   21、二上已申报
	private String FExt5;//项目控制数金额状态
	private String FExt6;//项目评审状态   0、未评审 1、待评 2、已通过 -1、已退回
	private String reviewTime;//项目评审时间   年-月-日
	private String FExt7; //项目自评状态  1、已自评
	private String FExt8;
	private String FExt9;
	private String FExt10;
	private String FExt11;//下环节处理编码
	private String FExt12;//一下备注
	private String FProStauts;//结项状态
	private Integer FExportStauts;//报表收报状态 	0:未收报	1:已收报 2:到达预算管理岗，报表收报页面可以查看了
	private Integer FProOrBasic;//预算支出类型     区分基本支出或项目支出：0=基本支出，1=项目支出
	private Integer FAnalysisType;//报表分析时数据类型     1-一上，2-项目评审，3-一下，4-二上，5-二下
	
	
	
	
	//一级分类名称（选择）
	private String firstLevelName;  
	//一级分类代码（选择）
	private String firstLevelCode;
	//二级分类名称（选择）
	private String secondLevelName;
	//二级分类代码（选择）
	private String secondLevelCode;
	//基建属性
	private String baseBuildType;
	//功能分类（传入）
	private String functionType;
	//项目负责人职务
	private String headerJob;
	//项目负责人电话
	private String headerPhone;
	//是否拼盘
	private String isMerge;
	//计划开始执行年份
	private String planStartYear;
	//最新批复年份
	private String lastReplyYear;
	//密级（传入）
	private String secretLevel;
	//保密期限单位
	private String secretDeadlineType;
	//保密期限
	private String secretDeadline;
	//是否横向标识
	private String isOrientation;
	//财政审核状态
	private String finantialReviewStatus;
	//是否标识上报财政库
	private String isReport;
	//部门标识统计
	private String isDepart;
	//项目单位
	private String departName;
	//主管单位及代码
	private String managerDepartCode;
	//采购方式
	private String purchaseWay;
	//审核财拨建议数
	private Double reviewAmount;
	//一上申报数
	private Double commitAmount1;
	//一下控制数
	private Double provideAmount1;
	//一下控制财拨结余数
	private Double leastAmount1;
	//二下批复财拨结余数
	private Double provideLeastAmount2;
	//二上申报数
	private Double commitAmount2;
	//二上报财结余数
	private Double commitLeastAmount2;
	//下环节处理人 姓名
	private String nextAssignerName;
	//下环节处理人 编码
	private String nextAssignerCode;
	//总体目标描述
	private String totalityDescribe;
	
	
	//Transient Fields
	private TProcessCheck checkInfo;
	private String FFlowStautsName;//审批状态名称
	private String sbkLx;//申报库类型 项目申报xmsb审批xmsp台账xmtz(页面跳转参数)
	private Double controlNum;//预算控制数
	private int pageOrder; //页面显示排序
	private String typeName;//项目类型
	//private String proAttributeName;//项目属性
	private String accessoryId;//显示使用附件Id
	private String FStauts;//项目状态1保存99删除
	
	private Date FProAppliTime1;	//查询是使用（申报查询开始时间）
	private Date FProAppliTime2;	//查询是使用（申报查询结束时间）
	
	private Double efficiency1;		//执行进度区间（执行进度区间查询开始）
	private Double efficiency2;		//执行进度区间（执行进度区间查询结束）
	
	private String planStartYear1;		//项目开始执行年份区间（项目开始执行年份区间查询开始）
	private String planStartYear2;		//项目开始执行年份区间（项目开始执行年份区间查询结束）
	
	//保存项目支出明细
	private List<AnalysisProExpendDetail> expendList;
	//保存项目支出计划
	private List<TProPlan> planList;
	//保存项目支出绩效目标
	private TProGoal goal;
	//保存项目支出绩效目标明细
	private List<TProGoalDetail> goalList;
	
	private Double efficiency;//项目执行率(数据库中没有，用于前台)
	private Double syAmount;//剩余金额(数据库中没有，用于前台)
	private Double djAmount;//剩余金额(数据库中没有，用于前台)

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_ID", unique = true, nullable = false)
	public Integer getFId() {
		return FId;
	}

	public void setFId(Integer fId) {
		this.FId = fId;
	}
	
	@Column(name = "F_PRO_ID")
	public Integer getFProId() {
		return this.FProId;
	}

	public void setFProId(Integer FProId) {
		this.FProId = FProId;
	}
	

	@Transient
	public String getTypeName() {
		if (FProType != null) {
			return FProType.getName();
		}
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Column(name = "F_PRO_NAME", length = 100)
	public String getFProName() {
		return this.FProName;
	}

	public void setFProName(String FProName) {
		this.FProName = FProName;
	}

	@Column(name = "F_PRO_CODE", length = 32)
	public String getFProCode() {
		return this.FProCode;
	}

	public void setFProCode(String fProCode) {
		this.FProCode = fProCode;
	}

	@ManyToOne
	@JoinColumn(name = "F_PRO_TYPE",referencedColumnName="lookupscode")
	public Lookups getFProType() {
		return this.FProType;
	}

	public void setFProType(Lookups FProType) {
		this.FProType = FProType;
	}

	@Column(name = "F_PRO_BUDGET_AMOUNT", precision = 22, scale = 0)
	public Double getFProBudgetAmount() {
		return this.FProBudgetAmount;
	}

	public void setFProBudgetAmount(Double FProBudgetAmount) {
		this.FProBudgetAmount = FProBudgetAmount;
	}

	@Column(name ="F_PRO_STAUTS")
	public String getFProStauts() {
		return FProStauts;
	}

	public void setFProStauts(String fProStauts) {
		FProStauts = fProStauts;
	}
	
	@Column(name ="F_EXPORT_STAUTS")
	public Integer getFExportStauts() {
		return FExportStauts;
	}

	public void setFExportStauts(Integer fExportStauts) {
		FExportStauts = fExportStauts;
	}
	
	@Column(name = "F_PROCUREMENT_YN", length = 2)
	public String getFProcurementYn() {
		return this.FProcurementYn;
	}

	public void setFProcurementYn(String FProcurementYn) {
		this.FProcurementYn = FProcurementYn;
	}

	@Column(name = "F_PROCUREMENT_AMOUNT", precision = 22, scale = 0)
	public Double getFProcurementAmount() {
		return this.FProcurementAmount;
	}

	public void setFProcurementAmount(Double FProcurementAmount) {
		this.FProcurementAmount = FProcurementAmount;
	}

	@Column(name = "F_PRO_HEAD", length = 20)
	public String getFProHead() {
		return this.FProHead;
	}

	public void setFProHead(String FProHead) {
		this.FProHead = FProHead;
	}

	@Column(name = "F_PRO_APPLI_PEOPLE", length = 30)
	public String getFProAppliPeople() {
		return this.FProAppliPeople;
	}

	public void setFProAppliPeople(String FProAppliPeople) {
		this.FProAppliPeople = FProAppliPeople;
	}
	
	@Column(name = "F_PRO_APPLI_PEOPLE_ID", length = 50)
	public String getFProAppliPeopleId() {
		return FProAppliPeopleId;
	}

	public void setFProAppliPeopleId(String fProAppliPeopleId) {
		FProAppliPeopleId = fProAppliPeopleId;
	}

	@Column(name = "F_PRO_APPLI_DEPART", length = 50)
	public String getFProAppliDepart() {
		return this.FProAppliDepart;
	}

	public void setFProAppliDepart(String FProAppliDepart) {
		this.FProAppliDepart = FProAppliDepart;
	}

	@Column(name = "F_PRO_APPLI_TIME", length = 19)
	/*@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")*/
	public Date getFProAppliTime() {
		return this.FProAppliTime;
	}

	public void setFProAppliTime(Date FProAppliTime) {
		this.FProAppliTime = FProAppliTime;
	}

	
	@Column(name = "F_TOTALITY_DESCRIBE", length = 200)
	public String getTotalityDescribe() {
		return totalityDescribe;
	}

	public void setTotalityDescribe(String totalityDescribe) {
		this.totalityDescribe = totalityDescribe;
	}

	@Column(name = "F_CONTINUOUS_YN", length = 2)
	public String getFContinuousYn() {
		return this.FContinuousYn;
	}

	public void setFContinuousYn(String FContinuousYn) {
		this.FContinuousYn = FContinuousYn;
	}

	@Column(name = "F_PRO_ATTRIBUTE", length = 20)
	public String getFProAttribute() {
		return this.FProAttribute;
	}

	public void setFProAttribute(String FProAttribute) {
		this.FProAttribute = FProAttribute;
	}

	@Column(name = "F_PRO_BUDGET_CYCLE", length = 20)
	public String getFProBudgetCycle() {
		return this.FProBudgetCycle;
	}

	public void setFProBudgetCycle(String FProBudgetCycle) {
		this.FProBudgetCycle = FProBudgetCycle;
	}

	@Column(name = "F_PRO_ROLLING_CYCLE", length = 20)
	public String getFProRollingCycle() {
		return this.FProRollingCycle;
	}

	public void setFProRollingCycle(String FProRollingCycle) {
		this.FProRollingCycle = FProRollingCycle;
	}

	@Column(name = "F_PRO_CLASS", length = 20)
	public String getFProClass() {
		return this.FProClass;
	}

	public void setFProClass(String FProClass) {
		this.FProClass = FProClass;
	}
	
	@Transient
	public String getFproClassName () {
		if ("1".equals(FProClass)) {
			return "常规性项目";
		} else if ("2".equals(FProClass)) {
			return "一次性跨年项目";
		} else if ("3".equals(FProClass)) {
			return "一次性非跨年项目";
		}
		return "";
	}

	@Column(name = "F_PRO_NUM", length = 20)
	public String getFProNum() {
		return this.FProNum;
	}

	public void setFProNum(String FProNum) {
		this.FProNum = FProNum;
	}

	@Column(name = "F_PRO_ACCORDING", length = 100)
	public String getFProAccording() {
		return this.FProAccording;
	}

	public void setFProAccording(String FProAccording) {
		this.FProAccording = FProAccording;
	}

	@Column(name = "F_EXPLAIN", length = 500)
	public String getFExplain() {
		return this.FExplain;
	}

	public void setFExplain(String FExplain) {
		this.FExplain = FExplain;
	}
	
	@Column(name = "F_PER_GOAL")
	public String getFPerGoal() {
		return FPerGoal;
	}

	public void setFPerGoal(String fPerGoal) {
		FPerGoal = fPerGoal;
	}

	@Column(name = "F_FLOW_STAUTS", length = 2)
	public String getFFlowStauts() {
		return this.FFlowStauts;
	}

	public void setFFlowStauts(String FFlowStauts) {
		this.FFlowStauts = FFlowStauts;
	}

	@Column(name = "F_IS_EXECUTE", length = 2)
	public String getFIsExecute() {
		return FIsExecute;
	}


	public void setFIsExecute(String fIsExecute) {
		FIsExecute = fIsExecute;
	}


	@Column(name = "F_EXT_1", length = 50)
	public String getFExt1() {
		return this.FExt1;
	}

	public void setFExt1(String FExt1) {
		this.FExt1 = FExt1;
	}

	@Column(name = "F_EXT_2", length = 50)
	public String getFExt2() {
		return this.FExt2;
	}

	public void setFExt2(String FExt2) {
		this.FExt2 = FExt2;
	}

	@Column(name = "F_EXT_3", length = 50)
	public String getFExt3() {
		return this.FExt3;
	}

	public void setFExt3(String FExt3) {
		this.FExt3 = FExt3;
	}

	@Column(name = "F_EXT_4", length = 50)
	public String getFExt4() {
		return this.FExt4;
	}

	public void setFExt4(String FExt4) {
		this.FExt4 = FExt4;
	}

	@Column(name = "F_EXT_5", length = 50)
	public String getFExt5() {
		return this.FExt5;
	}

	public void setFExt5(String FExt5) {
		this.FExt5 = FExt5;
	}

	@Column(name = "F_ACCT_ACCO_NAME")
	public String getFAccoAttName() {
		return FAccoAttName;
	}

	public void setFAccoAttName(String fAccoAttName) {
		FAccoAttName = fAccoAttName;
	}

	@Column(name = "F_ACCT_PLAN_NAME")
	public String getFPlanAttName() {
		return FPlanAttName;
	}

	public void setFPlanAttName(String fPlanAttName) {
		FPlanAttName = fPlanAttName;
	}

	@Column(name = "F_UPDATE_USER")
	public String getUpdator() {
		return updator;
	}


	public void setUpdator(String updator) {
		this.updator = updator;
	}

	@Column(name = "F_UPDATE_TIME")
	public Date getUpdateTime() {
		return updateTime;
	}


	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "F_CREATE_USER",updatable=false)
	public String getCreator() {
		return creator;
	}


	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Column(name="F_CREATE_TIME",updatable=false)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Transient
	public TProcessCheck getCheckInfo() {
		return checkInfo;
	}

	public void setCheckInfo(TProcessCheck checkInfo) {
		this.checkInfo = checkInfo;
	}
	
	@Column(name = "F_PRO_LIB_TYPE", length = 2)
	public String getFProLibType() {
		return this.FProLibType;
	}

	public void setFProLibType(String FProLibType) {
		this.FProLibType = FProLibType;
	}

	@Transient
	public String getSbkLx() {
		return sbkLx;
	}

	public void setSbkLx(String sbkLx) {
		this.sbkLx = sbkLx;
	}

	@Transient
	public String getFFlowStautsName() {
		if (!StringUtil.isEmpty(FFlowStauts)) {
			if ("0".equals(FFlowStauts)) {
				return "暂存";
			} else if ("1".equals(FFlowStauts)) {
				return "一级审批";
			} else if ("2".equals(FFlowStauts)) {
				return "二级审批";
			} else if ("3".equals(FFlowStauts)) {
				return "已审批";
			}
		}
		return "";
	}

	public void setFFlowStautsName(String fFlowStautsName) {
		FFlowStautsName = fFlowStautsName;
	}

	@Transient
	public Double getControlNum() {
		return controlNum;
	}

	public void setControlNum(Double controlNum) {
		this.controlNum = controlNum;
	}

	@Transient
	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	@Column(name = "F_FINISH_DATE")
	public Date getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(Date finishDate) {
		this.finishDate = finishDate;
	}

	@Column(name = "F_EXT_6")
	public String getFExt6() {
		return FExt6;
	}

	public void setFExt6(String fExt6) {
		FExt6 = fExt6;
	}

	@Column(name = "F_EXT_7")
	public String getFExt7() {
		return FExt7;
	}

	public void setFExt7(String fExt7) {
		FExt7 = fExt7;
	}

	@Column(name = "F_EXT_8")
	public String getFExt8() {
		return FExt8;
	}

	public void setFExt8(String fExt8) {
		FExt8 = fExt8;
	}

	@Column(name = "F_EXT_9")
	public String getFExt9() {
		return FExt9;
	}

	public void setFExt9(String fExt9) {
		FExt9 = fExt9;
	}

	@Column(name = "F_EXT_10")
	public String getFExt10() {
		return FExt10;
	}

	public void setFExt10(String fExt10) {
		FExt10 = fExt10;
	}

	@Column(name = "F_EXT_11")
	public String getFExt11() {
		return FExt11;
	}

	public void setFExt11(String fExt11) {
		FExt11 = fExt11;
	}
	
	@Column(name = "F_EXT_12")
	public String getFExt12() {
		return FExt12;
	}

	public void setFExt12(String fExt12) {
		FExt12 = fExt12;
	}

	@Column(name = "F_LEV_NAME_1")
	public String getFirstLevelName() {
		return firstLevelName;
	}

	public void setFirstLevelName(String firstLevelName) {
		this.firstLevelName = firstLevelName;
	}

	@Column(name = "F_LEV_CODE_1")
	public String getFirstLevelCode() {
		return firstLevelCode;
	}

	public void setFirstLevelCode(String firstLevelCode) {
		this.firstLevelCode = firstLevelCode;
	}

	@Column(name = "F_LEV_NAME_2")
	public String getSecondLevelName() {
		return secondLevelName;
	}

	public void setSecondLevelName(String secondLevelName) {
		this.secondLevelName = secondLevelName;
	}

	@Column(name = "F_LEV_CODE_2")
	public String getSecondLevelCode() {
		return secondLevelCode;
	}

	public void setSecondLevelCode(String secondLevelCode) {
		this.secondLevelCode = secondLevelCode;
	}

	@Column(name = "F_INFRAST_PROPERTY")
	public String getBaseBuildType() {
		return baseBuildType;
	}

	public void setBaseBuildType(String baseBuildType) {
		this.baseBuildType = baseBuildType;
	}

	@Column(name = "F_FUNCTION_CLASS")
	public String getFunctionType() {
		return functionType;
	}

	public void setFunctionType(String functionType) {
		this.functionType = functionType;
	}

	@Column(name = "F_PRO_HEAD_JOB")
	public String getHeaderJob() {
		return headerJob;
	}

	public void setHeaderJob(String headerJob) {
		this.headerJob = headerJob;
	}

	@Column(name = "F_PRO_HEAD_TEL")
	public String getHeaderPhone() {
		return headerPhone;
	}

	public void setHeaderPhone(String headerPhone) {
		this.headerPhone = headerPhone;
	}

	@Column(name = "F_IS_MERGE")
	public String getIsMerge() {
		return isMerge;
	}

	public void setIsMerge(String isMerge) {
		this.isMerge = isMerge;
	}

	@Column(name = "F_START_YEAR_PLAN")
	public String getPlanStartYear() {
		return planStartYear;
	}

	public void setPlanStartYear(String planStartYear) {
		this.planStartYear = planStartYear;
	}

	@Column(name = "F_PF_YEAR")
	public String getLastReplyYear() {
		return lastReplyYear;
	}

	public void setLastReplyYear(String lastReplyYear) {
		this.lastReplyYear = lastReplyYear;
	}

	@Column(name = "F_SECRECY_GRADE")
	public String getSecretLevel() {
		return secretLevel;
	}

	public void setSecretLevel(String secretLevel) {
		this.secretLevel = secretLevel;
	}

	@Column(name = "F_SECRECY_TYPE")
	public String getSecretDeadlineType() {
		return secretDeadlineType;
	}

	public void setSecretDeadlineType(String secretDeadlineType) {
		this.secretDeadlineType = secretDeadlineType;
	}

	@Column(name = "F_SECRECY_TIME")
	public String getSecretDeadline() {
		return secretDeadline;
	}

	public void setSecretDeadline(String secretDeadline) {
		this.secretDeadline = secretDeadline;
	}

	@Column(name = "F_IS_HX")
	public String getIsOrientation() {
		return isOrientation;
	}

	public void setIsOrientation(String isOrientation) {
		this.isOrientation = isOrientation;
	}

	@Column(name = "F_CZB_RESULT")
	public String getFinantialReviewStatus() {
		return finantialReviewStatus;
	}

	public void setFinantialReviewStatus(String finantialReviewStatus) {
		this.finantialReviewStatus = finantialReviewStatus;
	}

	@Column(name = "F_IS_REPORT")
	public String getIsReport() {
		return isReport;
	}

	public void setIsReport(String isReport) {
		this.isReport = isReport;
	}

	@Column(name = "F_IS_DEPT")
	public String getIsDepart() {
		return isDepart;
	}

	public void setIsDepart(String isDepart) {
		this.isDepart = isDepart;
	}

	@Column(name = "F_PRO_DEPT")
	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	@Column(name = "F_MGR_DEPT_CODE")
	public String getManagerDepartCode() {
		return managerDepartCode;
	}

	public void setManagerDepartCode(String managerDepartCode) {
		this.managerDepartCode = managerDepartCode;
	}

	@Column(name = "F_PROCUREMENT_TYPE")
	public String getPurchaseWay() {
		return purchaseWay;
	}

	public void setPurchaseWay(String purchaseWay) {
		this.purchaseWay = purchaseWay;
	}

	@Column(name = "F_AUDIT_PROP")
	public Double getReviewAmount() {
		return reviewAmount;
	}

	public void setReviewAmount(Double reviewAmount) {
		this.reviewAmount = reviewAmount;
	}

	@Column(name = "F_CB_1")
	public Double getCommitAmount1() {
		return commitAmount1;
	}

	public void setCommitAmount1(Double commitAmount1) {
		this.commitAmount1 = commitAmount1;
	}

	@Column(name = "F_KZCB_1")
	public Double getProvideAmount1() {
		return provideAmount1;
	}

	public void setProvideAmount1(Double provideAmount1) {
		this.provideAmount1 = provideAmount1;
	}

	@Column(name = "F_KZCB_JY_1")
	public Double getLeastAmount1() {
		return leastAmount1;
	}

	public void setLeastAmount1(Double leastAmount1) {
		this.leastAmount1 = leastAmount1;
	}

	@Column(name = "F_RP_CB_JY_2")
	public Double getProvideLeastAmount2() {
		return provideLeastAmount2;
	}

	public void setProvideLeastAmount2(Double provideLeastAmount2) {
		this.provideLeastAmount2 = provideLeastAmount2;
	}

	@Column(name = "F_CB_2")
	public Double getCommitAmount2() {
		return commitAmount2;
	}

	public void setCommitAmount2(Double commitAmount2) {
		this.commitAmount2 = commitAmount2;
	}

	@Column(name = "F_CB_JY_2")
	public Double getCommitLeastAmount2() {
		return commitLeastAmount2;
	}

	public void setCommitLeastAmount2(Double commitLeastAmount2) {
		this.commitLeastAmount2 = commitLeastAmount2;
	}

	@Column(name = "F_USER_NAME")
	public String getNextAssignerName() {
		return nextAssignerName;
	}

	public void setNextAssignerName(String nextAssignerName) {
		this.nextAssignerName = nextAssignerName;
	}

	@Column(name = "F_USER_CODE")
	public String getNextAssignerCode() {
		return nextAssignerCode;
	}

	public void setNextAssignerCode(String nextAssignerCode) {
		this.nextAssignerCode = nextAssignerCode;
	}
	
	
	@Transient
	public Double getDjAmount() {
		return djAmount;
	}

	public void setDjAmount(Double djAmount) {
		this.djAmount = djAmount;
	}

	@Transient
	public List<AnalysisProExpendDetail> getExpendList() {
		return expendList;
	}

	public void setExpendList(List<AnalysisProExpendDetail> expendList) {
		this.expendList = expendList;
	}

	@Transient
	public List<TProPlan> getPlanList() {
		return planList;
	}

	public void setPlanList(List<TProPlan> planList) {
		this.planList = planList;
	}

	@Transient
	public TProGoal getGoal() {
		return goal;
	}

	public void setGoal(TProGoal goal) {
		this.goal = goal;
	}

	@Transient
	public List<TProGoalDetail> getGoalList() {
		return goalList;
	}

	public void setGoalList(List<TProGoalDetail> goalList) {
		this.goalList = goalList;
	}

	
	@Column(name = "F_STAUTS")
	public String getFStauts() {
		return FStauts;
	}

	public void setFStauts(String FStauts) {
		this.FStauts = FStauts;
	}
	@Transient
	public Date getFProAppliTime1() {
		return FProAppliTime1;
	}

	public void setFProAppliTime1(Date fProAppliTime1) {
		FProAppliTime1 = fProAppliTime1;
	}
	@Transient
	public Date getFProAppliTime2() {
		return FProAppliTime2;
	}

	public void setFProAppliTime2(Date fProAppliTime2) {
		FProAppliTime2 = fProAppliTime2;
	}

	@Override
	@Transient
	public String getJoinTable() {
		return "t_pro_basic_info";
	}

	@Override
	@Transient
	public String getEntryId() {
		return String.valueOf(FProId);
	}

	@Transient
	public Double getEfficiency() {
		return efficiency;
	}

	public void setEfficiency(Double efficiency) {
		this.efficiency = efficiency;
	}

	
	@Column(name ="F_PRO_APPLI_DEPART_ID")
	public String getFProAppliDepartId() {
		return FProAppliDepartId;
	}

	public void setFProAppliDepartId(String fProAppliDepartId) {
		FProAppliDepartId = fProAppliDepartId;
	}

	@Transient
	public Double getEfficiency1() {
		return efficiency1;
	}

	public void setEfficiency1(Double efficiency1) {
		this.efficiency1 = efficiency1;
	}

	@Transient
	public Double getEfficiency2() {
		return efficiency2;
	}

	public void setEfficiency2(Double efficiency2) {
		this.efficiency2 = efficiency2;
	}
	@Transient
	public String getPlanStartYear1() {
		return planStartYear1;
	}

	public void setPlanStartYear1(String planStartYear1) {
		this.planStartYear1 = planStartYear1;
	}
	@Transient
	public String getPlanStartYear2() {
		return planStartYear2;
	}

	public void setPlanStartYear2(String planStartYear2) {
		this.planStartYear2 = planStartYear2;
	}
	
	@Column( name = "F_ANALYSIS_TYPE")
	public Integer getFAnalysisType() {
		return FAnalysisType;
	}

	public void setFAnalysisType(Integer fAnalysisType) {
		FAnalysisType = fAnalysisType;
	}

	@Override
	@Transient
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.nextAssignerName=userName;
	}
	@Override
	@Transient
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.nextAssignerCode=userId;
	}
	@Override
	@Transient
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.FExt11=nCode;
	}
	@Override
	@Transient
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.FFlowStauts=checkStatus;
	}

	@Override
	@Transient
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return FFlowStauts;
	}
	
	@Override
	@Transient
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return FProCode;
	}
	@Override
	@Transient
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return FProId;
	}
	
	@Override
	@Transient
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return FExt11;
	}

	@Override
	@Transient
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	@Transient
	public String getUserId() {
		// TODO Auto-generated method stub
		return FProAppliPeopleId;
	}
	@Transient
	public Double getSyAmount() {
		return syAmount;
	}

	public void setSyAmount(Double syAmount) {
		this.syAmount = syAmount;
	}

	@Override
	@Transient
	public void setStauts(String status) {
		this.FExt4=status;
		// TODO Auto-generated method stub
		
	}

	@Override
	@Transient
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_PRO_CODE";
	}

	@Override
	@Transient
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return nextAssignerCode;
	}

	@Column(name ="PROORBASIC")
	public Integer getFProOrBasic() {
		return FProOrBasic;
	}

	public void setFProOrBasic(Integer fProOrBasic) {
		FProOrBasic = fProOrBasic;
	}
	@Column(name ="F_REVIEW_TIME")
	public String getReviewTime() {
		return reviewTime;
	}

	public void setReviewTime(String reviewTime) {
		this.reviewTime = reviewTime;
	}

	@Transient
	public String getAccessoryId() {
		return accessoryId;
	}

	public void setAccessoryId(String accessoryId) {
		this.accessoryId = accessoryId;
	}

	
	
}