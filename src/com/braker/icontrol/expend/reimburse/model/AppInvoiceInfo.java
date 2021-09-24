package com.braker.icontrol.expend.reimburse.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * app发票信息表的model
 * @author 沈帆
 * @createtime 2020-07-01
 * @updatetime 2020-07-01
 */
@Entity
@Table(name = "T_APP_INVOICE_INFO")
public class AppInvoiceInfo extends BaseEntityEmpty   {
	@Id
	@Column(name = "F_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fIId;				//主键ID
	
	@Column(name = "F_INVOICE_CODE")
	private String fInvoiceCode;			//发票号码
	
	@Column(name = "F_R_ID")
	private Integer fRId;				//保存该发票所属单据的主键
	
	@Column(name = "F_INVOICE_AMOUNT")
	private String fInvoiceAmount;			//发票金额
	
	@Column(name = "F_UPLOAD_TIME")
	private Date fUploadTime;			//上传时间
	
	@Column(name = "F_FILE_SRC")
	private String fFileSrc;				//发票保存路径
	
	@Column(name = "F_FILE_ID")
	private String fFileId;				//附件id
	
	@Column(name = "F_UPLOAD_USERID")
	private String fUploadUserid;        //上传人id
	
	@Column(name = "F_UPLOAD_USERNAME")
	private String fUploadUsername;        //上传人姓名
	
	@Column(name = "F_INVOICE_STATUS")
	private String fInvoiceStatus;        //票据状态（锁定/未锁定）
	
	@Column(name = "F_TRUE_OR_FALSE")
	private String fTrueOrFalse;        //票据真假状态 (0-假，1-真，2-未验证)
	
	@Column(name = "P_FLAG")
	private String pFlag;        //删除状态（99为删除）
	
	@Column(name = "F_MARK")
    public String mark;         //备注
	
	@Column(name = "F_REIMB_TYPE")
	public String reimbType;         //报销类型(0-直接报销，1-申请报销)
    
	@Column(name = "F_COST_TYPE")
	public String costType;         //费用类型
	
	@Transient
	private String isFirst;  //是否首次报销(0为是1为否)
	
	public String getpFlag() {
		return pFlag;
	}

	public void setpFlag(String pFlag) {
		this.pFlag = pFlag;
	}

	public Integer getfIId() {
		return fIId;
	}

	public void setfIId(Integer fIId) {
		this.fIId = fIId;
	}

	public String getfInvoiceCode() {
		return fInvoiceCode;
	}

	public void setfInvoiceCode(String fInvoiceCode) {
		this.fInvoiceCode = fInvoiceCode;
	}

	public Integer getfRId() {
		return fRId;
	}

	public void setfRId(Integer fRId) {
		this.fRId = fRId;
	}

	public String getfInvoiceAmount() {
		return fInvoiceAmount;
	}

	public void setfInvoiceAmount(String fInvoiceAmount) {
		this.fInvoiceAmount = fInvoiceAmount;
	}

	public Date getfUploadTime() {
		return fUploadTime;
	}

	public void setfUploadTime(Date fUploadTime) {
		this.fUploadTime = fUploadTime;
	}

	public String getfFileSrc() {
		return fFileSrc;
	}

	public void setfFileSrc(String fFileSrc) {
		this.fFileSrc = fFileSrc;
	}

	public String getfFileId() {
		return fFileId;
	}

	public void setfFileId(String fFileId) {
		this.fFileId = fFileId;
	}

	public String getfUploadUserid() {
		return fUploadUserid;
	}

	public void setfUploadUserid(String fUploadUserid) {
		this.fUploadUserid = fUploadUserid;
	}

	public String getfUploadUsername() {
		return fUploadUsername;
	}

	public void setfUploadUsername(String fUploadUsername) {
		this.fUploadUsername = fUploadUsername;
	}

	public String getfInvoiceStatus() {
		return fInvoiceStatus;
	}

	public void setfInvoiceStatus(String fInvoiceStatus) {
		this.fInvoiceStatus = fInvoiceStatus;
	}

	public String getfTrueOrFalse() {
		return fTrueOrFalse;
	}

	public void setfTrueOrFalse(String fTrueOrFalse) {
		this.fTrueOrFalse = fTrueOrFalse;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getReimbType() {
		return reimbType;
	}

	public void setReimbType(String reimbType) {
		this.reimbType = reimbType;
	}

	public String getCostType() {
		return costType;
	}

	public void setCostType(String costType) {
		this.costType = costType;
	}

	public String getIsFirst() {
		return isFirst;
	}

	public void setIsFirst(String isFirst) {
		this.isFirst = isFirst;
	}

	

	
	
}
