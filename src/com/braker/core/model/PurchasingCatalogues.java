package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 采购目录管理
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */

@Entity
@Table(name="T_PURCHASING_CATALOGUES")
public class PurchasingCatalogues extends BaseEntityEmpty implements Combobox{
	
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fId;
	
	@Column(name = "F_LEVEL")
	private String flevel;			//目录级别
	
	@Column(name = "F_P_PUR_CODE")
	private String fpPurCode;			//上级目录编码

	@Column(name = "F_PUR_CODE")
	private String fpurCode;			//目录编码
	
	@Column(name = "F_PUR_NAME")
	private String fpurName;			//目录名称
	
	@Column(name = "F_MEASURE_UNIT")
	private String fmeasureUnit;			//计量单位
	
	@Column(name = "F_REMARK")
	private String fremark;			//备注

	@Transient
	private Integer num;			//序号(数据库中没有)

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getFlevel() {
		return flevel;
	}

	public void setFlevel(String flevel) {
		this.flevel = flevel;
	}

	public String getFpPurCode() {
		return fpPurCode;
	}

	public void setFpPurCode(String fpPurCode) {
		this.fpPurCode = fpPurCode;
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

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	@Override
	public String getId() {
		return String.valueOf(fId);
	}
	
	@Override
	public String getCode() {
		// TODO Auto-generated method stub
		return fpurCode;
	}

	@Override
	public String getGridCode() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSftjCode() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return fpurName;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}
}
