package com.braker.icontrol.expend.apply.model;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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
import com.braker.common.util.DateUtil;
import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 出国计划model
 * @author 张迅
 * @createtime 2020-02-13
 */
@Entity
@Table(name = "t_abroad_plan")
public class AbroadPlan extends BaseEntity{
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer planId;				//主键ID
	
	@Column(name = "F_A_ID")
	private Integer aId;				//出国信息ID
	
	@Column(name = "F_G_ID")
	private Integer gId;				//申请信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//报销信息ID
	
	@Column(name = "F_ABROAD_DATE")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date abroadDate;				//出访日期
	
	@Column(name = "F_ARRIVE_COUNTRY_ID")
	private Integer arriveCountryId;				//到达国家ID
	
	@Column(name = "F_ARRIVE_COUNTRY")
	private String arriveCountry;				//到达国家
	
	@Column(name = "F_ARRIVE_CITY")
	private String arriveCity;				//到达城市
	
	@Column(name = "F_TYPE")
	private String type;				//类型

	@Column(name = "F_VEHICLE")
	private String vehicle;			//交通工具
	
	@Column(name = "F_VEHICLELEVEL")
	private String vehicleLevel;			//交通工具级别
	
	@Column(name = "F_TIME_START")
	private Date timeStart;				//起始日期
	
	@Column(name = "F_TIME_END")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date timeEnd;				//结束日期
	
	@Column(name = "F_STAY_HOURS")
	private String stayHours;				//停留时间

	@Column(name = "F_REMARK")
	private String remark;				//备注
	
	@Transient
	private Integer startMonth;				//开始月
	
	@Transient
	private Integer startDay;				//开始日
	
	@Transient
	private Integer endMonth;				//结束月
	
	@Transient
	private Integer endDay;				//结束日
	
	@Transient
	private Integer dayNum;				//天数
	
	@Transient
	private Integer peopleNum;				//人数
	
	@Transient
	private String standardAmount;				//标准金额
	
	@Transient
	private BigDecimal reimbAmount;				//报销金额
	
	@Transient
	private String timeEndSort;				//结束时间排序
	
	@Column(name = "F_STATUS")
	private Integer status;				//状态值easyui插件中带的，装换json时用(数据库中没有)

	
	public void setStatus(Integer status) {
		this.status = status;
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

	public Integer getArriveCountryId() {
		return arriveCountryId;
	}

	public void setArriveCountryId(Integer arriveCountryId) {
		this.arriveCountryId = arriveCountryId;
	}

	public Integer getPlanId() {
		return planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public Integer getaId() {
		return aId;
	}

	public void setaId(Integer aId) {
		this.aId = aId;
	}

	public Date getAbroadDate() {
		return abroadDate;
	}

	public void setAbroadDate(Date abroadDate) {
		this.abroadDate = abroadDate;
	}

	public String getArriveCountry() {
		return arriveCountry;
	}

	public void setArriveCountry(String arriveCountry) {
		this.arriveCountry = arriveCountry;
	}

	public String getArriveCity() {
		return arriveCity;
	}

	public void setArriveCity(String arriveCity) {
		this.arriveCity = arriveCity;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getStayHours() {
		return stayHours;
	}

	public void setStayHours(String stayHours) {
		this.stayHours = stayHours;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStatus() {
		return status;
	}

	public Integer getStartMonth() {
		return startMonth;
	}

	public void setStartMonth(Integer startMonth) {
		this.startMonth = startMonth;
	}

	public Integer getStartDay() {
		return startDay;
	}

	public void setStartDay(Integer startDay) {
		this.startDay = startDay;
	}

	public Integer getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(Integer endMonth) {
		this.endMonth = endMonth;
	}

	public Integer getEndDay() {
		return endDay;
	}

	public void setEndDay(Integer endDay) {
		this.endDay = endDay;
	}

	public void setDayNum(Integer dayNum) {
		this.dayNum = dayNum;
	}

	public Integer getDayNum() {
		return dayNum;
	}

	public void setPeopleNum(Integer peopleNum) {
		this.peopleNum = peopleNum;
	}

	public Integer getPeopleNum() {
		return peopleNum;
	}

	public String getStandardAmount() {
		return standardAmount;
	}

	public void setStandardAmount(String standardAmount) {
		this.standardAmount = standardAmount;
	}

	public BigDecimal getReimbAmount() {
		return reimbAmount;
	}

	public void setReimbAmount(BigDecimal reimbAmount) {
		this.reimbAmount = reimbAmount;
	}

	
	public String getTimeEndSort() {
		return DateUtil.formatDate(timeEnd);
	}

	public void setTimeEndSort(String timeEndSort) {
		this.timeEndSort = timeEndSort;
	}

	
	
}
