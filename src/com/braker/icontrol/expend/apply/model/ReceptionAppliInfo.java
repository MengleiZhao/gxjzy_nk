package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 接待费申请信息明细model
 * 是接待费申请信息明细的model类
 * @author 叶崇晖
 * @createtime 2018-06-14
 * @updatetime 2018-06-14
 */
@Entity
@Table(name = "T_RECEPTION_APPLI_INFO")
public class ReceptionAppliInfo extends BaseEntity{
	@Id
	@Column(name = "F_J_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer jId;				//主键ID
	
	@Column(name = "F_G_ID")
	private Integer gId;				//基本信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//报销信息ID
	
	@Column(name = "F_RECEPTION_OBJECT")
	private String receptionObject;		//接待对象单位
	
	@Column(name = "F_RECEPTION_LEVEL")
	private String receptionLevel;		//接待等级
	
	@Column(name = "F_RECEPTION_LEVEL1")
	private String receptionLevel1;		//接待级别
	
	@Column(name = "F_RECEPTION_DATE_START")
	private Date reDateStart;			//接待时间（开始）
	
	@Column(name = "F_RECEPTION_DATE_END")
	private Date reDateEnd;				//接待时间（结束）
	
	@Column(name = "F_RECEPTION_DAY_NUM")
	private String reDayNum;			//接待天数
	
	@Column(name = "F_RECEPTION_PEOPLE_NUM")
	private String rePeopNum;			//接待对象人数（用餐总人数）
	
	@Column(name = "F_DINING_PLACE_PLAN")
	private String diningPlacePlan;		//接待就餐安排
	
	@Column(name = "F_DINING_PLACE_PLAN1")
	private String diningPlacePlan1;		//接待就餐安排:宴请（来访单位带队领导姓名）
	
	@Column(name = "F_DINING_PLACE_PLAN2")
	private String diningPlacePlan2;		//接待就餐安排:工作餐（来访单位带队领导职务（职称））
	
	@Column(name = "F_DINING_PLACE_PLAN3")
	private String diningPlacePlan3;		//接待就餐安排:自助餐（陪餐人数）
	
	@Column(name = "F_DINING_PLACE_PLAN4")
	private String diningPlacePlan4;		//接待就餐安排:份饭
	
	@Column(name = "F_DINING_PLACE_PLAN5")
	private String diningPlacePlan5;		//接待就餐安排:其他
	
	@Column(name = "F_DINING_PLACE")
	private String diningPlace;			//工作餐就餐地点（用餐地点）
	
	@Column(name = "F_DINING_PLACE_EXPLAIN")
	private String dPlaceExplain;		//地点说明
	
	@Column(name = "F_ATTEND_PEOPLE")
	private String reAttendPeople;		//陪餐人员-->主陪人
	
	@Column(name = "F_ATTEND_NUM")
	private String attendPeopNum;		//陪餐人数（随行人数）
	
	@Column(name = "F_DINING_NUM")
	private String diningNum;			//就餐餐数
	
	@Column(name = "F_RECEPTION_CONTENT")
	private String receptionContent;	//接待内容（来访活动名称）
	
	@Column(name = "F_STAY_YN")
	private String stayYN;				//是否安排住宿0、不安排 1、安排
	
	@Column(name = "UNIT_FETE_SITE")
	private String unitFeteSite;		//宴请地点
	
	@Column(name = "UNIT_FETE_NUM")
	private Integer unitFeteNum;		//宴请人数
	
	@Column(name = "F_STAY_PLACE_EXPLAI")
	private String stayPlaceExplai;		//宴请原因
	
	@Column(name = "F_STAY_STANDARD")
	private String stayStandard;		//住宿标准
	
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name = "F_FEAST_DATE")
	private Date feastDay;		//宴请时间
	
	@Transient
	private Integer num;				//序号(数据库中没有)

	@Column(name = "F_FETE_TIME")
	private Date fFeteTime;			//宴请时间
	
