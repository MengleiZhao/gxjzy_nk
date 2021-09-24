package com.braker.icontrol.budget.release.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;


/**
 * 部门基本支出基本信息model
 * 是部门基本支出基本信息的model类
 * @author 叶崇晖
 * @createtime 2018-07-11
 * @updatetime 2018-07-11
 */
@Entity
@Table(name = "T_BASIC_EXPEND_DEPT")
public class TBasicExpendDept extends BaseEntity{
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fpId;			//主键ID
	
	@Column(name = "F_DC_ID")
	private Integer fdcId;			//关联预算编制（二上）的副键
	
	@Column(name = "F_NAME")
	private String name;			//名称
	
	@Column(name = "F_CODE")
	private String code;			//编码
	
	@Column(name = "F_PARENT_ID")
	private Integer parentId;		//父节点id
	
	@Column(name = "F_DEPARTMENT")
	private String department;		//归口部门
	
	@Column(name = "F_CONTROL")
	private Double control;			//控制数
	
	@Column(name = "F_SPENT")
	private Double spent;			//已用额度
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getFdcId() {
		return fdcId;
	}

	public void setFdcId(Integer fdcId) {
		this.fdcId = fdcId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Double getControl() {
		return control;
	}

	public void setControl(Double control) {
		this.control = control;
	}

	public Double getSpent() {
		return spent;
	}

	public void setSpent(Double spent) {
		this.spent = spent;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	
}
