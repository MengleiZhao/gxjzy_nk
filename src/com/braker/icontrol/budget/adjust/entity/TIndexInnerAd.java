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
import com.braker.common.entity.EntityDao;

/**
 * 内部指标调整的model
 * 是内部指标调整的model类
 * @author 叶崇晖
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
@Entity
@Table(name = "T_INDEX_INNER_AD")
public class TIndexInnerAd extends BaseEntityEmpty implements CheckEntity,EntityDao{
	@Id
	@Column(name = "F_IN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer inId;			//主键ID
	
	@Column(name = "F_IN_CODE")
	private String inCode;			//内部调整编码
	
	@Column(name = "F_APP_USER")
	private String appUser;			//申请人
	
	@Column(name = "F_APP_TIME")
	private Date appTime;			//申请时间
	
	@Column(name = "F_APP_DESC")
	private String appDesc;			//申请事由
	
	@Column(name = "F_OP_USER")
	private String opUser;			//操作人
	
	@Column(name = "F_DEPT_CODE")
	private String deptCode;		//部门
	
	@Column(name = "F_OP_TIME",updatable=false)
	private Date opTime;			//调整时间
	
	@Column(name = "F_INSIDE_DEPTID")
	private String insideDeptId;	//调出部门id
	
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
	
	@Column(name = "F_CHANGE_TYPE")
	private String changeType;		//调整类型
	
	@Column(name = "F_IS_ACROSS_DEPT")
	private String isAcrossDept;	//是否跨部门 1-是 0-不是
	
	@Column(name ="F_INDEX_TYPE")
	private Integer indexType;//预算支出类型     区分基本支出或项目支出：0=基本支出，1=项目支出 2=大项目
	
	@Column(name = "T_PRO_USE_TYPE")
	private String proUseType;	 //预算使用类型
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;			//调整金额
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String indexNameOut;			//调整指标名称(数据库中没有)
	
	@Transient
	private BigDecimal changeAmountOut;			//指标调整金额(数据库中没有)
	
	@Transient
	private String indexNameIn;			//调入指标名称(数据库中没有)
	
	@Transient
	private BigDecimal changeAmountIn;			//调入金额(数据库中没有)
	
	@Transient
	private String inSideDepartName;			//调减部门名称数据库中没有)

	
	
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	public String getIsAcrossDept() {
		return isAcrossDept;
	}

	public void setIsAcrossDept(String isAcrossDept) {
		this.isAcrossDept = isAcrossDept;
	}

	public Integer getInId() {
		return inId;
	}

	public void setInId(Integer inId) {
		this.inId = inId;
	}

	public String getAppUser() {
		return appUser;
	}

	public void setAppUser(String appUser) {
		this.appUser = appUser;
	}

	public Date getAppTime() {
		return appTime;
	}

	public void setAppTime(Date appTime) {
		this.appTime = appTime;
	}

	public String getAppDesc() {
		return appDesc;
	}

	public void setAppDesc(String appDesc) {
		this.appDesc = appDesc;
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

	public String getInsideDeptId() {
		return insideDeptId;
	}

	public void setInsideDeptId(String insideDeptId) {
		this.insideDeptId = insideDeptId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
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

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getIndexNameOut() {
		return indexNameOut;
	}

	public void setIndexNameOut(String indexNameOut) {
		this.indexNameOut = indexNameOut;
	}

	public BigDecimal getChangeAmountOut() {
		return changeAmountOut;
	}

	public void setChangeAmountOut(BigDecimal changeAmountOut) {
		this.changeAmountOut = changeAmountOut;
	}

	public String getIndexNameIn() {
		return indexNameIn;
	}

	public void setIndexNameIn(String indexNameIn) {
		this.indexNameIn = indexNameIn;
	}

	public BigDecimal getChangeAmountIn() {
		return changeAmountIn;
	}

	public void setChangeAmountIn(BigDecimal changeAmountIn) {
		this.changeAmountIn = changeAmountIn;
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
		return inCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return inId;
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
		return appUser;
	}

	@Override
	public String getJoinTable() {
		return "T_INDEX_INNER_AD";
	}
	
	public String getInCode() {
		return inCode;
	}

	public void setInCode(String inCode) {
		this.inCode = inCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_IN_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

	public String getInSideDepartName() {
		return inSideDepartName;
	}

	public void setInSideDepartName(String inSideDepartName) {
		this.inSideDepartName = inSideDepartName;
	}

	public Integer getIndexType() {
		return indexType;
	}

	public void setIndexType(Integer indexType) {
		this.indexType = indexType;
	}

	@Override
	public String getEntryId() {
		return String.valueOf(inId);
	}

	public String getProUseType() {
		return proUseType;
	}

	public void setProUseType(String proUseType) {
		this.proUseType = proUseType;
	}
	
}
