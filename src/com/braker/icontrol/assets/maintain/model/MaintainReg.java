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
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 * 资产维修登记表
 * @author 陈睿超
 */
@Entity
@Table(name ="T_MAINTENANCE_REGISTRATION")
public class MaintainReg extends BaseEntity implements EntityDao{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_REG_ID")
	private Integer fRegID;//主键
	
	@OneToOne
	@JoinColumn(name ="F_ID",referencedColumnName="F_ID")
	private Maintain maintain;//外键维修申请表主键
	
	@Column(name ="T_MAIN_REG_CODE")
	private String tMianRegCode;//维修登记单号
	
	@ManyToOne
	@JoinColumn(name ="F_MAIN_WHETHER" ,referencedColumnName ="lookupscode")
	private Lookups fMainWhether;//是否产生维修费用  :sfcswxfy-01产生费用，sfcswxfy-02不产生费用
	
	@Column(name ="F_MAIN_AMOUNT")
	private Double fRegAmount;//维修费用
	
	@Column(name ="F_MAIN_RESULT")
	private String fMainResult;//维修结果
	
	@Column(name ="F_REMARK")
	private String fRegRemark;//备注
	
	@Column(name ="F_MAIN_REG_ID")
	private String fMainRegID;//操作部门ID
	
	@Column(name ="F_MAIN_REG_DEPT")
	private String fMainRegDept;//操作部门名称
	
	@Column(name ="F_MAIN_REG_USER_ID")
	private String fMainRegUserID;//操作人id
	
	@Column(name ="F_MAIN_REG_USER")
	private String fMainRegUser;//操作人名称
	
	@Column(name ="F_REQ_TIME")
	private Date fRegTime;//操作时间
	
	@Column(name ="F_REG_STAUTS")
	private String fRegstauts;//登记单状态:1-正常，99-删除
	
	@Transient
	private Date fRegTimeStart;//操作时间开始（查询用）
	
	@Transient
	private Date fRegTimeEnd;//操作时间截止（查询用）
	
	@Transient
	private String mainID;//传外键用

	@Transient
	private String mainWhether;//是否产生费用（显示）
	
	@Transient
	private Integer number;//序号
	
	public Integer getfRegID() {
		return fRegID;
	}

	public void setfRegID(Integer fRegID) {
		this.fRegID = fRegID;
	}

	public Maintain getMaintain() {
		return maintain;
	}

	public void setMaintain(Maintain maintain) {
		this.maintain = maintain;
	}

	public String gettMianRegCode() {
		return tMianRegCode;
	}

	public void settMianRegCode(String tMianRegCode) {
		this.tMianRegCode = tMianRegCode;
	}

	public Double getfRegAmount() {
		return fRegAmount;
	}

	public void setfRegAmount(Double fRegAmount) {
		this.fRegAmount = fRegAmount;
	}

	public String getfMainResult() {
		return fMainResult;
	}

	public void setfMainResult(String fMainResult) {
		this.fMainResult = fMainResult;
	}

	public String getfRegRemark() {
		return fRegRemark;
	}

	public void setfRegRemark(String fRegRemark) {
		this.fRegRemark = fRegRemark;
	}

	public String getfMainRegID() {
		return fMainRegID;
	}

	public void setfMainRegID(String fMainRegID) {
		this.fMainRegID = fMainRegID;
	}

	public String getfMainRegDept() {
		return fMainRegDept;
	}

	public void setfMainRegDept(String fMainRegDept) {
		this.fMainRegDept = fMainRegDept;
	}

	public String getfMainRegUserID() {
		return fMainRegUserID;
	}

	public void setfMainRegUserID(String fMainRegUserID) {
		this.fMainRegUserID = fMainRegUserID;
	}

	public String getfMainRegUser() {
		return fMainRegUser;
	}

	public void setfMainRegUser(String fMainRegUser) {
		this.fMainRegUser = fMainRegUser;
	}

	public Date getfRegTime() {
		return fRegTime;
	}

	public void setfRegTime(Date fRegTime) {
		this.fRegTime = fRegTime;
	}

	public String getMainID() {
		return mainID;
	}

	public void setMainID(String mainID) {
		this.mainID = mainID;
	}

	public Lookups getfMainWhether() {
		return fMainWhether;
	}

	public void setfMainWhether(Lookups fMainWhether) {
		this.fMainWhether = fMainWhether;
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

	public Date getfRegTimeStart() {
		return fRegTimeStart;
	}

	public void setfRegTimeStart(Date fRegTimeStart) {
		this.fRegTimeStart = fRegTimeStart;
	}

	public Date getfRegTimeEnd() {
		return fRegTimeEnd;
	}

	public void setfRegTimeEnd(Date fRegTimeEnd) {
		this.fRegTimeEnd = fRegTimeEnd;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getfRegstauts() {
		return fRegstauts;
	}

	public void setfRegstauts(String fRegstauts) {
		this.fRegstauts = fRegstauts;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_MAINTENANCE_REGISTRATION";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fRegID);
	}
	
	
	
}
