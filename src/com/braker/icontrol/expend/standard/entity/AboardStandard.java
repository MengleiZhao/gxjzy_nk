package com.braker.icontrol.expend.standard.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 因公出国费用的配置信息
 * @author 张迅
 * @createtime 2019-05-24
 * @updatetime 2019-05-24
 */
@Entity
@Table(name = "T_ABOARD_STANDARD")
public class AboardStandard extends Standard {
	
	/** 业务字段 **/
	
	@Column(name = "F_COST_TRAFFIC")
	private Double costTraffic;						//国外交通补助
	
	@Column(name = "F_COST_POCKET1")
	private Double costPocket1;						//零用费-10天内
	
	@Column(name = "F_COST_POCKET2")
	private Double costPocket2;						//零用费-10天后
	
	@Transient
	private int pageOrder; 							//页面显示排序


	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Double getCostTraffic() {
		return costTraffic;
	}

	public void setCostTraffic(Double costTraffic) {
		this.costTraffic = costTraffic;
	}

	public Double getCostPocket1() {
		return costPocket1;
	}

	public void setCostPocket1(Double costPocket1) {
		this.costPocket1 = costPocket1;
	}

	public Double getCostPocket2() {
		return costPocket2;
	}

	public void setCostPocket2(Double costPocket2) {
		this.costPocket2 = costPocket2;
	}

	
	
	
}

