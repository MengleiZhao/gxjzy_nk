package com.braker.icontrol.expend.reimburse.model;

/**
 * 发票明细
 * @author 张迅
 *
 */
public class InvoiceDetail {


	private String taxSum;		//税额
	
	private String priceUnit;	//单价
	
	private String taxRate;		//税率
	
	private String amount;		//数量
	
	private String unit;		//单位
	
	private String name;		//货物或应税劳务、服务名称
	
	private String priceSum;	//总价
	
	private String spec;		//规格型号

	public String getTaxSum() {
		return taxSum;
	}

	public void setTaxSum(String taxSum) {
		this.taxSum = taxSum;
	}

	public String getPriceUnit() {
		return priceUnit;
	}

	public void setPriceUnit(String priceUnit) {
		this.priceUnit = priceUnit;
	}

	public String getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(String taxRate) {
		this.taxRate = taxRate;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPriceSum() {
		return priceSum;
	}

	public void setPriceSum(String priceSum) {
		this.priceSum = priceSum;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}
	
	
	
}
