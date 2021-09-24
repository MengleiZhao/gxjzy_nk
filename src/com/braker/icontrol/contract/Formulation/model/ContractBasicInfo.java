package com.braker.icontrol.contract.Formulation.model;

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
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 * 合同基本信息表
 * @author 陈睿超
 *
 */
@Entity
@Table(name = "T_CONTRACT_BASIC_INFO")
public class ContractBasicInfo extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_CONT_ID")
	private Integer fcId;
	
	@Column(name ="F_CONT_CODE")
	private String fcCode;//合同编号（流水号）
	
	@Column(name = "F_CONT_TYPE")
	private String fcType;//合同分类
	
	@Column(name = "F_CONT_TYPE_NAME")
	private String fcTypeName;//合同分类名称
	
	@Column(name="F_CONT_TITLE")
	private String fcTitle;//合同名称
	
	@Column(name ="F_CONT_NUM")
	private String fcNum;//合同份数
	
	@Column(name ="F_CONTRACTOR")
	private String fContractor;//签约方名称
	
	@ManyToOne
	@JoinColumn(name ="F_CONT_STYLE",referencedColumnName ="lookupscode")
	private Lookups fContStyle;//合同形式  1.政府标准合同 2.本单位范本合同 3.部门拟制合同 4.对方拟制合同
	
	@Transient
	private String contstyle;//合同形式（显示用）1.政府标准合同 2.本单位范本合同 3.部门拟制合同 4.对方拟制合同
	
	@Column(name = "F_CONT_AMOUNT_MAX")
	private String fcAmountMax;//合同金额大写(万元)（收入、支出用）

	@Column(name = "F_AMOUNT")
	private String fcAmount;//合同金额小写(万元)（收入、支出用）
	
	@Column(name = "F_TOTALAMOUNT")
	private String totalAmount;//汇总金额
	
	@ManyToOne
	@JoinColumn(name ="F_PAYTYPE",referencedColumnName="lookupscode")
	private Lookups fPayType;//付款方式 1.支票 2.电汇 3.银行转账 4.其他
	
	@Transient
	private String payType;//付款方式（显示用）1.支票 2.电汇 3.银行转账 4.其他
	
	@Column(name ="F_PURCH_NAME")
	private String fPurchName;//采购订单名称
	
	@Column(name ="F_PURCH_NO")
	private String fPurchNo;//采购订单ID（支出用）
	
	@Column(name ="F_BUDGET_INDEX_CODE")
	private Integer fBudgetIndexCode;//预算指标ID（支出用）
	
	@Column(name ="F_BUDGET_INDEX_NAME")
	private String fBudgetIndexName;//预算指标名称（支出用）
	
	@Column(name = "F_PRO_DETAIL_ID")
	private Integer proDetailId;	//项目支出明细id
	
	@Column(name ="F_AVAILABLE_AMOUNT")
	private String fAvailableAmount;//指标可用金额（支出用）
	
	@Column(name ="F_INDEX_TYPE")
	private String indexType;//指标类型（支出用）
	
	@Column(name = "F_OPERATOR")
	private String fOperator;//申请人
	
	@Column(name ="F_OPERATOR_ID")
	private String fOperatorId;//申请人id

	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//所属部门
	
	@Column(name ="F_DEPT_ID")
	private String fDeptId;//所属部门
	
	@Column(name = "F_REQ_TIME")
	private Date fReqtIME;//申请时间
	
	@Column(name="F_REMARK")
	private String fRemark;//合同说明
	
	@Column(name= "F_CONT_START_TIME")
	private Date fContStartTime;// 合同开始时间
	
	@Column(name ="F_CONT_END_TIME")
	private Date fContEndTime;//合同结束时间
	
	@Column(name ="F_SIGN_USER")
	private String fSignUser;//合同签署人
	
	@Column(name ="F_SIGN_TIME")
	private Date fSignTime;//合同签署时间
	
	@Column(name ="F_MARGIN_AMOUNT")
	private String fMarginAmount;//保证金金额（元）
	
	@Column(name ="F_IS_AUTHOR")
	private String fIsAuthor;//是否委托授权
	
	@Column(name ="F_WARRANTY_PERIOD")
	private String fWarrantyPeriod;//质保期
	
	@Column(name ="F_FLOW_STAUTS")
	private String fFlowStauts;//审批状态 -1-已退回,0-暂存,1-待审批,9-已审批'
	
	@Column(name ="F_CONT_STAUTS")
	private String fContStauts;//合同状态 	-1-已终止		1-拟定	3-已结项	9-备案	99-删除

	@Column(name ="F_UPDATE_STATUS")
	private String fUpdateStatus;//合同变更状态 1-已变更 0-未变更 2-变更中	 2020.02.17陈睿超加

	@Column(name ="F_DISPUTE_STATUS")
	private String fDisputeStatus;//合同纠纷状态 1-有纠纷	 0-没纠纷	 2020.02.17陈睿超加
	
	@Column(name ="F_USER_NAME")
	private String fUserName;//下环节处理人 姓名
	
	@Column (name ="F_USER_CODE")
	private String fUserCode;//下环节处理人 编码
	
	@Column(name ="F_PRO_CODE")
	private String fProCode;//项目编号
	
	@Column(name ="F_N_CODE")
	private String fNCode;//下节点节点编码
	 
	@Column(name ="F_PAY_STAUTS")
	private String fPayStauts;//质保金是否退还
	
	@Column(name = "F_FUND_SOURCE")
	private String fundSource;//资金来源：0-财政拨款收入、1-教育事业收入、2-科研事业收入、3-非同级拨款收入、4-其他收入、5-利息收入
	
	@Column(name = "F_BANK_NAME")
	private String bankAccountName;//银行账户字典名称
	
	@Column(name = "F_BANK_ID")
	private String bankAccountId;//银行账户字典id
	
	@Column(name = "F_ASSIS_DEPT_ID")
	private String assisDeptId;	//协调部门id
	
	@Column(name = "F_ASSIS_DEPT_NAME")
	private String assisDeptName;//协调部门名称
	
	@Column(name = "F_STANDARD")
	private Integer standard;//是否制式合同 0:否，1：是
	
	@Column(name = "F_ISINVOICE")
	private Integer isinvoice;//是否预开发票 0:否，1：是
	
	@Column(name = "F_ISKJHT")
	private Integer iskjht;//是否框架合同 0:否，1：是
	
	@Column(name ="F_GDSTATUS")
	private String fgdStauts; //归档状态0未归档1已归档
	
	@Column(name ="F_HTTYPE")
	private String fhttype; //合同属性0申请合同1変更合同  2021-6-3崔敬贤加
	
	@Column(name ="F_JFSTATUS")
	private String fjfStauts; //纠纷保存状态0暂存1提交
	
	@Column(name = "F_SEALED_STATUS")
	private Integer fsealedStatus;//是否盖章	0-未盖章	 	1-已盖章 2021-02-01 沈帆加
	
	@Column(name = "F_IF_FJJHT")
	private Integer ifFjjht;//是否非经济合同	1-是	 	0-否 2021-02-04 沈帆加
	
	@Column(name = "F_IF_REIM")
	private String ifReim;		//是否报销完		1-是	 	0-否 2021-03-11 赵孟雷加
	
	@Column(name ="F_performance")
	private String fperformance;//履约保证金
	
	@Column(name ="F_YHTID")
	private Integer fyhtid;//原合同id
	
	@Transient
	private int number;//序号
	
	@Transient
	private String fAllAmount;//已付总额
	
	@Transient
	private String fNotAllAmountL;//未付总额
	
	@Transient
	private Integer fPlanId;//付款计划的id

	@Transient
	private Date fRecePlanTime;//计划付款时间
	
	@Transient
	private String fReceProperty;//付款性质
	
	@Transient
	private String fReceCondition;//付款条件
	
	@Transient
	private Double fRecePlanAmount;//预计付款金额
	
	@Transient
	private Integer datenumber;//距离预计付款时间还有几天
	
	@Transient
	private String fRecUser;//登记人
	
	@Transient
	private Date fRecTime;//登记时间
	
	@Transient
	private String fPayRemark;//付款说明
	
	@Transient
	private String fWarType;//保证金类型
	
	@Transient
	private String fPayAmount;//付款金额
	
	@Transient
	private String percentage;//执行百分比
	
	@Transient
	private Double percentageTempStart;//搜索栏查询百分比开始
	
	@Transient
	private Double percentageTempEnd;//搜索栏查询百分比结束
	
	@Transient
	private Double cAmountBegin;//合同金额开始区间
	
	@Transient
	private Double cAmountEnd;//合同金额戒指区间
	@Transient
	private String gdspstatus;//归档审批状态0：未审批1：提交，待审9：已审核 
	@Transient
	private String fCIds;//批量合同ID     2021.3.10 赵孟雷加 
	@Transient
	private String flowStauts;//收款计划审批状态  2021.6.17崔敬贤加
	@Transient
	private Double bcSkAmount;//本次收款金额  2021.6.18崔敬贤加
	@Transient
	private String fProceeds;//收款性质  2021.6.18崔敬贤加

	
	public Integer getIskjht() {
		return iskjht;
	}

	public void setIskjht(Integer iskjht) {
		this.iskjht = iskjht;
	}

	public Double getBcSkAmount() {
		return bcSkAmount;
	}

	public void setBcSkAmount(Double bcSkAmount) {
		this.bcSkAmount = bcSkAmount;
	}

	public String getfProceeds() {
		return fProceeds;
	}

	public void setfProceeds(String fProceeds) {
		this.fProceeds = fProceeds;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public Integer getFyhtid() {
		return fyhtid;
	}

	public void setFyhtid(Integer fyhtid) {
		this.fyhtid = fyhtid;
	}

	public String getFhttype() {
		return fhttype;
	}

	public void setFhttype(String fhttype) {
		this.fhttype = fhttype;
	}

	public Integer getIsinvoice() {
		return isinvoice;
	}

	public void setIsinvoice(Integer isinvoice) {
		this.isinvoice = isinvoice;
	}

	public String getFperformance() {
		return fperformance;
	}

	public void setFperformance(String fperformance) {
		this.fperformance = fperformance;
	}

	public String getGdspstatus() {
		return gdspstatus;
	}

	public void setGdspstatus(String gdspstatus) {
		this.gdspstatus = gdspstatus;
	}

	public String getFcTypeName() {
		return fcTypeName;
	}

	public void setFcTypeName(String fcTypeName) {
		this.fcTypeName = fcTypeName;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getFjfStauts() {
		return fjfStauts;
	}

	public void setFjfStauts(String fjfStauts) {
		this.fjfStauts = fjfStauts;
	}

	public String getFgdStauts() {
		return fgdStauts;
	}

	public void setFgdStauts(String fgdStauts) {
		this.fgdStauts = fgdStauts;
	}

	public String getfProCode() {
		return fProCode;
	}

	public void setfProCode(String fProCode) {
		this.fProCode = fProCode;
	}

	public String getfNCode() {
		return fNCode;
	}

	public void setfNCode(String fNCode) {
		this.fNCode = fNCode;
	}

	public String getfPayStauts() {
		return fPayStauts;
	}

	public void setfPayStauts(String fPayStauts) {
		this.fPayStauts = fPayStauts;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
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

	public String getfPayRemark() {
		return fPayRemark;
	}

	public void setfPayRemark(String fPayRemark) {
		this.fPayRemark = fPayRemark;
	}

	public String getfWarType() {
		return fWarType;
	}

	public void setfWarType(String fWarType) {
		this.fWarType = fWarType;
	}

	public String getfPayAmount() {
		return fPayAmount;
	}

	public void setfPayAmount(String fPayAmount) {
		this.fPayAmount = fPayAmount;
	}

	public Integer getfPlanId() {
		return fPlanId;
	}

	public void setfPlanId(Integer fPlanId) {
		this.fPlanId = fPlanId;
	}

	public Date getfRecePlanTime() {
		return fRecePlanTime;
	}

	public void setfRecePlanTime(Date fRecePlanTime) {
		this.fRecePlanTime = fRecePlanTime;
	}

	public String getfReceProperty() {
		return fReceProperty;
	}

	public void setfReceProperty(String fReceProperty) {
		this.fReceProperty = fReceProperty;
	}

	public String getfReceCondition() {
		return fReceCondition;
	}

	public void setfReceCondition(String fReceCondition) {
		this.fReceCondition = fReceCondition;
	}

	public Double getfRecePlanAmount() {
		return fRecePlanAmount;
	}

	public void setfRecePlanAmount(Double fRecePlanAmount) {
		this.fRecePlanAmount = fRecePlanAmount;
	}

	public Integer getDatenumber() {
		return datenumber;
	}

	public void setDatenumber(Integer datenumber) {
		this.datenumber = datenumber;
	}
	public String getfAllAmount() {
		return fAllAmount;
	}

	public void setfAllAmount(String fAllAmount) {
		this.fAllAmount = fAllAmount;
	}

	public String getfNotAllAmountL() {
		return fNotAllAmountL;
	}

	public void setfNotAllAmountL(String fNotAllAmountL) {
		this.fNotAllAmountL = fNotAllAmountL;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfUserCode() {
		return fUserCode;
	}

	public void setfUserCode(String fUserCode) {
		this.fUserCode = fUserCode;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public String getFcCode() {
		return fcCode;
	}

	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}

	public String getFcType() {
		return fcType;
	}

	public void setFcType(String fcType) {
		this.fcType = fcType;
	}

	public String getFcTitle() {
		return fcTitle;
	}

	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}

	public String getFcNum() {
		return fcNum;
	}

	public void setFcNum(String fcNum) {
		this.fcNum = fcNum;
	}

	
	public String getFcAmount() {
		return fcAmount;
	}

	public void setFcAmount(String fcAmount) {
		this.fcAmount = fcAmount;
	}

	public String getfPurchNo() {
		return fPurchNo;
	}

	public void setfPurchNo(String fPurchNo) {
		this.fPurchNo = fPurchNo;
	}


	public Integer getfBudgetIndexCode() {
		return fBudgetIndexCode;
	}

	public void setfBudgetIndexCode(Integer fBudgetIndexCode) {
		this.fBudgetIndexCode = fBudgetIndexCode;
	}

	public String getfBudgetIndexName() {
		return fBudgetIndexName;
	}

	public void setfBudgetIndexName(String fBudgetIndexName) {
		this.fBudgetIndexName = fBudgetIndexName;
	}

	public String getfAvailableAmount() {
		return fAvailableAmount;
	}

	public void setfAvailableAmount(String fAvailableAmount) {
		this.fAvailableAmount = fAvailableAmount;
	}

	public String getfOperator() {
		return fOperator;
	}

	public void setfOperator(String fOperator) {
		this.fOperator = fOperator;
	}


	public Date getfReqtIME() {
		return fReqtIME;
	}

	public void setfReqtIME(Date fReqtIME) {
		this.fReqtIME = fReqtIME;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public Date getfContStartTime() {
		return fContStartTime;
	}

	public void setfContStartTime(Date fContStartTime) {
		this.fContStartTime = fContStartTime;
	}

	public Date getfContEndTime() {
		return fContEndTime;
	}

	public void setfContEndTime(Date fContEndTime) {
		this.fContEndTime = fContEndTime;
	}

	public String getfSignUser() {
		return fSignUser;
	}

	public void setfSignUser(String fSignUser) {
		this.fSignUser = fSignUser;
	}

	public Date getfSignTime() {
		return fSignTime;
	}

	public void setfSignTime(Date fSignTime) {
		this.fSignTime = fSignTime;
	}

	public String getfMarginAmount() {
		return fMarginAmount;
	}

	public void setfMarginAmount(String fMarginAmount) {
		this.fMarginAmount = fMarginAmount;
	}

	public String getfIsAuthor() {
		return fIsAuthor;
	}

	public void setfIsAuthor(String fIsAuthor) {
		this.fIsAuthor = fIsAuthor;
	}

	public String getfWarrantyPeriod() {
		return fWarrantyPeriod;
	}

	public void setfWarrantyPeriod(String fWarrantyPeriod) {
		this.fWarrantyPeriod = fWarrantyPeriod;
	}

	public String getfFlowStauts() {
		return fFlowStauts;
	}

	public void setfFlowStauts(String fFlowStauts) {
		this.fFlowStauts = fFlowStauts;
	}

	public String getfContStauts() {
		return fContStauts;
	}

	public void setfContStauts(String fContStauts) {
		this.fContStauts = fContStauts;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	public String getfOperatorId() {
		return fOperatorId;
	}

	public void setfOperatorId(String fOperatorId) {
		this.fOperatorId = fOperatorId;
	}

	public String getIfReim() {
		return ifReim;
	}

	public void setIfReim(String ifReim) {
		this.ifReim = ifReim;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_BASIC_INFO";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fcId);
	}

	public String getfPurchName() {
		return fPurchName;
	}

	public void setfPurchName(String fPurchName) {
		this.fPurchName = fPurchName;
	}

	public Double getPercentageTempStart() {
		return percentageTempStart;
	}

	public void setPercentageTempStart(Double percentageTempStart) {
		this.percentageTempStart = percentageTempStart;
	}

	public Double getPercentageTempEnd() {
		return percentageTempEnd;
	}

	public void setPercentageTempEnd(Double percentageTempEnd) {
		this.percentageTempEnd = percentageTempEnd;
	}

	public Double getcAmountBegin() {
		return cAmountBegin;
	}

	public void setcAmountBegin(Double cAmountBegin) {
		this.cAmountBegin = cAmountBegin;
	}

	public Double getcAmountEnd() {
		return cAmountEnd;
	}

	public void setcAmountEnd(Double cAmountEnd) {
		this.cAmountEnd = cAmountEnd;
	}
	
	public String getFundSource() {
		return fundSource;
	}

	public void setFundSource(String fundSource) {
		this.fundSource = fundSource;
	}

	public String getBankAccountName() {
		return bankAccountName;
	}

	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}

	public String getBankAccountId() {
		return bankAccountId;
	}

	public void setBankAccountId(String bankAccountId) {
		this.bankAccountId = bankAccountId;
	}

	public String getAssisDeptId() {
		return assisDeptId;
	}

	public void setAssisDeptId(String assisDeptId) {
		this.assisDeptId = assisDeptId;
	}

	public String getAssisDeptName() {
		return assisDeptName;
	}

	public void setAssisDeptName(String assisDeptName) {
		this.assisDeptName = assisDeptName;
	}

	public Integer getStandard() {
		return standard;
	}

	public void setStandard(Integer standard) {
		this.standard = standard;
	}
	
	/*public Integer getFsealedStatus() {
		return fsealedStatus;
	}

	public void setFsealedStatus(Integer fsealedStatus) {
		this.fsealedStatus = fsealedStatus;
	}*/

	public String getfCIds() {
		return fCIds;
	}

	public void setfCIds(String fCIds) {
		this.fCIds = fCIds;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.fUserName=userName;
	}
	public String getfUpdateStatus() {
		return fUpdateStatus;
	}

	public void setfUpdateStatus(String fUpdateStatus) {
		this.fUpdateStatus = fUpdateStatus;
	}

	public String getfDisputeStatus() {
		return fDisputeStatus;
	}

	public void setfDisputeStatus(String fDisputeStatus) {
		this.fDisputeStatus = fDisputeStatus;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fUserCode=userId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.fNCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fFlowStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fFlowStauts;
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fcCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fcId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fOperatorId;
	}

	@Override
	public void setStauts(String status) {
		this.fContStauts=status;
		// TODO Auto-generated method stub
		
	}

	public Lookups getfContStyle() {
		return fContStyle;
	}

	public void setfContStyle(Lookups fContStyle) {
		this.fContStyle = fContStyle;
	}

	public String getFcAmountMax() {
		return fcAmountMax;
	}

	public void setFcAmountMax(String fcAmountMax) {
		this.fcAmountMax = fcAmountMax;
	}

	public Lookups getfPayType() {
		return fPayType;
	}

	public void setfPayType(Lookups fPayType) {
		this.fPayType = fPayType;
	}

	public String getContstyle() {
		if(fContStyle!=null){
			return fContStyle.getName();
		}
		return contstyle;
	}

	public void setContstyle(String contstyle) {
		this.contstyle = contstyle;
	}

	public String getPayType() {
		if(fPayType!=null){
			return fPayType.getName();
		}
		return contstyle;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getfContractor() {
		return fContractor;
	}

	public void setfContractor(String fContractor) {
		this.fContractor = fContractor;
	}

	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_CONT_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fUserCode;
	}

	public Integer getFsealedStatus() {
		return fsealedStatus;
	}

	public void setFsealedStatus(Integer fsealedStatus) {
		this.fsealedStatus = fsealedStatus;
	}

	public Integer getIfFjjht() {
		return ifFjjht;
	}

	public void setIfFjjht(Integer ifFjjht) {
		this.ifFjjht = ifFjjht;
	}

}
