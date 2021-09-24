package com.braker.icontrol.assets.storage.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 资产操作流水
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_LIST")
public class AssetList extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_ID")
	private Integer fId;
	
	@Column(name ="F_OPT_TYPE")
	private String fOptType;//操作类型
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode;//相关单号
	
	@Column(name ="F_STOCK_CODE")
	private String fStockCode;//物资编码
	
	@Column(name ="F_ASS_NAME")
	private String fAssName;//物资名称
	
	@Column(name ="F_ASS_TYPE")
	private String fAssType;//资产类型
	
	@Column(name ="F_MEAS_UNIT")
	private String fMeasUnit;//计量单位
	
	@Column(name ="F_ASS_NUM")
	private String fAssNum;//数量
	
	@Column(name ="F_ASS_TIME")
	private Date fAssTime;//时间
	
	@Column(name ="F_ASS_DEPT")
	private String fAssDept;//操作部门
	
	@Column(name ="F_ASS_USER")
	private String fAssUser;//操作人

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getfOptType() {
		return fOptType;
	}

	public void setfOptType(String fOptType) {
		this.fOptType = fOptType;
	}

	public String getfAssCode() {
		return fAssCode;
	}

	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}

	public String getfStockCode() {
		return fStockCode;
	}

	public void setfStockCode(String fStockCode) {
		this.fStockCode = fStockCode;
	}

	public String getfAssName() {
		return fAssName;
	}

	public void setfAssName(String fAssName) {
		this.fAssName = fAssName;
	}

	public String getfAssType() {
		return fAssType;
	}

	public void setfAssType(String fAssType) {
		this.fAssType = fAssType;
	}

	public String getfMeasUnit() {
		return fMeasUnit;
	}

	public void setfMeasUnit(String fMeasUnit) {
		this.fMeasUnit = fMeasUnit;
	}

	public String getfAssNum() {
		return fAssNum;
	}

	public void setfAssNum(String fAssNum) {
		this.fAssNum = fAssNum;
	}

	public Date getfAssTime() {
		return fAssTime;
	}

	public void setfAssTime(Date fAssTime) {
		this.fAssTime = fAssTime;
	}

	public String getfAssDept() {
		return fAssDept;
	}

	public void setfAssDept(String fAssDept) {
		this.fAssDept = fAssDept;
	}

	public String getfAssUser() {
		return fAssUser;
	}

	public void setfAssUser(String fAssUser) {
		this.fAssUser = fAssUser;
	}

	
}
