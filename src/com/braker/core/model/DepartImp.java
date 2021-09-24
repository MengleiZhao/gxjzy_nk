package com.braker.core.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "sys_depart_imp")
public class DepartImp implements Serializable{

	private static final long serialVersionUID = -7296399223630464468L;
	
	@Id
    @Column(name = "pid")
	private String pid;
	private String code;
	private String shortName;
	private String fullName;
	private String parentId;
	private String orderNo;
	
	@Override
	public String toString() {
		String str = pid + code+", "+shortName+", "+fullName+", "+parentId+", "+orderNo;
		return str;
	}
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	
	
}
