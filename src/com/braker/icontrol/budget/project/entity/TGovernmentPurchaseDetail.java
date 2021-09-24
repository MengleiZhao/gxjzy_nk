package com.braker.icontrol.budget.project.entity;

import java.math.BigDecimal;
import java.sql.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


/**
 * 
* <p>Title:TGovernmentPurchaseDetail </p>
* <p>Description: 预算申报的政府采购明细表</p>
* <p>Company: </p> 
* @author zml
* @date 2021年5月12日
 */
@Entity
@Table(name = "T_GOVERNMENT_PURCHASE_DETAIL")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TGovernmentPurchaseDetail extends BaseEntity {

	@Id
	@Column(name = "F_G_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer gpId;				//主键
	
	@Column(name = "F_PRO_ID")
	private Integer fProId;				//项目表主键
	
	@Column(name = "F_ITEMS_DETAIL")
	private String fItemsDetail;				//品目明细
	
	@Column(name = "F_ITEMS_CODE")
	private String fItemsCode;				//品目编号
	
	@Column(name = "F_ITEMS_NAME")
	private String fItemsName;			//品目名称

	@Column(name = "F_ITEMS_CODE_NAME")
	private String fItemsCodeName;				//品目编码及名称
	
	@Column(name = "F_SUBJECT_CODE")
	private String subCode;				//经济分类科目编号
	
	@Column(name = "F_SUBJECT_NAME")
	private String subName;				//经济分类科目名称

	@Column(name = "F_IF_THREE_ASSETS")
	private Integer fIfThreeAssets;			//是否新增三项资产

	@Column(name = "F_PROCUREMENT_NUM")
	private Integer fProcurementNum; 			//采购数量

	@Column(name = "F_MEASUREMENT")
	private String fMeasurement;				//计量单位

	@Column(name = "F_UNIT_PRICE")
	private BigDecimal fUnitPrice;			//采购单价（元）

	@Column(name = "F_AMOUNT")
	private BigDecimal fAmount;				//总计

	@Column(name = "F_PLAN_DATE")
	private Date fPlanDate;				//计划采购日期

	@Column(name = "F_REFINING_EXPLAIN")
	private String fRefiningExplain;				//参数

	@Column(name = "F_ALLOCATION_STANDARD")
	private String fAllocationStandard;				//采购配置标准
	
	@Column(name = "F_EXPLAIN")
	private String fExplain;				//说明
	
	@Column(name = "F_IF_SOFTWARE")
	private String fIfSoftware;				//是否软件明细0:政府采购明细        1:政府采购明细软件类型

	public Integer getGpId() {
		return gpId;
	}

	public void setGpId(Integer gpId) {
		this.gpId = gpId;
	}

	public String getfItemsDetail() {
		return fItemsDetail;
	}

	public void setfItemsDetail(String fItemsDetail) {
		this.fItemsDetail = fItemsDetail;
	}

	public String getfItemsCode() {
		return fItemsCode;
	}

	public void setfItemsCode(String fItemsCode) {
		this.fItemsCode = fItemsCode;
	}

	public String getfItemsName() {
		return fItemsName;
	}

	public void setfItemsName(String fItemsName) {
		this.fItemsName = fItemsName;
	}

	public String getfItemsCodeName() {
		return fItemsCodeName;
	}

	public void setfItemsCodeName(String fItemsCodeName) {
		this.fItemsCodeName = fItemsCodeName;
	}

	public Integer getfIfThreeAssets() {
		return fIfThreeAssets;
	}

	public void setfIfThreeAssets(Integer fIfThreeAssets) {
		this.fIfThreeAssets = fIfThreeAssets;
	}

	public Integer getfProcurementNum() {
		return fProcurementNum;
	}

	public void setfProcurementNum(Integer fProcurementNum) {
		this.fProcurementNum = fProcurementNum;
	}

	public String getfMeasurement() {
		return fMeasurement;
	}

	public void setfMeasurement(String fMeasurement) {
		this.fMeasurement = fMeasurement;
	}

	public BigDecimal getfUnitPrice() {
		return fUnitPrice;
	}

	public void setfUnitPrice(BigDecimal fUnitPrice) {
		this.fUnitPrice = fUnitPrice;
	}

	public BigDecimal getfAmount() {
		return fAmount;
	}

	public void setfAmount(BigDecimal fAmount) {
		this.fAmount = fAmount;
	}

	public Date getfPlanDate() {
		return fPlanDate;
	}

	public void setfPlanDate(Date fPlanDate) {
		this.fPlanDate = fPlanDate;
	}

	public String getfRefiningExplain() {
		return fRefiningExplain;
	}

	public void setfRefiningExplain(String fRefiningExplain) {
		this.fRefiningExplain = fRefiningExplain;
	}

	public String getfAllocationStandard() {
		return fAllocationStandard;
	}

	public void setfAllocationStandard(String fAllocationStandard) {
		this.fAllocationStandard = fAllocationStandard;
	}

	public String getfExplain() {
		return fExplain;
	}

	public void setfExplain(String fExplain) {
		this.fExplain = fExplain;
	}

	public Integer getfProId() {
		return fProId;
	}

	public void setfProId(Integer fProId) {
		this.fProId = fProId;
	}

	public String getSubCode() {
		return subCode;
	}

	public void setSubCode(String subCode) {
		this.subCode = subCode;
	}

	public String getSubName() {
		return subName;
	}

	public void setSubName(String subName) {
		this.subName = subName;
	}

	public String getfIfSoftware() {
		return fIfSoftware;
	}

	public void setfIfSoftware(String fIfSoftware) {
		this.fIfSoftware = fIfSoftware;
	}
	
}
