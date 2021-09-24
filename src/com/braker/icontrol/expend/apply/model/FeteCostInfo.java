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
 * 宴请费信息列表
 * @author 赵孟雷
 *
 */
@Entity
@Table(name ="T_FETE_COST_INFO")
public class FeteCostInfo extends BaseEntity implements EntityDao{

	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;//主键
	
	@Column(name = "F_G_ID")
	private Integer gId;			//ApplicationBasicInfo 的主键ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//ReimbAppliBasicInfo的主键ID
	
	@Column(name = "F_ADDRESS_ID")
	private Integer fAddressId;//目的地id
	
	@Column(name = "F_ADDRESS")
	private String fAddress;//目的地
	
	@Column(name = "F_FEE_NUM")
	private Integer fFeeNum;//宴请人数
	
	@Column(name = "F_ACCOMPANY_NUM")
	private Integer fAccompanyNum;//陪餐人数
	
	@Column(name  = "F_APPLY_AMOUNT")
	private BigDecimal fApplyAmount;//事前申请金额(元)
	
	@Column(name  = "F_REIMB_AMOUNT")
	private BigDecimal fReimbAmount;//报销金额(元)

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

	public Integer getfAddressId() {
		return fAddressId;
	}

	public void setfAddressId(Integer fAddressId) {
		this.fAddressId = fAddressId;
	}

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
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

	public String getfAddress() {
		return fAddress;
	}

	public void setfAddress(String fAddress) {
		this.fAddress = fAddress;
	}

	public Integer getfFeeNum() {
		return fFeeNum;
	}

	public void setfFeeNum(Integer fFeeNum) {
		this.fFeeNum = fFeeNum;
	}

	public Integer getfAccompanyNum() {
		return fAccompanyNum;
	}

	public void setfAccompanyNum(Integer fAccompanyNum) {
		this.fAccompanyNum = fAccompanyNum;
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

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
