package com.braker.icontrol.assets.maintain.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;


/**
 * 资产维修表
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_ASSET_MAINTENANCE")
public class Maintain extends BaseEntity implements EntityDao , CheckEntity{
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fID;//主键

	@OneToOne
	@JoinColumn(name ="F_B_ID" ,referencedColumnName="F_B_ID")
	private TBudgetIndexMgr budgetIndexMgr;//外键  预算指标管理表 
	
	@Column(name ="T_ASSET_MAIN_CODE")
	private String tAssetMainCode;//资产维修单流水号
	
	@Column(name ="F_MAIN_DEPT_ID")
	private String fMainDeptID;//申请部门ID
	
	@Column(name ="F_MAIN_DEPT")
	private String fMainDept;//申请部门名称
	
	@Column(name ="F_MAIN_USER_ID")
	private String fMainUserID;//申请人ID
	
	@Column(name ="F_MAIN_USER")
	private String fMainUser;//申请人名称
	
	@Column(name ="F_MAIN_TIME")
	private Date fMainTime;//申请时间
	
	@Column(name ="F_ASS_CODE")
	private String fAssCode;//维修资产编号
	
	@Column(name ="F_ASS_NAME")
	private String fAssName;//维修资产名称
	
	@Column(name="F_ASS_MODEL")
	private String fAssModel;//维修资产规格型号
	
	@ManyToOne
	@JoinColumn(name ="F_MAIN_WHETHER" ,referencedColumnName ="lookupscode")
	private Lookups fMainWhether;//是否产生维修费用  :sfcswxfy-01产生费用，sfcswxfy-02不产生费用
	
	@Column(name ="F_MAIN_AMOUNT")
	private Double fMainAmount;//维修费用
	
	@Column(name ="F_B_INDEX_CODE")
	private String fBIndexCode;//预算指标编码
	
	@Column(name ="F_B_INDEX_NAME")
	private String fBIndexName;//预算指标名称
	
	@Column(name ="F_REMARK")
	private String fFaultRemark;//故障情况
	
	@Column(name ="F_NEXT_USER_NAME")
	private String fNextUserName;//下环节处理人 姓名
	
	@Column(name ="F_NEXT_USER_CODE")
	private String fNextUserCode;//下环节处理人 编码
	
	@Column(name ="F_NEXT_CODE")
	private String fNextCode;//下节点节点编码

	@Column(name ="F_FLOW_STAUTS")
	private String fFlowStauts;//审批状态：0：暂存,1：待审核,2：审核中,9：已审核
	
	@Column(name ="F_MAIN_STAUTS")
	private String fMainStauts;//维修单状态 ：1-正常，99删除
	
	@Column(name ="F_REPAIR_TIME")
	private Date fRepairTime;//报修时间
	
	@Column(name ="F_ACQUISITION_DATE")
	private Date fAcquisitionDate;//购置时间
	
	@Column(name ="F_REG_STAUTS")
	private String fRegStauts;//登记状态0-未登记，1-已登记
	
	@Transient
	private Date fRepairTimeStart;//报修时间开始(查询用)
	
	@Transient
	private Date fRepairTimeEnd;//报修时间结束(查询用)
	
	@Transient
	private String mainWhether;//是否产生费用（显示）
	
	@Transient
	private Integer number;//序号
	
	@Transient
	private Integer bId;//用来传指标的主键(传值用)

	public Integer getfID() {
		return fID;
	}

	public void setfID(Integer fID) {
		this.fID = fID;
	}

	public TBudgetIndexMgr getBudgetIndexMgr() {
		return budgetIndexMgr;
	}

	public void setBudgetIndexMgr(TBudgetIndexMgr budgetIndexMgr) {
		this.budgetIndexMgr = budgetIndexMgr;
	}

	public String gettAssetMainCode() {
		return tAssetMainCode;
	}

	public void settAssetMainCode(String tAssetMainCode) {
		this.tAssetMainCode = tAssetMainCode;
	}

	public String getfMainDeptID() {
		return fMainDeptID;
	}

	public void setfMainDeptID(String fMainDeptID) {
		this.fMainDeptID = fMainDeptID;
	}

	public String getfMainDept() {
		return fMainDept;
	}

	public void setfMainDept(String fMainDept) {
		this.fMainDept = fMainDept;
	}

	public String getfMainUserID() {
		return fMainUserID;
	}

	public void setfMainUserID(String fMainUserID) {
		this.fMainUserID = fMainUserID;
	}

	public String getfMainUser() {
		return fMainUser;
	}

	public void setfMainUser(String fMainUser) {
		this.fMainUser = fMainUser;
	}

	public Date getfMainTime() {
		return fMainTime;
	}

	public void setfMainTime(Date fMainTime) {
		this.fMainTime = fMainTime;
	}

	public String getfAssCode() {
		return fAssCode;
	}

	public void setfAssCode(String fAssCode) {
		this.fAssCode = fAssCode;
	}

	public String getfAssName() {
		return fAssName;
	}

	public void setfAssName(String fAssName) {
		this.fAssName = fAssName;
	}

	public Lookups getfMainWhether() {
		return fMainWhether;
	}

	public void setfMainWhether(Lookups fMainWhether) {
		this.fMainWhether = fMainWhether;
	}

	public Double getfMainAmount() {
		return fMainAmount;
	}

	public void setfMainAmount(Double fMainAmount) {
		this.fMainAmount = fMainAmount;
	}

	public String getfBIndexCode() {
		return fBIndexCode;
	}

	public void setfBIndexCode(String fBIndexCode) {
		this.fBIndexCode = fBIndexCode;
	}

	public String getfBIndexName() {
		return fBIndexName;
	}

	public void setfBIndexName(String fBIndexName) {
		this.fBIndexName = fBIndexName;
	}

	public String getfFaultRemark() {
		return fFaultRemark;
	}

	public void setfFaultRemark(String fFaultRemark) {
		this.fFaultRemark = fFaultRemark;
	}

	public String getfNextUserName() {
		return fNextUserName;
	}

	public void setfNextUserName(String fNextUserName) {
		this.fNextUserName = fNextUserName;
	}

	public String getfNextUserCode() {
		return fNextUserCode;
	}

	public void setfNextUserCode(String fNextUserCode) {
		this.fNextUserCode = fNextUserCode;
	}

	public String getfNextCode() {
		return fNextCode;
	}

	public void setfNextCode(String fNextCode) {
		this.fNextCode = fNextCode;
	}

	public String getfMainStauts() {
		return fMainStauts;
	}

	public void setfMainStauts(String fMainStauts) {
		this.fMainStauts = fMainStauts;
	}

	public String getMainWhether() {
		if(fMainWhether!=null){
			return fMainWhether.getName();
		}
		return mainWhether;
	}

	public void setMainWhether(String mainWhether) {
		this.mainWhether = mainWhether;
	}

	public String getfAssModel() {
		return fAssModel;
	}

	public void setfAssModel(String fAssModel) {
		this.fAssModel = fAssModel;
	}

	public Date getfRepairTime() {
		return fRepairTime;
	}

	public void setfRepairTime(Date fRepairTime) {
		this.fRepairTime = fRepairTime;
	}

	public Date getfAcquisitionDate() {
		return fAcquisitionDate;
	}

	public void setfAcquisitionDate(Date fAcquisitionDate) {
		this.fAcquisitionDate = fAcquisitionDate;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Date getfRepairTimeStart() {
		return fRepairTimeStart;
	}

	public void setfRepairTimeStart(Date fRepairTimeStart) {
		this.fRepairTimeStart = fRepairTimeStart;
	}

	public Date getfRepairTimeEnd() {
		return fRepairTimeEnd;
	}

	public void setfRepairTimeEnd(Date fRepairTimeEnd) {
		this.fRepairTimeEnd = fRepairTimeEnd;
	}

	public Integer getbId() {
		if(budgetIndexMgr!=null){
			return budgetIndexMgr.getbId();
		}
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
	}

	public String getfFlowStauts() {
		return fFlowStauts;
	}

	public void setfFlowStauts(String fFlowStauts) {
		this.fFlowStauts = fFlowStauts;
	}
	
	public String getfRegStauts() {
		return fRegStauts;
	}

	public void setfRegStauts(String fRegStauts) {
		this.fRegStauts = fRegStauts;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_ASSET_MAINTENANCE";
	}
	
	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fID);
	}
	
	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.fNextUserName=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fNextUserCode=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.fNextCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fFlowStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fFlowStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fMainStauts=status;
	}
	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return tAssetMainCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fID;
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fMainUserID;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNextCode;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "T_ASSET_MAIN_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fNextUserCode;
	}
	
	
}
