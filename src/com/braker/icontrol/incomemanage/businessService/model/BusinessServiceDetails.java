package com.braker.icontrol.incomemanage.businessService.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 
 * @Description 经营服务性收入的详情表
 * @author 汪耀
 * @date : 2019年11月5日 下午4:18:20
 */
@Entity
@Table(name = "T_BUSINESS_SERVICE_DETAILS")
public class BusinessServiceDetails extends BaseEntity {
	@Id
	@Column(name = "F_DETAILS_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer fdId;					//详情表id
	
	@Column(name = "F_BUSI_ID")
	private Integer fbId;					//外键
	
	@Column(name = "F_CHARGE_ITEMS")
	private String fChargeItems;			//收费项目
	
	@Column(name = "F_CHARGE_UNIT")
	private String fChargeUnit;				//计费单位
	
	@Column(name = "F_CHARGE_ADVICE")
	private String fChargeAdvice;			//收费标准意见
	
	@Column(name = "F_REMARK")
	private String fRemark;					//备注
	
	@Transient
	private Integer num;					//序号

	public Integer getFdId() {
		return fdId;
	}

	public void setFdId(Integer fdId) {
		this.fdId = fdId;
	}

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public String getfChargeItems() {
		return fChargeItems;
	}

	public void setfChargeItems(String fChargeItems) {
		this.fChargeItems = fChargeItems;
	}

	public String getfChargeUnit() {
		return fChargeUnit;
	}

	public void setfChargeUnit(String fChargeUnit) {
		this.fChargeUnit = fChargeUnit;
	}

	public String getfChargeAdvice() {
		return fChargeAdvice;
	}

	public void setfChargeAdvice(String fChargeAdvice) {
		this.fChargeAdvice = fChargeAdvice;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
}
