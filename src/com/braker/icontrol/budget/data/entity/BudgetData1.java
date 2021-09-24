package com.braker.icontrol.budget.data.entity;

import javax.persistence.Entity;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 预算指标执行情况报表
 * @author zhangxun
 *
 */
public class BudgetData1 extends BaseEntityEmpty {

	//序号
	private String pageOrder;
	//指标名称
	private String indexName;
	//指标额度
	private String indexAmount;
	//所属部门
	private String departName;
	//指标id
	private String indexId;
	//近3年年累值
	private String num0 = "0";
	private String num1 = "0";
	private String num2 = "0";
	//近三年环比
	private String cRate0;
	private String cRate1;
	private String cRate2;
	//近三年执行率
	private String dRate0;
	private String dRate1;
	private String dRate2;
	
	public String getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(String pageOrder) {
		this.pageOrder = pageOrder;
	}
	public String getIndexName() {
		return indexName;
	}
	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}
	public String getIndexAmount() {
		return indexAmount;
	}
	public void setIndexAmount(String indexAmount) {
		this.indexAmount = indexAmount;
	}
	public String getIndexId() {
		return indexId;
	}
	public void setIndexId(String indexId) {
		this.indexId = indexId;
	}
	public String getNum0() {
		return num0;
	}
	public void setNum0(String num0) {
		this.num0 = num0;
	}
	public String getNum1() {
		return num1;
	}
	public void setNum1(String num1) {
		this.num1 = num1;
	}
	public String getNum2() {
		return num2;
	}
	public void setNum2(String num2) {
		this.num2 = num2;
	}
	public String getcRate0() {
		return cRate0;
	}
	public void setcRate0(String cRate0) {
		this.cRate0 = cRate0;
	}
	public String getcRate1() {
		return cRate1;
	}
	public void setcRate1(String cRate1) {
		this.cRate1 = cRate1;
	}
	public String getcRate2() {
		return cRate2;
	}
	public void setcRate2(String cRate2) {
		this.cRate2 = cRate2;
	}
	public String getdRate0() {
		return dRate0;
	}
	public void setdRate0(String dRate0) {
		this.dRate0 = dRate0;
	}
	public String getdRate1() {
		return dRate1;
	}
	public void setdRate1(String dRate1) {
		this.dRate1 = dRate1;
	}
	public String getdRate2() {
		return dRate2;
	}
	public void setdRate2(String dRate2) {
		this.dRate2 = dRate2;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	
	
}
