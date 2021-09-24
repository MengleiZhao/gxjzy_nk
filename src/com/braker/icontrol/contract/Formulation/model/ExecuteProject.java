package com.braker.icontrol.contract.Formulation.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
@Entity
@Table(name = "t_executeproject")
public class ExecuteProject extends BaseEntity implements EntityDao,CheckEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fprojectId;
	
	@Column(name = "F_ZXXMID")
	private String fzxxmId;//执行项目表id
	
	@Column(name ="F_CONT_CODE")
	private String fcCode;//合同编号（流水号）
	
	@Column(name = "F_OPERATOR")
	private String fOperator;//申请人
	
	@Column(name ="F_OPERATOR_ID")
	private String fOperatorId;//申请人id

	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//所属部门
	
	@Column(name ="F_DEPT_ID")
	private String fDeptId;//所属部门
	
	@Column(name = "F_REQ_TIME")
	private Date fReqtIME;//申请时间
	
	@Column(name = "F_ZXXMCLR")
	private String zxxmclr;		//结转下环节处理人姓名
	
	@Column(name = "F_ZXXMCLRBM")
	private String zxxmclrbm;			//结转下环节处理人编码
	
	@Column(name = "F_XJDBM")
	private String xjdbm;			//结转下节点节点编码
	
	@Column(name = "F_JZSPZT")
	private String jzspzt;		//结转审批状态
	
	@Column(name = "F_JZSTAUTS")
	private String jzstauts;		//结转状态

	
	
	public String getFcCode() {
		return fcCode;
	}

	public void setFcCode(String fcCode) {
		this.fcCode = fcCode;
	}

	public String getJzstauts() {
		return jzstauts;
	}

	public void setJzstauts(String jzstauts) {
		this.jzstauts = jzstauts;
	}

	public Integer getFprojectId() {
		return fprojectId;
	}

	public void setFprojectId(Integer fprojectId) {
		this.fprojectId = fprojectId;
	}

	public String getFzxxmId() {
		return fzxxmId;
	}

	public void setFzxxmId(String fzxxmId) {
		this.fzxxmId = fzxxmId;
	}

	public String getfOperator() {
		return fOperator;
	}

	public void setfOperator(String fOperator) {
		this.fOperator = fOperator;
	}

	public String getfOperatorId() {
		return fOperatorId;
	}

	public void setfOperatorId(String fOperatorId) {
		this.fOperatorId = fOperatorId;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
	}

	public Date getfReqtIME() {
		return fReqtIME;
	}

	public void setfReqtIME(Date fReqtIME) {
		this.fReqtIME = fReqtIME;
	}

	public String getZxxmclr() {
		return zxxmclr;
	}

	public void setZxxmclr(String zxxmclr) {
		this.zxxmclr = zxxmclr;
	}

	public String getZxxmclrbm() {
		return zxxmclrbm;
	}

	public void setZxxmclrbm(String zxxmclrbm) {
		this.zxxmclrbm = zxxmclrbm;
	}

	public String getXjdbm() {
		return xjdbm;
	}

	public void setXjdbm(String xjdbm) {
		this.xjdbm = xjdbm;
	}

	public String getJzspzt() {
		return jzspzt;
	}

	public void setJzspzt(String jzspzt) {
		this.jzspzt = jzspzt;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.zxxmclr=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.zxxmclrbm=userId;
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return zxxmclrbm;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.xjdbm=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.jzspzt=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return jzspzt;
	}

	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.jzstauts=status;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fcCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_CONT_CODE";
	}

	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fprojectId;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fOperatorId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return xjdbm;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "t_executeproject";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return String.valueOf(fprojectId);
	}
	
	
}
