package com.braker.icontrol.contract.Formulation.model;


import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;
import com.braker.icontrol.cgmanage.cginquiries.model.Sel;
/**
 * 合同拟定和变更中的采购明细Model
 * @author 赵孟雷
 * @createtime 2020-12-11
 * @updatetime 2020-12-11
 */
@Entity
@Table(name="T_CONTRACT_PLAN_LIST")
public class ContractPlanList extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_P_L_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer mainId;			//主键ID
	
	@Column(name ="F_PL_ID")
	private Integer fplId;			//采购预算表的外键id
	
	@Column(name ="F_P_ID")
	private Integer fpId;			//采购申请表的外键id
	
	@Column(name ="F_CON_ID")
	private Integer fconId;			//合同外键id

	@Column(name ="F_UPT_ID")
	private Integer fId_U;			//变更合同外键id
	
	@Column(name = "F_PUR_CODE")
	private String fpurCode;//采购目录编码
	
	@Column(name = "F_PUR_NAME")
	private String fpurName;//采购目录名称
	
	@Column(name = "F_MEASURE_UNIT")
	private String fmeasureUnit;//计量单位
	
	@Column(name = "F_PUR_BRAND")
	private String fpurBrand;//采购品牌
	
	@Column(name = "F_SPEC")
	private String fspec;//规格
	
	@Column(name = "F_MODEL")
	private String fModel;//型号
	
	@Column(name = "F_NUM")
	private Integer fnum;//数量
	
	@Column(name = "F_UNIT_PRICE")
	private Double funitPrice;//参考单价
	
	@Column(name = "F_SUM_MONEY")
	private Double fsumMoney;//金额合计
	
	@Column(name = "F_COMM_PROP")
	private String fcommProp;//商品属性
	
	@Column(name = "F_NEED_TIME")
	private Date fneedTime;//需求时间
	
	@Column (name ="F_IS_IMP")
	private String fIsImp;// 是否进口 2020-12-10沈帆新增
	
	@Column (name ="F_SITE_AND_PERIOD")
	private String fSiteAndPeriod;// 安装使用地点服务周期 2020-12-10沈帆新增
	
	@Column (name ="F_MANAGER")
	private String fManager;//负责人 2020-12-10沈帆新增
	
	@Column (name ="F_TYPE")
	private String fType;//数据类型 2020-12-11赵孟雷新增       合同拟定：0        合同变更：1

	@Column (name ="F_IF_EDIT")
	private String fIfEdit;//2020-12-18   赵孟雷新增       是否可以编辑
	
	@Transient
	private Integer num;			//序号(数据库中没有)	
	
	public String getfIfEdit() {
		return fIfEdit;
	}

	public void setfIfEdit(String fIfEdit) {
		this.fIfEdit = fIfEdit;
	}

	public Integer getFconId() {
		return fconId;
	}

	public void setFconId(Integer fconId) {
		this.fconId = fconId;
	}

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public Integer getFplId() {
		return fplId;
	}

	public void setFplId(Integer fplId) {
		this.fplId = fplId;
	}

	public Integer getMainId() {
		return mainId;
	}

	public void setMainId(Integer mainId) {
		this.mainId = mainId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public String getFpurCode() {
		return fpurCode;
	}

	public void setFpurCode(String fpurCode) {
		this.fpurCode = fpurCode;
	}

	public String getFpurName() {
		return fpurName;
	}

	public void setFpurName(String fpurName) {
		this.fpurName = fpurName;
	}

	public String getFmeasureUnit() {
		return fmeasureUnit;
	}

	public void setFmeasureUnit(String fmeasureUnit) {
		this.fmeasureUnit = fmeasureUnit;
	}

	public String getFpurBrand() {
		return fpurBrand;
	}

	public void setFpurBrand(String fpurBrand) {
		this.fpurBrand = fpurBrand;
	}

	public Integer getFnum() {
		return fnum;
	}

	public void setFnum(Integer fnum) {
		this.fnum = fnum;
	}

	public Double getFunitPrice() {
		return funitPrice;
	}

	public void setFunitPrice(Double funitPrice) {
		this.funitPrice = funitPrice;
	}

	public Double getFsumMoney() {
		return fsumMoney;
	}

	public void setFsumMoney(Double fsumMoney) {
		this.fsumMoney = fsumMoney;
	}

	public String getFcommProp() {
		return fcommProp;
	}

	public void setFcommProp(String fcommProp) {
		this.fcommProp = fcommProp;
	}

	public Date getFneedTime() {
		return fneedTime;
	}

	public void setFneedTime(Date fneedTime) {
		this.fneedTime = fneedTime;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "ContractPlanList [mainId=" + mainId + ", fplId=" + fplId
				+ ", fpId=" + fpId + ", fconId=" + fconId + ", fpurCode="
				+ fpurCode + ", fpurName=" + fpurName + ", fmeasureUnit="
				+ fmeasureUnit + ", fpurBrand=" + fpurBrand + ", fModel=" + fModel + ", fspec=" + fspec
				+ ", fnum=" + fnum + ", funitPrice="
				+ funitPrice + ", fsumMoney=" + fsumMoney + ", fcommProp="
				+ fcommProp + ", fneedTime=" + fneedTime + ", fIsImp=" + fIsImp
				+ ", fSiteAndPeriod=" + fSiteAndPeriod + ", fManager="
				+ fManager + ", fType=" + fType + ", num=" + num + "]";
	}

	public String getfIsImp() {
		return fIsImp;
	}

	public void setfIsImp(String fIsImp) {
		this.fIsImp = fIsImp;
	}

	public String getfSiteAndPeriod() {
		return fSiteAndPeriod;
	}

	public void setfSiteAndPeriod(String fSiteAndPeriod) {
		this.fSiteAndPeriod = fSiteAndPeriod;
	}

	public String getfManager() {
		return fManager;
	}

	public void setfManager(String fManager) {
		this.fManager = fManager;
	}

	public String getFspec() {
		return fspec;
	}

	public void setFspec(String fspec) {
		this.fspec = fspec;
	}

	public String getfModel() {
		return fModel;
	}

	public void setfModel(String fModel) {
		this.fModel = fModel;
	}

	public Integer getfId_U() {
		return fId_U;
	}

	public void setfId_U(Integer fId_U) {
		this.fId_U = fId_U;
	}
	
	
}
