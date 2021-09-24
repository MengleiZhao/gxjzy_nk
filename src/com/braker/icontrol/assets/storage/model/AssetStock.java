package com.braker.icontrol.assets.storage.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;
/**
 * 库存数量表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_STOCK")
public class AssetStock extends BaseEntityEmpty{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fId;//
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode;//物资编码
	
	@Column(name ="F_RESI_NUM")
	private Integer fRestNum;//库存数量
	
	@Column(name ="F_UPDATE_USER")
	private String fUpadteUser;//修改人
	
	@Column(name ="F_UPDATE_TIME")
	private Date fUpdateTime;//修改时间
	
	@Column(name ="F_BEFORE_RESI_NUM")
	private Integer fBeforeRestNum;//修改前库存数量
	
	@Column(name ="F_AFTER_RESI_NUM")
	private Integer fAfterRestNum;//修改后库存数量

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getfAssCode() {
		return fAssCode;
	}

	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}

	public Integer getfRestNum() {
		return fRestNum;
	}

	public void setfRestNum(Integer fRestNum) {
		this.fRestNum = fRestNum;
	}

	public String getfUpadteUser() {
		return fUpadteUser;
	}

	public void setfUpadteUser(String fUpadteUser) {
		this.fUpadteUser = fUpadteUser;
	}

	public Date getfUpdateTime() {
		return fUpdateTime;
	}

	public void setfUpdateTime(Date fUpdateTime) {
		this.fUpdateTime = fUpdateTime;
	}

	public Integer getfBeforeRestNum() {
		return fBeforeRestNum;
	}

	public void setfBeforeRestNum(Integer fBeforeRestNum) {
		this.fBeforeRestNum = fBeforeRestNum;
	}

	public Integer getfAfterRestNum() {
		return fAfterRestNum;
	}

	public void setfAfterRestNum(Integer fAfterRestNum) {
		this.fAfterRestNum = fAfterRestNum;
	}
	
}
