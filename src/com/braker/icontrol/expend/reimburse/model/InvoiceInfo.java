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
 * 发票信息表的model
 * @author 叶崇晖
 * @createtime 2019-03-28
 * @updatetime 2019-03-28
 */
@Entity
@Table(name = "T_INVOICE_INFO")
public class InvoiceInfo extends BaseEntityEmpty implements EntityDao {
	@Id
	@Column(name = "F_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer iId;				//主键ID
	
	@Column(name = "F_TYPE")
	private String type;				//所属类型(1、直接报销	2、申请报销)
	
	@Column(name = "F_R_ID")
	private Integer rId;				//保存该发票所属单据的主键
	
	@Column(name = "F_INVOICE_TYPE")
	private String invoiceType;			//发票类型(1、普通发票	2、增值税专用发票		3、机打发票		4、定额发票		5、剪开式发票	6、机动车专用发票)
	
	@Column(name = "F_INVOICE_CODE")
	private String invoiceCode;			//发票代码
	
	@Column(name = "F_INVOICE_NUM")
	private String invoiceNum;			//发票号码
	
	@Column(name = "F_CHECK_CODE")
	private String checkCode;			//校验码
	
	@Column(name = "F_INVOICE_TIME")
	private Date invoiceTime;			//开票日期
	
	@Column(name = "F_BUYER_NAME")
	private String buyerName;			//购买方名称
	
	@Column(name = "F_BUYER_CODE")
	private String buyerCode;			//购买方纳税人识别号
	
	@Column(name = "F_BUYER_ADDRESS_TEL")
	private String buyerAddressTel;		//购买方地址、电话
	
	@Column(name = "F_BUYER_BANK_ACCOUNT")
	private String buyerBankAccount;	//购买方开户行及账号
	
	@Column(name = "F_PRICE_CAPITALS")
	private String priceCapitals;		//价税合计（大写）
	
	@Column(name = "F_PRICE_LOWER_CASE")
	private String priceLowerCase;		//价税合计（小写）
	
	@Column(name = "F_SELLER_NAME")
	private String sellerName;			//销售方名称
	
	@Column(name = "F_SELLER_CODE")
	private String sellerCode;			//销售方纳税人识别号
	
	@Column(name = "F_SELLER_ADDRESS_TEL")
	private String sellerAddressTel;	//销售方地址、电话
	
	@Column(name = "F_SELLER_BANK_ACCOUNT")
	private String sellerBankAccount;	//销售方纳税人识别号
	
	@Column(name = "F_INVOICE_REMARK")
	private String invoiceRemark;		//备注
	
	@Column(name = "F_PAYEE")
	private String invoicePayee;		//收款人
	
	@Column(name = "F_CHECKER")
	private String invoiceChecker;		//复核人
	
	@Column(name = "F_DRAWER")
	private String invoiceDrawer;		//开票人
	
	@Column(name = "F_FILE_SRC")
	private String fileSrc;				//发票保存路径
	
	@Transient
	private List<InvoiceCouponInfo> couponList;//发票票面list
	
	@Transient
	private String fileName;			//附件名称
	
	@Transient
	private String fileId;				//附件id

	public Integer getiId() {
		return iId;
	}

	public void setiId(Integer iId) {
		this.iId = iId;
	}

	public String getInvoiceType() {
		return invoiceType;
	}

	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
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

	public String getCheckCode() {
		return checkCode;
	}

	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	public Date getInvoiceTime() {
		return invoiceTime;
	}

	public void setInvoiceTime(Date invoiceTime) {
		this.invoiceTime = invoiceTime;
	}

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public String getBuyerCode() {
		return buyerCode;
	}

	public void setBuyerCode(String buyerCode) {
		this.buyerCode = buyerCode;
	}

	public String getBuyerAddressTel() {
		return buyerAddressTel;
	}

	public void setBuyerAddressTel(String buyerAddressTel) {
		this.buyerAddressTel = buyerAddressTel;
	}

	public String getBuyerBankAccount() {
		return buyerBankAccount;
	}

	public void setBuyerBankAccount(String buyerBankAccount) {
		this.buyerBankAccount = buyerBankAccount;
	}

	public String getPriceCapitals() {
		return priceCapitals;
	}

	public void setPriceCapitals(String priceCapitals) {
		this.priceCapitals = priceCapitals;
	}

	public String getPriceLowerCase() {
		return priceLowerCase;
	}

	public void setPriceLowerCase(String priceLowerCase) {
		this.priceLowerCase = priceLowerCase;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getSellerCode() {
		return sellerCode;
	}

	public void setSellerCode(String sellerCode) {
		this.sellerCode = sellerCode;
	}

	public String getSellerAddressTel() {
		return sellerAddressTel;
	}

	public void setSellerAddressTel(String sellerAddressTel) {
		this.sellerAddressTel = sellerAddressTel;
	}

	public String getSellerBankAccount() {
		return sellerBankAccount;
	}

	public void setSellerBankAccount(String sellerBankAccount) {
		this.sellerBankAccount = sellerBankAccount;
	}

	public String getInvoiceRemark() {
		return invoiceRemark;
	}

	public void setInvoiceRemark(String invoiceRemark) {
		this.invoiceRemark = invoiceRemark;
	}

	public String getInvoicePayee() {
		return invoicePayee;
	}

	public void setInvoicePayee(String invoicePayee) {
		this.invoicePayee = invoicePayee;
	}

	public String getInvoiceChecker() {
		return invoiceChecker;
	}

	public void setInvoiceChecker(String invoiceChecker) {
		this.invoiceChecker = invoiceChecker;
	}

	public String getInvoiceDrawer() {
		return invoiceDrawer;
	}

	public void setInvoiceDrawer(String invoiceDrawer) {
		this.invoiceDrawer = invoiceDrawer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<InvoiceCouponInfo> getCouponList() {
		return couponList;
	}

	public void setCouponList(List<InvoiceCouponInfo> couponList) {
		this.couponList = couponList;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getFileSrc() {
		return fileSrc;
	}

	public void setFileSrc(String fileSrc) {
		this.fileSrc = fileSrc;
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
		// TODO Auto-generated method stub
		return "T_INVOICE_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(getiId());
	}
}
