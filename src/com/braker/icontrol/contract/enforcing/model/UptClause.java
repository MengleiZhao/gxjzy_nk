package com.braker.icontrol.contract.enforcing.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;

/**
 * 合同变更表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_CONTRACT_UPT_CLAUSE")
public class UptClause extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_ATTAC_UPT_ID")
	private Integer fAttacUptId;
	
	@Column(name ="F_ID")
	private Integer fId_U_AU;//关联t_contract_upt的主键
	
	@Column(name ="F_CO_OLD")
	private String fcoOld;//变更前内容
	
	@Column(name ="F_CO_NEW")
	private String fcoNew;//变更后内容
	
	

	public Integer getfAttacUptId() {
		return fAttacUptId;
	}

	public void setfAttacUptId(Integer fAttacUptId) {
		this.fAttacUptId = fAttacUptId;
	}

	public Integer getfId_U_AU() {
		return fId_U_AU;
	}

	public void setfId_U_AU(Integer fId_U_AU) {
		this.fId_U_AU = fId_U_AU;
	}

	public String getFcoOld() {
		return fcoOld;
	}

	public void setFcoOld(String fcoOld) {
		this.fcoOld = fcoOld;
	}

	public String getFcoNew() {
		return fcoNew;
	}

	public void setFcoNew(String fcoNew) {
		this.fcoNew = fcoNew;
	}


	
	
}
