package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 公务出国申请表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ABROAD_APPLI_INFO")
public class AbroadAppliInfo extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_A_ID")
	private Integer faId;

	@Column(name ="F_G_ID")
	private Integer gId;//外键
	
	@Column(name = "F_R_ID")
	private Integer rId;			//ReimbAppliBasicInfo的主键ID
	
	@Column(name ="F_ABROAD_DATE_START")
	private Date fAbroadDateStart;//出国时间（开始）
	
	@Column(name ="F_ABROAD_DATE_END")
	private Date fAbroadDateEnd;//出国时间（结束）
	
	@Column(name ="F_ABROAD_DAY_NUM")
	private String fAbroadDayNum;//出国天数
	
	@Column(name ="F_ABROAD_PEOPLE")
	private String fAbroadPeople;//出国人员
	
	@Column(name ="F_TASK_TYPE")
	private String fTasjType;//任务类型
	
	@Column(name ="F_ABROAD_PLACE")
	private String fAbroadPlace;//组团单位
	
	@Column(name ="F_VEHICLE")
	private String fVehicle;//交通工具
	
	@Column(name ="F_VEHICLE_LEVEL")
	private String fVehicleLevel;//交通工具等级
	
	@Column(name ="F_DINING_PLACE")
	private Integer fDiningPlace;//是否宴请 1-是，0-否
	
	@Column(name ="F_TEAM_NAME")
	private String fTeamName;     //团组名称
	
	@Column(name ="F_TEAM_LEADER")
	private String fTeamLeader; //团长
	
	@Column(name ="F_TEAM_PERSON_NUM")
	private String fTeamPersonNum; //团员人数
	
	@Column(name ="F_THIS_UNIT_TEAM_PERSON_NUM")
	private String fThisUnitTeamPersonNum; //本单位团员人数
	
	@Column(name ="F_EXT_1")
	private String fExt1;
	
	@Column(name ="F_EXT_2")
	private String fExt2;
	
	@Column(name ="F_EXT_3")
	private String fExt3;
	
	@Column(name ="F_EXT_4")
	private String fExt4;

	@Column(name ="F_EXT_5")
	private String fExt5;
	//国际旅费：人数、标准、金额
	@Column(name = "F_TRAVEL_PERSON")
	private String travelPerson;
	@Column(name = "COST_TRAVEL_STD")
	private Double travelStd;
	@Column(name = "COST_TRAVEL_MONEY")
	private Double travelMoney;
	//住宿费：人数、标准、天数、金额
	@Column(name = "F_HOTEL_PERSON")
	private String hotelPerson;
	@Column(name = "COST_HOTEL_STD")
	private Double hotelStd;
	@Column(name = "F_HOTEL_DAY")
	private String hotelDay;
	@Column(name = "COST_HOTEL_MONEY")
	private Double hotelMoney;
	//伙食：人数、标准、天数、金额
	@Column(name = "F_FOOD_PERSON")
	private String foodPerson;
	@Column(name = "COST_FOOD_STD")
	private Double foodStd;
	@Column(name = "F_FOOD_DAY")
	private String foodDay;
	@Column(name = "COST_FOOD_MONEY")
	private Double foodMoney;
	//公杂费：人数、标准、天数、金额
	@Column(name = "F_MIX_PERSON")
	private String mixPerson;
	@Column(name = "COST_MIX_STD")
	private Double mixStd;
	@Column(name = "F_MIX_DAY")
	private String mixDay;
	@Column(name = "COST_MIX_MONEY")
	private Double mixMoney;
	//宴请费：人数、标准、天数、金额
	@Column(name = "F_FETE_PERSON")
	private String fetePerson;
	@Column(name = "COST_FETE_STD")
	private Double feteStd;
	@Column(name = "F_FETE_DAY")
	private String feteDay;
	@Column(name = "COST_FETE_MONEY")
	private Double feteMoney;
	//国外交通费：金额
	@Column(name = "COST_TRAFFIC_MONEY")
	private Double trafficMoney;
	
	//以下为其他费用
	//签证费：金额
	@Column(name = "COST_VISA_MONEY")
	private Double visaMoney;
	//保险费：金额
	@Column(name = "COST_PREMIUM_MONEY")
	private Double premiumMoney;
	//防疫费：金额
	@Column(name = "COST_ANTIEPIDEMIC_MONEY")
	private Double antiepidemicMoney;	
	//国际注册费：金额
	@Column(name = "COST_REGISTERING_MONEY")
	private Double registeringMoney;
	//其他费：金额
	@Column(name = "COST_OTHER_MONEY")
	private Double otherMoney;
	//其他费用总金额
	@Column(name = "COST_TOTALOTHER_MONEY")
	private Double totalOtherMoney;
	
	//备注
	@Column(name = "F_REMARK")
	private String remark;

	@Transient
	private String fDiningPlaceChecked;//用于接收是否宴请选中
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getfAbroadDateStart() {
		return fAbroadDateStart;
	}

	public void setfAbroadDateStart(Date fAbroadDateStart) {
		this.fAbroadDateStart = fAbroadDateStart;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getfAbroadDateEnd() {
		return fAbroadDateEnd;
	}

	public void setfAbroadDateEnd(Date fAbroadDateEnd) {
		this.fAbroadDateEnd = fAbroadDateEnd;
	}

	public Integer getFaId() {
		return faId;
	}

	public void setFaId(Integer faId) {
		this.faId = faId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getfAbroadDayNum() {
		return fAbroadDayNum;
	}

	public void setfAbroadDayNum(String fAbroadDayNum) {
		this.fAbroadDayNum = fAbroadDayNum;
	}

	public String getfAbroadPeople() {
		return fAbroadPeople;
	}

	public void setfAbroadPeople(String fAbroadPeople) {
		this.fAbroadPeople = fAbroadPeople;
	}

	public String getfTasjType() {
		return fTasjType;
	}

	public void setfTasjType(String fTasjType) {
		this.fTasjType = fTasjType;
	}

	public String getfAbroadPlace() {
		return fAbroadPlace;
	}

	public void setfAbroadPlace(String fAbroadPlace) {
		this.fAbroadPlace = fAbroadPlace;
	}

	public String getfVehicle() {
		return fVehicle;
	}

	public void setfVehicle(String fVehicle) {
		this.fVehicle = fVehicle;
	}

	public String getfVehicleLevel() {
		return fVehicleLevel;
	}

	public void setfVehicleLevel(String fVehicleLevel) {
		this.fVehicleLevel = fVehicleLevel;
	}

	public Integer getfDiningPlace() {
		return fDiningPlace;
	}

	public void setfDiningPlace(Integer fDiningPlace) {
		this.fDiningPlace = fDiningPlace;
	}

	public String getfTeamName() {
		return fTeamName;
	}

	public void setfTeamName(String fTeamName) {
		this.fTeamName = fTeamName;
	}

	public String getfTeamLeader() {
		return fTeamLeader;
	}

	public void setfTeamLeader(String fTeamLeader) {
		this.fTeamLeader = fTeamLeader;
	}

	public String getfTeamPersonNum() {
		return fTeamPersonNum;
	}

	public void setfTeamPersonNum(String fTeamPersonNum) {
		this.fTeamPersonNum = fTeamPersonNum;
	}

	public String getfExt1() {
		return fExt1;
	}

	public void setfExt1(String fExt1) {
		this.fExt1 = fExt1;
	}

	public String getfExt2() {
		return fExt2;
	}

	public void setfExt2(String fExt2) {
		this.fExt2 = fExt2;
	}

	public String getfExt3() {
		return fExt3;
	}

	public void setfExt3(String fExt3) {
		this.fExt3 = fExt3;
	}

	public String getfExt4() {
		return fExt4;
	}

	public void setfExt4(String fExt4) {
		this.fExt4 = fExt4;
	}

	public String getfExt5() {
		return fExt5;
	}

	public void setfExt5(String fExt5) {
		this.fExt5 = fExt5;
	}

	public String getTravelPerson() {
		return travelPerson;
	}

	public void setTravelPerson(String travelPerson) {
		this.travelPerson = travelPerson;
	}

	public Double getTravelStd() {
		return travelStd;
	}

	public void setTravelStd(Double travelStd) {
		this.travelStd = travelStd;
	}

	public Double getTravelMoney() {
		return travelMoney;
	}

	public void setTravelMoney(Double travelMoney) {
		this.travelMoney = travelMoney;
	}

	public String getHotelPerson() {
		return hotelPerson;
	}

	public void setHotelPerson(String hotelPerson) {
		this.hotelPerson = hotelPerson;
	}

	public Double getHotelStd() {
		return hotelStd;
	}

	public void setHotelStd(Double hotelStd) {
		this.hotelStd = hotelStd;
	}

	public String getHotelDay() {
		return hotelDay;
	}

	public void setHotelDay(String hotelDay) {
		this.hotelDay = hotelDay;
	}

	public Double getHotelMoney() {
		return hotelMoney;
	}

	public void setHotelMoney(Double hotelMoney) {
		this.hotelMoney = hotelMoney;
	}

	public String getFoodPerson() {
		return foodPerson;
	}

	public void setFoodPerson(String foodPerson) {
		this.foodPerson = foodPerson;
	}

	public Double getFoodStd() {
		return foodStd;
	}

	public void setFoodStd(Double foodStd) {
		this.foodStd = foodStd;
	}

	public String getFoodDay() {
		return foodDay;
	}

	public void setFoodDay(String foodDay) {
		this.foodDay = foodDay;
	}

	public Double getFoodMoney() {
		return foodMoney;
	}

	public void setFoodMoney(Double foodMoney) {
		this.foodMoney = foodMoney;
	}

	public String getMixPerson() {
		return mixPerson;
	}

	public void setMixPerson(String mixPerson) {
		this.mixPerson = mixPerson;
	}

	public Double getMixStd() {
		return mixStd;
	}

	public void setMixStd(Double mixStd) {
		this.mixStd = mixStd;
	}

	public String getMixDay() {
		return mixDay;
	}

	public void setMixDay(String mixDay) {
		this.mixDay = mixDay;
	}

	public Double getMixMoney() {
		return mixMoney;
	}

	public void setMixMoney(Double mixMoney) {
		this.mixMoney = mixMoney;
	}

	public String getFetePerson() {
		return fetePerson;
	}

	public void setFetePerson(String fetePerson) {
		this.fetePerson = fetePerson;
	}

	public Double getFeteStd() {
		return feteStd;
	}

	public void setFeteStd(Double feteStd) {
		this.feteStd = feteStd;
	}

	public String getFeteDay() {
		return feteDay;
	}

	public void setFeteDay(String feteDay) {
		this.feteDay = feteDay;
	}

	public Double getFeteMoney() {
		return feteMoney;
	}

	public void setFeteMoney(Double feteMoney) {
		this.feteMoney = feteMoney;
	}

	public Double getTrafficMoney() {
		return trafficMoney;
	}

	public void setTrafficMoney(Double trafficMoney) {
		this.trafficMoney = trafficMoney;
	}

	public Double getVisaMoney() {
		return visaMoney;
	}

	public void setVisaMoney(Double visaMoney) {
		this.visaMoney = visaMoney;
	}

	public Double getPremiumMoney() {
		return premiumMoney;
	}

	public void setPremiumMoney(Double premiumMoney) {
		this.premiumMoney = premiumMoney;
	}

	public Double getAntiepidemicMoney() {
		return antiepidemicMoney;
	}

	public void setAntiepidemicMoney(Double antiepidemicMoney) {
		this.antiepidemicMoney = antiepidemicMoney;
	}

	public Double getRegisteringMoney() {
		return registeringMoney;
	}

	public void setRegisteringMoney(Double registeringMoney) {
		this.registeringMoney = registeringMoney;
	}

	public Double getOtherMoney() {
		return otherMoney;
	}

	public void setOtherMoney(Double otherMoney) {
		this.otherMoney = otherMoney;
	}

	public Double getTotalOtherMoney() {
		return totalOtherMoney;
	}

	public void setTotalOtherMoney(Double totalOtherMoney) {
		this.totalOtherMoney = totalOtherMoney;
	}

	public String getfThisUnitTeamPersonNum() {
		return fThisUnitTeamPersonNum;
	}

	public void setfThisUnitTeamPersonNum(String fThisUnitTeamPersonNum) {
		this.fThisUnitTeamPersonNum = fThisUnitTeamPersonNum;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getfDiningPlaceChecked() {
		return fDiningPlaceChecked;
	}

	public void setfDiningPlaceChecked(String fDiningPlaceChecked) {
		this.fDiningPlaceChecked = fDiningPlaceChecked;
	}

	
}
