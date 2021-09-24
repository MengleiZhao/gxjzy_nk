package com.braker.icontrol.expend.apply.model;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 师资费用各项明细信息model
 * @author 沈帆
 * @createtime 2020-05-13
 * @updatetime 2020-05-13
 */
@Entity
@Table(name = "T_TRAIN_TEACHER_COST")
public class TrainTeacherCost extends BaseEntity{
	@Id
	@Column(name = "F_TH_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer thId;							//主键ID
	
	@Column(name = "F_T_ID")
	private Integer tId;							//培训信息ID
	
	@Column(name = "F_LECTURER_NAME")
	private String lecturerName;					// 讲师姓名
	
	@Column(name = "F_LECTURER_NUMBER")
	private String fIdentityNumber;					// 讲师身份证号
	
	@Column(name = "F_LECTURER_TIME")
	private String lessonTime;						// 学时
	
	@Column(name = "F_LESSON_STD")
	private String lessonStd;						//讲课费-费用标准
	
	@Column(name = "F_REALITY_LESSON_STD")
	private String realityLessonStd;				//讲课费-实际费用标准
	
	@Column(name = "F_LESSON_STD_TOTAL")
	private String lessonStdTotal;					//讲课费-费用标准总额（正常）
	
	@Column(name = "F_LESSON_STD_TOTAL_UP")
	private String lessonStdTotalUp;				//讲课费-费用标准总额（上浮）
	
	@Column(name = "F_AMOUNT")
	private BigDecimal applySum;						//申请金额
	
	@Column(name = "F_RIMB_AMOUNT")
	private BigDecimal reimbSum;						//报销金额
	
	@Column(name = "F_HOTEL_DAY")
	private String hotelDay;						//住宿费-人/天
	
	@Column(name = "F_HOTEL_STD")
	private String hotelStd;						//住宿费-费用标准

	@Column(name = "F_REALITY_HOTEL_STD")
	private BigDecimal realityHotelStd;					//住宿费-实际费用标准
	
	@Column(name = "F_HOTEL_STD_TOTAL")
	private String hotelStdTotal;					//住宿费-费用标准总额
	
	@Column(name = "F_FOOD_DAY")
	private String foodDay;							//伙食费-人/天
	
	@Column(name = "F_FOOD_STD")
	private String foodStd;							//伙食费-费用标准

	@Column(name = "F_REALITY_FOOD_STD")
	private BigDecimal realityFoodStd;					//伙食费-实际费用标准
	
	@Column(name = "F_FOOD_STD_TOTAL")
	private String foodStdTotal;					//伙食费-费用标准总额
	
	@Column(name = "F_ADMINISTRATIVE_LEVEL")
	private String administrativeLevel;				//行政级别
	
	@Column(name = "F_ADMINISTRATIVE_LEVEL_NAME")
	private String administrativeLevelName;				//行政级别名称
	
	@Column(name = "F_VEHICLE")
	private String vehicle;         				//交通工具
	
	@Column(name = "F_VEHICLE_LEVEL")
	private String vehicleLevel;    				//交通工具级别
	
	@Column(name = "F_COST_TYPE")
	private String costType;    					//费用类型
	
	@Column(name = "F_IS_OUTSIDE")
	private String isOutside;						//是否异地（0-否，1-是）
	
	@Column(name = "F_COST_NAME")
	private String costName;						//费用名称
	
	@Column(name = "F_REMARK")
	private String remark;							//备注
	
	@Column(name = "F_NET_AMOUNT")
	private BigDecimal fNetAmount;						//实发金额
	
	@Column(name = "F_INDIVIDUAL_INCOME_TAX")
	private BigDecimal fIndividualIncomeTax;			//个人所得税
	
	public BigDecimal getRealityHotelStd() {
		return realityHotelStd;
	}

	public void setRealityHotelStd(BigDecimal realityHotelStd) {
		this.realityHotelStd = realityHotelStd;
	}

	public BigDecimal getRealityFoodStd() {
		return realityFoodStd;
	}

	public void setRealityFoodStd(BigDecimal realityFoodStd) {
		this.realityFoodStd = realityFoodStd;
	}

	public String getfIdentityNumber() {
		return fIdentityNumber;
	}

	public void setfIdentityNumber(String fIdentityNumber) {
		this.fIdentityNumber = fIdentityNumber;
	}

	public BigDecimal getfNetAmount() {
		return fNetAmount;
	}

	public void setfNetAmount(BigDecimal fNetAmount) {
		this.fNetAmount = fNetAmount;
	}

	public String getRealityLessonStd() {
		return realityLessonStd;
	}

	public void setRealityLessonStd(String realityLessonStd) {
		this.realityLessonStd = realityLessonStd;
	}

	public BigDecimal getfIndividualIncomeTax() {
		return fIndividualIncomeTax;
	}

	public void setfIndividualIncomeTax(BigDecimal fIndividualIncomeTax) {
		this.fIndividualIncomeTax = fIndividualIncomeTax;
	}

	public String getCostName() {
		return costName;
	}

	public void setCostName(String costName) {
		this.costName = costName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getFoodDay() {
		return foodDay;
	}

	public void setFoodDay(String foodDay) {
		this.foodDay = foodDay;
	}

	public String getHotelDay() {
		return hotelDay;
	}

	public void setHotelDay(String hotelDay) {
		this.hotelDay = hotelDay;
	}

	public String getLessonTime() {
		return lessonTime;
	}

	public void setLessonTime(String lessonTime) {
		this.lessonTime = lessonTime;
	}

	public Integer getThId() {
		return thId;
	}

	public void setThId(Integer thId) {
		this.thId = thId;
	}

	public Integer gettId() {
		return tId;
	}

	public void settId(Integer tId) {
		this.tId = tId;
	}

	public String getLecturerName() {
		return lecturerName;
	}

	public void setLecturerName(String lecturerName) {
		this.lecturerName = lecturerName;
	}

	public String getLessonStd() {
		return lessonStd;
	}

	public void setLessonStd(String lessonStd) {
		this.lessonStd = lessonStd;
	}

	public String getLessonStdTotal() {
		return lessonStdTotal;
	}

	public void setLessonStdTotal(String lessonStdTotal) {
		this.lessonStdTotal = lessonStdTotal;
	}

	public String getLessonStdTotalUp() {
		return lessonStdTotalUp;
	}

	public void setLessonStdTotalUp(String lessonStdTotalUp) {
		this.lessonStdTotalUp = lessonStdTotalUp;
	}

	public BigDecimal getApplySum() {
		return applySum;
	}

	public void setApplySum(BigDecimal applySum) {
		this.applySum = applySum;
	}

	public String getHotelStd() {
		return hotelStd;
	}

	public void setHotelStd(String hotelStd) {
		this.hotelStd = hotelStd;
	}

	public String getHotelStdTotal() {
		return hotelStdTotal;
	}

	public void setHotelStdTotal(String hotelStdTotal) {
		this.hotelStdTotal = hotelStdTotal;
	}

	public String getFoodStd() {
		return foodStd;
	}

	public void setFoodStd(String foodStd) {
		this.foodStd = foodStd;
	}

	public String getFoodStdTotal() {
		return foodStdTotal;
	}

	public void setFoodStdTotal(String foodStdTotal) {
		this.foodStdTotal = foodStdTotal;
	}

	public String getAdministrativeLevel() {
		return administrativeLevel;
	}

	public void setAdministrativeLevel(String administrativeLevel) {
		this.administrativeLevel = administrativeLevel;
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

	public String getCostType() {
		return costType;
	}

	public void setCostType(String costType) {
		this.costType = costType;
	}

	public String getIsOutside() {
		return isOutside;
	}

	public void setIsOutside(String isOutside) {
		this.isOutside = isOutside;
	}

	public BigDecimal getReimbSum() {
		return reimbSum;
	}

	public void setReimbSum(BigDecimal reimbSum) {
		this.reimbSum = reimbSum;
	}

	public String getAdministrativeLevelName() {
		return administrativeLevelName;
	}

	public void setAdministrativeLevelName(String administrativeLevelName) {
		this.administrativeLevelName = administrativeLevelName;
	}
}
