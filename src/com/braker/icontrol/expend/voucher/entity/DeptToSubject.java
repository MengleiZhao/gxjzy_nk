package com.braker.icontrol.expend.voucher.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 部门对应费用科目
 * @author 陈睿超
 * @createTime 2019-06-28
 */
@Entity
@Table(name ="T_DEPT_TO_SUBJECT")
public class DeptToSubject extends BaseEntity{

	@Id
	@Column(name ="F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fid;//主键
	
	@Column(name ="F_CODE")
	private String fCode;//编号
	
	@Column(name ="F_DEPT_NAME")
	private String fDeptName;//部门名称
	
	@Column(name ="F_DEPT_ID")
	private String fDeptId;//部门id
	
	@Column(name ="F_SUBJECT_NAME")
	private String fSubjectName;//对应费用科目名称

	@Column(name ="F_SUBJECT_CODE")
	private String fSubjectCode;//对应费用科目编码
	
	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public String getfCode() {
		return fCode;
	}

	public void setfCode(String fCode) {
		this.fCode = fCode;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
	}

	public String getfSubjectName() {
		return fSubjectName;
	}

	public void setfSubjectName(String fSubjectName) {
		this.fSubjectName = fSubjectName;
	}

	public String getfSubjectCode() {
		return fSubjectCode;
	}

	public void setfSubjectCode(String fSubjectCode) {
		this.fSubjectCode = fSubjectCode;
	}
	
	
	
	
	
}
