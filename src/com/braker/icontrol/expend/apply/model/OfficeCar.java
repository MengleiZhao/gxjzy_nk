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

import org.springframework.beans.factory.annotation.Autowired;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 公务用车详情表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_OFFICE_CAR")
public class OfficeCar extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_OC_ID")
	private Integer focID;
	
	@Column(name = "F_G_ID")
	private Integer gId;//外键
	
	@Column(name = "F_R_ID")
	private Integer rId;//报销主表关联字段
	
	@Column(name ="F_USE_TIME")
	private Date fUseTime;//用车时间
	
	@Column(name ="F_CAR_TYPE")
	private String fCarType;//用车类型
	
	@Column(name ="F_USE_TYPE")
	private String fUseType;//费用类型
	
	@Column(name ="F_EXPENSE_NAME")
	private String fExpenseName;//费用名称
	
	@Column(name ="F_USE_AMOUNT")
	private Double fUseAmount;//申请费用
	
	@Column(name ="F_USER_NUMBER")
	private Integer fUserNumber;//乘车人数
	
	@Column(name ="F_USE_REMARK")
	private String fUseRemark;//用车事由
	
	@Column(name ="F_CAR_NUM")
	private String fCarNum;//车牌号
	
	@Column(name ="F_DRIVING_ROUTE")
	private String fDrivingRoute;//行车线路
	
	@Column(name ="F_REMARK")
	private String fRemark;//备注
	
	@Column(name ="F_LAST_TIME")
	private Date fLastTime;//上次保养时间
	
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

	@Column(name = "F_STATUS")
	private Integer fStatus;//数据状态0-事前申请，1-事后报销
	
	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public Integer getFocID() {
		return focID;
	}

	public void setFocID(Integer focID) {
		this.focID = focID;
	}


	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public String getfUseType() {
		return fUseType;
	}

	public void setfUseType(String fUseType) {
		this.fUseType = fUseType;
	}

	public String getfExpenseName() {
		return fExpenseName;
	}

	public void setfExpenseName(String fExpenseName) {
		this.fExpenseName = fExpenseName;
	}

	public Double getfUseAmount() {
		return fUseAmount;
	}

	public void setfUseAmount(Double fUseAmount) {
		this.fUseAmount = fUseAmount;
	}

	public String getfCarNum() {
		return fCarNum;
	}

	public void setfCarNum(String fCarNum) {
		this.fCarNum = fCarNum;
	}

	public Date getfLastTime() {
		return fLastTime;
	}

	public void setfLastTime(Date fLastTime) {
		this.fLastTime = fLastTime;
	}

	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getfUseTime() {
		return fUseTime;
	}

	public void setfUseTime(Date fUseTime) {
		this.fUseTime = fUseTime;
	}

	public String getfCarType() {
		return fCarType;
	}

	public void setfCarType(String fCarType) {
		this.fCarType = fCarType;
	}

	public Integer getfUserNumber() {
		return fUserNumber;
	}

	public void setfUserNumber(Integer fUserNumber) {
		this.fUserNumber = fUserNumber;
	}

	public String getfUseRemark() {
		return fUseRemark;
	}

	public void setfUseRemark(String fUseRemark) {
		this.fUseRemark = fUseRemark;
	}

	public String getfDrivingRoute() {
		return fDrivingRoute;
	}

	public void setfDrivingRoute(String fDrivingRoute) {
		this.fDrivingRoute = fDrivingRoute;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
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
	
	
}
