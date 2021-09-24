package com.braker.icontrol.cgmanage.cgsupplier.model;

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
 * 供应商历史记录成交表model
 * @author 冉德茂
 * @createtime 2018-09-12
 * @updatetime 2018-09-12
 */

@Entity
@Table(name="T_SUPPLIER_TRANSACTION_HIS")
public class SupplierTransactionHis extends BaseEntityEmpty {
	
	@Id
	@Column(name = "F_H_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fhId;
	
	@Column(name ="F_W_ID")
	private Integer fwId;	
	
	@Column(name ="F_BID_ID")
	private Integer fbIdId;	
	
	@Column(name = "F_TR_TIME")
	private Date ftrTime;			//成交时间
	
	@Column(name = "F_SUP_CODE")
	private String fsupCode;		//供应商编码
	
	@Column(name = "F_SUP_NAME")
	private String fsupName;		//供应商名称
	
	@Column(name = "F_PRO_NAME")
	private String fproName;		//项目名称（招标名称）
	
	@Column(name = "F_TR_AMOUNT")
	private String ftrAmount;		//成交金额（中标总金额）
	
	@Column(name = "F_TR_YEAR")
	private String ftrYear;		//成交年份
	
	@Column(name = "F_TR_MONTH")
	private String ftrMonth;		//成交月份
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	public String getFtrYear() {
		return ftrYear;
	}

	public void setFtrYear(String ftrYear) {
		this.ftrYear = ftrYear;
	}

	public String getFtrMonth() {
		return ftrMonth;
	}

	public void setFtrMonth(String ftrMonth) {
		this.ftrMonth = ftrMonth;
	}

	public Integer getFbIdId() {
		return fbIdId;
	}

	public void setFbIdId(Integer fbIdId) {
		this.fbIdId = fbIdId;
	}

	public Integer getFhId() {
		return fhId;
	}

	public void setFhId(Integer fhId) {
		this.fhId = fhId;
	}

	public Integer getFwId() {
		return fwId;
	}

	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}

	public Date getFtrTime() {
		return ftrTime;
	}

	public void setFtrTime(Date ftrTime) {
		this.ftrTime = ftrTime;
	}

	public String getFsupCode() {
		return fsupCode;
	}

	public void setFsupCode(String fsupCode) {
		this.fsupCode = fsupCode;
	}

	public String getFsupName() {
		return fsupName;
	}

	public void setFsupName(String fsupName) {
		this.fsupName = fsupName;
	}

	public String getFproName() {
		return fproName;
	}

	public void setFproName(String fproName) {
		this.fproName = fproName;
	}

	public String getFtrAmount() {
		return ftrAmount;
	}

	public void setFtrAmount(String ftrAmount) {
		this.ftrAmount = ftrAmount;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	
	
	
}
