package com.braker.icontrol.expend.reimburse.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 报销费用明细表的model(用来关联报销单信息和发票信息)
 * @author 沈帆
 * @createtime 2020-02-19
 * @updatetime 2020-02-19
 */
@Entity
@Table(name = "T_COST_DETAIL_INFO")
public class CostDetailInfo extends BaseEntityEmpty  {
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer cId;				//主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//所属申请单据的主键
	
	@Column(name = "F_D_R_ID")
	private Integer dRId;				//所属直接报销单据的主键
	
	@Column(name = "F_COST_NAME")
	private String costName;			//费用名称
	
	@Column(name = "F_AMOUNT")
	private Double costAmount;			//申请金额
	
	@Transient
	private Integer num;	//递增序号
	
	@Transient
	private List<InvoiceCouponInfo> couponList;//发票票面list
	

	public Integer getdRId() {
		return dRId;
	}

	public void setdRId(Integer dRId) {
		this.dRId = dRId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public List<InvoiceCouponInfo> getCouponList() {
		return couponList;
	}

	public void setCouponList(List<InvoiceCouponInfo> couponList) {
		this.couponList = couponList;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public String getCostName() {
		return costName;
	}

	public void setCostName(String costName) {
		this.costName = costName;
	}

	public Double getCostAmount() {
		return costAmount;
	}

	public void setCostAmount(Double costAmount) {
		this.costAmount = costAmount;
	}





}
