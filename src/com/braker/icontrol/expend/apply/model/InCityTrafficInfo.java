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

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 差旅市内交通费
 * @author 陈睿超
 *
 */
@Entity
@Table(name = "T_INCITY_TRAFFIC_INFO")
public class InCityTrafficInfo extends BaseEntity implements EntityDao{
	
	@Id
	@Column(name = "F_T_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer ftId;//主键
	
	@Column(name = "F_G_ID")
	private Integer gId;			//ApplicationBasicInfo 的主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//ReimbAppliBasicInfo的主键ID
	
	@Column(name = "F_LEAVE_RETURN")
	private String fLeaveReturn;//离/返津

	@Column(name = "F_TRAVAL_TYPE")
	private String travelType;			//出差类型
	
	@Column(name = "F_ARRIVALS_DATE")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	private Date fArrivalsDate;//离/返津日期
	
	@Column(name  = "F_APPLY_AMOUNT")
	private Double fApplyAmount;//事前申请金额(元)
	
	@Column(name  = "F_REIMB_AMOUNT")
	private Double fReimbAmount;//报销金额(元)
	
	@Column(name  = "F_STD_AMOUNT")
	private Double fStdAmount;//金额标准(元)
	
	@Column(name = "F_STATUS")
	private Integer fStatus;//数据状态0-事前申请，1-事后报销
	
	@Column(name = "F_DISTANCE_DAY")
	private Integer fDistanceDay;//相隔天数
	
	@Column(name = "F_ADJACENT_DAY")
	private Integer fAdjacentDay;//相邻天数
	
	@Column(name  = "F_PERSON")
	private String fPerson;//出行人员
	
	@Column(name  = "F_PERSON_ID")
	private String fPersonId;//出行人员ID
	
	@Column(name  = "F_SUBSIDY_DAY")
	private String fSubsidyDay;//补贴天数
	
	@Transient
	private Integer num;         //数量
	
	public String getfPersonId() {
		return fPersonId;
	}

	public void setfPersonId(String fPersonId) {
		this.fPersonId = fPersonId;
	}

	public Double getfStdAmount() {
		return fStdAmount;
	}

	public void setfStdAmount(Double fStdAmount) {
		this.fStdAmount = fStdAmount;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public Integer getfDistanceDay() {
		return fDistanceDay;
	}

	public void setfDistanceDay(Integer fDistanceDay) {
		this.fDistanceDay = fDistanceDay;
	}

	public Integer getfAdjacentDay() {
		return fAdjacentDay;
	}

	public void setfAdjacentDay(Integer fAdjacentDay) {
		this.fAdjacentDay = fAdjacentDay;
	}

	public String getfSubsidyDay() {
		return fSubsidyDay;
	}

	public void setfSubsidyDay(String fSubsidyDay) {
		this.fSubsidyDay = fSubsidyDay;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getFtId() {
		return ftId;
	}

	public void setFtId(Integer ftId) {
		this.ftId = ftId;
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

	public String getfLeaveReturn() {
		return fLeaveReturn;
	}

	public void setfLeaveReturn(String fLeaveReturn) {
		this.fLeaveReturn = fLeaveReturn;
	}

	public Date getfArrivalsDate() {
		return fArrivalsDate;
	}

	public void setfArrivalsDate(Date fArrivalsDate) {
		this.fArrivalsDate = fArrivalsDate;
	}

	public Double getfApplyAmount() {
		return fApplyAmount;
	}

	public void setfApplyAmount(Double fApplyAmount) {
		this.fApplyAmount = fApplyAmount;
	}

	public Double getfReimbAmount() {
		return fReimbAmount;
	}

	public void setfReimbAmount(Double fReimbAmount) {
		this.fReimbAmount = fReimbAmount;
	}

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public String getfPerson() {
		return fPerson;
	}

	public void setfPerson(String fPerson) {
		this.fPerson = fPerson;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_INCITY_TRAFFIC_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(ftId);
	}

	
	
	
	
}
