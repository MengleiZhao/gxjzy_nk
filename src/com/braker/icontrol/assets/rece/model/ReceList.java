package com.braker.icontrol.assets.rece.model;

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

/**
 * 资产领用清单
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_RECE_LIST")
public class ReceList extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_LIST_ID")
	private Integer fListId;
	
	@ManyToOne
	@JoinColumn(name ="F_ID",referencedColumnName="F_ID")
	private Rece rece;//外键rece表的主键
	
	@Column(name ="F_ASS_RECE_CODE")
	private String fAssReceCode_RL;//资产领用单号（流水号）
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode_RL;//物资编码

	@Column(name ="F_ASS_NAME")
	private String fAssName_RL;//物资名称
	
	@Column(name ="F_ASS_SPECIF")
	private String fAssSpecif_RL;//规格型号
	
	@Column(name ="F_MEAS_UNIT")
	private String fMeasUnit_RL;//计量单位
	
	@Column(name ="F_RECE_NUM")
	private String fReceNum_RL;//数量
	
	@Column(name="F_SIGN_PRICE")
	private String fSignPrice;//单价（元）
	
	@Column(name="F_AMOUNT")
	private String fAmount;//金额（元）
	
	@Column(name ="F_NEW_ADDRESS")
	private String fNewAddress;//新存放地点
	
	@Column(name ="F_NEW_USER")
	private String fNewUser;//新资产管理人
	
	@Column(name ="F_OLD_ADDRESS")
	private String fOldAddress;//原存放地点
	
	@Column(name ="F_OLD_USER")
	private String fOldUser;//原资产管理人
	
	@Column(name ="F_REMARK")
	private String fRemark_RL;//备注
	
	@Transient
	private Integer fNumber;//可用数量

	public Integer getfListId() {
		return fListId;
	}

	public void setfListId(Integer fListId) {
		this.fListId = fListId;
	}

	public String getfAssReceCode_RL() {
		return fAssReceCode_RL;
	}

	public void setfAssReceCode_RL(String fAssReceCode_RL) {
		this.fAssReceCode_RL = fAssReceCode_RL;
	}

	public String getfAssCode_RL() {
		return fAssCode_RL;
	}

	public void setfAssCode_RL(String fAssCode_RL) {
		this.fAssCode_RL = fAssCode_RL;
	}

	public String getfAssName_RL() {
		return fAssName_RL;
	}

	public void setfAssName_RL(String fAssName_RL) {
		this.fAssName_RL = fAssName_RL;
	}

	public String getfMeasUnit_RL() {
		return fMeasUnit_RL;
	}

	public void setfMeasUnit_RL(String fMeasUnit_RL) {
		this.fMeasUnit_RL = fMeasUnit_RL;
	}

	public String getfReceNum_RL() {
		return fReceNum_RL;
	}

	public void setfReceNum_RL(String fReceNum_RL) {
		this.fReceNum_RL = fReceNum_RL;
	}

	public Rece getRece() {
		return rece;
	}

	public void setRece(Rece rece) {
		this.rece = rece;
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

	public String getfNewAddress() {
		return fNewAddress;
	}

	public void setfNewAddress(String fNewAddress) {
		this.fNewAddress = fNewAddress;
	}

	public String getfNewUser() {
		return fNewUser;
	}

	public void setfNewUser(String fNewUser) {
		this.fNewUser = fNewUser;
	}

	public String getfOldAddress() {
		return fOldAddress;
	}

	public void setfOldAddress(String fOldAddress) {
		this.fOldAddress = fOldAddress;
	}

	public String getfOldUser() {
		return fOldUser;
	}

	public void setfOldUser(String fOldUser) {
		this.fOldUser = fOldUser;
	}

	public String getfRemark_RL() {
		return fRemark_RL;
	}

	public void setfRemark_RL(String fRemark_RL) {
		this.fRemark_RL = fRemark_RL;
	}

	public Integer getfNumber() {
		return fNumber;
	}

	public void setfNumber(Integer fNumber) {
		this.fNumber = fNumber;
	}

	public String getfAssSpecif_RL() {
		return fAssSpecif_RL;
	}

	public void setfAssSpecif_RL(String fAssSpecif_RL) {
		this.fAssSpecif_RL = fAssSpecif_RL;
	}
	
	
	
}
