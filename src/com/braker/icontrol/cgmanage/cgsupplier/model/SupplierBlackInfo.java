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
import com.braker.common.entity.CheckEntity;


/**
 *供应商黑名单记录的实体类
 * @author 李安达
 * @createtime 2019-02-27
 * @updatetime 2019-02-27
 */

@Entity
@Table(name="T_WINNING_BLACK_INFO")
public class SupplierBlackInfo extends BaseEntityEmpty implements CheckEntity{
	
	@Id
	@Column(name = "F_W_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fwBId;
	
	@Column(name = "F_W_ID")
	private Integer fwId;			//供应商id
	
	@Column(name = "F_W_B_CODE")
	private String fwBCode;			//黑名单编号
	
	@Column(name = "F_W_NAME")
	private String fwName;			//供应商名称
	
	@Column(name = "F_W_CODE")
	private String fwCode;			//供应商编码
	
	@Column(name = "F_BLACK_TIME")
	private Date fblackTime;			//移入或者移出黑名单时间
	
	@Column(name = "F_BLACK_DESC")
	private String fblackDesc;			//移入或者移出原因
	
	@Column(name = "F_OP_NAME")
	private String fopName;			//操作人
	
	@Column(name = "F_FLAG")
	private Integer fFlag;			//标识，0:默认，1：移出。2：移入
	
	@Column(name = "F_USER_NAME")	//下环节处理人姓名
	private String fUserName;
	
	@Column(name = "F_USER_ID")	//下环节处理人Id
	private String fUserId;
	
	@Column(name = "F_N_CODE")	//下环节节点
	private String fNcode;
	
	@Column(name = "F_CHECK_STATUS")	//审核状态
	private String fCheckStatus;
	
	@Column(name ="F_REC_USER")
	private String fRecUser;//申請人
	
	@Column(name ="F_EXT_1")
	private String fRecUserId;//申请人id
	
	@Column(name ="F_REC_DEPT")
	private String fRecDept;//申请部门
	
	@Column(name ="F_REC_DEPT_ID")
	private String fRecDeptId;//申请部门编码
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	@Transient
	private String fwuserName;			//联系人

	@Transient
	private Integer faccFreq;			//累计移入黑名单次数

	public Integer getFwBId() {
		return fwBId;
	}

	public String getFwuserName() {
		return fwuserName;
	}

	public void setFwuserName(String fwuserName) {
		this.fwuserName = fwuserName;
	}

	public Integer getFaccFreq() {
		return faccFreq;
	}

	public void setFaccFreq(Integer faccFreq) {
		this.faccFreq = faccFreq;
	}

	public void setFwBId(Integer fwBId) {
		this.fwBId = fwBId;
	}

	public Integer getFwId() {
		return fwId;
	}

	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}

	public String getFwName() {
		return fwName;
	}

	public void setFwName(String fwName) {
		this.fwName = fwName;
	}

	public String getFwCode() {
		return fwCode;
	}

	public void setFwCode(String fwCode) {
		this.fwCode = fwCode;
	}
	
	public Date getFblackTime() {
		return fblackTime;
	}

	public void setFblackTime(Date fblackTime) {
		this.fblackTime = fblackTime;
	}

	public String getFblackDesc() {
		return fblackDesc;
	}

	public void setFblackDesc(String fblackDesc) {
		this.fblackDesc = fblackDesc;
	}

	public String getFopName() {
		return fopName;
	}

	public void setFopName(String fopName) {
		this.fopName = fopName;
	}

	public Integer getfFlag() {
		return fFlag;
	}

	public void setfFlag(Integer fFlag) {
		this.fFlag = fFlag;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfUserId() {
		return fUserId;
	}

	public void setfUserId(String fUserId) {
		this.fUserId = fUserId;
	}

	public String getfNcode() {
		return fNcode;
	}

	public void setfNcode(String fNcode) {
		this.fNcode = fNcode;
	}

	public String getfCheckStatus() {
		return fCheckStatus;
	}

	public void setfCheckStatus(String fCheckStatus) {
		this.fCheckStatus = fCheckStatus;
	}

	public String getfRecUser() {
		return fRecUser;
	}

	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}


	public String getFwBCode() {
		return fwBCode;
	}

	public void setFwBCode(String fwBCode) {
		this.fwBCode = fwBCode;
	}

	
	public String getfRecUserId() {
		return fRecUserId;
	}

	public void setfRecUserId(String fRecUserId) {
		this.fRecUserId = fRecUserId;
	}

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}

	public String getfRecDeptId() {
		return fRecDeptId;
	}

	public void setfRecDeptId(String fRecDeptId) {
		this.fRecDeptId = fRecDeptId;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.fUserName=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fUserId=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.fNcode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fCheckStatus=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fCheckStatus;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fwBCode;
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fwBId;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fRecUserId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNcode;
	}
	@Override
	public String getJoinTable() {
		return "T_WINNING_BLACK_INFO";
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_W_B_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fUserId;
	}
}
