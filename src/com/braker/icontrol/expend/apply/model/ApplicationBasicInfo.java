package com.braker.icontrol.expend.apply.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 支出申请基本信息model
 * 是支出申请基本信息的model类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Entity
@Table(name = "T_APPLICATION_BASIC_INFO")
public class ApplicationBasicInfo extends BaseEntity implements EntityDao,CheckEntity{
	@Id
	@Column(name = "F_G_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer gId;			//主键ID
	
	@Column(name = "F_G_CODE")
	private String gCode;			//申请单号
	
	@Column(name = "F_APPLY_NAME")
	private String applyName;			//申请单名称
	
	@Column(name = "F_G_NAME")
	private String gName;			//申请摘要名称
	
	@Column(name = "F_USER")
	private String user;			//申请人id
	
	@Column(name = "F_USER_NAME")
	private String userNames;		//申请人姓名
	
	@Column(name = "F_DEPT")
	private String dept;			//申请人所属部门的id
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;		//申请人所属部门名称
	
	@Column(name = "F_REQ_TIME")
	private Date reqTime;			//申请时间
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;			//申请总金额
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;		//预算指标名称
	
	@Column(name = "F_INDEX_ID")
	private Integer indexId;		//预算指标Id
	
	@Column(name = "F_PRO_ID")
	private Integer proId;	//项目id
	
	@Column(name = "F_PRO_DETAIL_ID")
	private Integer proDetailId;	//项目支出明细id
	
	@Column(name = "F_PRO_CHARGER")
	private String proCharger;		//项目负责人
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType;		//预算指标类型0位基本支出指标，1位项目支出指标
	
	@Column(name = "F_INDEX_AMOUNT")
	private BigDecimal indexAmount;		//可用预算金额
	
	@Column(name = "F_REASON")
	private String reason;			//申请事由
	
	@Column(name = "F_APP_TYPE")
	private String type;			//申请事项
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;			//申请状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_REIMB_TYPE")
	private String reimbType;		//报销类型
	
	@Column(name = "F_SUGGEST_DEP")
	private String suggestDep;		//归口部门意见
	
	@Column(name = "F_SUGGEST_DEP_ID")
	private String suggestDepId;		//归口部门ID
	
	@Column(name = "F_SUGGEST_DEP_NAME")
	private String suggestDeptname;		//归口部们名称
	
	@Column(name = "F_SUGGEST_CAP")
	private String suggestCap;		//主管校长意见
	
	@Column(name = "F_HOTEL_HINT")
	private String fHotelHint;//差旅住宿费提示信息
	
	@Column(name = "F_TRAFFIC_HINT")
	private String fTrafficHint;//差旅交通提示信息
	
	/*
	 * 附件ID
	 */
	@Column(name = "F_OUTSIDE_AMOUNT")
	private BigDecimal OutsideAmount;			//城市间交通费总金额（元）
	
	@Column(name = "F_OUTSIDE_FILE_ID")
	private String OutsideFileId;			//城市间交通费附件ID
	
	@Column(name = "F_CITY_AMOUNT")
	private BigDecimal cityAmount;			//市内交通费总金额（元）
	
	@Column(name = "F_CITY_FILE_ID")
	private String cityFileId;			//市内交通费附件ID
	
	@Column(name = "F_HOTEL_AMOUNT")
	private BigDecimal hotelAmount;			//住宿费总金额（元）
	
	@Column(name = "F_HOTEL_FILE_ID")
	private String hotelFileId;			//住宿费附件ID
	
	@Column(name = "F_FOOD_AMOUNT")
	private BigDecimal foodAmount;			//伙食补助费总金额（元）
	
	@Column(name = "F_FOOD_FILE_ID")
	private String foodFileId;			//伙食补助费附件ID
	
	@Column(name = "F_TRAVEL_TYPE")
	private String travelType;			//出差类型
	
	@Column(name = "F_EXPENDITURE_TYPE")
	private String expenditureType;			//出差类型
	
	@Column(name = "F_FOOD_NUM")
	private Integer fFoodNum;//是否重复申报伙食费
	
	
	@Column(name = "MEETING_SUMMARY_YEAR1")
	private String meetingSummaryYear1;   //校长办公会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME1")
	private String meetingSummaryTime1; //校长办公会会议纪要次数
	
	@Column(name = "MEETING_SUMMARY_YEAR2")
	private String meetingSummaryYear2;   //党委会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME2")
	private String meetingSummaryTime2;  //党委会会议纪要次数

	@Column(name = "F_TRAVEL_AMOUNT")
	private BigDecimal travelAmount;			//差旅费金额
	
	@Column(name = "F_MEETING_TRAIN_AMOUNT")
	private BigDecimal meetTrainAmount;			//会议、培训费

	@Column(name = "F_WHETHER_ACCOMPANY")
	private String fWhetherAccompany;//是否随行
	
	@Column(name = "F_COST_TYPE")
	private String fcostType;		//费用类型

	@Column(name = "F_RESEARCH_TYPE")
	private String researchType;			//科研类型    KEYAN",text:"科研","JIAOGAI",text:"教改"
	
	@Column(name = "F_ATTEND_PEOPLE")
	private String travelAttendPeop;	//出差人员或教职工人员或同行人
	
	@Column(name = "F_ATTEND_PEOPLE_ID")
	private String travelAttendPeopId;	//出差人员或教职工人员或同行人ID
	
	@Column(name = "F_STATEMENT")
	private String statement;	//声明
	
	@Column(name = "F_IF_DEPUTY")
	private Integer ifDeputy;	//是否副职  1：是      0：否
	
	@Column(name = "F_TRIPDATE")
	private Date tripdate;		//出行时间
	
	@Transient
	private BigDecimal pfAmount; 		//预算批复金额
	
	@Transient
	private String pfDate;			//预算批复时间
	
	@Transient
	private String pfDepartName;	//使用部门
	
	@Transient
	private BigDecimal syAmount;		//可用余额
	
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String userName;		//申请人姓名
	
	@Transient
	private Date reqTime1;			//开始申请时间(查询用)
	
	@Transient
	private Date reqTime2;			//结束申请时间(查询用)
	
	@Transient
	private Integer rId;			//报销单id
	
	@Transient
	private BigDecimal reimbAmount;		//报销金额
	
	@Transient
	private Date reimbTime;			//报销时间
	
	@Transient	
	private String reimbFlowStauts;		//报销单审批状态

	@Transient
	private String reimbStauts;			//报销状态
	
	@Transient
	private String applyAmountcapital;		//事前申请金额大写
	
	@Transient
	private String reimbAmountcapital;		//报销申请金额大写
	
	@Transient
	private String proDetailName;		//预算支出明细名称
	
	@Transient
	private String arriveCountry;				//到达国家
	
	@Transient
	private String arrivePlan;				//出行计划
	
	@Transient
	private String rName;				//报销摘要
	
	@Transient
	private Integer userLevel;				//申请人级别
	
	public String getResearchType() {
		return researchType;
	}

	public void setResearchType(String researchType) {
		this.researchType = researchType;
	}

	public Integer getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(Integer userLevel) {
		this.userLevel = userLevel;
	}

	public Date getTripdate() {
		return tripdate;
	}

	public void setTripdate(Date tripdate) {
		this.tripdate = tripdate;
	}

	public Integer getIfDeputy() {
		return ifDeputy;
	}

	public void setIfDeputy(Integer ifDeputy) {
		this.ifDeputy = ifDeputy;
	}

	public String getFcostType() {
		return fcostType;
	}

	public void setFcostType(String fcostType) {
		this.fcostType = fcostType;
	}

	public String getfWhetherAccompany() {
		return fWhetherAccompany;
	}

	public void setfWhetherAccompany(String fWhetherAccompany) {
		this.fWhetherAccompany = fWhetherAccompany;
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

	public Integer getfFoodNum() {
		return fFoodNum;
	}

	public void setfFoodNum(Integer fFoodNum) {
		this.fFoodNum = fFoodNum;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public String getgCode() {
		return gCode;
	}

	public void setgCode(String gCode) {
		this.gCode = gCode;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
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

	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
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

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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

	public void setStauts(String stauts) {
		this.stauts = stauts;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getReimbType() {
		return reimbType;
	}

	public void setReimbType(String reimbType) {
		this.reimbType = reimbType;
	}



	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Date getReqTime1() {
		return reqTime1;
	}

	public void setReqTime1(Date reqTime1) {
		this.reqTime1 = reqTime1;
	}

	public Date getReqTime2() {
		return reqTime2;
	}

	public void setReqTime2(Date reqTime2) {
		this.reqTime2 = reqTime2;
	}

	@Override
	public String getJoinTable() {

		return "T_APPLICATION_BASIC_INFO";
	}

	@Override
	public String getEntryId() {

		return String.valueOf(getgId());
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
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return gCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return gId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return user;
	}

	public String getProCharger() {
		return proCharger;
	}

	public void setProCharger(String proCharger) {
		this.proCharger = proCharger;
	}

	public String getSuggestDep() {
		return suggestDep;
	}

	public void setSuggestDep(String suggestDep) {
		this.suggestDep = suggestDep;
	}

	public String getSuggestCap() {
		return suggestCap;
	}

	public void setSuggestCap(String suggestCap) {
		this.suggestCap = suggestCap;
	}

	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
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

	public String getSuggestDepId() {
		return suggestDepId;
	}

	public void setSuggestDepId(String suggestDepId) {
		this.suggestDepId = suggestDepId;
	}

	public String getSuggestDeptname() {
		return suggestDeptname;
	}

	public void setSuggestDeptname(String suggestDeptname) {
		this.suggestDeptname = suggestDeptname;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_G_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public BigDecimal getReimbAmount() {
		return reimbAmount;
	}

	public void setReimbAmount(BigDecimal reimbAmount) {
		this.reimbAmount = reimbAmount;
	}

	public Date getReimbTime() {
		return reimbTime;
	}

	public void setReimbTime(Date reimbTime) {
		this.reimbTime = reimbTime;
	}

	public String getReimbFlowStauts() {
		return reimbFlowStauts;
	}

	public void setReimbFlowStauts(String reimbFlowStauts) {
		this.reimbFlowStauts = reimbFlowStauts;
	}

	public String getReimbStauts() {
		return reimbStauts;
	}

	public void setReimbStauts(String reimbStauts) {
		this.reimbStauts = reimbStauts;
	}

	public String getOutsideFileId() {
		return OutsideFileId;
	}

	public void setOutsideFileId(String outsideFileId) {
		OutsideFileId = outsideFileId;
	}

	public String getCityFileId() {
		return cityFileId;
	}

	public void setCityFileId(String cityFileId) {
		this.cityFileId = cityFileId;
	}

	public String getHotelFileId() {
		return hotelFileId;
	}

	public void setHotelFileId(String hotelFileId) {
		this.hotelFileId = hotelFileId;
	}

	public String getFoodFileId() {
		return foodFileId;
	}

	public void setFoodFileId(String foodFileId) {
		this.foodFileId = foodFileId;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public BigDecimal getOutsideAmount() {
		return OutsideAmount;
	}

	public void setOutsideAmount(BigDecimal outsideAmount) {
		OutsideAmount = outsideAmount;
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

	public String getUserNames() {
		return userNames;
	}

	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}

	public String getApplyAmountcapital() {
		return applyAmountcapital;
	}

	public void setApplyAmountcapital(String applyAmountcapital) {
		this.applyAmountcapital = applyAmountcapital;
	}

	public String getReimbAmountcapital() {
		return reimbAmountcapital;
	}

	public void setReimbAmountcapital(String reimbAmountcapital) {
		this.reimbAmountcapital = reimbAmountcapital;
	}

	public String getMeetingSummaryYear1() {
		return meetingSummaryYear1;
	}

	public void setMeetingSummaryYear1(String meetingSummaryYear1) {
		this.meetingSummaryYear1 = meetingSummaryYear1;
	}

	public String getMeetingSummaryTime1() {
		return meetingSummaryTime1;
	}

	public void setMeetingSummaryTime1(String meetingSummaryTime1) {
		this.meetingSummaryTime1 = meetingSummaryTime1;
	}

	public String getMeetingSummaryYear2() {
		return meetingSummaryYear2;
	}

	public void setMeetingSummaryYear2(String meetingSummaryYear2) {
		this.meetingSummaryYear2 = meetingSummaryYear2;
	}

	public String getMeetingSummaryTime2() {
		return meetingSummaryTime2;
	}

	public void setMeetingSummaryTime2(String meetingSummaryTime2) {
		this.meetingSummaryTime2 = meetingSummaryTime2;
	}

	public String getProDetailName() {
		return proDetailName;
	}

	public void setProDetailName(String proDetailName) {
		this.proDetailName = proDetailName;
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

	public String getrName() {
		return rName;
	}

	public void setrName(String rName) {
		this.rName = rName;
	}

	public String getfHotelHint() {
		return fHotelHint;
	}

	public void setfHotelHint(String fHotelHint) {
		this.fHotelHint = fHotelHint;
	}

	public String getfTrafficHint() {
		return fTrafficHint;
	}

	public void setfTrafficHint(String fTrafficHint) {
		this.fTrafficHint = fTrafficHint;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	public String getExpenditureType() {
		return expenditureType;
	}

	public void setExpenditureType(String expenditureType) {
		this.expenditureType = expenditureType;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
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
