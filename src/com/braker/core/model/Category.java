package com.braker.core.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.Combobox;
import com.braker.common.entity.GenericEntityNow;
import com.braker.common.util.StringUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "sys_lookup")
public class Category extends GenericEntityNow implements Combobox{

	private static final long serialVersionUID = 4469966284356996326L;

	@Column(name = "lookupcode")
    private String code;
    
    @Column(name = "lookupname")
    private String name;
    
    @ManyToOne
    @JoinColumn(name = "parentid")
    @JsonIgnore
    private Category parent;

    private String description;

    private String orderNo;
    
    @OneToMany(targetEntity = Category.class, mappedBy = "parent", cascade = CascadeType.MERGE, fetch=FetchType.LAZY)
    @JsonIgnore
    private Set<Category> children;
    
    @Transient 
	private String parentCode;   //父级code

	public Set<Category> getChildren() {
		return children;
	}

	public void setChildren(Set<Category> children) {
		this.children = children;
	}

    public String getParentName(){
    	String parentName="";
    	if(null!=parent && !StringUtil.isEmpty(parent.getName())){
    		parentName=parent.getName();
    	}
    	return parentName;
    }
    
    public String getCode()
    {
        return code;
    }

    public String getDescription()
    {
        return description;
    }

    public String getName()
    {
        return name;
    }

    public String getOrderNo()
    {
        return orderNo;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setOrderNo(String orderNo)
    {
        this.orderNo = orderNo;
    }

	public Category getParent()
	{
		return parent;
	}

	public void setParent(Category parent)
	{
		this.parent = parent;
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

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
    
}
