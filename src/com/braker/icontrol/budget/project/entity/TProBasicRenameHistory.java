package com.braker.icontrol.budget.project.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

@Entity
@Table(name = "t_pro_basic_rename_history")
public class TProBasicRenameHistory  extends BaseEntityEmpty{

	@Id
	@Column(name = "R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer rId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer  proId;			//项目id
	
	@Column(name = "OLD_VALUE")
	private String oldValue;			//复核前
	
	@Column(name = "NEW_VALUE")
	private String newValue;			//复核后
	
	@Column(name = "OPERATOR")
	private String operator;		//操作员名字
	
	@Column(name = "OPERATOR_ID")
	private String operatorId;			//操作员用户id
	
	@Column(name = "UPDATE_TIME")
	private Date updateTime;		//复核时间
	
	@Transient
	private int num;
	@Transient
	private String  proName;			//项目名称

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public String getOldValue() {
		return oldValue;
	}

	public void setOldValue(String oldValue) {
		this.oldValue = oldValue;
	}

	public String getNewValue() {
		return newValue;
	}

	public void setNewValue(String newValue) {
		this.newValue = newValue;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}
	
}
