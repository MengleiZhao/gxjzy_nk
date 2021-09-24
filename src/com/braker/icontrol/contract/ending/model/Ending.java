package com.braker.icontrol.contract.ending.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;

/**
 * 合同终止信息
 * @author 陈睿超	 
 * @createTime 2018-11-22
 *
 */
@Table(name="T_CONTRACT_END")
@Entity
public class Ending extends BaseEntity implements EntityDao,CheckEntity{

	
	@Id
	@Column(name ="F_END_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fEndId;//主键
	
	@JoinColumn(name ="F_CONT_ID")
	@OneToOne
	private ContractBasicInfo contractBasicInfo;
	
	@Column(name ="F_END_CODE")
	private String fEndCode;//终止单编号
	
	@Column(name ="F_END_TYPE")
	private String fEndType;//终止类型
	
	@Column(name ="F_END_REMARK")
	private String fEndRemark;//终止原因
	
	@Column(name ="STAUTS")
	private String stauts;//审批状态    -1-已退回,0-暂存,1-待审批,9-已审批'
	
	@Column(name ="ENDSTAUTS")
	private String endStauts;//终止单状态 1-正常，99删除
	
	@Column(name ="F_NEXT_USER_NAME")
	private String fNextUserName;//下环节处理人 姓名
	
	@Column(name ="F_NEXT_USER_CODE")
	private String fNextUserCode;//下环节处理人 编码
	
	@Column(name ="F_NEXT_CODE")
	private String fNextCode;//下节点节点编码
	
	@Column(name ="F_END_TIME")
	private Date fEndTime;//申请时间
	
	@Column(name ="F_END_DEPT")
	private String fEndDept;//申请部门
	
	@Column(name ="F_END_USER")
	private String fEndUser;//申请人
	
	@Column(name ="F_END_USER_ID")
	private String fEndUserId;//申请人ID

	@Transient
	private Integer fcontId;//用来页面传输合同主键的临时变量
	
	@Transient
	private Integer number;
	
	@Transient
	private String fcTitle;//合同名称
	
	@Transient
	private String title;//合同名称(查询使用)
	
	public Integer getfEndId() {
		return fEndId;
	}

	public void setfEndId(Integer fEndId) {
		this.fEndId = fEndId;
	}

	public ContractBasicInfo getContractBasicInfo() {
		return contractBasicInfo;
	}

	public void setContractBasicInfo(ContractBasicInfo contractBasicInfo) {
		this.contractBasicInfo = contractBasicInfo;
	}

	public String getfEndType() {
		return fEndType;
	}

	public void setfEndType(String fEndType) {
		this.fEndType = fEndType;
	}

	public String getfEndRemark() {
		return fEndRemark;
	}

	public void setfEndRemark(String fEndRemark) {
		this.fEndRemark = fEndRemark;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public Integer getNumber() {
		return number;
	}
	
	public void setNumber(Integer number) {
		this.number = number;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_END";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fEndId);
	}

	public String getFcTitle() {
		return contractBasicInfo.getFcTitle();
	}

	public void setFcTitle(ContractBasicInfo contractBasicInfo) {
		this.fcTitle = contractBasicInfo.getFcTitle();
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

	public Date getfEndTime() {
		return fEndTime;
	}

	public void setfEndTime(Date fEndTime) {
		this.fEndTime = fEndTime;
	}

	public String getfEndDept() {
		return fEndDept;
	}

	public void setfEndDept(String fEndDept) {
		this.fEndDept = fEndDept;
	}

	public String getfEndUser() {
		return fEndUser;
	}

	public void setfEndUser(String fEndUser) {
		this.fEndUser = fEndUser;
	}

	public String getfEndUserId() {
		return fEndUserId;
	}

	public void setfEndUserId(String fEndUserId) {
		this.fEndUserId = fEndUserId;
	}

	public String getfEndCode() {
		return fEndCode;
	}

	public void setfEndCode(String fEndCode) {
		this.fEndCode = fEndCode;
	}

	public String getEndStauts() {
		return endStauts;
	}

	public void setEndStauts(String endStauts) {
		this.endStauts = endStauts;
	}

	public Integer getFcontId() {
		return fcontId;
	}

	public void setFcontId(Integer fcontId) {
		this.fcontId = fcontId;
	}

	public void setFcTitle(String fcTitle) {
		this.fcTitle = fcTitle;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
		this.stauts=checkStatus;
	}

	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return stauts;
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fEndCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fEndId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return fNextCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fEndUserId;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_END_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fNextUserCode;
	}

	
	
	
	
}
