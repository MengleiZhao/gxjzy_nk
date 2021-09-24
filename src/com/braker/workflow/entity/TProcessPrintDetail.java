package com.braker.workflow.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 审签拼接信息显示表
 * @author 陈睿超
 *
 */
@Entity
@Table(name = "T_PROCESS_PRINT_DETAIL")
public class TProcessPrintDetail extends BaseEntity {

	
	@Id
	@Column(name = "F_P_D_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer FpDId;
	
	@Column(name ="F_P_W_ID")	
	private Integer FpWId;//申请报销主键id
	
	@Column(name ="F_P_W_D_ID")	
	private Integer FpWdDd;//直接报销主键id
	
	@Column(name ="F_P_W_I_ID")	
	private Integer FpWIiD;//借款主键id
	
	@Column(name ="F_P_W_P_ID")	
	private Integer FpWIPid;//还款主键id
	
	@Column(name ="F_TABLE_NAME")	
	private String FTabName;//保存类名

	@Column(name ="F_TABLE_ID_NAME")	
	private String FTabIdName;//保存类的主键名称
	
	@Column(name ="F_TABLE_ID")	
	private Integer FTabId;//保存类的主键id值
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//审批人ID
	
	@Column(name = "F_USER_NAME")
	private String fuserName;		//审批人名字
	
	@Column(name = "F_DEPT_ID")
	private String fdeptId;			//审批人部门ID
	
	@Column(name = "F_DEPT_NAME")
	private String fdeptName;		//审批人部门名字
	
	@Column(name = "F_CHECK_TIME")
	private Date fcheckTime;		//审批时间
	
	@Column(name = "F_ROLE_NAME")
	private String fRoleName;		//角色
	
	@Column(name = "F_REMARK")
	private String fcheckRemake;	//审批内容
	
	@Column(name = "F_RESULT")
	private String fcheckResult;	//审批结果  1通过   0不通过
	
	@Column(name = "F_SIGN")
	private String fSign;	//0:未审批完录入的数据        1：已审批完录入数据

	@Transient
	private String fcheckTimes;		//审批时间(数据库中没有)   显示年月日
	
	public String getFcheckTimes() {
		return fcheckTimes;
	}

	public String getfSign() {
		return fSign;
	}

	public void setfSign(String fSign) {
		this.fSign = fSign;
	}

	public void setFcheckTimes(String fcheckTimes) {
		this.fcheckTimes = fcheckTimes;
	}

	public Integer getFpDId() {
		return FpDId;
	}

	public void setFpDId(Integer fpDId) {
		FpDId = fpDId;
	}

	public Integer getFpWId() {
		return FpWId;
	}

	public void setFpWId(Integer fpWId) {
		FpWId = fpWId;
	}

	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getFuserName() {
		return fuserName;
	}

	public void setFuserName(String fuserName) {
		this.fuserName = fuserName;
	}

	public String getFdeptId() {
		return fdeptId;
	}

	public void setFdeptId(String fdeptId) {
		this.fdeptId = fdeptId;
	}

	public String getFdeptName() {
		return fdeptName;
	}

	public void setFdeptName(String fdeptName) {
		this.fdeptName = fdeptName;
	}

	public String getFcheckRemake() {
		return fcheckRemake;
	}

	public void setFcheckRemake(String fcheckRemake) {
		this.fcheckRemake = fcheckRemake;
	}

	public String getFcheckResult() {
		return fcheckResult;
	}

	public void setFcheckResult(String fcheckResult) {
		this.fcheckResult = fcheckResult;
	}

	public Date getFcheckTime() {
		return fcheckTime;
	}

	public void setFcheckTime(Date fcheckTime) {
		this.fcheckTime = fcheckTime;
	}

	public String getfRoleName() {
		return fRoleName;
	}

	public void setfRoleName(String fRoleName) {
		this.fRoleName = fRoleName;
	}

	public Integer getFpWdDd() {
		return FpWdDd;
	}

	public void setFpWdDd(Integer fpWdDd) {
		FpWdDd = fpWdDd;
	}

	public Integer getFpWIiD() {
		return FpWIiD;
	}

	public void setFpWIiD(Integer fpWIiD) {
		FpWIiD = fpWIiD;
	}

	public Integer getFpWIPid() {
		return FpWIPid;
	}

	public void setFpWIPid(Integer fpWIPid) {
		FpWIPid = fpWIPid;
	}

	public String getFTabName() {
		return FTabName;
	}

	public void setFTabName(String fTabName) {
		FTabName = fTabName;
	}

	public String getFTabIdName() {
		return FTabIdName;
	}

	public void setFTabIdName(String fTabIdName) {
		FTabIdName = fTabIdName;
	}

	public Integer getFTabId() {
		return FTabId;
	}

	public void setFTabId(Integer fTabId) {
		FTabId = fTabId;
	}

	
	
	
	
	
}
