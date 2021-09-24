package com.braker.icontrol.incomemanage.accountsCurrent.model;
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
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.Combobox;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * 往来款立项
 * @author 赵孟雷
 *
 */
@Entity
@Table(name = "T_ACCOUNTS_CURRENT_APPROVAL")
public class AccountsCurrent extends BaseEntity implements EntityDao,CheckEntity,Combobox{

	@Id
	@Column(name = "F_A_C_A_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer fAcaId;
	
	@Column(name = "F_PRO_NAME")
	private String proName;				//项目名称
	
	@Column(name = "F_PRO_CODE")
	private String proCode;				//项目编号
	
	@Column(name = "F_CONTEN_EXPLAIN")
	private String contenExplain;		//内容说明
	
	@Column(name = "F_USER")
	private String userId;				//申请人id
	
	@Column(name = "F_USER_NAME")
	private String userName;			//申请人姓名
	
	@Column(name = "F_DEPT_ID")
	private String deptId;				//申请人所属部门的id
	
	@Column(name = "F_DEPT_NAME")
	private String deptName;			//申请人所属部门名称
	
	@Column(name = "F_REQ_TIME")
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date reqTime;				//申请时间

	@Column(name = "F_FLOW_STAUTS")
	private String flowStauts;			//审批状态
	
	@Column(name = "F_STAUTS")
	private String stauts;				//申请状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;			//下环节处理人姓名
	
	@Column(name = "F_USER_ID")
	private String fuserId;				//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;				//下节点节点编码
	
	@Column(name = "F_REGISTER_STAUTS")
	private String rStauts;				//登记状态
	
	@Column(name = "F_AFFIRM_STAUTS")
	private String aStauts;				//确认状态

	@Transient
	private BigDecimal incomeMoney;          //收款金额
	
	@Transient
	private BigDecimal paymentMoney;          //付款金额
	
	public BigDecimal getIncomeMoney() {
		return incomeMoney;
	}

	public void setIncomeMoney(BigDecimal incomeMoney) {
		this.incomeMoney = incomeMoney;
	}

	public BigDecimal getPaymentMoney() {
		return paymentMoney;
	}

	public void setPaymentMoney(BigDecimal paymentMoney) {
		this.paymentMoney = paymentMoney;
	}

	public String getrStauts() {
		return rStauts;
	}

	public void setrStauts(String rStauts) {
		this.rStauts = rStauts;
	}

	public String getaStauts() {
		return aStauts;
	}

	public void setaStauts(String aStauts) {
		this.aStauts = aStauts;
	}

	public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public Integer getfAcaId() {
		return fAcaId;
	}

	public void setfAcaId(Integer fAcaId) {
		this.fAcaId = fAcaId;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getContenExplain() {
		return contenExplain;
	}

	public void setContenExplain(String contenExplain) {
		this.contenExplain = contenExplain;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Date getReqTime() {
		return reqTime;
	}

	public void setReqTime(Date reqTime) {
		this.reqTime = reqTime;
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

	@Override
	public void setNextCheckUserName(String userName) {
		this.userName2=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fuserId=userId;
	}

	@Override
	public String getNextCheckUserId() {
		return fuserId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.flowStauts=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		return flowStauts;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
	}

	@Override
	public String getBeanCode() {
		return proCode;
	}

	@Override
	public String getBeanCodeField() {
		return "F_PRO_CODE";
	}

	@Override
	public Integer getBeanId() {
		return fAcaId;
	}

	@Override
	public String getNextCheckKey() {
		return nCode;
	}

	@Override
	public String getJoinTable() {
		return "T_ACCOUNTS_CURRENT_APPROVAL";
	}

	@Override
	public String getEntryId() {
		return String.valueOf(getfAcaId());
	}

	/* 
	 * <p>Title: getCode</p>
	 * <p>Description: </p>
	 * @return
	 * @see com.braker.common.entity.Combobox#getCode() 
	 * @author 陈睿超
	 * @createtime 2020年11月23日
	 * @updator 陈睿超
	 * @updatetime 2020年11月23日
	 */
	@Override
	public String getCode() {
		// TODO Auto-generated method stub
		return getProCode();
	}

	/* 
	 * <p>Title: getGridCode</p>
	 * <p>Description: </p>
	 * @return
	 * @see com.braker.common.entity.Combobox#getGridCode() 
	 * @author 陈睿超
	 * @createtime 2020年11月23日
	 * @updator 陈睿超
	 * @updatetime 2020年11月23日
	 */
	@Override
	public String getGridCode() {
		// TODO Auto-generated method stub
		return null;
	}

	/* 
	 * <p>Title: getSftjCode</p>
	 * <p>Description: </p>
	 * @return
	 * @see com.braker.common.entity.Combobox#getSftjCode() 
	 * @author 陈睿超
	 * @createtime 2020年11月23日
	 * @updator 陈睿超
	 * @updatetime 2020年11月23日
	 */
	@Override
	public String getSftjCode() {
		// TODO Auto-generated method stub
		return null;
	}

	/* 
	 * <p>Title: getText</p>
	 * <p>Description: </p>
	 * @return
	 * @see com.braker.common.entity.Combobox#getText() 
	 * @author 陈睿超
	 * @createtime 2020年11月23日
	 * @updator 陈睿超
	 * @updatetime 2020年11月23日
	 */
	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return getProName();
	}

	/* 
	 * <p>Title: getDesc</p>
	 * <p>Description: </p>
	 * @return
	 * @see com.braker.common.entity.Combobox#getDesc() 
	 * @author 陈睿超
	 * @createtime 2020年11月23日
	 * @updator 陈睿超
	 * @updatetime 2020年11月23日
	 */
	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}
	

}
