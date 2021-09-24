package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntity;

/**
 * 资金来源表
* <p>Title:TCapitalSource </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月2日
 */
@Entity
@Table(name = "T_CAPITAL_SOURCE")
public class TCapitalSource extends BaseEntity  {
	
	@Id
	@Column(name = "F_C_S_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fCSId;
	
	@Column(name="F_CAPITAL_SOURCE_NAME")
	private String csName;
	
	@Column(name="F_CAPITAL_SOURCE_CODE")
	private String csCode;

	public Integer getfCSId() {
		return fCSId;
	}

	public void setfCSId(Integer fCSId) {
		this.fCSId = fCSId;
	}

	public String getCsName() {
		return csName;
	}

	public void setCsName(String csName) {
		this.csName = csName;
	}

	public String getCsCode() {
		return csCode;
	}

	public void setCsCode(String csCode) {
		this.csCode = csCode;
	}
	
	
}