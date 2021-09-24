/**
 * <p>Title: ContractRevenue.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年11月13日
 */
package com.braker.icontrol.incomemanage.contractRevenue.model;

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
 * <p>Title: ContractRevenue</p>  
 * <p>Description: 合同类收入基础类</p>  
 * @author 陈睿超
 * @date 2020年11月13日  
 */
@Entity
@Table(name ="T_CONTRACT_REVENUE")
public class ContractRevenue extends BaseEntity implements EntityDao{

	
	
	@Id
	@Column(name ="F_CR_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fcrID;
	
	@Column(name ="F_CR_CODE")
	private String crCode;//登记单号

	@Column(name ="F_REVENUE_DEPART_NAME")
	private String departName;//登记部门名称
	
	@Column(name ="F_REVENUE_DEPART_ID")
	private String departId;//登记部门id
	
	@Column(name ="F_REVENUE_USER_NAME")
	private String userName;//登记人名称
	
	@Column(name ="F_REVENUE_USER_ID")
	private String userId;//登记人ID
	
	@Column(name ="F_PRO_NAME")
	private String proName;//项目名称
	
	@Column(name ="F_REVENUE_REMARKS")
	private String revenueRemarks;//依据及简要说明
	
	@Column(name ="F_REVENUE_TIME")
	private Date revenueTime;//登记时间
	
	@Column(name ="F_CONT_CODE")
	private String fcCode;//合同编号（流水号）
	
	@Column(name="F_CONT_TITLE")
	private String fcTitle;//合同名称
	
	@Column(name ="F_PAYMENT_DATE")
	private Date  paymentDate;//实际来款日期
	
	@Column(name ="F_VOUCHER_NUMBER")
	private String voucherNumber;//会计凭证号
	
	@Column(name ="F_CONFIRM_STATUS")
	private Integer confirmStatus;//确认状态	0-未确认,1-已确认 
	
	
	@Transient
	private Integer number;//序号 


	public Integer getFcrID() {
		return fcrID;
	}


	public void setFcrID(Integer fcrID) {
		this.fcrID = fcrID;
	}


	public String getCrCode() {
		return crCode;
	}


	public void setCrCode(String crCode) {
		this.crCode = crCode;
	}


	public String getDepartName() {
		return departName;
	}


	public void setDepartName(String departName) {
		this.departName = departName;
	}


	public String getDepartId() {
		return departId;
	}


	public void setDepartId(String departId) {
		this.departId = departId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getProName() {
		return proName;
	}


	public void setProName(String proName) {
		this.proName = proName;
	}


	public String getRevenueRemarks() {
		return revenueRemarks;
	}


	public void setRevenueRemarks(String revenueRemarks) {
		this.revenueRemarks = revenueRemarks;
	}


	public Date getRevenueTime() {
		return revenueTime;
	}


	public void setRevenueTime(Date revenueTime) {
		this.revenueTime = revenueTime;
	}


	public String getFcCode() {
		return fcCode;
	}


	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}


	public String getFcTitle() {
		return fcTitle;
	}


	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}


	public Date getPaymentDate() {
		return paymentDate;
	}


	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}


	public String getVoucherNumber() {
		return voucherNumber;
	}


	public void setVoucherNumber(String voucherNumber) {
		this.voucherNumber = voucherNumber;
	}


	public Integer getConfirmStatus() {
		return confirmStatus;
	}


	public void setConfirmStatus(Integer confirmStatus) {
		this.confirmStatus = confirmStatus;
	}


	public Integer getNumber() {
		return number;
	}


	public void setNumber(Integer number) {
		this.number = number;
	}


	/* 
	 * <p>Title: getJoinTable</p>
	 * <p>Description: get数据库中表名</p>
	 * @return
	 * @see com.braker.common.entity.EntityDao#getJoinTable() 
	 * @author 陈睿超
	 * @createtime 2020年11月13日
	 * @updator 陈睿超
	 * @updatetime 2020年11月13日
	 */
	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_CONTRACT_REVENUE";
	}


	/* 
	 * <p>Title: getEntryId</p>
	 * <p>Description: get主键</p>
	 * @return
	 * @see com.braker.common.entity.EntityDao#getEntryId() 
	 * @author 陈睿超
	 * @createtime 2020年11月13日
	 * @updator 陈睿超
	 * @updatetime 2020年11月13日
	 */
	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(fcrID);
	}
	
	
	
	
}
