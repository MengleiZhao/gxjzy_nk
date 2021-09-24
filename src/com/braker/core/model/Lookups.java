package com.braker.core.model;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.braker.common.entity.Combobox;
import com.braker.common.entity.GenericEntityNow;
import com.braker.common.util.StringUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@SuppressWarnings("serial")
@Entity
@Table(name = "sys_lookups")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Lookups extends GenericEntityNow implements Combobox{

	@Column(name = "lookupscode")
    private String code;
	
	@Column(name = "lookupsname")
    private String name;
	
	@Column(name = "shaort_name")
    private String shortName;

	@ManyToOne
    @JoinColumn(name = "lookup_id")
	@JsonIgnore
    private Category category;
	
    private String description;

    private String orderNo;
    
    public Lookups(){
    	
    }
    
    public Lookups(String name, int orderNo, String code, Category category, User creator, Date createDate){
    	super();
    	this.name = name;
    	this.orderNo = String.valueOf(orderNo);
    	this.code = code;
    	this.category = category;
    	super.setCreator(creator);
    	super.setCreateTime(createDate);
    }

    public String getCategoryName(){
    	String categoryName="";
    	if(null!=category && !StringUtil.isEmpty(category.getName())){
    		categoryName=category.getName();
    	}
    	return categoryName;
    }
    
    public String getCategoryCode(){
    	String categoryCode="";
    	if(null!=category && !StringUtil.isEmpty(category.getCode())){
    		categoryCode=category.getCode();
    	}
    	return categoryCode;
    }
    
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Category getCategory()
	{
		return category;
	}

	public void setCategory(Category category)
	{
		this.category = category;
	}
	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return getName();
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getGridCode() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSftjCode() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	
}
