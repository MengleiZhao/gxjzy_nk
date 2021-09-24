package com.braker.icontrol.expend.standard.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 会议费用的配置信息
 * @author 张迅
 * @createtime 2019-05-24
 * @updatetime 2019-05-24
 */
@Entity
@Table(name = "T_MEET_STANDARD")
public class MeetStandard extends Standard {
	
	
	/** 业务字段 **/
	
	@Column(name = "T_COST_HOTEL")
	private Double costHotel;						//住宿费
	
	@Column(name = "T_COST_FOOD")
	private Double costFood;						//伙食费
	
	@Column(name = "T_COST_OTHER")
	private Double costOther;						//其他费用
	
	@Column(name = "T_COST_LEVEL")
	private String costLevel; 						//会议级别  1-一类，2-二类 ，3-三/四类
	@Column(name = "F_MEET_TYPE")
	private Integer meetType;						//会议类型 1-一类会议。2-二类会议 3-三类会议 4-四类会议
	
	@Transient
	private int pageOrder; 							//页面显示排序

	/** getter/setter **/
	
	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Double getCostHotel() {
		return costHotel;
	}

	public void setCostHotel(Double costHotel) {
		this.costHotel = costHotel;
	}

	public Double getCostFood() {
		return costFood;
	}

	public void setCostFood(Double costFood) {
		this.costFood = costFood;
	}

	public Double getCostOther() {
		return costOther;
	}

	public void setCostOther(Double costOther) {
		this.costOther = costOther;
	}

	public String getCostLevel() {
		return costLevel;
	}

	public void setCostLevel(String costLevel) {
		this.costLevel = costLevel;
	}

	public Integer getMeetType() {
		return meetType;
	}

	public void setMeetType(Integer meetType) {
		this.meetType = meetType;
	}

	
	
	
}

