package com.braker.icontrol.expend.standard.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 公务接待费用的配置信息
 * @author 张迅
 * @createtime 2019-05-24
 * @updatetime 2019-05-24
 */
@Entity
@Table(name = "T_RECEP_STANDARD")
public class RecepStandard extends Standard {
	
	
	/** 业务字段 **/
	
	@Column(name = "F_COST_FOOD1")
	private Double costFood1;						//正餐费用
	
	@Column(name = "F_COST_FOOD2")
	private Double costFood2;						//早餐费用
	
	@Column(name = "F_COST_FOOD3")
	private Double costFood3;						//宴请费用
	
	//以下为外宾
	@Column(name = "F_COST_FOOD4")
	private Double costFood4;						//正、副部长级人员出面举办的宴会

	@Column(name = "F_COST_FOOD5")
	private Double costFood5;						//厅局级及以人员出面举办的宴会
	
	@Column(name = "F_COST_FOOD6")
	private Double costFood6;						//冷餐
	
	@Column(name = "F_COST_FOOD7")
	private Double costFood7;						//酒会
	
	@Column(name = "F_COST_FOOD8")
	private Double costFood8;						//茶会
	
	@Column(name = "F_COST_FOOD9")
	private Double costFood9;						//日常伙食
	
	@Column(name = "F_COST_FOOD3")
	
	@Transient
	private int pageOrder; 							//页面显示排序

	/** getter/setter **/
	

	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Double getCostFood1() {
		return costFood1;
	}

	public void setCostFood1(Double costFood1) {
		this.costFood1 = costFood1;
	}

	public Double getCostFood2() {
		return costFood2;
	}

	public void setCostFood2(Double costFood2) {
		this.costFood2 = costFood2;
	}

	public Double getCostFood3() {
		return costFood3;
	}

	public void setCostFood3(Double costFood3) {
		this.costFood3 = costFood3;
	}

	public Double getCostFood4() {
		return costFood4;
	}

	public void setCostFood4(Double costFood4) {
		this.costFood4 = costFood4;
	}

	public Double getCostFood5() {
		return costFood5;
	}

	public void setCostFood5(Double costFood5) {
		this.costFood5 = costFood5;
	}

	public Double getCostFood6() {
		return costFood6;
	}

	public void setCostFood6(Double costFood6) {
		this.costFood6 = costFood6;
	}

	public Double getCostFood7() {
		return costFood7;
	}

	public void setCostFood7(Double costFood7) {
		this.costFood7 = costFood7;
	}

	public Double getCostFood8() {
		return costFood8;
	}

	public void setCostFood8(Double costFood8) {
		this.costFood8 = costFood8;
	}

	public Double getCostFood9() {
		return costFood9;
	}

	public void setCostFood9(Double costFood9) {
		this.costFood9 = costFood9;
	}

	
	
	
}

