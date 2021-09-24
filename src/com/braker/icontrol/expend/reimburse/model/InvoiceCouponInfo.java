package com.braker.icontrol.expend.reimburse.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 发票票面信息表的model
 * @author 叶崇晖
 * @createtime 2019-03-28
 * @updatetime 2019-03-28
 */
@Entity
@Table(name = "T_INVOICE_COUPON_INFO")
public class InvoiceCouponInfo extends BaseEntityEmpty {
	
	
	@Id
	@Column(name = "F_I_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer icId;				//主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//所属申请单据的主键
	
	@Column(name = "F_D_R_ID")
	private Integer dRId;				//所属直接报销单据的主键
	
	@Column(name = "F_I_ID")
	private Integer cId;				//发票信息id(副键)
	
	@Column(name = "F_GOODS_SERVICE")
	private String goodsService;		//货物或应税劳务、服务名称
	
	@Column(name = "F_NORMS")
	private String norms;				//规格型号
	
	@Column(name = "F_NUMBER")
	private String number;				//数量
	
	@Column(name = "F_UNIVALENT")
	private Double univalent;			//单价
	
	@Column(name = "F_AMOUNT")
	private Double amount;				//金额
	
	@Column(name = "F_TAX_RATE")
	private String taxRate;				//税率
	
	@Column(name = "F_TAX")
	private Double tax;					//税额
	@Column(name = "F_TIME")
	private Date time;					//开票时间
	
	@Column(name = "F_REMARK")
	private String remark;					//备注
	
	@Column(name = "F_FP_PICTURE")
	private String fpPicture;			//发票缩略图
	
	//以下为住宿费才有
	@Column(name = "F_START_TIME")
	private Date startTime;					//入住时间
	
	@Column(name = "F_END_TIME")
	private Date endTime;					//退房时间
	
	@Column(name = "F_DAYS")
	private String days;					//天数
	
	@Column(name = "F_AVERAGE")
	private Double average;					//日均价
	
	@Column(name = "F_PEOPLE")
	private String people;					//住宿人员
	
	@Column(name = "F_UNIT")
	private String unit;				//住宿地点
	
	@Column(name = "F_FILE_ID")
	private String fileId;				//附件id
	
	//以下为长途交通费才有
	@Column(name = "F_AMOUNT1")
	private Double amount1;		//退改等附加金额
	
	@Column(name = "F_AMOUNT2")
	private Double amount2;		//金额小计

	@Column(name = "F_RIDE_TIME")
	private Date rideTime;			//乘坐日期
	
	@Column(name = "F_VEHICLE")
	private String vehicle;				//交通工具
	
	@Column(name = "F_VEHICLE_LEVEL")
	private String vehicleLevel;		//乘坐类别
	
	@Column(name = "F_TRAVEL_PLACE_START")
	private String placeStart;			//出差地点（出发）
	
	@Column(name = "F_TRAVEL_PLACE_END")
	private String placeEnd;			//出差地点（到达）
	
	@Column(name  = "F_DATA_TYPE")
	private String fDataType;			//发票类型(格式：名称+第几个发票快) travel-1 comm-1(通用事项) directly-1(直接报销)
	
	@Column(name  = "F_FILES_PATH")
	private String filepath;	//附件路径
	
	@Transient
	private String costName;	//费用名称
	
	@Transient
	private Double costAmount;	//费用金额
	
	
	@Transient
	private Integer num;	//递增序号
	public Integer getIcId() {
		return icId;
	}

	public void setIcId(Integer icId) {
		this.icId = icId;
	}

	public String getGoodsService() {
		return goodsService;
	}

	public void setGoodsService(String goodsService) {
		this.goodsService = goodsService;
	}

	public String getNorms() {
		return norms;
	}

	public void setNorms(String norms) {
		this.norms = norms;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getTaxRate() {
		return taxRate;
	}

	public void setTaxRate(String taxRate) {
		this.taxRate = taxRate;
	}

	public Double getTax() {
		return tax;
	}

	public void setTax(Double tax) {
		this.tax = tax;
	}
	
	public Double getUnivalent() {
		return univalent;
	}

	public void setUnivalent(Double univalent) {
		this.univalent = univalent;
	}

	@Override
	public String toString() {
		return "InvoiceCouponInfo [icId=" + icId + ", cId=" + cId
				+ ", goodsService=" + goodsService + ", norms=" + norms
				+ ", unit=" + unit + ", number=" + number + ", amount="
				+ amount + ", taxRate=" + taxRate + ", tax=" + tax + "]";
	}

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getFpPicture() {
		return fpPicture;
	}

	public void setFpPicture(String fpPicture) {
		this.fpPicture = fpPicture;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public Double getAverage() {
		return average;
	}

	public void setAverage(Double average) {
		this.average = average;
	}

	public String getPeople() {
		return people;
	}

	public void setPeople(String people) {
		this.people = people;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Double getAmount1() {
		return amount1;
	}

	public void setAmount1(Double amount1) {
		this.amount1 = amount1;
	}

	public Double getAmount2() {
		return amount2;
	}

	public void setAmount2(Double amount2) {
		this.amount2 = amount2;
	}

	public Date getRideTime() {
		return rideTime;
	}

	public void setRideTime(Date rideTime) {
		this.rideTime = rideTime;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getVehicleLevel() {
		return vehicleLevel;
	}

	public void setVehicleLevel(String vehicleLevel) {
		this.vehicleLevel = vehicleLevel;
	}

	public String getPlaceStart() {
		return placeStart;
	}

	public void setPlaceStart(String placeStart) {
		this.placeStart = placeStart;
	}

	public String getPlaceEnd() {
		return placeEnd;
	}

	public void setPlaceEnd(String placeEnd) {
		this.placeEnd = placeEnd;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getdRId() {
		return dRId;
	}

	public void setdRId(Integer dRId) {
		this.dRId = dRId;
	}

	public String getfDataType() {
		return fDataType;
	}

	public void setfDataType(String fDataType) {
		this.fDataType = fDataType;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	
	
}
