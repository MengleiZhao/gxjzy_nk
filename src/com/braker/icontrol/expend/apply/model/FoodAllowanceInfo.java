package com.braker.icontrol.expend.apply.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.annotation.Generated;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 差旅伙食补助费信息列表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_FOOD_ALLOWANCE_INFO")
public class FoodAllowanceInfo extends BaseEntity implements EntityDao{

	@Id
	@Column(name = "F_F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer ffId;//主键
	
	@Column(name = "F_G_ID")
	private Integer gId;			//ApplicationBasicInfo 的主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//ReimbAppliBasicInfo的主键ID

	@Column(name = "F_TRAVAL_TYPE")
	private String travelType;			//出差类型
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name = "F_START_DATE")
	private Date fStartDate;//出发日期
	
	@Column(name = "F_ARRIVALS_DATE")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	private Date fArrivalsDate;//到达日期
	
	@Column(name = "F_ADDRESS")
	private String fAddress;//目的地
	
	@Column(name = "F_NAME")
	private String fname;//伙食补助人员姓名
	
	@Column(name = "F_NAME_ID")
	private String fnameId;//伙食补助人员姓名ID
	
	@Column(name = "F_DAYS")
	private Integer fDays;//伙食补助天数
	
	@Column(name  = "F_APPLY_AMOUNT")
	private BigDecimal fApplyAmount;//事前申请金额(元)
	
	@Column(name  = "F_REIMB_AMOUNT")
	private BigDecimal fReimbAmount;//报销金额(元)

	@Column(name  = "F_STD_AMOUNT")
	private BigDecimal fStdAmount;//金额标准(元)
	
	@Column(name = "F_STANDARD")
	private BigDecimal standard;//住宿标准
	
	@Column(name = "F_COUNT_STANDARD")
	private BigDecimal countStandard;//总额标准（外币）
	
	@Column(name = "F_CURRENCY")
	private String currency;//币种
	
	@Column(name = "F_STATUS")
	private Integer fStatus;//数据状态0-事前申请，1-事后报销
	
	@Transient
	private Integer num;         //数量
	
	public BigDecimal getfStdAmount() {
		return fStdAmount;
	}

	public void setfStdAmount(BigDecimal fStdAmount) {
		this.fStdAmount = fStdAmount;
	}

	public String getTravelType() {
		return travelType;
	}

	public void setTravelType(String travelType) {
		this.travelType = travelType;
	}

	public BigDecimal getStandard() {
		return standard;
	}

	public void setStandard(BigDecimal standard) {
		this.standard = standard;
	}

	public BigDecimal getCountStandard() {
		return countStandard;
	}

	public void setCountStandard(BigDecimal countStandard) {
		this.countStandard = countStandard;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getFfId() {
		return ffId;
	}

	public void setFfId(Integer ffId) {
		this.ffId = ffId;
	}

	public Date getfStartDate() {
		return fStartDate;
	}

	public void setfStartDate(Date fStartDate) {
		this.fStartDate = fStartDate;
	}

	public Date getfArrivalsDate() {
		return fArrivalsDate;
	}

	public void setfArrivalsDate(Date fArrivalsDate) {
		this.fArrivalsDate = fArrivalsDate;
	}

	public String getfAddress() {
		return fAddress;
	}

	public void setfAddress(String fAddress) {
		this.fAddress = fAddress;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getFnameId() {
		return fnameId;
	}

	public void setFnameId(String fnameId) {
		this.fnameId = fnameId;
	}

	public Integer getfDays() {
		return fDays;
	}

	public void setfDays(Integer fDays) {
		this.fDays = fDays;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public BigDecimal getfApplyAmount() {
		return fApplyAmount;
	}

	public void setfApplyAmount(BigDecimal fApplyAmount) {
		this.fApplyAmount = fApplyAmount;
	}

	public BigDecimal getfReimbAmount() {
		return fReimbAmount;
	}

	public void setfReimbAmount(BigDecimal fReimbAmount) {
		this.fReimbAmount = fReimbAmount;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_FOOD_ALLOWANCE_IFOR";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(ffId);
	}

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}
	
	
	
	
	
	
	
}
