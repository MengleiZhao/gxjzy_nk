package com.braker.icontrol.cgmanage.cgprocess.model;

import java.math.BigDecimal;
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
 * 采购招标登记的model   更改为    采购过程登记model
 * @author 冉德茂
 * @createtime 2018-07-18
 * @updatetime 2018-07-18
 */

@Entity
@Table(name="T_BIDDING_REGIST")
public class BiddingRegist extends BaseEntity implements EntityDao{
	
	@Id
	@Column(name = "F_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   
	private Integer fbId;							//主键ID
	
	@Column(name = "F_P_ID")							
	private Integer fpId;							//外键ID  链接PurchaseApplyBasic (F_P_ID);
	
	@Column(name = "F_W_ID")							
	private Integer fwId;							//外键ID  链接供应商的id (F_P_ID);
	
	@Column(name = "F_BID_AMOUNT")
	private BigDecimal fbidAmount;						//中标金额
	
	@Column(name = "F_BID_TIME")
	private Date fbidTime;							//中标时间
	
	@Column(name = "F_STAUTS")
	private String fstatus;							//数据状态
	
	
	/**
	 * 暂不使用
	 */
	@Column(name = "F_BIDDING_NAME")
	private String fbiddingName;					//招标名称
	
	@Column(name = "F_BIDDING_CODE")
	private String fbiddingCode;					//招标编号
	
	@Column(name = "F_START_TIME")
	private Date fstartTime;						//开标时间
	
	@Column(name = "F_TEND_UNIT_NAME")
	private String ftendUnitName;					//招标单位
		
	@Column(name = "F_TEND_UNIT_ADDR")
	private String ftendUnitAddr;					//招标单位地址
	
	@Column(name = "F_TEND_USER_TEL")
	private String ftendUserTel;					//招标联系人电话
	
	@Column(name = "F_TEND_FAX")
	private String ftendFax;						//招标单位传真
	
	@Column(name = "F_TEND_USER")
	private String ftendUser;						//招标单位联系人
	
	@Column(name = "F_AGENT_NAME")
	private String fagentName;						//代理机构
	
	@Column(name = "F_AGENT_USER")
	private String fagentUser;						//代理机构联系人
	
	@Column(name = "F_AGENT_ADDR")
	private String fagentAddr;						//代理机构地址
	
	@Column(name = "F_AGENT_USER_TEL")
	private String fagentUserTel;					//代理联系人电话
	
	@Column(name = "F_AGENT_FAX")
	private String fagentFax;						//代理机构传真
	
	@Column(name = "F_BID_STAUTS")
	private String fbidStatus;						//中标登记状态    
	
	

	@Transient
	private Integer num;							//序号(数据库中没有)


	public Integer getFbId() {
		return fbId;
	}

	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getFwId() {
		return fwId;
	}

	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}

	public BigDecimal getFbidAmount() {
		return fbidAmount;
	}

	public void setFbidAmount(BigDecimal fbidAmount) {
		this.fbidAmount = fbidAmount;
	}

	public Date getFbidTime() {
		return fbidTime;
	}

	public void setFbidTime(Date fbidTime) {
		this.fbidTime = fbidTime;
	}

	public String getFstatus() {
		return fstatus;
	}

	public void setFstatus(String fstatus) {
		this.fstatus = fstatus;
	}

	public String getFbiddingName() {
		return fbiddingName;
	}

	public void setFbiddingName(String fbiddingName) {
		this.fbiddingName = fbiddingName;
	}

	public String getFbiddingCode() {
		return fbiddingCode;
	}

	public void setFbiddingCode(String fbiddingCode) {
		this.fbiddingCode = fbiddingCode;
	}

	public Date getFstartTime() {
		return fstartTime;
	}

	public void setFstartTime(Date fstartTime) {
		this.fstartTime = fstartTime;
	}

	public String getFtendUnitName() {
		return ftendUnitName;
	}

	public void setFtendUnitName(String ftendUnitName) {
		this.ftendUnitName = ftendUnitName;
	}

	public String getFtendUnitAddr() {
		return ftendUnitAddr;
	}

	public void setFtendUnitAddr(String ftendUnitAddr) {
		this.ftendUnitAddr = ftendUnitAddr;
	}

	public String getFtendUserTel() {
		return ftendUserTel;
	}

	public void setFtendUserTel(String ftendUserTel) {
		this.ftendUserTel = ftendUserTel;
	}

	public String getFtendFax() {
		return ftendFax;
	}

	public void setFtendFax(String ftendFax) {
		this.ftendFax = ftendFax;
	}

	public String getFtendUser() {
		return ftendUser;
	}

	public void setFtendUser(String ftendUser) {
		this.ftendUser = ftendUser;
	}

	public String getFagentName() {
		return fagentName;
	}

	public void setFagentName(String fagentName) {
		this.fagentName = fagentName;
	}

	public String getFagentUser() {
		return fagentUser;
	}

	public void setFagentUser(String fagentUser) {
		this.fagentUser = fagentUser;
	}

	public String getFagentAddr() {
		return fagentAddr;
	}

	public void setFagentAddr(String fagentAddr) {
		this.fagentAddr = fagentAddr;
	}

	public String getFagentUserTel() {
		return fagentUserTel;
	}

	public void setFagentUserTel(String fagentUserTel) {
		this.fagentUserTel = fagentUserTel;
	}

	public String getFagentFax() {
		return fagentFax;
	}

	public void setFagentFax(String fagentFax) {
		this.fagentFax = fagentFax;
	}

	public String getFbidStatus() {
		return fbidStatus;
	}

	public void setFbidStatus(String fbidStatus) {
		this.fbidStatus = fbidStatus;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String getJoinTable() {
		return "T_BIDDING_REGIST";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(fbId);
	}
	

}
