package com.braker.icontrol.cgmanage.cgprocess.model;

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
 * 采购中标登记的model
 * @author 冉德茂
 * @createtime 2018-07-20
 * @updatetime 2018-07-20
 */

@Entity
@Table(name="T_BID_REGIST")
public class BidRegist extends BaseEntity implements EntityDao{
	
	@Id
	@Column(name = "F_BID_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fbIdId;
	
	@Column(name ="F_P_ID")							//外键ID  链接采购表的id(F_P_ID);
	private Integer fpId;
	
	@Column(name ="F_B_ID")							//外键ID  招标表的主键id  中标后改为1  避免多次进行中标登记;
	private Integer fbId;
	
	@Column(name ="F_W_ID")							//外键ID  链接供应商的id (F_P_ID);
	private Integer fwId;
		
	@Column(name = "F_NOTIC_TITLE")
	private String fnoticTitle;			//中标公告标题
	
	@Column(name = "F_ABSTRACT")
	private String fabstract;			//中标公告摘要
	
	@Column(name = "F_NOTIC_PUB_TIME")
	private Date fnoticPubTime;			//公告发布日期
	
	@Column(name = "F_PRO_NUM")
	private String fproNum;			//项目报个数
	
	@Column(name = "F_BID_TIME")
	private Date fbidTime;			//中标日期
	
	@Column(name = "F_BID_AMOUNT")
	private String fbidAmount;			//总中标金额
	
	@Column(name = "F_BIDDING_NAME")
	private String fbiddingName;			//招标名称
	
	@Column(name = "F_BIDDING_CODE")
	private String fbiddingCode;			//招标编号
	
	@Column(name = "F_AGENT_NAME")
	private String fagentName;			//招标代理机构名称
	
	@Column(name = "F_ORG_NAME")
	private String forgName;			//中标组织名称(供应商名称)
	
	@Column(name = "F_START_TIME")
	private Date fstartTime;			//开标时间
	
	@Column(name = "F_JUDGE_TIME")
	private Date fjudgeTime;			//评价时间
	
	@Column(name = "F_JUDGE_ADDR")
	private String fjudgeAddr;			//评价地点
	
	@Column(name = "F_STAUTS")
	private String fstatus;			//评价地点
	
	@Transient
	private Integer num;			//序号(数据库中没有)


	
	
	
	public Integer getFbId() {
		return fbId;
	}


	public void setFbId(Integer fbId) {
		this.fbId = fbId;
	}


	public Integer getFwId() {
		return fwId;
	}


	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}


	public String getFstatus() {
		return fstatus;
	}


	public void setFstatus(String fstatus) {
		this.fstatus = fstatus;
	}


	public Date getFjudgeTime() {
		return fjudgeTime;
	}


	public void setFjudgeTime(Date fjudgeTime) {
		this.fjudgeTime = fjudgeTime;
	}


	public String getFjudgeAddr() {
		return fjudgeAddr;
	}


	public void setFjudgeAddr(String fjudgeAddr) {
		this.fjudgeAddr = fjudgeAddr;
	}


	public String getForgName() {
		return forgName;
	}


	public void setForgName(String forgName) {
		this.forgName = forgName;
	}


	public String getFagentName() {
		return fagentName;
	}


	public void setFagentName(String fagentName) {
		this.fagentName = fagentName;
	}


	public Integer getFbIdId() {
		return fbIdId;
	}


	public void setFbIdId(Integer fbIdId) {
		this.fbIdId = fbIdId;
	}


	public Integer getFpId() {
		return fpId;
	}


	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}


	public String getFnoticTitle() {
		return fnoticTitle;
	}


	public void setFnoticTitle(String fnoticTitle) {
		this.fnoticTitle = fnoticTitle;
	}


	public String getFabstract() {
		return fabstract;
	}


	public void setFabstract(String fabstract) {
		this.fabstract = fabstract;
	}


	public Date getFnoticPubTime() {
		return fnoticPubTime;
	}


	public void setFnoticPubTime(Date fnoticPubTime) {
		this.fnoticPubTime = fnoticPubTime;
	}


	public String getFproNum() {
		return fproNum;
	}


	public void setFproNum(String fproNum) {
		this.fproNum = fproNum;
	}


	public Date getFbidTime() {
		return fbidTime;
	}


	public void setFbidTime(Date fbidTime) {
		this.fbidTime = fbidTime;
	}


	public String getFbidAmount() {
		return fbidAmount;
	}


	public void setFbidAmount(String fbidAmount) {
		this.fbidAmount = fbidAmount;
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


	public Integer getNum() {
		return num;
	}


	public void setNum(Integer num) {
		this.num = num;
	}


	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_BID_REGIST";
	}


	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(fbIdId);
	}

	
	

}
