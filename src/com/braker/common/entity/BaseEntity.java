package com.braker.common.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;

import com.braker.core.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;

@SuppressWarnings("serial")
@MappedSuperclass
public class BaseEntity extends AbstractEntity{
	
	@Column(name = "F_UPDATE_USER")
	private String updator;
    
    @Column(name = "F_UPDATE_TIME")
    private Date updateTime=new Date();
    
    @Column(name = "F_CREATE_USER",updatable=false)
	private String creator;
    
	@Column(name="F_CREATE_TIME",updatable=false)
	private Date createTime;
	

	public String getUpdator() {
		return updator;
	}

	public void setUpdator(String updator) {
		this.updator = updator;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	@Override
	public String getId() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setId(String id) {
		// TODO Auto-generated method stub
		
	}
}
