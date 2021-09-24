package com.braker.icontrol.expend.apply.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 人员差旅记录表model
 * @author 叶崇晖
 * @createtime 2019-01-23
 * @updatetime 2019-01-23
 */
@Entity
@Table(name = "T_TRAVEL_RECORD")
public class TravelRecord extends BaseEntityEmpty {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;				//主键ID
	
	@Column(name = "F_G_CODE")
	private String gCode;				//事前申请单编码
	
	@Column(name = "F_USER_ID")
	private String userId;				//人员ID
	
	@Column(name = "F_TYPE")
	private String type;				//记录类型
	
	@Column(name = "F_PLACE_CODE")
	private String placeCode;			//地点编码

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	
	public String getgCode() {
		return gCode;
	}

	public void setgCode(String gCode) {
		this.gCode = gCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPlaceCode() {
		return placeCode;
	}

	public void setPlaceCode(String placeCode) {
		this.placeCode = placeCode;
	}
	
	
}
