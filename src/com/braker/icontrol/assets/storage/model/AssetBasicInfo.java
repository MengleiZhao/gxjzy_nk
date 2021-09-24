package com.braker.icontrol.assets.storage.model;

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
import com.braker.common.entity.Combobox;
import com.braker.core.model.Lookups;

/**
 * 资产品目表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_BASIC_INFO")
public class AssetBasicInfo extends BaseEntity implements Combobox{
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ASS_ID")
	private Integer fAssId;
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode;//资产编号

	@Column(name ="F_CONT_CODE")
	private String fcCode;			//合同编号
	
	@Column(name ="F_ASS_NAME")
	private String fAssName;//资产名称
	
	@Column(name ="F_ASS_TYPE")
	private String fAssType;//资产类型
	
	@Column(name ="F_SP_MODEL")
	private String fSPModel;//规格型号
	
	@Column(name ="F_MEAS_UNIT")
	private String fMeasUnit;//计量单位
	
	@Column(name ="F_REMARK")
	private String fRemark_ABI;//説明
	
	@Column(name ="F_COMPTY_NAME")
	private String fComptyName;//品牌全称
	
	@Column(name ="F_COMPTY_SORT")
	private String fComptySort;//品牌简称
	
	@Column(name ="F_OLD_AMOUNT")
	private Double fOldAmount;//资产原值
	
	@Column(name ="F_ACQUISITION_DATE")
	private Date fAcquisitionDate;//取得日期
	
	@Column(name ="F_WX_TIME")
	private String fWxTime;//使用年限
	
	@ManyToOne
	@JoinColumn(name ="F_ASS_STAUTS" ,referencedColumnName ="lookupscode")
	private Lookups fAssStauts;//资产状态（下拉框） ：ZCZT-01-库存中，ZCZT-02-使用中，ZCZT-03-已处置
	
	@Column(name ="F_USE_NAME_ID")
	private String fUseNameID;//使用人ID 不写则表示在库中，未使用
	
	@Column(name ="F_USE_NAME")
	private String fUseName;//正在使用人名称
	
	@Column(name ="F_USE_DEPT_ID")
	private String fUseDeptID;//使用部门ID
	
	@Column(name ="F_USE_DEPT")
	private String fUseDept;//使用部门名称
	
	@Transient
	private String assStauts;//资产状态(显示用)
	
	@Transient
	private Integer stockNum;//库存数量

	@Transient
	private Integer number;//序号
	
	
	public String getFcCode() {
		return fcCode;
	}

	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getStockNum() {
		return stockNum;
	}

	public void setStockNum(Integer stockNum) {
		this.stockNum = stockNum;
	}

	public Integer getfAssId() {
		return fAssId;
	}

	public void setfAssId(Integer fAssId) {
		this.fAssId = fAssId;
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

	public String getfAssType() {
		return fAssType;
	}

	public void setfAssType(String fAssType) {
		this.fAssType = fAssType;
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

	public String getfRemark_ABI() {
		return fRemark_ABI;
	}

	public void setfRemark_ABI(String fRemark_ABI) {
		this.fRemark_ABI = fRemark_ABI;
	}

	public String getfComptyName() {
		return fComptyName;
	}

	public void setfComptyName(String fComptyName) {
		this.fComptyName = fComptyName;
	}

	public String getfComptySort() {
		return fComptySort;
	}

	public void setfComptySort(String fComptySort) {
		this.fComptySort = fComptySort;
	}

	@Override
	public String getCode() {
		return fAssCode;
	}

	@Override
	public String getGridCode() {
		return null;
	}

	@Override
	public String getSftjCode() {
		return fMeasUnit;
	}

	@Override
	public String getText() {
		return fAssName;
	}

	@Override
	public String getDesc() {
		return null;
	}

	public Double getfOldAmount() {
		return fOldAmount;
	}

	public void setfOldAmount(Double fOldAmount) {
		this.fOldAmount = fOldAmount;
	}

	public Date getfAcquisitionDate() {
		return fAcquisitionDate;
	}

	public void setfAcquisitionDate(Date fAcquisitionDate) {
		this.fAcquisitionDate = fAcquisitionDate;
	}

	public String getfWxTime() {
		return fWxTime;
	}

	public void setfWxTime(String fWxTime) {
		this.fWxTime = fWxTime;
	}

	public Lookups getfAssStauts() {
		return fAssStauts;
	}

	public void setfAssStauts(Lookups fAssStauts) {
		this.fAssStauts = fAssStauts;
	}

	public String getAssStauts() {
		if(fAssStauts!=null){
			return fAssStauts.getName();
		}
		return assStauts;
	}

	public void setAssStauts(String assStauts) {
		this.assStauts = assStauts;
	}


	public String getfUseNameID() {
		return fUseNameID;
	}

	public void setfUseNameID(String fUseNameID) {
		this.fUseNameID = fUseNameID;
	}

	public String getfUseName() {
		return fUseName;
	}

	public void setfUseName(String fUseName) {
		this.fUseName = fUseName;
	}

	public String getfUseDeptID() {
		return fUseDeptID;
	}

	public void setfUseDeptID(String fUseDeptID) {
		this.fUseDeptID = fUseDeptID;
	}

	public String getfUseDept() {
		return fUseDept;
	}

	public void setfUseDept(String fUseDept) {
		this.fUseDept = fUseDept;
	}

	
	}
