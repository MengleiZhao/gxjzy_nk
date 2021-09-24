package com.braker.icontrol.expend.apply.model;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 公务接待餐费明细
 * @author 沈帆
 *
 */
@Entity
@Table(name ="T_RECEPTION_FOOD")
public class ReceptionFood extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_F_ID")
	private Integer fID;
	
	@Column(name = "F_G_ID")
	private Integer gId;			//申请信息ID

	@Column(name = "F_R_ID")
	private Integer rId;			//报销信息ID
	
	@Column(name ="F_FOOD_TYPE")
	private String fFoodType;        //类别
	
	@Column(name ="F_COST_STD")
	private String fCostStd;  //费用标准
	
	@Column(name ="F_PERSON_NUM")
	private String fPersonNum;       //就餐人数
	
	@Column(name ="F_OTHER_NUM")
	private String fOtherNum;       //其中陪餐人数
	
	@Column(name ="F_NUM")
	private String fNum; //次数
	
	@Column(name ="F_COST_FOOD")
	private Double fCostFood;//餐费小计
	
	@Column(name ="F_MARK")
	private String mark; //其他费用标识
	
	@Column(name ="F_TIME")
	private Date time; //时间
	
	@Column(name ="F_DATE")
	private Date date; //日期
	
	@Column(name ="F_PLACE")
	private String place; //地点
	
	@Column(name ="F_REIMB_COST_FOOD")
	private Double fReimbCostFood;//报销餐费小计

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

	public Integer getfID() {
		return fID;
	}

	public void setfID(Integer fID) {
		this.fID = fID;
	}

	public String getfFoodType() {
		return fFoodType;
	}

	public void setfFoodType(String fFoodType) {
		this.fFoodType = fFoodType;
	}

	public String getfCostStd() {
		return fCostStd;
	}

	public void setfCostStd(String fCostStd) {
		this.fCostStd = fCostStd;
	}

	public String getfPersonNum() {
		return fPersonNum;
	}

	public void setfPersonNum(String fPersonNum) {
		this.fPersonNum = fPersonNum;
	}

	public String getfNum() {
		return fNum;
	}

	public void setfNum(String fNum) {
		this.fNum = fNum;
	}

	public Double getfCostFood() {
		return fCostFood;
	}

	public void setfCostFood(Double fCostFood) {
		this.fCostFood = fCostFood;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getfOtherNum() {
		return fOtherNum;
	}

	public void setfOtherNum(String fOtherNum) {
		this.fOtherNum = fOtherNum;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public Double getfReimbCostFood() {
		return fReimbCostFood;
	}

	public void setfReimbCostFood(Double fReimbCostFood) {
		this.fReimbCostFood = fReimbCostFood;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}


	
}
