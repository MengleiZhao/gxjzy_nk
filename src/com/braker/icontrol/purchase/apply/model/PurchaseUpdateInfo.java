package com.braker.icontrol.purchase.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="T_PURCHASE_UPDATE")
@JsonIgnoreProperties(ignoreUnknown = true)
public class PurchaseUpdateInfo extends BaseEntity{
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId;
	
	@Column(name ="F_P_ID")
	private Integer fpId;
	
	@Column(name = "F_UPDATE_USER_ID")
	private String updateUserId;
	
	@Column(name = "F_UPDATE_USER_NAME")
	private String updateUserName;
	
	@Column(name = "F_UPDATE_DATE")
	private Date fUpdateDate;
	
	@Column(name = "F_PROJECT_NAME")
	private String projectName;
	
	@Column(name = "F_METHOD")
	private String method;
	
	@Column(name = "F_ORGTYPE")
	private String orgType;
	
	@Column(name = "F_UPDATE_METHOD")
	private String updateMethod;
	
	@Column(name = "F_UPDATE_ORGTYPE")
	private String updateOrgType;
	
	@Transient
	private int num;					//序号(数据库里没有的)

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getUpdateUserId() {
		return updateUserId;
	}

	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}

	public String getUpdateUserName() {
		return updateUserName;
	}

	public void setUpdateUserName(String updateUserName) {
		this.updateUserName = updateUserName;
	}



	public Date getfUpdateDate() {
		return fUpdateDate;
	}

	public void setfUpdateDate(Date fUpdateDate) {
		this.fUpdateDate = fUpdateDate;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

	public String getUpdateMethod() {
		return updateMethod;
	}

	public void setUpdateMethod(String updateMethod) {
		this.updateMethod = updateMethod;
	}

	public String getUpdateOrgType() {
		return updateOrgType;
	}

	public void setUpdateOrgType(String updateOrgType) {
		this.updateOrgType = updateOrgType;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
