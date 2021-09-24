package com.braker.icontrol.expend.standard.entity;

import java.sql.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 差旅费的配置信息
 * @author 张迅
 * @createtime 2019-04-28
 * @updatetime 2019-04-28
 */
@Entity
@Table(name = "T_HOTEL_STANDARD")
public class HotelStandard extends Standard {
	
	/** 业务字段 **/
	
	@Column(name = "F_IF_DEFAULT")
	private Integer ifDefault;							//是否默认
	
	@Column(name = "F_AREA_ID")
	private Integer areaId;							//地区ID
	
	@Column(name = "F_AREA")
	private String area;							//地区
	
	@Column(name = "F_NORMAL_PRICE_MAX")
	private Double normalPriceMax;					//住宿费标准（市级）
	
	@Column(name = "F_NORMAL_PRICE_MID")
	private Double normalPriceMid;					//住宿费标准（局级）
	
	@Column(name = "F_NORMAL_PRICE_MIN")
	private Double normalPriceMin;					//住宿费标准（其他人员）
	
	@Column(name = "F_BUSY_PRICE_MAX")
	private Double busyPriceMax;					//旺季标准（市级）
	
	@Column(name = "F_BUSY_PRICE_MID")
	private Double busyPriceMid;					//旺季标准（局级）
	
	@Column(name = "F_BUSY_PRICE_MIN")
	private Double busyPriceMin;					//旺季标准（其他人员）
    
    @OneToMany(targetEntity = TDateBusyTime.class, mappedBy = "pId", cascade = CascadeType.MERGE, fetch=FetchType.EAGER)
    @JsonIgnore
    private List<TDateBusyTime> children;
    
	@Column(name = "F_DATE_BUSY_START")
	private Date busyDateStart;						//旺季期间（开始）
	
	@Column(name = "F_DATE_BUSY_END")
	private Date busyDateEnd;						//旺季期间（结束）
	
	@Column(name = "F_BUSY_RATE")
	private Float busyRate;							//上浮比例

	@Column(name = "F_HASBUSY")
	private Integer hasBusy;						//是否存在旺季上浮
	
	@Column(name = "F_COST_FOOD")
	private Double costFood;						//伙食补助费
	
	@Column(name = "F_COST_TRAFFIC_LONG")
	private Double costTrafficLong;					//长途交通费
	
	@Column(name = "F_COST_TRAFFIC_SHORT")
	private Double costTrafficShort;				//市内交通费
	
	@Column(name = "F_COST_EXTRAS")
	private Double costExtras;						//杂费
	
	@Column(name = "F_HAS_HOTEL")
	private Integer hasHotel;						//是否有住宿费
	
	@Column(name = "F_HAS_FOOD")
	private Integer hasFood;						//是否有伙食补助费
	
	@Column(name = "F_HAS_TRAFFICLONG")
	private Integer hasTrafficLong;					//是否有长途交通费
	
	@Column(name = "F_HAS_TRAFFICSHORT")
	private Integer hasTrafficShort;				//是否有市内交通费
	
	@Column(name = "F_HAS_EXTRAS")
	private Integer hasExtras;						//是否有杂费
	
	@Transient
	private int pageOrder; 							//页面显示排序
	
	/** 构造方法 **/
	 
	public HotelStandard() {
		super();
	}
	

	/** getter/setter **/
	

	public String getArea() {
		return area;
	}


	public void setArea(String area) {
		this.area = area;
	}

	public Double getNormalPriceMax() {
		return normalPriceMax;
	}

	public void setNormalPriceMax(Double normalPriceMax) {
		this.normalPriceMax = normalPriceMax;
	}

	public Double getNormalPriceMid() {
		return normalPriceMid;
	}

	public void setNormalPriceMid(Double normalPriceMid) {
		this.normalPriceMid = normalPriceMid;
	}

	public Double getNormalPriceMin() {
		return normalPriceMin;
	}

	public void setNormalPriceMin(Double normalPriceMin) {
		this.normalPriceMin = normalPriceMin;
	}

	public Double getBusyPriceMax() {
		return busyPriceMax;
	}

	public void setBusyPriceMax(Double busyPriceMax) {
		this.busyPriceMax = busyPriceMax;
	}

	public Double getBusyPriceMid() {
		return busyPriceMid;
	}

	public void setBusyPriceMid(Double busyPriceMid) {
		this.busyPriceMid = busyPriceMid;
	}

	public Double getBusyPriceMin() {
		return busyPriceMin;
	}

	public void setBusyPriceMin(Double busyPriceMin) {
		this.busyPriceMin = busyPriceMin;
	}

	public Date getBusyDateStart() {
		return busyDateStart;
	}

	public void setBusyDateStart(Date busyDateStart) {
		this.busyDateStart = busyDateStart;
	}

	public Date getBusyDateEnd() {
		return busyDateEnd;
	}

	public void setBusyDateEnd(Date busyDateEnd) {
		this.busyDateEnd = busyDateEnd;
	}

	public Float getBusyRate() {
		return busyRate;
	}

	public void setBusyRate(Float busyRate) {
		this.busyRate = busyRate;
	}

	public Integer getHasBusy() {
		return hasBusy;
	}

	public void setHasBusy(Integer hasBusy) {
		this.hasBusy = hasBusy;
	}

	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Double getCostFood() {
		return costFood;
	}

	public void setCostFood(Double costFood) {
		this.costFood = costFood;
	}

	public Double getCostTrafficLong() {
		return costTrafficLong;
	}

	public void setCostTrafficLong(Double costTrafficLong) {
		this.costTrafficLong = costTrafficLong;
	}

	public Double getCostTrafficShort() {
		return costTrafficShort;
	}

	public void setCostTrafficShort(Double costTrafficShort) {
		this.costTrafficShort = costTrafficShort;
	}

	public Double getCostExtras() {
		return costExtras;
	}

	public void setCostExtras(Double costExtras) {
		this.costExtras = costExtras;
	}

	public Integer getHasHotel() {
		return hasHotel;
	}

	public void setHasHotel(Integer hasHotel) {
		this.hasHotel = hasHotel;
	}

	public Integer getHasFood() {
		return hasFood;
	}

	public void setHasFood(Integer hasFood) {
		this.hasFood = hasFood;
	}

	public Integer getHasTrafficLong() {
		return hasTrafficLong;
	}

	public void setHasTrafficLong(Integer hasTrafficLong) {
		this.hasTrafficLong = hasTrafficLong;
	}

	public Integer getHasTrafficShort() {
		return hasTrafficShort;
	}

	public void setHasTrafficShort(Integer hasTrafficShort) {
		this.hasTrafficShort = hasTrafficShort;
	}

	public Integer getHasExtras() {
		return hasExtras;
	}

	public void setHasExtras(Integer hasExtras) {
		this.hasExtras = hasExtras;
	}


	public List<TDateBusyTime> getChildren() {
		return children;
	}


	public void setChildren(List<TDateBusyTime> children) {
		this.children = children;
	}


	public Integer getAreaId() {
		return areaId;
	}


	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
	
}

