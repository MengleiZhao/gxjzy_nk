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
import com.braker.core.model.Lookups;

/**
 * 资产操作流水表
 * @author 陈睿超
 * @createtime 2019-04-15
 *
 */
@Entity
@Table(name ="T_ASSETFLOW_LIST")
public class AssetFlow extends BaseEntity {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer flowId;//主键
	
	@Column(name ="F_ASSET_LIST_CODE")
	private String fAssetListCode;//操作流水单号
	
	@ManyToOne
	@JoinColumn(name ="F_OPT_TYPE",referencedColumnName="lookupscode")
	private Lookups fOptType;//操作类型:ZCLSCZLX-01-入库,ZCLSCZLX-02-领用,ZCLSCZLX-03-调拨,ZCLSCZLX-04-处置,ZCLSCZLX-05-维修
	
	@Transient
	private String optType;//操作方式（显示用）
	
	@Column(name ="F_ASS_CODE")
	private String flowCode;//相关操作单号
	
	@Column(name ="F_STOCK_CODE")
	private String flowStockCode;//资产编码
	
	@Column(name ="F_ASS_NAME")
	private String flowAssName;//资产名称
	
	@ManyToOne
	@JoinColumn(name ="F_ASS_TYPE",referencedColumnName="lookupscode")
	private Lookups flowAssType;//资产类型 ：ZCLX-01-低值易耗品,ZCLX-02-固定资产,ZCLX-03-无形资产

	@Transient
	private String fAssType;//资产类型（显示用）
	
	@Column(name ="F_MEAS_UNIT")
	private String flowMeasUnit;//计量单位
	
	@Column(name ="F_ASS_NUM")
	private Integer flowNum;//数量
	
	@Column(name ="F_ASS_TIME")
	private Date flowTime;//操作时间
	
	@Column(name ="F_ASS_DEPT")
	private String flowDeptName;//操作部门名称
	
	@Column(name ="F_ASS_DEPT_ID")
	private String flowDeptID;//操作部门ID
	
	@Column(name ="F_ASS_USER_ID")
	private String flowUserID;//操作人ID
	
	@Column(name ="F_ASS_USER")
	private String flowUser;//操作人

	public Integer getFlowId() {
		return flowId;
	}

	public void setFlowId(Integer flowId) {
		this.flowId = flowId;
	}

	public String getfAssetListCode() {
		return fAssetListCode;
	}

	public void setfAssetListCode(String fAssetListCode) {
		this.fAssetListCode = fAssetListCode;
	}

	public Lookups getfOptType() {
		return fOptType;
	}

	public void setfOptType(Lookups fOptType) {
		this.fOptType = fOptType;
	}

	public String getFlowCode() {
		return flowCode;
	}

	public void setFlowCode(String flowCode) {
		this.flowCode = flowCode;
	}

	public String getFlowStockCode() {
		return flowStockCode;
	}

	public void setFlowStockCode(String flowStockCode) {
		this.flowStockCode = flowStockCode;
	}

	public String getFlowAssName() {
		return flowAssName;
	}

	public void setFlowAssName(String flowAssName) {
		this.flowAssName = flowAssName;
	}

	public Lookups getFlowAssType() {
		return flowAssType;
	}

	public void setFlowAssType(Lookups flowAssType) {
		this.flowAssType = flowAssType;
	}

	public String getFlowMeasUnit() {
		return flowMeasUnit;
	}

	public void setFlowMeasUnit(String flowMeasUnit) {
		this.flowMeasUnit = flowMeasUnit;
	}

	public Integer getFlowNum() {
		return flowNum;
	}

	public void setFlowNum(Integer flowNum) {
		this.flowNum = flowNum;
	}

	public Date getFlowTime() {
		return flowTime;
	}

	public void setFlowTime_F(Date flowTime) {
		this.flowTime = flowTime;
	}

	public String getFlowDeptName() {
		return flowDeptName;
	}

	public void setFlowDeptName(String flowDeptName) {
		this.flowDeptName = flowDeptName;
	}

	public String getFlowDeptID() {
		return flowDeptID;
	}

	public void setFlowDeptID(String flowDeptID) {
		this.flowDeptID = flowDeptID;
	}

	public String getFlowUserID() {
		return flowUserID;
	}

	public void setFlowUserID(String flowUserID) {
		this.flowUserID = flowUserID;
	}

	public String getFlowUser() {
		return flowUser;
	}

	public void setFlowUser(String flowUser) {
		this.flowUser = flowUser;
	}

	public String getOptType() {
		if(fOptType!=null){
			return fOptType.getName();
		}
		return optType;
	}

	public void setOptType(String optType) {
		this.optType = optType;
	}

	public String getfAssType() {
		if(flowAssType!=null){
			return flowAssType.getName();
		}
		return fAssType;
	}

	public void setfAssType(String fAssType) {
		this.fAssType = fAssType;
	}
	
	
	
	
	
	
	
	
	
	
}