	@Column(name = "COST_HOTEL")
	private Double costHotel;		//住宿费
	
	@Column(name = "COST_FOOD_STD")
	private Double costFoodStd;		//餐费总标准（费用预算）
	
	@Column(name = "COST_FOOD")
	private Double costFood;		//餐费
	
	@Column(name = "COST_TRAFFIC")
	private Double costTraffic;		//交通费
	
	@Column(name = "COST_RENT")
	private Double costRent;		//会议室租金
	
	@Column(name = "COST_OTHER")
	private Double costOther;		//其他费用
	
	@Column(name = "F_HOTEL_CONTENT")
	private String hotelContet;		//住宿安排
	
	@Column(name = "F_OTHER_CONTENT")
	private String otherContet;		//其他安排
	
	@Column(name = "F_PAYMENT_NUM")
	private String paymentNum;		//缴费人数
	
	@Column(name = "F_PAYMENT_STD")
	private String paymentStd;		//缴费标准
	
	@Column(name = "F_PAYMENT_AMOUNT")
	private Double paymentAmount;		//缴费总金额(报销金额)
	
	@Column(name = "F_IS_FOREIGN")
	private String isForeign;		//是否有外宾接待
	
	
	

	
	
	
	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getUnitFeteSite() {
		return unitFeteSite;
	}

	public void setUnitFeteSite(String unitFeteSite) {
		this.unitFeteSite = unitFeteSite;
	}

	public Integer getUnitFeteNum() {
		return unitFeteNum;
	}

	public void setUnitFeteNum(Integer unitFeteNum) {
		this.unitFeteNum = unitFeteNum;
	}

	public Integer getjId() {
		return jId;
	}

