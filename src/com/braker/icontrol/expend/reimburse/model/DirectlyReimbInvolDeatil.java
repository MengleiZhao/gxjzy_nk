package com.braker.icontrol.expend.reimburse.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;

/**
 * 直接报销申请发票明细表的model
 * @author 叶崇晖
 * @createtime 2018-08-06
 * @updatetime 2018-08-06
 */
@Entity
@Table(name = "T_DIRECTLY_REIMB_INVOI_DETAIL")
public class DirectlyReimbInvolDeatil extends BaseEntity implements EntityDao {
	@Id
	@Column(name = "F_N_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer naId;			//主键ID
	
	@Column(name = "F_DR_ID",updatable=false)
	private Integer drId;			//申请信息ID
	
	@Column(name = "F_INVOICE_CODE")
	private String invoiceCode;		//发票代码
	
	@Column(name = "F_INVOICE_NUM")
	private String invoiceNum;		//发票号码
	
	@Column(name = "F_INVOICE_TIME")
	private Date invoiceTime;		//开票时间
	
	@Column(name = "F_FILE_SRC")
	private String fileSrc;			//存放路径(不在存放废弃)
	
	@Column(name = "F_REMARK")
	private String invoiceRemark;	//备注(不在存放废弃)
	
	@Transient
	private String openTime;		//接收JSON
	
	@Transient
	private String fileName;		//附件名称
	
	@Transient
	private String fileId;			//附件id

	
	public Integer getNaId() {
		return naId;
	}

	public void setNaId(Integer naId) {
		this.naId = naId;
	}

	public Integer getDrId() {
		return drId;
	}

	public void setDrId(Integer drId) {
		this.drId = drId;
	}

	public String getInvoiceCode() {
		return invoiceCode;
	}

	public void setInvoiceCode(String invoiceCode) {
		this.invoiceCode = invoiceCode;
	}

	public String getInvoiceNum() {
		return invoiceNum;
	}

	public void setInvoiceNum(String invoiceNum) {
		this.invoiceNum = invoiceNum;
	}

	public Date getInvoiceTime() {
		return invoiceTime;
	}

	public void setInvoiceTime(Date invoiceTime) {
		this.invoiceTime = invoiceTime;
	}

	public String getFileSrc() {
		return fileSrc;
	}

	public void setFileSrc(String fileSrc) {
		this.fileSrc = fileSrc;
	}

	public String getInvoiceRemark() {
		return invoiceRemark;
	}

	public void setInvoiceRemark(String invoiceRemark) {
		this.invoiceRemark = invoiceRemark;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}
	
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	@Override
	public String getJoinTable() {

		return "T_DIRECTLY_REIMB_INVOI_DETAIL";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(getNaId());
	}
	
	
}
