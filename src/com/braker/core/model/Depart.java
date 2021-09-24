package com.braker.core.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.Combobox;
import com.braker.common.entity.GenericEntityNow;
import com.braker.common.entity.SelectTree;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.impl.DepartMngImpl;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "sys_depart")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Depart extends GenericEntityNow implements Combobox,SelectTree,Serializable{
	
	private static final long serialVersionUID = 3844645003343878376L;
	
	public static final String TYPE_COM = "COMPANY";
	public static final String TYPE_DEPT = "DEPART";

	@Column(name = "DEPARTCODE")
	private String code;//单位代码
	
	@Column(name = "DEPARTNAME")
	private String name;//单位名称
	
	@Column(name = "PARENTID",insertable=false ,updatable=false)
	private String parentId;//父节点id
	
	@Transient
	private String checked;
	
    @ManyToOne
    @JoinColumn(name = "PARENTID")
    @JsonIgnore
	private Depart parent;//上级单位

	@Column(name = "DESCRIPTION")
	private String description;//简称

	@Column(name = "ORDERNO")
	private String orderNo;//排序
	
	@Column(name = "TYPE")
	private String type;//类型 公司/部门
	
	@ManyToOne
	@JoinColumn(name = "MANAGER_ID")
	private User manager;//主管领导
	
	//责任领导 领导电话 联系人 联系人电话
	private String grww_zrld;
	private String grww_zrlddh;
	private String grww_lxr;
	private String grww_lxrdh;
	

    @OneToMany(targetEntity = Depart.class, mappedBy = "parent", cascade = CascadeType.MERGE, fetch=FetchType.LAZY)
    @JsonIgnore
    private Set<Depart> children;

	public String getGrww_zrld() {
		return grww_zrld;
	}
	public void setGrww_zrld(String grwwZrld) {
		grww_zrld = grwwZrld;
	}
	public String getGrww_zrlddh() {
		return grww_zrlddh;
	}
	public void setGrww_zrlddh(String grwwZrlddh) {
		grww_zrlddh = grwwZrlddh;
	}
	public String getGrww_lxr() {
		return grww_lxr;
	}
	public void setGrww_lxr(String grwwLxr) {
		grww_lxr = grwwLxr;
	}
	public String getGrww_lxrdh() {
		return grww_lxrdh;
	}
	public void setGrww_lxrdh(String grwwLxrdh) {
		grww_lxrdh = grwwLxrdh;
	}
	public Set<Depart> getChildren() {
		return children;
	}
	
	public void setChildren(Set<Depart> children) {
		this.children = children;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getManager() {
		return manager;
	}
	public void setManager(User manager) {
		this.manager = manager;
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
	
	public String getParentName(){
		if(null!=parent && !StringUtil.isEmpty(parent.getName())){
			return parent.getName();
		}
		return "";
	}

	public Depart getParent() {
		return parent;
	}

	public void setParent(Depart parent) {
		this.parent = parent;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Transient
	private String selectTree;
	
	@Override
	@JsonIgnore
	public SelectTree getTreeParent() {
		// TODO Auto-generated method stub
		return getParent();
	}

	@Override
	public String getTreeName() {
		// TODO Auto-generated method stub
		return getName();
	}

	@Override
	public String getSelectTree() {
		// TODO Auto-generated method stub
		return selectTree;
	}

	@Override
	public void setSelectTree(String selectTree) {
		// TODO Auto-generated method stub
		this.selectTree = selectTree;
	}

	@Override
	public Set<? extends SelectTree> getTreeChild(String treeId) {
		// TODO Auto-generated method stub
		return DepartMngImpl.parentDeptSetsMap.get(treeId);
	//	return getChildren();
	}

	@Override
	public Set<? extends SelectTree> getTreeChildRaw() {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void setTreeChild(Set treeChild) {
		// TODO Auto-generated method stub
	}

	@Override
	public String getTreeId() {
		// TODO Auto-generated method stub
		return getId().toString();
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	public String getManagerName(){
		return (manager != null? manager.getName():"");
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
	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return name;
	}
	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}
	

}
