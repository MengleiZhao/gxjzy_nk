package com.braker.common.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.AbstractEntity;
import com.braker.core.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;

@SuppressWarnings("serial")
@MappedSuperclass
public class GenericEntity extends AbstractEntity{
	@Id
    @Column(name = "pid")
	@GeneratedValue(strategy=GenerationType.AUTO)
//    @GeneratedValue(generator = "hibernate-uuid")
//    @GenericGenerator(name = "hibernate-uuid", strategy = "guid")
    private String id;
	
	@Column(name = "pflag")
    private String flag="1";//逻辑删除标志位 1表示有效，0表示无效 
	
    @ManyToOne
	@JoinColumn(name = "updator")
    @JsonIgnore
	private User updator;
    
    @Column(name = "updatetime")
    private Date updateTime = new Date();
    
    @ManyToOne
    @JoinColumn(name = "creator",updatable=false)
    @JsonIgnore
	private User creator;
    
    
	@Column(name="createtime",updatable=false)
	private Date createTime=new Date();
	
    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public User getUpdator() {
		return updator;
	}

	public void setUpdator(User updator) {
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

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}
}
