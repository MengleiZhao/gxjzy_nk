package com.braker.icontrol.expend.reimburse.model;

import java.math.BigDecimal;
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
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;

/**
 * 报销报销基本信息model
 * @author 叶崇晖
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
@Entity
@Table(name = "T_REIMB_APPLI_BASIC_INFO")
public class ReimbAppliBasicInfo extends BaseEntity implements EntityDao ,CheckEntity{
	
	
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer rId;			//主键ID
	
	@Column(name = "F_R_CODE")
	private String rCode;			//报销单编号
	
	@Column(name = "F_G_CODE")
	private String gCode;			//申请单号（流水号）
	
	@Column(name = "F_REIM_NAME")
	private String reimName;			//报销名称
	
	@Column(name = "F_CONT_ID")
	private String 	payId;			//合同单ID
	
	@Column(name = "F_CONT_CODE")
	private String contCode;		//合同单号（流水号）
	
	@Column(name="F_CONT_TITLE")
	private String fcTitle;        //合同名称
	
	@Column(name = "F_USER")
	private String user;			//报销人id
	
	@Column(name = "F_DEPT")
	private String dept;			//报销部门id
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;		//报销部门名称
	
	@Column(name = "F_REQ_TIME")
	private Date reimburseReqTime;	//报销时间
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;			//报销总金额(合同报销时为付款金额)
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;		//预算指标
	
	@Column(name = "F_INDEX_ID")
	private Integer indexId;		//预算指标Id
	
	@Column(name = "F_PRO_DETAIL_ID")
	private Integer proDetailId;	//项目支出明细id
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType;		//预算指标类型0位基本支出指标，1位项目支出指标
	
	@Column(name = "F_INDEX_AMOUNT")
	private BigDecimal indexAmount;		//可用预算金额
	
	@Column(name = "F_REASON")
	private String reimburseReason;	//报销事由
	
	@Column(name = "F_REIMB_TYPE")
	private String type;			//报销事项   额外增加一个9-往来款报销 10-为采购报销
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;			//报销状态
	 
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_CASHIER_TYPE")
	private String cashierType;		//出纳受理状态0未受理1已受理
	
	@Column(name = "F_EXT_1")
	private String gName;			//报销摘要(对应的事前申请摘要相同，为方便数据传输这里起名和事前申请的申请摘要gName相同)
	
	@Column(name = "F_FUND_SOURCE")
	private String fundSource;		//资金来源：0-财政拨款收入、1-教育事业收入、2-科研事业收入、3-非同级拨款收入、4-其他收入、5-利息收入
	
	@Column(name = "F_WITH_LOAN")
	private Integer withLoan;		//是否冲销借款
	
	@Column(name = "F_CX_AMOUNT")
	private BigDecimal cxAmount;			//冲销金额
	
	@Column(name = "F_FOOD_NUM")
	private Integer fFoodNum;//是否重复申报伙食费
	
	@ManyToOne
	@JoinColumn(name = "F_LAON_ID",referencedColumnName="F_L_ID")
	private LoanBasicInfo loan;		//借款单id
	
	@Column(name = "F_BANK_ID")
	private String bankAccountId;	//银行账户字典id
	
	@Column(name = "F_BANK_NAME")
	private String bankAccountName;	//银行账户字典名称
	
	@Column(name = "F_REGISTER")
	private String register;//是否生成凭证 0-未生成 1-已生成
	
	@Column(name = "F_APPLY_AMOUNT")
	private BigDecimal applyAmount;		//申请金额
	
	@Column(name = "F_UPDATE_PLAN_STATUS")
	private Integer fupdateStatus;		//行程是否有变更 0-否，1-是
	
	@Column(name = "F_UPDATE_PLAN_REASON")
	private String fupdateReason;		//变更说明
	
	/*@Column(name = "F_CASHIER")
	private String cashierStatus;*/			//出纳确认状态	（0、未确认 1、已确认	）
	
	@Column(name = "F_OUTSIDE_AMOUNT")
	private BigDecimal outsideAmount;			//城市间交通费总金额（元）
	
	@Column(name = "F_OUTSIDE_TEACHER_AMOUNT")
	private BigDecimal outsideTeacherAmount;			//城市间交通费总金额（元） ----教师金额
	
	@Column(name = "F_OUTSIDE_STUDENT_AMOUNT")
	private BigDecimal outsideStudentAmount;			//城市间交通费总金额（元） ----学生金额
	
	@Column(name = "F_CITY_AMOUNT")
	private BigDecimal cityAmount;			//市内交通费总金额（元）

	@Column(name = "F_CITY_TEACHER_AMOUNT")
	private BigDecimal cityTeacherAmount;			//市内交通费总金额（元） ----教师金额
	
	@Column(name = "F_CITY_STUDENT_AMOUNT")
	private BigDecimal cityStudentAmount;			//市内交通费总金额（元） ----学生金额
	
	@Column(name = "F_HOTEL_AMOUNT")
	private BigDecimal hotelAmount;			//住宿费总金额（元）

	@Column(name = "F_HOTEL_TEACHER_AMOUNT")
	private BigDecimal hotelTeacherAmount;			//住宿费总金额（元） ----教师金额
	
	@Column(name = "F_HOTEL_STUDENT_AMOUNT")
	private BigDecimal hotelStudentAmount;			//住宿费总金额（元） ----学生金额
	
	@Column(name = "F_FOOD_AMOUNT")
	private BigDecimal foodAmount;			//伙食补助费总金额（元）

	@Column(name = "F_FOOD_TEACHER_AMOUNT")
	private BigDecimal foodTeacherAmount;			//伙食补助费总金额（元） ----教师金额
	
	@Column(name = "F_FOOD_STUDENT_AMOUNT")
	private BigDecimal foodStudentAmount;			//伙食补助费总金额（元） ----学生金额
	
	@Column(name = "F_TRAVEL_TYPE")
	private String travelType;			//出差类型
	
	@Column(name = "F_RECEIVPLAN_ID")
	private String receivplanid;	//合同待付款数据id
	
	@Column(name = "F_INTANGIBLE_ID")
	private String checkintangibleAssetid;	//无形资产入账单id
	
	@Column(name = "F_FIXED_ID")
	private String checkFixedAssetid;		//固定资产入账单id
	
	@Column(name = "F_ACCEPT_ID")
	private String checkacceptid;			//验收单id
	
	@Column(name = "F_INTANGIBLE_NAME")
	private String checkintangibleName;	//无形资产入账单名字
	
	@Column(name = "F_FIXED_NAME")
	private String checkFixedName;		//固定资产入账单名字
	
	@Column(name = "F_ACCEPT_NAME")
	private String checkacceptName;			//验收单名字
	
	@Column(name = "F_PRO_NAME")
	private String proName;				//项目名称2020.11.11陈睿超添加，用于往来款报销

	@Column(name = "F_WHETHER_ACCOMPANY")
	private String fWhetherAccompany;//是否随行

	@Column(name = "F_MEETING_TRAIN_AMOUNT")
	private BigDecimal meetTrainAmount;			//会议、培训费

	@Column(name = "F_TRAVEL_AMOUNT")
	private BigDecimal travelAmount;			//差旅费金额
	
	@Column(name = "F_IF_CFO")
	private String ifCfo;			//部门主管校长是否财务校长（若为部门主管校长，需审批至校长）0：否     1：是
	
	@Column(name = "F_PAID_PEOPLE")
	private String PaidPeople;			//判断付讫人是谁
	
	@Column(name = "F_PAYMENT_TYPE")
	private String paymentType;		//收款方式（1、银行代发2、现金3、支票4、电汇5、公务卡）2020.12.15应马经理要求调整
	
	@Column(name = "F_PURCHASE_ID")
	private Integer purchaseId;			//采购单ID 2020-12-16 沈帆加
	
	@Column(name = "F_ATTEND_PEOPLE")
	private String travelAttendPeop;	//出差人员或教职工人员或同行人
	
	@Column(name = "F_ATTEND_PEOPLE_ID")
	private String travelAttendPeopId;	//出差人员或教职工人员或同行人ID
	
	@Column(name = "F_STATEMENT")
	private String statement;	//声明
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private Date reqTime;			//时间(工作流中用到)
	
	@Transient
	private String userName;		//报销人名称
	
	@Transient
	private Date reimburseReqTime1;	//报销时间开始(查询用)
	
	@Transient
	private Date reimburseReqTime2;	//报销时间结束(查询用)
	
	@Transient
	private BigDecimal pfAmount; 		//预算批复金额
	
	@Transient
	private String pfDate;			//预算批复时间
	
	@Transient
	private String pfDepartName;	//使用部门
	
	@Transient
	private BigDecimal syAmount;		//可用余额
	
	@Transient
	private String reimAmountcapital;		//报销金额大写
	
	@Transient
	private String arriveCountry;				//到达国家
	
	@Transient
	private String arrivePlan;				//出行计划
	
	@Transient
	private String proDetailName;		//预算支出明细名称
	
	@Transient
	private String proCharger;		//项目负责人

	@Transient
	private Integer userLevel;				//申请人级别
	
	public Integer getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(Integer userLevel) {
		this.userLevel = userLevel;
	}

	public String getPaidPeople() {
		return PaidPeople;
	}

	public void setPaidPeople(String paidPeople) {
		PaidPeople = paidPeople;
	}

	public String getIfCfo() {
		return ifCfo;
	}

	public void setIfCfo(String ifCfo) {
		this.ifCfo = ifCfo;
	}

	public BigDecimal getTravelAmount() {
		return travelAmount;
	}

	public void setTravelAmount(BigDecimal travelAmount) {
		this.travelAmount = travelAmount;
	}

	public BigDecimal getMeetTrainAmount() {
		return meetTrainAmount;
	}

	public void setMeetTrainAmount(BigDecimal meetTrainAmount) {
		this.meetTrainAmount = meetTrainAmount;
	}

	public BigDecimal getOutsideTeacherAmount() {
		return outsideTeacherAmount;
	}

	public void setOutsideTeacherAmount(BigDecimal outsideTeacherAmount) {
		this.outsideTeacherAmount = outsideTeacherAmount;
	}

	public BigDecimal getOutsideStudentAmount() {
		return outsideStudentAmount;
	}

	public void setOutsideStudentAmount(BigDecimal outsideStudentAmount) {
		this.outsideStudentAmount = outsideStudentAmount;
	}

	public BigDecimal getCityTeacherAmount() {
		return cityTeacherAmount;
	}

	public void setCityTeacherAmount(BigDecimal cityTeacherAmount) {
		this.cityTeacherAmount = cityTeacherAmount;
	}

	public BigDecimal getCityStudentAmount() {
		return cityStudentAmount;
	}

	public void setCityStudentAmount(BigDecimal cityStudentAmount) {
		this.cityStudentAmount = cityStudentAmount;
	}

	public BigDecimal getHotelTeacherAmount() {
		return hotelTeacherAmount;
	}

	public void setHotelTeacherAmount(BigDecimal hotelTeacherAmount) {
		this.hotelTeacherAmount = hotelTeacherAmount;
	}

	public BigDecimal getHotelStudentAmount() {
		return hotelStudentAmount;
	}

	public void setHotelStudentAmount(BigDecimal hotelStudentAmount) {
		this.hotelStudentAmount = hotelStudentAmount;
	}

	public BigDecimal getFoodTeacherAmount() {
		return foodTeacherAmount;
	}

	public void setFoodTeacherAmount(BigDecimal foodTeacherAmount) {
		this.foodTeacherAmount = foodTeacherAmount;
	}

	public BigDecimal getFoodStudentAmount() {
		return foodStudentAmount;
	}

	public void setFoodStudentAmount(BigDecimal foodStudentAmount) {
		this.foodStudentAmount = foodStudentAmount;
	}

	public String getfWhetherAccompany() {
		return fWhetherAccompany;
	}

	public void setfWhetherAccompany(String fWhetherAccompany) {
		this.fWhetherAccompany = fWhetherAccompany;
	}
	
	public String getReimAmountcapital() {
		return reimAmountcapital;
	}

	public void setReimAmountcapital(String reimAmountcapital) {
		this.reimAmountcapital = reimAmountcapital;
	}

	public Integer getfFoodNum() {
		return fFoodNum;
	}

	public void setfFoodNum(Integer fFoodNum) {
		this.fFoodNum = fFoodNum;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}

	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getrCode() {
		return rCode;
	}

	public void setrCode(String rCode) {
		this.rCode = rCode;
	}

	public String getgCode() {
		return gCode;
	}

	public void setgCode(String gCode) {
		this.gCode = gCode;
	}

	public String getBankAccountId() {
		return bankAccountId;
	}

	public void setBankAccountId(String bankAccountId) {
		this.bankAccountId = bankAccountId;
	}

	public String getBankAccountName() {
		return bankAccountName;
	}

	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}

	public String getContCode() {
		return contCode;
	}

	public void setContCode(String contCode) {
		this.contCode = contCode;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Date getReimburseReqTime() {
		return reimburseReqTime;
	}

	public void setReimburseReqTime(Date reimburseReqTime) {
		this.reimburseReqTime = reimburseReqTime;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public Integer getIndexId() {
		return indexId;
	}

	public void setIndexId(Integer indexId) {
		this.indexId = indexId;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	public BigDecimal getIndexAmount() {
		return indexAmount;
	}

	public void setIndexAmount(BigDecimal indexAmount) {
		this.indexAmount = indexAmount;
	}

	public String getReimburseReason() {
		return reimburseReason;
	}

	public void setReimburseReason(String reimburseReason) {
		this.reimburseReason = reimburseReason;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getStauts() {
		return stauts;
	}


	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}




	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public String getCashierType() {
		return cashierType;
	}


	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getReimburseReqTime1() {
		return reimburseReqTime1;
	}

	public void setReimburseReqTime1(Date reimburseReqTime1) {
		this.reimburseReqTime1 = reimburseReqTime1;
	}

	public Date getReimburseReqTime2() {
		return reimburseReqTime2;
	}

	public void setReimburseReqTime2(Date reimburseReqTime2) {
		this.reimburseReqTime2 = reimburseReqTime2;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
	}


	public Integer getWithLoan() {
		return withLoan;
	}

	public void setWithLoan(Integer withLoan) {
		this.withLoan = withLoan;
	}

	public LoanBasicInfo getLoan() {
		return loan;
	}

	public void setLoan(LoanBasicInfo loan) {
		this.loan = loan;
	}

	@Override
	@Transient
	public String getJoinTable() {
		return "T_REIMB_APPLI_BASIC_INFO";
	}

	@Override
	@Transient
	public String getEntryId() {
		return String.valueOf(rId);
	}

	public String getRegister() {
		return register;
	}

	public void setRegister(String register) {
		this.register = register;
	}

	public Integer getFupdateStatus() {
		return fupdateStatus;
	}

	public void setFupdateStatus(Integer fupdateStatus) {
		this.fupdateStatus = fupdateStatus;
	}

	public String getFupdateReason() {
		return fupdateReason;
	}

	public void setFupdateReason(String fupdateReason) {
		this.fupdateReason = fupdateReason;
	}

	public String getPayId() {
		return payId;
	}

	public void setPayId(String payId) {
		this.payId = payId;
	}

	public String getFcTitle() {
		return fcTitle;
	}

	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}

	public String getCheckintangibleAssetid() {
		return checkintangibleAssetid;
	}

	public void setCheckintangibleAssetid(String checkintangibleAssetid) {
		this.checkintangibleAssetid = checkintangibleAssetid;
	}

	public String getCheckFixedAssetid() {
		return checkFixedAssetid;
	}

	public void setCheckFixedAssetid(String checkFixedAssetid) {
		this.checkFixedAssetid = checkFixedAssetid;
	}

	public String getCheckacceptid() {
		return checkacceptid;
	}

	public void setCheckacceptid(String checkacceptid) {
		this.checkacceptid = checkacceptid;
	}

	public String getCheckintangibleName() {
		return checkintangibleName;
	}

	public void setCheckintangibleName(String checkintangibleName) {
		this.checkintangibleName = checkintangibleName;
	}

	public String getCheckFixedName() {
		return checkFixedName;
	}

	public void setCheckFixedName(String checkFixedName) {
		this.checkFixedName = checkFixedName;
	}

	public String getCheckacceptName() {
		return checkacceptName;
	}

	public String getReceivplanid() {
		return receivplanid;
	}

	public void setReceivplanid(String receivplanid) {
		this.receivplanid = receivplanid;
	}

	public void setCheckacceptName(String checkacceptName) {
		this.checkacceptName = checkacceptName;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.userName2=userName;
	}
	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.flowStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return flowStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.stauts=status;
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return rCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return rId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String cashierType) {
		// TODO Auto-generated method stub
		this.cashierType=cashierType;
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return user;
		}
	
		public String getFundSource() {
			return fundSource;
		}
	
		public void setFundSource(String fundSource) {
			this.fundSource = fundSource;
		}

		public BigDecimal getPfAmount() {
			return pfAmount;
		}

		public void setPfAmount(BigDecimal pfAmount) {
			this.pfAmount = pfAmount;
		}

		public String getPfDate() {
			return pfDate;
		}

		public void setPfDate(String pfDate) {
			this.pfDate = pfDate;
		}

		public String getPfDepartName() {
			return pfDepartName;
		}

		public void setPfDepartName(String pfDepartName) {
			this.pfDepartName = pfDepartName;
		}

		public BigDecimal getSyAmount() {
			return syAmount;
		}

		public void setSyAmount(BigDecimal syAmount) {
			this.syAmount = syAmount;
		}

		@Override
		public String getBeanCodeField() {
			// TODO Auto-generated method stub
			return "F_R_CODE";
		}

		@Override
		public String getNextCheckUserId() {
			// TODO Auto-generated method stub
			return fuserId;
		}

		public BigDecimal getCxAmount() {
			return cxAmount;
		}

		public void setCxAmount(BigDecimal cxAmount) {
			this.cxAmount = cxAmount;
		}

		public BigDecimal getOutsideAmount() {
			return outsideAmount;
		}

		public void setOutsideAmount(BigDecimal outsideAmount) {
			this.outsideAmount = outsideAmount;
		}

		public BigDecimal getCityAmount() {
			return cityAmount;
		}

		public void setCityAmount(BigDecimal cityAmount) {
			this.cityAmount = cityAmount;
		}

		public BigDecimal getHotelAmount() {
			return hotelAmount;
		}

		public void setHotelAmount(BigDecimal hotelAmount) {
			this.hotelAmount = hotelAmount;
		}

		public BigDecimal getFoodAmount() {
			return foodAmount;
		}

		public void setFoodAmount(BigDecimal foodAmount) {
			this.foodAmount = foodAmount;
		}

		public String getArriveCountry() {
			return arriveCountry;
		}

		public void setArriveCountry(String arriveCountry) {
			this.arriveCountry = arriveCountry;
		}

		public String getArrivePlan() {
			return arrivePlan;
		}

		public void setArrivePlan(String arrivePlan) {
			this.arrivePlan = arrivePlan;
		}

		public String getProDetailName() {
			return proDetailName;
		}

		public void setProDetailName(String proDetailName) {
			this.proDetailName = proDetailName;
		}

		public String getProCharger() {
			return proCharger;
		}

		public void setProCharger(String proCharger) {
			this.proCharger = proCharger;
		}

		public String getPaymentType() {
			return paymentType;
		}

		public void setPaymentType(String paymentType) {
			this.paymentType = paymentType;
		}

		public Integer getPurchaseId() {
			return purchaseId;
		}

		public void setPurchaseId(Integer purchaseId) {
			this.purchaseId = purchaseId;
		}

		public String getReimName() {
			return reimName;
		}

		public void setReimName(String reimName) {
			this.reimName = reimName;
		}

		public String getTravelAttendPeop() {
			return travelAttendPeop;
		}

		public void setTravelAttendPeop(String travelAttendPeop) {
			this.travelAttendPeop = travelAttendPeop;
		}

		public String getTravelAttendPeopId() {
			return travelAttendPeopId;
		}

		public void setTravelAttendPeopId(String travelAttendPeopId) {
			this.travelAttendPeopId = travelAttendPeopId;
		}

		public String getStatement() {
			return statement;
		}

		public void setStatement(String statement) {
			this.statement = statement;
		}
	
}
