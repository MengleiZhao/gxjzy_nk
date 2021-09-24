package com.braker.icontrol.expend.standard.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 因公出国各个国家费用的标准信息
 * @author 陈睿超
 * @createtime 2020-05-12
 * @updatetime 2020-05-12
 */
@Entity
@Table(name = "T_ABOARD_COUNTRY_STANDARD")
public class AboardCountryStandard extends Standard {
	
	/** 业务字段 **/
	@Column(name = "F_COUNTRY")
	private String country;//国家
	
	@Column(name = "F_CITY")
	private String city;//城市

	@Column(name = "F_CURRENCY")
	private String currency;//币种
	
	@Column(name = "COST_HOTEL_MONEY")
	private Double hotelMoney;//住宿费每人每天（元）
	
	@Column(name = "COST_FOOD_MONEY")
	private Double foodMoney;//伙食费每人每天（元）
	
	@Column(name = "COST_TRAFFIC_MONEY")
	private Double trafficMoney;//公杂费每人每天（元）
	
	@Transient
	private int pageOrder;//页面显示排序


	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public Double getHotelMoney() {
		return hotelMoney;
	}

	public void setHotelMoney(Double hotelMoney) {
		this.hotelMoney = hotelMoney;
	}

	public Double getFoodMoney() {
		return foodMoney;
	}

	public void setFoodMoney(Double foodMoney) {
		this.foodMoney = foodMoney;
	}

	public Double getTrafficMoney() {
		return trafficMoney;
	}

	public void setTrafficMoney(Double trafficMoney) {
		this.trafficMoney = trafficMoney;
	}

	
	
	
}

