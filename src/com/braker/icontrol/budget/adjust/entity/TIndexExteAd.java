package com.braker.icontrol.budget.adjust.entity;

import java.math.BigDecimal;
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
import com.braker.core.model.User;

/**
 * 指标外部调整的model
 * 是指标外部调整的model类
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Entity
@Table(name = "T_INDEX_EXTE_AD")
public class TIndexExteAd extends BaseEntityEmpty implements CheckEntity{
	@Id
	@Column(name = "F_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer aId;			//主键ID
	
	@Column(name = "F_OUT_CODE")
	private String outCode;			//外部调整编码
	
	@Column(name = "F_DECLARER")
	private String declarer;		//申报人
	
	@Column(name = "F_DECL_TIME")
	private Date declTime;			//申报日期
	
	@Column(name = "F_EXTE_TYPE")
	private String exteType;		//调整类型
	
	@Column(name = "F_EXTE_DESC")
	private String exteDesc;		//调整说明
	
	@Column(name = "F_OP_USER")
	private String opUser;			//操作人
	
	@Column(name = "F_DEPT_CODE")
	private String deptCode;		//所属部门
	
	@Column(name = "F_OP_TIME",updatable=false)
	private Date opTime;			//调整时间
	
	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;		//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;			//申请状态
	
	@Column(name = "F_USER_NAME")
	private String fuserName;		//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_ACCOUNT_STAUTS")
	private String accountStauts;	//到账状态
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String indexName;			//调整指标名称(数据库中没有)
	
	@Transient
	private BigDecimal changeAmount;			//指标调整金额(数据库中没有)
	@Transient
	private BigDecimal changeAmountBegin;			//调整金额起始
	@Transient
	private BigDecimal changeAmountEnd;			//调整金额起结尾
	

	public BigDecimal getChangeAmountBegin() {
		return changeAmountBegin;
	}

	public void setChangeAmountBegin(BigDecimal changeAmountBegin) {
		this.changeAmountBegin = changeAmountBegin;
	}

	public BigDecimal getChangeAmountEnd() {
		return changeAmountEnd;
	}

	public void setChangeAmountEnd(BigDecimal changeAmountEnd) {
		this.changeAmountEnd = changeAmountEnd;
	}

	public Integer getaId() {
		return aId;
	}

	public void setaId(Integer aId) {
		this.aId = aId;
	}

	public String getDeclarer() {
		return declarer;
	}

	public void setDeclarer(String declarer) {
		this.declarer = declarer;
	}

	public Date getDeclTime() {
		return declTime;
	}

	public void setDeclTime(Date declTime) {
		this.declTime = declTime;
	}

	public String getExteType() {
		return exteType;
	}

	public void setExteType(String exteType) {
		this.exteType = exteType;
	}

	public String getExteDesc() {
		return exteDesc;
	}

	public void setExteDesc(String exteDesc) {
		this.exteDesc = exteDesc;
	}

	public String getOpUser() {
		return opUser;
	}

	public void setOpUser(String opUser) {
		this.opUser = opUser;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public String getFlowStauts() {
		return flowStauts;
	}

	public void setFlowStauts(String flowStauts) {
		this.flowStauts = flowStauts;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}


	public String getFuserName() {
		return fuserName;
	}

	public void setFuserName(String fuserName) {
		this.fuserName = fuserName;
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

	public String getAccountStauts() {
		return accountStauts;
	}

	public void setAccountStauts(String accountStauts) {
		this.accountStauts = accountStauts;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public BigDecimal getChangeAmount() {
		return changeAmount;
	}

	public void setChangeAmount(BigDecimal changeAmount) {
		this.changeAmount = changeAmount;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.fuserName=userName;
	}
	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.flowStauts=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return flowStauts;
	}
	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return outCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return aId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return declarer;
	}
	@Override
	public String getJoinTable() {
		return "T_INDEX_EXTE_AD";
	}
	
	public String getOutCode() {
		return outCode;
	}

	public void setOutCode(String outCode) {
		this.outCode = outCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_OUT_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}
	
	
}
