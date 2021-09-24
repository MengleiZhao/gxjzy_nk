package com.braker.icontrol.cgmanage.cgconfplan.model;


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
 * 采购配置申请商品清单的model
 * @author 冉德茂
 * @createtime 2018-10-11
 * @updatetime 2018-10-11
 */
@Entity
@Table(name="T_PROCUREMENT_PLAN_LIST")
public class ProcurementPlanList extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_P_L_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer mainId;			//主键ID
	
	@Column(name ="F_PL_ID")
	private Integer fplId;			//采购预算表的外键id
	
	@Column(name ="F_P_ID")
	private Integer fpId;			//采购申请表的外键id
	
	@Column(name ="F_B_ID")
	private Integer fbId;			//采购过程登记表的外键id
	
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
	
	@Column (name ="F_IS_ARGUMENT")
	private String fIsArgument;// 是否论证 2021-2-26赵孟雷新增
	
	@Column (name ="F_SITE_AND_PERIOD")
	private String fSiteAndPeriod;// 安装使用地点服务周期 2020-12-10沈帆新增
	
	@Column (name ="F_MANAGER")
	private String fManager;//负责人 2020-12-10沈帆新增
	
	@Column (name ="F_TYPE")
	private String fType;//数据类型 2020-12-11赵孟雷新增       采购申请：1        采购登记：2          采购验收：3
	
	@Transient
	private String fIfEdit;//2020-12-18   赵孟雷新增       是否可以编辑
	
	@Transient
	private Integer num;			//序号(数据库中没有)	
	
	@Transient
	private List<Sel> selList;			//供货商集合(数据库中没有)	

	public String getfIfEdit() {
		return fIfEdit;
	}

	public void setfIfEdit(String fIfEdit) {
		this.fIfEdit = fIfEdit;
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

	public List<Sel> getSelList() {
		return selList;
	}

	public void setSelList(List<Sel> selList) {
		this.selList = selList;
	}

	@Override
	public String toString() {
		return "ProcurementPlanList [mainId=" + mainId + ", fpId=" + fpId
				+ ", fpurCode=" + fpurCode + ", fpurName=" + fpurName
				+ ", fmeasureUnit=" + fmeasureUnit + ", fpurBrand=" + fpurBrand
				+ ", fnum=" + fnum
				+ ", funitPrice=" + funitPrice + ", fsumMoney=" + fsumMoney + ", fModel=" + fModel + ", fspec=" + fspec
				+ ", fcommProp=" + fcommProp + ", fneedTime=" + fneedTime
				+ ", num=" + num + ", getMainId()=" + getMainId()
				+ ", getFpId()=" + getFpId() + ", getFpurCode()="
				+ getFpurCode() + ", getFpurName()=" + getFpurName()
				+ ", getFmeasureUnit()=" + getFmeasureUnit()
				+ ", getFpurBrand()=" + getFpurBrand()  + ", getFnum()=" + getFnum()
				+ ", getFunitPrice()=" + getFunitPrice() + ", getFsumMoney()="
				+ getFsumMoney() + ", getFcommProp()=" + getFcommProp()
				+ ", getFneedTime()=" + getFneedTime() + ", getNum()="
				+ getNum() + ", getId()=" + getId() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString()
				+ ", getClass()=" + getClass() + "]";
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

	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public String getfIsArgument() {
		return fIsArgument;
	}

	public void setfIsArgument(String fIsArgument) {
		this.fIsArgument = fIsArgument;
	}
}
