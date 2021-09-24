package com.braker.icontrol.budget.project.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 采购一采多年项目表
* <p>Title:TPurchaseManyYearsPro </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月10日
 */
@Entity
@Table(name = "T_PURCHASE_MANY_YEARS_PRO")
public class TPurchaseManyYearsPro extends BaseEntityEmpty  {
	
	@Id
	@Column(name = "F_P_M_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private String pmId;
	
	@Column(name = "F_PRO_ID")
	private Integer fProId;  //项目id
	
	@Column(name = "F_PUR_YEAR")
	private String purYear;  //采购年度
	
	@Column(name = "F_YEAR_AMOUNT")
	private BigDecimal yearAmount;			//年度预算安排金额
	
	@Column(name = "F_EXPLAIN")
	private String fExplain;		//说明
	
	@Column(name = "F_IF_SOFTWARE")
	private String fIfSoftware;				//是否软件明细0:政府采购明细        1:政府采购明细软件类型
	public String getPmId() {
		return pmId;
	}

	public void setPmId(String pmId) {
		this.pmId = pmId;
	}

	public Integer getfProId() {
		return fProId;
	}

	public void setfProId(Integer fProId) {
		this.fProId = fProId;
	}

	public String getPurYear() {
		return purYear;
	}

	public void setPurYear(String purYear) {
		this.purYear = purYear;
	}

	public BigDecimal getYearAmount() {
		return yearAmount;
	}

	public void setYearAmount(BigDecimal yearAmount) {
		this.yearAmount = yearAmount;
	}

	public String getfExplain() {
		return fExplain;
	}

	public void setfExplain(String fExplain) {
		this.fExplain = fExplain;
	}

	public String getfIfSoftware() {
		return fIfSoftware;
	}

	public void setfIfSoftware(String fIfSoftware) {
		this.fIfSoftware = fIfSoftware;
	}
	
}