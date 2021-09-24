package com.braker.icontrol.incomemanage.accountsCurrent.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 来款登记明细
 * @author 赵孟雷
 */
@Entity
@Table(name = "T_RECEIVE_MONEY_DETAIL")
public class ReceiveMoneyDetail extends BaseEntity{
	
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer frId;
	
	@Column(name = "F_M_S_ID")
	private Integer fMSId;				//登记ID
	
	@Column(name = "F_P_ID")
	private Integer fpId;				//登记ID
	
	@Column(name = "F_OPPOSITE_UNIT")
	private String oppositeUnit;        //对方单位
	
	@Column(name = "F_PLAN_MONEY")
	private BigDecimal planMoney;          //预计来款金额      金额（元）
	
	@Column(name = "F_PLAN_TIME")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date planTime;				//预计时间

	@Column(name = "F_INVOICE_KIND")
	private String invoiceKind;        //开票种类
	
	@Column(name = "F_TYPE")
	private String fType;        //数据类型
	
	@Column(name = "F_INVOICE_KIND_SHOW")
	private String invoiceKindShow;        //开票种类显示用

	@Column(name = "F_ID_CRAD")
	private String idCard;        //身份证号/税号
	
	@Column(name = "F_IS_BILL")
	private String fIsBill;        //是否预开发票
	
	@Column(name = "F_PAY_STATUS")
	private String payStatus;        //是否完成缴款（1-是 0-否） 
	
	@Column(name = "FLOW_STATUS")
	private String FlowStatus;        //审批状态 
	
	@Column(name = "F_REMAKE")
	private String remake;        //备注
	
	@Transient
	private Integer num;				//序号
	
	
	
	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public String getfIsBill() {
		return fIsBill;
	}

	public void setfIsBill(String fIsBill) {
		this.fIsBill = fIsBill;
	}

	public String getFlowStatus() {
		return FlowStatus;
	}

	public void setFlowStatus(String flowStatus) {
		FlowStatus = flowStatus;
	}

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public Integer getFrId() {
		return frId;
	}

	public void setFrId(Integer frId) {
		this.frId = frId;
	}

	public Integer getfMSId() {
		return fMSId;
	}

	public void setfMSId(Integer fMSId) {
		this.fMSId = fMSId;
	}

	public String getOppositeUnit() {
		return oppositeUnit;
	}

	public void setOppositeUnit(String oppositeUnit) {
		this.oppositeUnit = oppositeUnit;
	}

	public BigDecimal getPlanMoney() {
		return planMoney;
	}

	public void setPlanMoney(BigDecimal planMoney) {
		this.planMoney = planMoney;
	}

	public Date getPlanTime() {
		return planTime;
	}

	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}

	public String getInvoiceKind() {
		return invoiceKind;
	}

	public void setInvoiceKind(String invoiceKind) {
		this.invoiceKind = invoiceKind;
	}

	public String getInvoiceKindShow() {
		return invoiceKindShow;
	}

	public void setInvoiceKindShow(String invoiceKindShow) {
		this.invoiceKindShow = invoiceKindShow;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getRemake() {
		return remake;
	}

	public void setRemake(String remake) {
		this.remake = remake;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String toString() {
		
		return "{" +
        "\"frId\":\"" + frId +"\","+
        "\"fMSId\":\"" + fMSId + "\","+
        "\"oppositeUnit\":\"" + oppositeUnit + "\"," +
        "\"planMoney\":\"" + planMoney + "\"," +
        "\"planTime\":\"" + planTime + "\"," +
        "\"invoiceKind\":\"" + invoiceKind + "\"," +
        "\"fType\":\"" + fType + "\"," +
        "\"invoiceKindShow\":\"" + invoiceKindShow + "\"," +
        "\"idCard\":\"" + idCard + "\"," +
        "\"payStatus\":\"" + payStatus + "\"," +
        "\"remake\":\"" + remake + "\"," +
        "\"num\":\"" + num + "\"" +
        '}';
	}
	
	
	
	
}
