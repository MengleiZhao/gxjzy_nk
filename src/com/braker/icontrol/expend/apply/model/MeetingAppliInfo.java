package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.joda.time.DateTime;
import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 会议费申请信息model
 * 是会议费申请信息的model类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Entity
@Table(name = "T_MEETING_APPLI_INFO")
public class MeetingAppliInfo extends BaseEntity{
	@Id
	@Column(name = "F_M_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer mId;				//主键ID
	
	@Column(name = "F_G_ID")
	private Integer gId;				//事前申请信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//报销信息ID
	
	@Column(name = "F_MEETING_NAME")
	private String meetingName;			//会议名称
	
	@Column(name = "F_MEETING_TYPE")
	private String meetingType;			//会议类型
	
	@Column(name = "F_MEETING_METHOD")
	private String meetingMethod;		//会议召开方式
	
	@Column(name = "F_MEETING_DATE_START")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date dateStart;				//报到时间
	
	@Column(name = "F_MEETING_DATE_END")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date dateEnd;				//离开时间
	
	@Column(name = "F_DURATION")
	private String duration;			//会议历时
	
	@Column(name = "F_MEETING_DAY_NUM")
	private String dayNum;				//会议天数	字段停用
	
	@Column(name = "F_MEETING_PLACE")
	private String meetingPlace;		//会议地点
	
	@Column(name = "F_MEETING_PLACE_EXPLAIN")
	private String placeExplain;		//会议地点说明
	
	@Column(name = "F_ATTEND_PEOPLE")
	private String attendPeople;		//主要参会人员
	
	@Column(name = "F_ATTEND_NUM")
	private String attendNum;			//参会人数
	
	@Column(name = "F_STAFF_NUM")
	private String staffNum;			//工作人员数量
	
	@Column(name = "F_MEETING_CONTENT")
	private String content;				//会议内容
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;			//审批状态
	
	@Column(name = "F_SHENG")
	private String fsheng;			//省
	
	@Column(name = "F_SHI")
	private String fshi;			//市
	
	@Column(name = "F_QU")
	private String fqu;			//区
	
	//住宿费：标准、人数、天数、金额、实际金额
	@Column(name = "COST_HOTEL_STD")
	private Double hotelStd;
	@Column(name = "COST_HOTEL_PERSON_NUM")
	private Integer hotelPersonNum;
	@Column(name = "COST_HOTEL_DAY_NUM")
	private Integer hotelDayNum;
	@Column(name = "COST_HOTEL_MONEY")
	private Double hotelMoney;
	@Column(name = "COST_REALITY_HOTEL_MONEY")
	private Double realityHotelMoney;
	@Transient
	private Double hotelStdSingle;
	
	//伙食费：标准、人数、天数、金额、实际金额
	@Column(name = "COST_FOOD_STD")
	private Double foodStd;
	@Column(name = "COST_FOOD_PERSON_NUM")
	private Integer foodPersonNum;
	@Column(name = "COST_FOOD_DAY_NUM")
	private Integer foodDayNum;
	@Column(name = "COST_FOOD_MONEY")
	private Double foodMoney;
	@Column(name = "COST_REALITY_FOOD_MONEY")
	private Double realityFoodMoney;
	@Transient
	private Double foodStdSingle;
	
	//其它费用：标准、人数、天数、金额、实际金额
	@Column(name = "COST_OTHER_STD")
	private Double otherStd;
	@Column(name = "COST_OTHER_PERSON_NUM")
	private Integer otherPersonNum;
	@Column(name = "COST_OTHER_DAY_NUM")
	private Integer otherDayNum;
	@Column(name = "COST_OTHER_MONEY")
	private Double otherMoney;
	@Column(name = "COST_REALITY_OTHER_MONEY")
	private Double realityOtherMoney;
	@Transient
	private Double otherStdSingle;
	
	//文件印刷费：标准、人数、天数、金额、实际金额
	@Column(name = "COST_PRINTING_STD")
	private Double printingStd;
	@Column(name = "COST_PRINTING_PERSON_NUM")
	private Integer printingPersonNum;
	@Column(name = "COST_PRINTING_DAY_NUM")
	private Integer printingDayNum;
	@Column(name = "COST_PRINTING_MONEY")
	private Double printingMoney;
	@Column(name = "COST_REALITY_PRINTING_MONEY")
	private Double realityPrintingMoney;
	
	//会议场租金：标准、人数、天数、金额、实际金额
	@Column(name = "COST_RENT_STD")
	private Double rentStd;
	@Column(name = "COST_RENT_PERSON_NUM")
	private Integer rentPersonNum;
	@Column(name = "COST_RENT_DAY_NUM")
	private Integer rentDayNum;
	@Column(name = "COST_RENT_MONEY")
	private Double rentMoney;
	@Column(name = "COST_REALITY_RENT_MONEY")
	private Double realityRentMoney;
	
	//交通费：标准、人数、天数、金额、实际金额
	@Column(name = "COST_TRAFFIC_STD")
	private Double trafficStd;
	@Column(name = "COST_TRAFFIC_PERSON_NUM")
	private Integer trafficPersonNum;
	@Column(name = "COST_TRAFFIC_DAY_NUM")
	private Integer trafficDayNum;
	@Column(name = "COST_TRAFFIC_MONEY")
	private Double trafficMoney;
	@Column(name = "COST_REALITY_TRAFFIC_MONEY")
	private Double realityTrafficMoney;
	
	@Transient
	private Integer num;				//序号(数据库中没有)

	
	
	
	
	public String getFsheng() {
		return fsheng;
	}

	public void setFsheng(String fsheng) {
		this.fsheng = fsheng;
	}

	public String getFshi() {
		return fshi;
	}

	public void setFshi(String fshi) {
		this.fshi = fshi;
	}

	public String getFqu() {
		return fqu;
	}

	public void setFqu(String fqu) {
		this.fqu = fqu;
	}

	public Integer getmId() {
		return mId;
	}

	public void setmId(Integer mId) {
		this.mId = mId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public String getMeetingName() {
		return meetingName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

	public String getMeetingType() {
		return meetingType;
	}

	public void setMeetingType(String meetingType) {
		this.meetingType = meetingType;
	}

	public String getMeetingMethod() {
		return meetingMethod;
	}

	public void setMeetingMethod(String meetingMethod) {
		this.meetingMethod = meetingMethod;
	}
	public Date getDateStart() {
		return dateStart;
	}

	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}

	public Date getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(Date dateEnd) {
		this.dateEnd = dateEnd;
	}

	public String getDayNum() {
		return dayNum;
	}

	public void setDayNum(String dayNum) {
		this.dayNum = dayNum;
	}

	public String getMeetingPlace() {
		return meetingPlace;
	}

	public void setMeetingPlace(String meetingPlace) {
		this.meetingPlace = meetingPlace;
	}

	public String getPlaceExplain() {
		return placeExplain;
	}

	public void setPlaceExplain(String placeExplain) {
		this.placeExplain = placeExplain;
	}

	public String getAttendPeople() {
		return attendPeople;
	}

	public void setAttendPeople(String attendPeople) {
		this.attendPeople = attendPeople;
	}

	public String getAttendNum() {
		return attendNum;
	}

	public void setAttendNum(String attendNum) {
		this.attendNum = attendNum;
	}

	public String getStaffNum() {
		return staffNum;
	}

	public void setStaffNum(String staffNum) {
		this.staffNum = staffNum;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public Double getHotelStd() {
		return hotelStd;
	}

	public void setHotelStd(Double hotelStd) {
		this.hotelStd = hotelStd;
	}

	public Integer getHotelPersonNum() {
		return hotelPersonNum;
	}

	public void setHotelPersonNum(Integer hotelPersonNum) {
		this.hotelPersonNum = hotelPersonNum;
	}

	public Integer getHotelDayNum() {
		return hotelDayNum;
	}

	public void setHotelDayNum(Integer hotelDayNum) {
		this.hotelDayNum = hotelDayNum;
	}

	public Double getHotelMoney() {
		return hotelMoney;
	}

	public void setHotelMoney(Double hotelMoney) {
		this.hotelMoney = hotelMoney;
	}

	public Double getFoodStd() {
		return foodStd;
	}

	public void setFoodStd(Double foodStd) {
		this.foodStd = foodStd;
	}

	public Integer getFoodPersonNum() {
		return foodPersonNum;
	}

	public void setFoodPersonNum(Integer foodPersonNum) {
		this.foodPersonNum = foodPersonNum;
	}

	public Integer getFoodDayNum() {
		return foodDayNum;
	}

	public void setFoodDayNum(Integer foodDayNum) {
		this.foodDayNum = foodDayNum;
	}

	public Double getFoodMoney() {
		return foodMoney;
	}

	public void setFoodMoney(Double foodMoney) {
		this.foodMoney = foodMoney;
	}

	public Double getOtherStd() {
		return otherStd;
	}

	public void setOtherStd(Double otherStd) {
		this.otherStd = otherStd;
	}

	public Integer getOtherPersonNum() {
		return otherPersonNum;
	}

	public void setOtherPersonNum(Integer otherPersonNum) {
		this.otherPersonNum = otherPersonNum;
	}

	public Integer getOtherDayNum() {
		return otherDayNum;
	}

	public void setOtherDayNum(Integer otherDayNum) {
		this.otherDayNum = otherDayNum;
	}

	public Double getOtherMoney() {
		return otherMoney;
	}

	public void setOtherMoney(Double otherMoney) {
		this.otherMoney = otherMoney;
	}

	public Double getPrintingStd() {
		return printingStd;
	}

	public void setPrintingStd(Double printingStd) {
		this.printingStd = printingStd;
	}

	public Integer getPrintingPersonNum() {
		return printingPersonNum;
	}

	public void setPrintingPersonNum(Integer printingPersonNum) {
		this.printingPersonNum = printingPersonNum;
	}

	public Integer getPrintingDayNum() {
		return printingDayNum;
	}

	public void setPrintingDayNum(Integer printingDayNum) {
		this.printingDayNum = printingDayNum;
	}

	public Double getPrintingMoney() {
		return printingMoney;
	}

	public void setPrintingMoney(Double printingMoney) {
		this.printingMoney = printingMoney;
	}

	public Double getRentStd() {
		return rentStd;
	}

	public void setRentStd(Double rentStd) {
		this.rentStd = rentStd;
	}

	public Integer getRentPersonNum() {
		return rentPersonNum;
	}

	public void setRentPersonNum(Integer rentPersonNum) {
		this.rentPersonNum = rentPersonNum;
	}

	public Integer getRentDayNum() {
		return rentDayNum;
	}

	public void setRentDayNum(Integer rentDayNum) {
		this.rentDayNum = rentDayNum;
	}

	public Double getRentMoney() {
		return rentMoney;
	}

	public void setRentMoney(Double rentMoney) {
		this.rentMoney = rentMoney;
	}

	public Double getTrafficStd() {
		return trafficStd;
	}

	public void setTrafficStd(Double trafficStd) {
		this.trafficStd = trafficStd;
	}

	public Integer getTrafficPersonNum() {
		return trafficPersonNum;
	}

	public void setTrafficPersonNum(Integer trafficPersonNum) {
		this.trafficPersonNum = trafficPersonNum;
	}

	public Integer getTrafficDayNum() {
		return trafficDayNum;
	}

	public void setTrafficDayNum(Integer trafficDayNum) {
		this.trafficDayNum = trafficDayNum;
	}

	public Double getTrafficMoney() {
		return trafficMoney;
	}

	public void setTrafficMoney(Double trafficMoney) {
		this.trafficMoney = trafficMoney;
	}

	public Double getRealityHotelMoney() {
		return realityHotelMoney;
	}

	public void setRealityHotelMoney(Double realityHotelMoney) {
		this.realityHotelMoney = realityHotelMoney;
	}

	public Double getRealityFoodMoney() {
		return realityFoodMoney;
	}

	public void setRealityFoodMoney(Double realityFoodMoney) {
		this.realityFoodMoney = realityFoodMoney;
	}

	public Double getRealityOtherMoney() {
		return realityOtherMoney;
	}

	public void setRealityOtherMoney(Double realityOtherMoney) {
		this.realityOtherMoney = realityOtherMoney;
	}

	public Double getRealityPrintingMoney() {
		return realityPrintingMoney;
	}

	public void setRealityPrintingMoney(Double realityPrintingMoney) {
		this.realityPrintingMoney = realityPrintingMoney;
	}

	public Double getRealityRentMoney() {
		return realityRentMoney;
	}

	public void setRealityRentMoney(Double realityRentMoney) {
		this.realityRentMoney = realityRentMoney;
	}

	public Double getRealityTrafficMoney() {
		return realityTrafficMoney;
	}

	public void setRealityTrafficMoney(Double realityTrafficMoney) {
		this.realityTrafficMoney = realityTrafficMoney;
	}

	public Double getHotelStdSingle() {
		return hotelStdSingle;
	}

	public void setHotelStdSingle(Double hotelStdSingle) {
		this.hotelStdSingle = hotelStdSingle;
	}

	public Double getFoodStdSingle() {
		return foodStdSingle;
	}

	public void setFoodStdSingle(Double foodStdSingle) {
		this.foodStdSingle = foodStdSingle;
	}

	public Double getOtherStdSingle() {
		return otherStdSingle;
	}

	public void setOtherStdSingle(Double otherStdSingle) {
		this.otherStdSingle = otherStdSingle;
	}

	@Override
	public String toString() {
		return "MeetingAppliInfo [mId=" + mId + ", gId=" + gId
				+ ", meetingName=" + meetingName + ", meetingType="
				+ meetingType + ", meetingMethod=" + meetingMethod
				+ ", dateStart=" + dateStart + ", dateEnd=" + dateEnd
				+ ", dayNum=" + dayNum + ", meetingPlace=" + meetingPlace
				+ ", placeExplain=" + placeExplain + ", attendPeople="
				+ attendPeople + ", attendNum=" + attendNum + ", staffNum="
				+ staffNum + ", content=" + content + ", flowStauts="
				+ flowStauts + ", num=" + num + "]";
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}
	
	
	
}
