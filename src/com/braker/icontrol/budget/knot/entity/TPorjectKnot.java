package com.braker.icontrol.budget.knot.entity;

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
import com.braker.common.entity.EntityDao;

/**
 * 
 * <p>Description: 结项申请类</p>
 * @author:安达
 * @date： 2019年6月19日下午5:08:01
 */
@Entity
@Table(name="T_PROJECT_KNOT")
public class TPorjectKnot extends BaseEntity implements EntityDao,CheckEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_K_ID")
	private Integer fkId;
	
	@Column(name = "F_PRO_ID")
	private Integer FProId;  //项目id
	
	@Column(name = "F_KNOT_CODE")
	private String FKnotCode;//结项编号
	
	@Column(name = "F_PRO_CODE")
	private String FProCode;//项目编号
	
	@Column(name = "F_PRO_NAME")
	private String FProName;//项目名称
	
	@Column(name = "F_PRO_BUDGET_AMOUNT")
	private BigDecimal FProBudgetAmount;//项目预算金额
	
	@Column(name = "F_PRO_OUT_AMOUNT")
	private BigDecimal FProOutAmount;//项目实际支出金额
	
	@Column(name = "F_PRO_EFFICIENCY")
	private BigDecimal FProEfficiency;//项目完成率	
	
	@Column(name = "F_PRO_MEMO")
	private String FProMemo;//项目验收结论
	
	@Column(name = "F_FIRST_LEVEL_NAME")
	private String firstLevelName;  //一级分类名称（选择）
	
	@Column(name = "F_FIRST_LEVEL_CODE")
	private String firstLevelCode; //一级分类代码（选择）
	
	@Column(name = "F_BEGIN_TIME")
	private Date proBeginTime;			//项目开始时间
	
	@Column(name = "F_END_TIME")
	private Date proEndTime;			//项目结束时间
	
	@Column(name = "F_REQ_TIME")
	private Date freqTime;			//申请日期
	
	@Column(name = "F_REQ_USER_NAME")
	private String freqUserName;		//申请人名字
	
	@Column(name = "F_REQ_USER_ID")
	private String freqUserId;		//申请人ID
	
	@Column(name = "F_REQ_DEPT")
	private String freqDept;		//申请部门
	
	@Column(name = "F_REQ_DEPT_ID")
	private String freqDeptId;		//申请部门编号
	
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
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	

	
	
	public BigDecimal getFProBudgetAmount() {
		return FProBudgetAmount;
	}

	public void setFProBudgetAmount(BigDecimal fProBudgetAmount) {
		FProBudgetAmount = fProBudgetAmount;
	}

	public Integer getFkId() {
		return fkId;
	}

	public void setFkId(Integer fkId) {
		this.fkId = fkId;
	}

	public Integer getFProId() {
		return FProId;
	}

	public void setFProId(Integer fProId) {
		FProId = fProId;
	}

	public String getFProCode() {
		return FProCode;
	}

	public void setFProCode(String fProCode) {
		FProCode = fProCode;
	}

	public String getFProName() {
		return FProName;
	}

	public void setFProName(String fProName) {
		FProName = fProName;
	}

	public BigDecimal getFProOutAmount() {
		return FProOutAmount;
	}

	public void setFProOutAmount(BigDecimal fProOutAmount) {
		FProOutAmount = fProOutAmount;
	}

	public BigDecimal getFProEfficiency() {
		return FProEfficiency;
	}

	public void setFProEfficiency(BigDecimal fProEfficiency) {
		FProEfficiency = fProEfficiency;
	}

	public String getFProMemo() {
		return FProMemo;
	}

	public void setFProMemo(String fProMemo) {
		FProMemo = fProMemo;
	}

	public String getFirstLevelName() {
		return firstLevelName;
	}

	public void setFirstLevelName(String firstLevelName) {
		this.firstLevelName = firstLevelName;
	}

	public String getFirstLevelCode() {
		return firstLevelCode;
	}

	public void setFirstLevelCode(String firstLevelCode) {
		this.firstLevelCode = firstLevelCode;
	}

	public Date getProBeginTime() {
		return proBeginTime;
	}

	public void setProBeginTime(Date proBeginTime) {
		this.proBeginTime = proBeginTime;
	}

	public Date getProEndTime() {
		return proEndTime;
	}

	public void setProEndTime(Date proEndTime) {
		this.proEndTime = proEndTime;
	}

	public Date getFreqTime() {
		return freqTime;
	}

	public void setFreqTime(Date freqTime) {
		this.freqTime = freqTime;
	}

	public String getFreqUserName() {
		return freqUserName;
	}

	public void setFreqUserName(String freqUserName) {
		this.freqUserName = freqUserName;
	}

	public String getFreqUserId() {
		return freqUserId;
	}

	public void setFreqUserId(String freqUserId) {
		this.freqUserId = freqUserId;
	}

	public String getFreqDept() {
		return freqDept;
	}

	public void setFreqDept(String freqDept) {
		this.freqDept = freqDept;
	}

	public String getFreqDeptId() {
		return freqDeptId;
	}

	public void setFreqDeptId(String freqDeptId) {
		this.freqDeptId = freqDeptId;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	
	
	public String getFKnotCode() {
		return FKnotCode;
	}

	public void setFKnotCode(String fKnotCode) {
		FKnotCode = fKnotCode;
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
		return FKnotCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fkId;
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
		return freqUserId;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_PROJECT_KNOT";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return fkId+"";
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_KNOT_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
