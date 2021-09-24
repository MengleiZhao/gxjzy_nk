package com.braker.icontrol.assets.handle.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Entity;

import com.braker.common.entity.BaseEntity;
/**
 * 低值易耗品处置清单表
 * @author 陈睿超
 * @createTime 2019-05-31
 */
@Entity
@Table(name ="T_LOW_REGISTRATION")
public class AssetLowRegistration extends BaseEntity {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_REG_ID")
	private Integer fRegId;
	
	@ManyToOne
	@JoinColumn(name ="F_ID",referencedColumnName="F_ID")
	private Handle handle;//资产处置信息(外键)
	
	@Column(name="F_ASS_HANDLE_CODE")
	private String fAssHandleRegCode;//资产处置登记单号
	
	@Column(name="F_ASS_CODE")
	private String fAssCode;//处置物资编号
	
	@Column(name="F_ASS_NAME")
	private String fAssName;//处置资产名称
	
	@Column(name="F_SP_MODEL")
	private String fSPModel;//规格型号
	
	@Column(name="F_MEAS_UNIT")
	private String fMeasUnit;//计量单位
	
	@Column(name="F_HANDLE_NUM")
	private String fHandleNum;//数量
	
	@Column(name="F_SIGN_PRICE")
	private String fSignPrice;//单价（元）
	
	@Column(name="F_AMOUNT")
	private String fAmount;//总金额（元）
	
	/*@Column(name ="F_HANDLE_REMARK")
	private String fLowHandleRemark;//处置原因*/
	
	@Column(name ="F_REMARK")
	private String fRemarkR;//备注

	
	
	public Integer getfRegId() {
		return fRegId;
	}

	public void setfRegId(Integer fRegId) {
		this.fRegId = fRegId;
	}

	public Handle getHandle() {
		return handle;
	}

	public void setHandle(Handle handle) {
		this.handle = handle;
	}

	public String getfAssHandleRegCode() {
		return fAssHandleRegCode;
	}

	public void setfAssHandleRegCode(String fAssHandleRegCode) {
		this.fAssHandleRegCode = fAssHandleRegCode;
	}

	public String getfAssCode() {
		return fAssCode;
	}

	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}

	public String getfAssName() {
		return fAssName;
	}

	public void setfAssName(String fAssName) {
		this.fAssName = fAssName;
	}

	public String getfSPModel() {
		return fSPModel;
	}

	public void setfSPModel(String fSPModel) {
		this.fSPModel = fSPModel;
	}

	public String getfMeasUnit() {
		return fMeasUnit;
	}

	public void setfMeasUnit(String fMeasUnit) {
		this.fMeasUnit = fMeasUnit;
	}

	public String getfHandleNum() {
		return fHandleNum;
	}

	public void setfHandleNum(String fHandleNum) {
		this.fHandleNum = fHandleNum;
	}

	public String getfSignPrice() {
		return fSignPrice;
	}

	public void setfSignPrice(String fSignPrice) {
		this.fSignPrice = fSignPrice;
	}

	public String getfAmount() {
		return fAmount;
	}

	public void setfAmount(String fAmount) {
		this.fAmount = fAmount;
	}

	/*public String getfLowHandleRemark() {
		return fLowHandleRemark;
	}

	public void setfLowHandleRemark(String fLowHandleRemark) {
		this.fLowHandleRemark = fLowHandleRemark;
	}*/

	public String getfRemarkR() {
		return fRemarkR;
	}

	public void setfRemarkR(String fRemarkR) {
		this.fRemarkR = fRemarkR;
	}
	
	
	
	
}
