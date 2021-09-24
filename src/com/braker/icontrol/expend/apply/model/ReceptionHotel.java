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
 * 公务接待住宿费明细
 * @author 沈帆
 *
 */
@Entity
@Table(name ="T_RECEPTION_HOTEL")
public class ReceptionHotel extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_H_ID")
	private Integer hID;
	
	@Column(name = "F_G_ID")
	private Integer gId;			//申请信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//报销信息ID
	
	@Column(name ="F_NAME")
	private String fName;       //姓名
	
	@Column(name = "F_POSITION")
	private String position;			//职务
	
	@Column(name = "F_POSITION_CODE")
	private String positionCode;			//职务代码
	
	@Column(name ="F_ROOM_TYPE")
	private String fRoomType;        //房型
	
	@Column(name ="F_COST_STD")
	private String fCostStd;  //费用标准
	
	@Column(name ="F_DAYS")
	private String fDays; //住宿天数
	
	@Column(name ="F_COST_HOTEL")
	private Double fCostHotel;//房费小计
	
	@Column(name ="F_PLACE")
	private String fPlace;//地点
	
	
	@Column(name ="F_START_TIME")
	private Date fStartTime;//入住时间
	
	@Column(name ="F_END_TIME")
	private Date fEndTime;//退房时间
	
	@Transient
	private Integer personNum;//人数


	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer gethID() {
		return hID;
	}

	public void sethID(Integer hID) {
		this.hID = hID;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getfRoomType() {
		return fRoomType;
	}

	public void setfRoomType(String fRoomType) {
		this.fRoomType = fRoomType;
	}

	public String getfCostStd() {
		return fCostStd;
	}

	public void setfCostStd(String fCostStd) {
		this.fCostStd = fCostStd;
	}

	public String getfDays() {
		return fDays;
	}

	public void setfDays(String fDays) {
		this.fDays = fDays;
	}

	public Double getfCostHotel() {
		return fCostHotel;
	}

	public void setfCostHotel(Double fCostHotel) {
		this.fCostHotel = fCostHotel;
	}

	public String getPositionCode() {
		return positionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public String getfPlace() {
		return fPlace;
	}

	public void setfPlace(String fPlace) {
		this.fPlace = fPlace;
	}

	public Date getfStartTime() {
		return fStartTime;
	}

	public void setfStartTime(Date fStartTime) {
		this.fStartTime = fStartTime;
	}

	public Date getfEndTime() {
		return fEndTime;
	}

	public void setfEndTime(Date fEndTime) {
		this.fEndTime = fEndTime;
	}

	public Integer getPersonNum() {
		return personNum;
	}

	public void setPersonNum(Integer personNum) {
		this.personNum = personNum;
	}

	
	
}
