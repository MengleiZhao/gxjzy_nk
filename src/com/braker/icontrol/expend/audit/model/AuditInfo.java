package com.braker.icontrol.expend.audit.model;

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
 * 财务审定信息model
 * @author 叶崇晖
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
@Entity
@Table(name = "T_AUDIT_INFO")
public class AuditInfo extends BaseEntity {
	
	@Id
	@Column(name = "F_AUDIT_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer auditId;		//主键ID
	
	@Column(name = "F_P_ID")
	private Integer pId;			//采购外键
	
	@Column(name = "F_DR_ID")
	private Integer drId;			//直接报销外键
	
	@Column(name = "F_R_ID")
	private Integer rId;			//申请报销外键
	
	@Column(name = "F_CONT_ID")
	private Integer contId;			//合同外键
	
	@Column(name = "F_USER_ID")
	private String userId;			//审定人ID
	
	@Column(name = "F_USER_NAME")
	private String userName;		//审定人名字
	
	@Column(name = "F_ROLE_NAME")
	private String roleName;		//审定人岗位
	
	@Column(name = "F_LEVEL")
	private String level;			//审定级别
	
	@Column(name = "F_RESULT")
	private String auditResult;		//审定意见
	
	@Column(name = "F_AUDIT_TIME")
	private Date auditTime;			//审定时间
	
	@Column(name = "F_REMARK")
	private String auditRemake;		//审定内容
	
	@Column(name = "F_STAUTS")
	private String stauts;			//审定信息状态1保存，99删除
	
	@Column(name = "F_LOAD_ID")		//借款单ID
	private String loadId;
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	public Integer getAuditId() {
		return auditId;
	}

	public void setAuditId(Integer auditId) {
		this.auditId = auditId;
	}

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getContId() {
		return contId;
	}

	public void setContId(Integer contId) {
		this.contId = contId;
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

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getAuditResult() {
		return auditResult;
	}

	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}

	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	public String getAuditRemake() {
		return auditRemake;
	}

	public void setAuditRemake(String auditRemake) {
		this.auditRemake = auditRemake;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getDrId() {
		return drId;
	}

	public void setDrId(Integer drId) {
		this.drId = drId;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public String getLoadId() {
		return loadId;
	}

	public void setLoadId(String loadId) {
		this.loadId = loadId;
	}
	
	
}
