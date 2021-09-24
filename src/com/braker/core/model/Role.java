package com.braker.core.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import com.braker.common.entity.GenericEntityNow;
import com.fasterxml.jackson.annotation.JsonIgnore;

@SuppressWarnings("serial")
@Entity
@Table(name = "sys_role")
public class Role extends GenericEntityNow {

    @Column(name = "rolecode")
	private String code;

    @Column(name = "rolename")
	private String name;

    @Column(name = "description")
	private String description;

    @Column(name = "orderno")
	private Integer orderNo;
    
    @Column(name = "departid")
    private String departid;
    
    @Column(name = "DEPARTNAME")
    private String departname;
    
    @Transient
	private Integer number;

    @ManyToMany(targetEntity = Function.class,cascade = {CascadeType.PERSIST,CascadeType.REFRESH,CascadeType.MERGE},fetch=FetchType.LAZY)
    @JoinTable(name="SYS_ROLE_FUNCTION",joinColumns=@JoinColumn(name="ROLE_ID"),inverseJoinColumns=@JoinColumn(name="FUNCTION_ID"))
	@Where(clause = "pflag = '1'")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private List<Function> functions;
    
	@ManyToMany(targetEntity = User.class ,cascade = {CascadeType.PERSIST,CascadeType.REFRESH,CascadeType.MERGE})
	@JoinTable(name="sys_user_role",
		joinColumns=@JoinColumn(name="roleid"),
		inverseJoinColumns=@JoinColumn(name="userid"))
	@Where(clause="pflag = '1'")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private List<User> users;
	/**
	 * User和Role是多对多关系，主控方在Role
     * 为Role添加User时，要在两端都添加，由Role相关系表中添加记录	 * @param user
	 */
	public void addUser(User user){
		this.getUsers().add(user);
		user.getRoles().add(this);
	}
	
	/**
	 * User和Role是多对多关系，主控方在Role
     * 删除User时，要在Role的User列表删除该User
     * 由Role相关系表中添加记录	 * @param user
	 */
	public void removeUser(User user){
        this.getUsers().remove(user);
        user.getRoles().add(this);
    }
	public void removeAllUser(){
		this.users=new ArrayList<User>();
	}
	
	public void addFunction(Function function){
		this.getFunctions().add(function);
		function.getRoles().add(this);
	}
	
	public void removeFunction(Function function){
        this.getFunctions().remove(function);
        function.getRoles().add(this);
    }
	
	public void removeAllFunction(){
		this.functions=new ArrayList<Function>();
	}
	
	public List<Function> getFunctions() {
		return functions;
	}
	public void setFunctions(List<Function> functions) {
		this.functions = functions;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getDepartid() {
		return departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	public String getDepartname() {
		return departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}
	
	
	
}
