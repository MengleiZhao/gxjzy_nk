package com.braker.icontrol.expend.apply.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;


/**
 * 陪同人员名单model
 * @author 沈帆
 * @createtime 2020-10-29
 * @updatetime 2020-10-29
 */
@Entity
@Table(name = "T_ACCOMPANY_PEOPLE_INFO")
public class AccompanyPeopleInfo extends BaseEntity{
	@Id
	@Column(name = "F_AC_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer acId;			//主键ID
	
	@Column(name = "F_J_ID")
	private Integer jId;				//接待信息ID
	
	@Column(name = "F_RECEPTION_PEOPLE_NAME")
	private String receptionPeopName;	//被接待人姓名
	
	@Column(name = "F_POSITION")
	private String position;			//职务
	

	@Column(name = "F_POSITION_CODE")
	private String positionCode;	
	

	public Integer getjId() {
		return jId;
	}

	public void setjId(Integer jId) {
		this.jId = jId;
	}

	public String getReceptionPeopName() {
		return receptionPeopName;
	}

	public void setReceptionPeopName(String receptionPeopName) {
		this.receptionPeopName = receptionPeopName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}


	public String getPositionCode() {
		return positionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public Integer getAcId() {
		return acId;
	}

	public void setAcId(Integer acId) {
		this.acId = acId;
	}
	
	
}
