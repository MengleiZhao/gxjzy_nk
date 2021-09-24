package com.braker.icontrol.contract.enforcing.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 合同结项信息表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_CONTRACT_FINISH")
public class Conclusion extends BaseEntity{

	@Id
	@Column(name ="F_FI_ID")
	private Integer fFiId;
	
	@Column(name="F_CONT_ID")
	private Integer fContId_F;//合同的主键
	
	@Column(name = "F_FI_TYPE")
	private String fFiType;//合同结项类型
	
	@Column(name ="F_FI_REMARK")
	private String fFiRemark;//合同结项说明
	

	public Integer getfFiId() {
		return fFiId;
	}

	public void setfFiId(Integer fFiId) {
		this.fFiId = fFiId;
	}

	public Integer getfContId_F() {
		return fContId_F;
	}

	public void setfContId_F(Integer fContId_F) {
		this.fContId_F = fContId_F;
	}

	public String getfFiType() {
		return fFiType;
	}

	public void setfFiType(String fFiType) {
		this.fFiType = fFiType;
	}

	public String getfFiRemark() {
		return fFiRemark;
	}

	public void setfFiRemark(String fFiRemark) {
		this.fFiRemark = fFiRemark;
	}

	
}
