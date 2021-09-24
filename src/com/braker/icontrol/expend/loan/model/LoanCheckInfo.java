package com.braker.icontrol.expend.loan.model;

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
 * 借款审批记录model
 * @author 叶崇晖
 * @createtime 2018-08-02
 * @updatetime 2018-08-02
 */
@Entity
@Table(name = "T_LOAN_CHECK_INFO")
public class LoanCheckInfo extends BaseEntity {
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer cId;			//主键ID
	
	@Column(name = "F_P_ID")
	private Integer pId;			//外键
	
	@Column(name = "F_L_ID")
	private Integer lId;			//外键
	
	@Column(name = "F_USER_ID")
	private String userId;			//审批人ID
	
	@Column(name = "F_USER_NAME")
	private String userName;		//审批人名字
	
	@Column(name = "F_ROLE_NAME")
	private String roleName;		//审批人岗位
	
	@Column(name = "F_LEVEL")
	private String level;			//审批级别
	
	@Column(name = "F_RESULT")
	private String checkResult;		//审批意见
	
	@Column(name = "F_CHECK_TIME")
	private Date checkTime;			//审批时间
	
	@Column(name = "F_REMARK")
	private String checkRemake;		//审批内容
	
	@Column(name = "F_STAUTS")
	private String stauts;			//审批信息状态1保存，99删除
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public Integer getlId() {
		return lId;
	}

	public void setlId(Integer lId) {
		this.lId = lId;
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

	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getCheckRemake() {
		return checkRemake;
	}

	public void setCheckRemake(String checkRemake) {
		this.checkRemake = checkRemake;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	
	
}
