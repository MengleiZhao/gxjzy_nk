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

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 事前申请、事后报销   城市间交通表
 * @author 赵孟雷
 *
 */
@Entity
@Table(name ="T_OUTSIDE_TRADDIC_INFO")
public class OutsideTrafficInfo extends BaseEntity {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_O_ID")
	private Integer fOId;           //主键ID

	@Column(name = "F_G_ID")
	private Integer gId;			//ApplicationBasicInfo 的主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//ReimbAppliBasicInfo的主键ID

	@Column(name = "F_TRAVAL_TYPE")
	private String travelType;			//出差类型
	
	@Column(name = "F_START_DATE")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	private Date fStartDate;		//出发日期
	
	@Column(name = "F_END_DATE")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	private Date fEndDate;			//到达日期
	
	@Column(name = "VEHICLE")
	private String vehicle;         //交通工具
	
	@Column(name = "VEHICLE_ID")
	private String vehicleId;         //交通工具id
	
	@Column(name = "VEHICLE_LEVEL")
	private String vehicleLevel;    //交通工具级别
	
	@Column(name = "TRAVEL_PERSONNEL")  //出行人员
	private String travelPersonnel;
	
	@Column(name = "TRAVEL_PERSONNEL_ID")  //出行人员ID
	private String travelPersonnelId;

	@Column(name = "TRAVEL_PERSONNEL_LEVEL")  //出行人员级别
	private String travelPersonnelLevel;
	
	@Column(name = "F_APPLY_AMOUNT")
	private BigDecimal applyAmount;			//申请金额（元）
	
	@Column(name = "F_REIMB_AMOUNT")
	private BigDecimal reimbAmount;			//报销金额（元）
	
	@Column(name = "F_STATUS")
	private String sts;			//状态      数据状态0-事前申请，1-事后报销
	
	@Column(name = "DEPARTURE_PLACE")  //出发地
	private String departurePlace;
	
	@Column(name = "DESTINATION")  //目的地
	private String destination;

	@Transient
	private Integer num;         //数量
	
	public String getTravelPersonnelLevel() {
		return travelPersonnelLevel;
	}

	public void setTravelPersonnelLevel(String travelPersonnelLevel) {
		this.travelPersonnelLevel = travelPersonnelLevel;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public String getTravelPersonnelId() {
		return travelPersonnelId;
	}

	public void setTravelPersonnelId(String travelPersonnelId) {
		this.travelPersonnelId = travelPersonnelId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getfOId() {
		return fOId;
	}

	public void setfOId(Integer fOId) {
		this.fOId = fOId;
	}

	public Date getfStartDate() {
		return fStartDate;
	}

	public void setfStartDate(Date fStartDate) {
		this.fStartDate = fStartDate;
	}

	public Date getfEndDate() {
		return fEndDate;
	}

	public void setfEndDate(Date fEndDate) {
		this.fEndDate = fEndDate;
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

	public String getTravelPersonnel() {
		return travelPersonnel;
	}

	public void setTravelPersonnel(String travelPersonnel) {
		this.travelPersonnel = travelPersonnel;
	}

	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}

	public BigDecimal getReimbAmount() {
		return reimbAmount;
	}

	public void setReimbAmount(BigDecimal reimbAmount) {
		this.reimbAmount = reimbAmount;
	}

	public String getSts() {
		return sts;
	}

	public void setSts(String sts) {
		this.sts = sts;
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

	public String getDeparturePlace() {
		return departurePlace;
	}

	public void setDeparturePlace(String departurePlace) {
		this.departurePlace = departurePlace;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getVehicleId() {
		return vehicleId;
	}

	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}
	
	
	
}
