package com.braker.icontrol.budget.project.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 
 * @Description 审批过程中审批人修改的字段值
 * @author 汪耀
 * @date : 2019年11月14日 下午1:53:00
 */
@Entity
@Table(name = "T_PRO_BASIC_CHECK_UPD")
public class TProBasicCheckUpdate extends BaseEntityEmpty implements
		Serializable {
	
	@Id
	@Column(name = "F_UPD_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer updId;				//主键
	
	@Column(name = "F_PRO_ID")
	private Integer proId;				//项目id
	
	@Column(name = "F_USER_NAME")
	private String userName;			//修改人
	
	@Column(name = "F_UPD_TIME")
	private Date updateTime;			//修改时间
	
	@Column(name = "F_COLUMN_NAME")
	private String columnName;			//修改的字段名称
	
	@Column(name = "F_OLD_VALUE")
	private String oldValue;			//字段旧值
	
	@Column(name = "F_NEW_VALUE")
	private String newValue;			//字段新值
	
	@Transient
	private Integer num;				//序号

	public Integer getUpdId() {
		return updId;
	}

	public void setUpdId(Integer updId) {
		this.updId = updId;
	}

	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	
}