	public void setjId(Integer jId) {
		this.jId = jId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public String getReceptionObject() {
		return receptionObject;
	}

	public void setReceptionObject(String receptionObject) {
		this.receptionObject = receptionObject;
	}

	public String getReceptionLevel() {
		return receptionLevel;
	}

	public void setReceptionLevel(String receptionLevel) {
		this.receptionLevel = receptionLevel;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getReDateStart() {
		return reDateStart;
	}

	public void setReDateStart(Date reDateStart) {
		this.reDateStart = reDateStart;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getReDateEnd() {
		return reDateEnd;
	}

	public void setReDateEnd(Date reDateEnd) {
		this.reDateEnd = reDateEnd;
	}

	public String getReDayNum() {
		return reDayNum;
	}

	public void setReDayNum(String reDayNum) {
		this.reDayNum = reDayNum;
	}

	public String getRePeopNum() {
		return rePeopNum;
	}

	public void setRePeopNum(String rePeopNum) {
		this.rePeopNum = rePeopNum;
	}

	public String getDiningPlacePlan() {
		return diningPlacePlan;
	}

	public void setDiningPlacePlan(String diningPlacePlan) {
		this.diningPlacePlan = diningPlacePlan;
	}

	public String getDiningPlace() {
		return diningPlace;
	}

	public void setDiningPlace(String diningPlace) {
		this.diningPlace = diningPlace;
	}

	public String getdPlaceExplain() {
		return dPlaceExplain;
	}

	public void setdPlaceExplain(String dPlaceExplain) {
		this.dPlaceExplain = dPlaceExplain;
	}

	public String getReAttendPeople() {
		return reAttendPeople;
	}

	public void setReAttendPeople(String reAttendPeople) {
		this.reAttendPeople = reAttendPeople;
	}

	public String getAttendPeopNum() {
		return attendPeopNum;
	}

	public void setAttendPeopNum(String attendPeopNum) {
		this.attendPeopNum = attendPeopNum;
	}

	public String getDiningNum() {
		return diningNum;
	}

	public void setDiningNum(String diningNum) {
		this.diningNum = diningNum;
	}

	public String getReceptionContent() {
		return receptionContent;
	}

	public void setReceptionContent(String receptionContent) {
		this.receptionContent = receptionContent;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStayYN() {
		return stayYN;
	}

	public void setStayYN(String stayYN) {
		this.stayYN = stayYN;
	}

	public String getStayPlaceExplai() {
		return stayPlaceExplai;
	}

	public void setStayPlaceExplai(String stayPlaceExplai) {
		this.stayPlaceExplai = stayPlaceExplai;
	}

	public String getStayStandard() {
		return stayStandard;
	}

	public void setStayStandard(String stayStandard) {
		this.stayStandard = stayStandard;
	}

	public Date getFeastDay() {
		return feastDay;
	}

	public void setFeastDay(Date feastDay) {
		this.feastDay = feastDay;
	}

	public String getDiningPlacePlan1() {
		return diningPlacePlan1;
	}

	public void setDiningPlacePlan1(String diningPlacePlan1) {
		this.diningPlacePlan1 = diningPlacePlan1;
	}

	public String getDiningPlacePlan2() {
		return diningPlacePlan2;
	}

	public void setDiningPlacePlan2(String diningPlacePlan2) {
		this.diningPlacePlan2 = diningPlacePlan2;
	}

	public String getDiningPlacePlan3() {
		return diningPlacePlan3;
	}

	public void setDiningPlacePlan3(String diningPlacePlan3) {
		this.diningPlacePlan3 = diningPlacePlan3;
	}

	public String getDiningPlacePlan4() {
		return diningPlacePlan4;
	}

	public void setDiningPlacePlan4(String diningPlacePlan4) {
		this.diningPlacePlan4 = diningPlacePlan4;
	}

	public String getDiningPlacePlan5() {
		return diningPlacePlan5;
	}

	public void setDiningPlacePlan5(String diningPlacePlan5) {
		this.diningPlacePlan5 = diningPlacePlan5;
	}

	public Date getfFeteTime() {
		return fFeteTime;
	}

	public void setfFeteTime(Date fFeteTime) {
		this.fFeteTime = fFeteTime;
	}

	public Double getCostHotel() {
		return costHotel;
	}

	public void setCostHotel(Double costHotel) {
		this.costHotel = costHotel;
	}

	public Double getCostFood() {
		return costFood;
	}

	public void setCostFood(Double costFood) {
		this.costFood = costFood;
	}

	public Double getCostTraffic() {
		return costTraffic;
	}

	public void setCostTraffic(Double costTraffic) {
		this.costTraffic = costTraffic;
	}

	public Double getCostRent() {
		return costRent;
	}

	public void setCostRent(Double costRent) {
		this.costRent = costRent;
	}

	public Double getCostOther() {
		return costOther;
	}

	public void setCostOther(Double costOther) {
		this.costOther = costOther;
	}

	public String getOtherContet() {
		return otherContet;
	}

	public void setOtherContet(String otherContet) {
		this.otherContet = otherContet;
	}

	public String getPaymentNum() {
		return paymentNum;
	}

	public void setPaymentNum(String paymentNum) {
		this.paymentNum = paymentNum;
	}

	public String getPaymentStd() {
		return paymentStd;
	}

	public void setPaymentStd(String paymentStd) {
		this.paymentStd = paymentStd;
	}

	public Double getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getHotelContet() {
		return hotelContet;
	}

	public void setHotelContet(String hotelContet) {
		this.hotelContet = hotelContet;
	}

	public String getIsForeign() {
		return isForeign;
	}

	public void setIsForeign(String isForeign) {
		this.isForeign = isForeign;
	}

	public Double getCostFoodStd() {
		return costFoodStd;
	}

	public void setCostFoodStd(Double costFoodStd) {
		this.costFoodStd = costFoodStd;
	}

	public String getReceptionLevel1() {
		return receptionLevel1;
	}

	public void setReceptionLevel1(String receptionLevel1) {
		this.receptionLevel1 = receptionLevel1;
	}

	
	
	
}
