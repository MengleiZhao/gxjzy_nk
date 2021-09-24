package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;


/**
 * 差旅人员信息model
 * @author 沈帆
 * @createtime 2020-01-14
 * @updatetime 2020-01-14
 */
@Entity
@Table(name = "T_TRAVEL_APPLI_PEOPLE_INFO")
public class TravelPeopleInfo extends BaseEntity{
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer travelRId;			//主键ID
	
	@Column(name = "F_TR_ID")
	private Integer trId;				//差旅信息ID
	
	@Column(name = "F_TRAVEL_PEOPLE_NAME")
	private String travelPeopName;	// 差旅人员姓名
	
	@Column(name = "F_POSITION")
	private String position;			//职务
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证号码
	
	@Column(name = "F_PHONENUM")
	private String phoneNum;			//联系方式
	
	@Column(name = "F_VEHICLE")
	private String vehicle;			//交通工具
	
	@Column(name = "F_VEHICLELEVEL")
	private String vehicleLevel;			//交通工具级别
	
	@Column(name = "F_STARTTIME")
	private Date startTime;			//开始时间
	
	@Column(name = "F_ENDTIME")
	private Date endTime;			//结束时间
	
	@Column(name = "F_TRAVELDAYS")
	private String travelDays;			//出差天数
	
	@Column(name = "F_HOTELDAYS")
	private String hotelDays;			//住宿天数
	
	@Column(name = "F_REMARK")
	private String remake;			//备注
	
	@Transient
	private String status;				//状态值easyui插件中带的，装换json时用(数据库中没有)

	
	
	public Integer getTravelRId() {
		return travelRId;
	}

	public void setTravelRId(Integer travelRId) {
		this.travelRId = travelRId;
	}

	public Integer getTrId() {
		return trId;
	}

	public void setTrId(Integer trId) {
		this.trId = trId;
	}

	
	public String getTravelPeopName() {
		return travelPeopName;
	}

	public void setTravelPeopName(String travelPeopName) {
		this.travelPeopName = travelPeopName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getRemake() {
		return remake;
	}

	public void setRemake(String remake) {
		this.remake = remake;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getVehicleLevel() {
		return vehicleLevel;
	}

	public void setVehicleLevel(String vehicleLevel) {
		this.vehicleLevel = vehicleLevel;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getTravelDays() {
		return travelDays;
	}

	public void setTravelDays(String travelDays) {
		this.travelDays = travelDays;
	}

	public String getHotelDays() {
		return hotelDays;
	}

	public void setHotelDays(String hotelDays) {
		this.hotelDays = hotelDays;
	}
	
	
}
