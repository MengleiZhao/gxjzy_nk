package com.braker.icontrol.cgmanage.cgexpert.model;

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



/**
 * 专家抽取记录的model
 * @author 焦广兴
 * @createtime 2019-06-27
 * @updatetime 2019-06-27
 */
@Entity
@Table(name="T_EXPERT_EXTRACT")
public class ExtractRecordInfo extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_EX_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fExId;
	
	@Column(name = "F_USER_ID")
	private String fUserID;			//抽取人ID
	
	@Column(name = "F_USER_NAME")	//抽取人姓名
	private String fUserName;

	@Column(name = "F_DEPT_ID")
	private String fDeptID;			//抽取人所属部门ID
	
	@Column(name = "F_DEPT_NAME")	//抽取人所属部门名称
	private String fDeptName;
	
	@Column(name = "F_FLAG")	//抽取状态 1：成功，2：失败
	private String fFlag;
	
	@Column(name = "F_RESULT")	//抽取结果 专家id
	private String fResult;
	
	@Column(name = "F_FIELD")	//抽取领域
	private String fField;
	
	@Column(name = "F_PERSON_NUM")	//抽取人数
	private Integer fPersonNum;
	
	@Column(name = "F_NUM")	//抽取次数
	private Integer fNum;
	
	@Column(name = "F_STATUS")		//数据状态
	private String fStatus;
	
	@Column(name ="F_REC_TIME")	//抽取时间
	private Date fRecTime;

	@Transient
	private Integer num;			//序号(数据库中没有)
	
	
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getfExId() {
		return fExId;
	}

	public void setfExId(Integer fExId) {
		this.fExId = fExId;
	}

	public String getfUserID() {
		return fUserID;
	}

	public void setfUserID(String fUserID) {
		this.fUserID = fUserID;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}

	public String getfDeptID() {
		return fDeptID;
	}

	public void setfDeptID(String fDeptID) {
		this.fDeptID = fDeptID;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfField() {
		return fField;
	}

	public void setfField(String fField) {
		this.fField = fField;
	}

	public Integer getfPersonNum() {
		return fPersonNum;
	}

	public void setfPersonNum(Integer fPersonNum) {
		this.fPersonNum = fPersonNum;
	}

	public String getfFlag() {
		return fFlag;
	}

	public void setfFlag(String fFlag) {
		this.fFlag = fFlag;
	}

	public String getfResult() {
		return fResult;
	}

	public void setfResult(String fResult) {
		this.fResult = fResult;
	}

	public Integer getfNum() {
		return fNum;
	}

	public void setfNum(Integer fNum) {
		this.fNum = fNum;
	}

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	public Date getfRecTime() {
		return fRecTime;
	}

	public void setfRecTime(Date fRecTime) {
		this.fRecTime = fRecTime;
	}	
	
	

}
