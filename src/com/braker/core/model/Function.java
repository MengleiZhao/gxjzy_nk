package com.braker.core.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import com.braker.common.entity.SelectTree;
import com.braker.core.manager.impl.FunctionMngImpl;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="SYS_FUNCTION")
public class Function  implements SelectTree,Serializable {

	private static final long serialVersionUID = -5739512476232195372L;
	/**
	 * 权限key,里面存放访问路径,保存在session
	 */
	public static final String RIGHTS_KEY = "_rights_key";
	@Id
    @Column(name = "pid")
    @GeneratedValue(strategy=GenerationType.AUTO)
//    @GenericGenerator(name = "nativeGenerator", strategy = "native")
    private Long id;
	
    @Column(name = "pflag")
    private String flag="1";      //逻辑删除标志位 1表示有效，0表示无效 
    
    @Column(name = "PARENT",insertable=false ,updatable=false)
    private String parentId;      //父节点Id
	
    @ManyToOne
	@JoinColumn(name = "pupdater")
    @JsonIgnore
    @NotFound(action=NotFoundAction.IGNORE)
	private User updator;
	
    @Column(name = "pupdatetime")
    private Date updateTime=new Date();
    
    @Column(name="createtime",updatable=false)
	private Date createTime=new Date();
	@ManyToOne
	@JoinColumn(name="creator",updatable=false)
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private User creator;
	private String name;
	private String url;
	private String funcs;
	private String description;
	private Integer priority;
	@Column(name="IS_MENU")
	private java.lang.Boolean menu;

	@ManyToOne
    @JoinColumn(name = "PARENT")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private Function parent;

	@OneToMany(targetEntity = Function.class,mappedBy = "parent",cascade = CascadeType.MERGE,fetch=FetchType.LAZY)
	@Where(clause = "pflag = '1'")
	@OrderBy(value="priority")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private Set<Function> child;
	
	@ManyToMany(targetEntity = Role.class,mappedBy = "functions",cascade = {CascadeType.PERSIST,CascadeType.REFRESH,CascadeType.MERGE},fetch=FetchType.LAZY)
	@Where(clause = "pflag = '1'")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private List<Role> roles;
	
	

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
	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
	public void addRole(Role role) {
		this.getRoles().add(role);
		role.getFunctions().add(this);
	}

	public void removeRole(Role role) {
		this.getRoles().remove(role);
		role.getFunctions().remove(this);
	}
	
	public java.lang.String getName() {
		return name;
	}

	public void setName(java.lang.String name) {
		this.name = name;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}
	
	public java.lang.String getUrl() {
		return url;
	}

	public void setUrl(java.lang.String url) {
		this.url = url;
	}

	public java.lang.String getFuncs() {
		return funcs;
	}

	public void setFuncs(java.lang.String funcs) {
		this.funcs = funcs;
	}

	public java.lang.String getDescription() {
		return description;
	}

	public void setDescription(java.lang.String description) {
		this.description = description;
	}

	public java.lang.Integer getPriority() {
		return priority;
	}

	public void setPriority(java.lang.Integer priority) {
		this.priority = priority;
	}

	public java.lang.Boolean getMenu() {
		return menu;
	}

	public void setMenu(java.lang.Boolean menu) {
		this.menu = menu;
	}

	public Function getParent() {
		return parent;
	}

	public void setParent(Function parent) {
		this.parent = parent;
	}

	public Set<Function> getChild() {
		return child;
	}

	public void setChild(Set<Function> child) {
		this.child = child;
	}
	
	/**
	 * 功能集的分隔符
	 */
	public static final String FUNC_SPLIT = "@";
	
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
	public Set<? extends SelectTree> getTreeChild(String treeid) {
		// TODO Auto-generated method stub
		Set<Function> set=FunctionMngImpl.parentFunSetsMap.get(treeid);
		return FunctionMngImpl.parentFunSetsMap.get(treeid);
		//return getChild();
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
	
	

}