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

import com.braker.core.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;

@MappedSuperclass
public class GenericIntEntity{
	@Id
    @Column(name = "pid")
    @GeneratedValue(strategy=GenerationType.AUTO)
//    @GenericGenerator(name = "nativeGenerator", strategy = "native")
    private Long id;
	
    @Column(name = "pflag")
    private String flag="1";      //逻辑删除标志位 1表示有效，0表示无效 
	
    @ManyToOne
	@JoinColumn(name = "pupdater")
    @JsonIgnore
	private User updator;
	
    @Column(name = "pupdatetime")
    private Date updateTime=new Date();
    
    @Column(name="createtime",updatable=false)
	private Date createTime=new Date();
    
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public User getUpdator() {
		return updator;
	}

	public void setUpdator(User updator) {
		this.updator =updator;
	}
}
