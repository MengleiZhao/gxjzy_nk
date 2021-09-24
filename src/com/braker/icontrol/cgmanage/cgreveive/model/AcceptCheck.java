package com.braker.icontrol.cgmanage.cgreveive.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;

/**
 * 采购验收的model
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */

@Entity
@Table(name="T_ACCEPT_CHECK")
public class AcceptCheck extends BaseEntity implements EntityDao,CheckEntity{
	
	@Id
	@Column(name = "F_ACP_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   
	private Integer facpId;							//主键ID
	
	@Column(name = "F_ACP_CODE")
	private String facpCode;						//验收单编号
	
	@Column(name ="F_P_ID")							
	private Integer fpId;							//外键ID  链接T_PURCHASE_APPLY_BASIC (F_P_ID);
	
	@Column(name ="F_P_CODE")							
	private String fpCode;							//外键ID  链接T_PURCHASE_APPLY_BASIC (F_P_CODE);
	
	@Column (name ="F_DEPT_ID")
	private String fDepartId;						//验收部门id
	
	@Column (name ="F_NAME")
	private String facpName;						//采购名称
	
	@Column (name ="F_AMOUNT")
	private Double facpAmount;						//采购金额
	
	@Column (name ="F_DEPT_NAME")
	private String fDepartName;						//验收部门名称
	
	@Column(name="F_ACP_USER_ID")
	private String facpUserId;						//验收人
	
	@Column(name="F_ACP_USERNAME")
	private String facpUsername;					//验收人姓名
	
	@Column(name = "F_ACP_TIME")
	private Date facpTime;							//验收时间
	
	@Column(name = "F_ACP_ADDR")
	private String facpAddr;						//验收地点	
	
	@Column(name = "F_QUALITY_IS_OK")
	private String fqualityIsOk;					//质量是否合格
	
	@Column(name = "F_IS_MATCH")
	private String fisMatch;						//验收合格
	
	@Column(name = "F_QUALITY_REMARK")
	private String fqualityRemark;					//质量说明

	@Column(name = "F_MATCH_REMARK")
	private String fmatchRemark;					//验收说明
	
	@Column (name ="F_STAUTS")
	private String fStauts;							//删除状态
	
	//审批
	@Column (name ="F_CHECK_STAUTS")
	private String fCheckStauts;					//验收审批状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;						//下环节处理人姓名
	
	@Column(name = "F_USER_CODE")
	private String fuserId;							//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;							//下节点节点编码
	@Column(name = "F_CG_USER")
	private String cgUser;							//采购单申请人id
	@Column(name = "F_CG_USERNAME")
	private String cgUserName;						//采购单申请人
	@Column(name = "F_CG_DEPT")
	private String cgDept;							//采购单申请人部门id
	@Column(name = "F_CG_DEPTNAME")
	private String cgDeptName;						//采购单申请人部门
	@Column(name = "F_CG_TIME")
	private Date cgTime;							//采购申请时间
	
	@Transient
	private Integer num;							//序号(数据库中没有)
	
	
	
	public String getCgUser() {
		return cgUser;
	}

	public void setCgUser(String cgUser) {
		this.cgUser = cgUser;
	}

	public String getCgUserName() {
		return cgUserName;
	}

	public void setCgUserName(String cgUserName) {
		this.cgUserName = cgUserName;
	}

	public String getCgDept() {
		return cgDept;
	}

	public void setCgDept(String cgDept) {
		this.cgDept = cgDept;
	}

	public String getCgDeptName() {
		return cgDeptName;
	}

	public void setCgDeptName(String cgDeptName) {
		this.cgDeptName = cgDeptName;
	}

	public Date getCgTime() {
		return cgTime;
	}

	public void setCgTime(Date cgTime) {
		this.cgTime = cgTime;
	}

	public String getFacpName() {
		return facpName;
	}

	public void setFacpName(String facpName) {
		this.facpName = facpName;
	}

	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public Double getFacpAmount() {
		return facpAmount;
	}

	public void setFacpAmount(Double facpAmount) {
		this.facpAmount = facpAmount;
	}

	public String getFqualityRemark() {
		return fqualityRemark;
	}

	public void setFqualityRemark(String fqualityRemark) {
		this.fqualityRemark = fqualityRemark;
	}

	public Integer getFacpId() {
		return facpId;
	}

	public void setFacpId(Integer facpId) {
		this.facpId = facpId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Date getFacpTime() {
		return facpTime;
	}

	public void setFacpTime(Date facpTime) {
		this.facpTime = facpTime;
	}

	public String getFacpAddr() {
		return facpAddr;
	}

	public void setFacpAddr(String facpAddr) {
		this.facpAddr = facpAddr;
	}

	public String getFqualityIsOk() {
		return fqualityIsOk;
	}

	public void setFqualityIsOk(String fqualityIsOk) {
		this.fqualityIsOk = fqualityIsOk;
	}

	public String getFisMatch() {
		return fisMatch;
	}

	public void setFisMatch(String fisMatch) {
		this.fisMatch = fisMatch;
	}

	public String getFmatchRemark() {
		return fmatchRemark;
	}

	public void setFmatchRemark(String fmatchRemark) {
		this.fmatchRemark = fmatchRemark;
	}

	public String getFacpCode() {
		return facpCode;
	}

	public void setFacpCode(String facpCode) {
		this.facpCode = facpCode;
	}

	public String getfDepartId() {
		return fDepartId;
	}

	public void setfDepartId(String fDepartId) {
		this.fDepartId = fDepartId;
	}

	public String getfDepartName() {
		return fDepartName;
	}

	public void setfDepartName(String fDepartName) {
		this.fDepartName = fDepartName;
	}

	public String getFacpUserId() {
		return facpUserId;
	}

	public void setFacpUserId(String facpUserId) {
		this.facpUserId = facpUserId;
	}

	public String getFacpUsername() {
		return facpUsername;
	}

	public void setFacpUsername(String facpUsername) {
		this.facpUsername = facpUsername;
	}

	public String getfStauts() {
		return fStauts;
	}

	public void setfStauts(String fStauts) {
		this.fStauts = fStauts;
	}

	public String getfCheckStauts() {
		return fCheckStauts;
	}

	public void setfCheckStauts(String fCheckStauts) {
		this.fCheckStauts = fCheckStauts;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}

	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}
	

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	
	@Transient
	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_ACCEPT_CHECK";
	}

	@Transient
	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(facpId);
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.userName2=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fCheckStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fCheckStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fStauts=status;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return facpCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_ACP_CODE";
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return facpId;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return facpUserId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}
	
	
	

}
