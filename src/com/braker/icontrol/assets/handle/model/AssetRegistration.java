package com.braker.icontrol.assets.handle.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 固定资产处置清单表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_REGISTRATION")
public class AssetRegistration extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_AR_ID")
	private Integer fARId;
	
	@ManyToOne
	@JoinColumn(name ="F_ID",referencedColumnName="F_ID")
	private Handle handle;//资产处置信息
	
	@Column(name="F_ASS_HANDLE_CODE")
	private String fAssHandleRegCode;//资产处置登记单号
	
	@Column(name="F_ASS_NAME")
	private String fAssName;//处置物资名称
	
	@Column(name="F_ASS_CODE")
	private String fAssCode;//处置物资编号
	
	@Column(name="F_ASS_MODEL")
	private String fSPModel;//规格型号
	
	@Column(name="F_HANDLE_NUM")
	private String fHandleNum;//数量
	
	@Column(name ="F_WX_TIME")
	private Double fWxTime;//规定使用年限(年)
	
	@Column(name ="F_USED_TIME")
	private Double fUsedTime;//已使用年限（年）
	
	@Column(name ="F_UNUSED_TIME")
	private Double fUnusedTime;//还可以使用年限（年）
	
	@Column(name ="F_BUY_TIME")
	private Date fBuyTime;//验收日期
	
	@Column(name ="F_OLD_AMOUNT")
	private Double fOldAmount;//资产原值(元)
	
	@Column(name ="F_RESIDUAL_VALUE")
	private Double fResidualValue;//资产残值（元）
	
	@Column(name ="F_ADDRESS")
	private String fAddress;//存放地址
	
	@Column(name ="F_REMARK")
	private String fRemarkR;//备注
	
	@Transient
	private Integer number;//序号
	@Transient
	private Integer fId;
	@Transient
	private String fBuyTimeColumn;//验收日期列表显示使用
	
	
	
	public Integer getfARId() {
		return fARId;
	}
	public void setfARId(Integer fARId) {
		this.fARId = fARId;
	}
	public Handle getHandle() {
		return handle;
	}
	public void setHandle(Handle handle) {
		this.handle = handle;
	}
	public String getfAssName() {
		return fAssName;
	}
	public void setfAssName(String fAssName) {
		this.fAssName = fAssName;
	}
	public String getfAssCode() {
		return fAssCode;
	}
	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}
	public String getfSPModel() {
		return fSPModel;
	}
	public void setfSPModel(String fSPModel) {
		this.fSPModel = fSPModel;
	}
	public String getfHandleNum() {
		return fHandleNum;
	}
	public void setfHandleNum(String fHandleNum) {
		this.fHandleNum = fHandleNum;
	}
	public Double getfWxTime() {
		return fWxTime;
	}
	public void setfWxTime(Double fWxTime) {
		this.fWxTime = fWxTime;
	}
	public Double getfUsedTime() {
		return fUsedTime;
	}
	public void setfUsedTime(Double fUsedTime) {
		this.fUsedTime = fUsedTime;
	}
	public Double getfUnusedTime() {
		return fUnusedTime;
	}
	public void setfUnusedTime(Double fUnusedTime) {
		this.fUnusedTime = fUnusedTime;
	}
	public Date getfBuyTime() {
		return fBuyTime;
	}
	public void setfBuyTime(Date fBuyTime) {
		this.fBuyTime = fBuyTime;
	}
	public Double getfOldAmount() {
		return fOldAmount;
	}
	public void setfOldAmount(Double fOldAmount) {
		this.fOldAmount = fOldAmount;
	}
	public Double getfResidualValue() {
		return fResidualValue;
	}
	public void setfResidualValue(Double fResidualValue) {
		this.fResidualValue = fResidualValue;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public Integer getfId() {
		return fId;
	}
	public void setfId(Integer fId) {
		this.fId = fId;
	}
	public String getfAddress() {
		return fAddress;
	}
	public void setfAddress(String fAddress) {
		this.fAddress = fAddress;
	}
	public String getfRemarkR() {
		return fRemarkR;
	}
	public void setfRemarkR(String fRemarkR) {
		this.fRemarkR = fRemarkR;
	}
	public String getfAssHandleRegCode() {
		return fAssHandleRegCode;
	}
	public void setfAssHandleRegCode(String fAssHandleRegCode) {
		this.fAssHandleRegCode = fAssHandleRegCode;
	}
	public String getfBuyTimeColumn() {
		return fBuyTimeColumn;
	}
	public void setfBuyTimeColumn(String fBuyTimeColumn) {
		this.fBuyTimeColumn = fBuyTimeColumn;
	}
	
	
	
	
	
}
