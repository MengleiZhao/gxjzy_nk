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
 * 被接待人员信息model
 * 是被接待人员信息的model类
 * @author 叶崇晖
 * @createtime 2018-06-14
 * @updatetime 2018-06-14
 */
@Entity
@Table(name = "T_RECEPTION_APPLI_PEOPLE_INFO")
public class ReceptionPeopleInfo extends BaseEntity{
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer travelRId;			//主键ID
	
	@Column(name = "F_J_ID")
	private Integer jId;				//接待信息ID
	
	@Column(name = "F_RECEPTION_PEOPLE_NAME")
	private String receptionPeopName;	//被接待人姓名
	
	@Column(name = "F_UNIT")
	private String unit;	//单位
	
	@Column(name = "F_CONTACT_INFORMATION")
	private String contactInformation;	//联系方式
	
	@Column(name = "F_POSITION")
	private String position;			//职务
	
	@Column(name = "F_REMARK")
	private String jDremake;			//备注
	
	@Transient
	private String status;				//状态值easyui插件中带的，装换json时用(数据库中没有)

	@Column(name = "F_POSITION_CODE")
	private String positionCode;	
	
	public Integer getTravelRId() {
		return travelRId;
	}

	public void setTravelRId(Integer travelRId) {
		this.travelRId = travelRId;
	}

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

	public String getjDremake() {
		return jDremake;
	}

	public void setjDremake(String jDremake) {
		this.jDremake = jDremake;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPositionCode() {
		return positionCode;
	}

	public void setPositionCode(String positionCode) {
		this.positionCode = positionCode;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getContactInformation() {
		return contactInformation;
	}

	public void setContactInformation(String contactInformation) {
		this.contactInformation = contactInformation;
	}
	
	
}
