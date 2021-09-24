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
 * 国际旅费model
 * @author 赵孟雷
 * @createtime 2020-05-20
 */
@Entity
@Table(name = "T_INTERNATIONAL_TRAVELING_EXPENSE")
public class InternationalTravelingExpense extends BaseEntity{
	@Id
	@Column(name = "F_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer iId;				//主键ID
	
	@Column(name = "F_G_ID")
	private Integer gId;				//申请ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//报销ID

	@Column(name = "F_TIME_START")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date timeStart;				//起始日期
	
	@Column(name = "F_TIME_END")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date timeEnd;				//结束日期
	
	@Column(name = "F_START_CITY")
	private String startCity;				//出发城市
	
	@Column(name = "F_ARRIVE_CITY")
	private String arriveCity;				//到达城市

	@Column(name = "F_VEHICLE")
	private String vehicle;			        //交通工具
	
	@Column(name = "F_VEHICLE_LEVEL")
	private String vehicleLevel;			        //交通工具级别
	
	@Column(name = "F_TRAIN_SUBSIDIES")
	private BigDecimal trainSubsidies;			//国际列车补助(美元)
	
	@Column(name = "F_APPLY_AMOUNT")
	private BigDecimal applyAmount;				//申请费用
	
	@Column(name = "F_STATUS")
	private Integer fStatus;				//状态   0申请   1报销

	@Transient
	private String vehicleText;            //用于交通工具文本显示
	
	public String getVehicleText() {
		return vehicleText;
	}

	public void setVehicleText(String vehicleText) {
		this.vehicleText = vehicleText;
	}

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public Integer getiId() {
		return iId;
	}

	public void setiId(Integer iId) {
		this.iId = iId;
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

	public Date getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(Date timeStart) {
		this.timeStart = timeStart;
	}

	public Date getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(Date timeEnd) {
		this.timeEnd = timeEnd;
	}

	public String getStartCity() {
		return startCity;
	}

	public void setStartCity(String startCity) {
		this.startCity = startCity;
	}

	public String getArriveCity() {
		return arriveCity;
	}

	public void setArriveCity(String arriveCity) {
		this.arriveCity = arriveCity;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public BigDecimal getTrainSubsidies() {
		return trainSubsidies;
	}

	public void setTrainSubsidies(BigDecimal trainSubsidies) {
		this.trainSubsidies = trainSubsidies;
	}

	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}

	public String getVehicleLevel() {
		return vehicleLevel;
	}

	public void setVehicleLevel(String vehicleLevel) {
		this.vehicleLevel = vehicleLevel;
	}
	
	
}
