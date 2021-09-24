package com.braker.icontrol.expend.apply.model;

import java.math.BigDecimal;

public class AbroadExpenseInfo {

	//申请ID
	private Integer gId;
	
	//申请费用
	private BigDecimal applyAmount;
	
	//费用名称
	private String expenseName;

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}

	public String getExpenseName() {
		return expenseName;
	}

	public void setExpenseName(String expenseName) {
		this.expenseName = expenseName;
	}

}
