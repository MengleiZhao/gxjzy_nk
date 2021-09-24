package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
@Entity
@Table(name = "xm_dept")
public class XmDept extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_ID")
	private Integer fxdId;
	
	@Column(name = "F_XMID")
	private String fxmid;//执行项目表id
	
	@Column(name = "F_DEPTID")
	private String fdeptid;//部门id

	public Integer getFxdId() {
		return fxdId;
	}

	public void setFxdId(Integer fxdId) {
		this.fxdId = fxdId;
	}

	public String getFxmid() {
		return fxmid;
	}

	public void setFxmid(String fxmid) {
		this.fxmid = fxmid;
	}

	public String getFdeptid() {
		return fdeptid;
	}

	public void setFdeptid(String fdeptid) {
		this.fdeptid = fdeptid;
	}
	
	
}
