package com.braker.icontrol.expend.apply.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 申请出国人员信息表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ABROAD_APPLI_PEOPLE_INFO")
public class AbroadAppliPepoleInfo extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_R_ID")
	private Integer frId;
	
	@Column(name ="F_A_ID")
	private Integer aId;  //出国信息ID
	
	@Column(name = "F_TRAVEL_PEOPLE_NAME")
	private String travelPeopName;	// 差旅人员姓名
	
	@Column(name = "F_POSITION")
	private String position;			//职务
	
	@Column(name = "F_POSITION_LEVEL")
	private String travelPersonnelLevel;	 //职务code
	
	@Column(name = "F_ID_CARD")
	private String idCard;			//身份证号
	
	@Column(name = "F_PHONENUM")
	private String phoneNum;			//联系方式
	
	@Column(name ="F_PASSPORT")
	private String fPassport; //护照号
	
	@Column(name ="F_TRAVEL_PEOPLE_ID")
	private String travelPeopId; //人员id

	public String getTravelPersonnelLevel() {
		return travelPersonnelLevel;
	}

	public void setTravelPersonnelLevel(String travelPersonnelLevel) {
		this.travelPersonnelLevel = travelPersonnelLevel;
	}

	public Integer getFrId() {
		return frId;
	}

	public void setFrId(Integer frId) {
		this.frId = frId;
	}

	public Integer getaId() {
		return aId;
	}

	public void setaId(Integer aId) {
		this.aId = aId;
	}

	public String getTravelPeopName() {
		return travelPeopName;
	}

	public void setTravelPeopName(String travelPeopName) {
		this.travelPeopName = travelPeopName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}



	public String getfPassport() {
		return fPassport;
	}

	public void setfPassport(String fPassport) {
		this.fPassport = fPassport;
	}


	
	public String getTravelPeopId() {
		return travelPeopId;
	}

	public void setTravelPeopId(String travelPeopId) {
		this.travelPeopId = travelPeopId;
	}

	
	
}
