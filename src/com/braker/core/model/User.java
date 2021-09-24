package com.braker.core.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import com.braker.common.entity.Combobox;
import com.braker.common.entity.GenericEntityNow;
import com.braker.common.util.StringUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@SuppressWarnings("serial")
@Entity
@Table(name = "sys_user")
@JsonIgnoreProperties(ignoreUnknown = true)
public class User extends GenericEntityNow implements Combobox{
	
	@Column(name = "is_locked")
	private String islocked = "FALSE";
	
	@Transient
	private String checked;

	@Column(name = "accountNo")
	private String accountNo;

	@Column(name = "name")
	private String name;

	@Column(name = "password")
	private String password;

	@Column(name = "post")
	private String post;

	@Column(name = "postLevel")
	private String postLevel;

	@Column(name = "mobileNo")
	private String mobileNo;

	@Column(name = "telNo")
	private String telNo;

	@Column(name = "faxNo")
	private String faxNo;

	@Column(name = "address")
	private String address;

	@Column(name = "postalCode")
	private String postalCode;
	
	@Column(name = "keyCode")
	private String keyCode;
	
	@Column(name = "invalidTime")
	private Timestamp invalidTime;
	
	@Column(name="IDnumber")
	private String iDnumber; // 身份证号
	
	@Column(name="passportID")
	private String passportID; // 护照号
	
	@Column(name = "email")
	private String email;
	/*@ManyToOne
	@JoinColumn(name="STREET_CODE",referencedColumnName="STREET_CODE")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private CommStreet street;
	*/
	@Column(name = "lastLoginTime") //上次登录时间
	private Date lastLoginTime;
	
	@ManyToOne
	@JoinColumn(name = "departid")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private Depart depart;
	
	public String getDpcode() {
		// TODO Auto-generated method stub
		String st="";
		if(depart!=null&&!StringUtil.isEmpty(depart.getCode())){
			st=depart.getCode();
		}
		return st;
	}

	@ManyToMany(targetEntity = Role.class, mappedBy = "users", cascade = {
			CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.MERGE })
	@Where(clause = "pflag = '1'")
	@JsonIgnore
	@NotFound(action=NotFoundAction.IGNORE)
	private List<Role> roles;
	

	/**
	 * User和Role是多对多关系，主控方在Role 为User添加Role时，要在两端都添加，由Role相关系表中添加记录
	 */
	public void addRole(Role role) {
		this.getRoles().add(role);
		role.getUsers().add(this);
	}

	/**
	 * User和Role是多对多关系，主控方在Role 为User删除Role时，要在两端都删除，由Role相关系表中添加记录
	 */
	public void removeRole(Role role) {
		this.getRoles().remove(role);
		role.getUsers().remove(this);
	}
	

	@Column(name = "is_person_liable")
	private String isPersonLiable;   //是否为责任人   0 不是，1是
	
	@Column(name = "dwdm")
	private String dwdm;
	@Column(name = "dwmc")
	private String dwmc;
	
	
	@Column(name="status")
	private String status; // 1 = 在岗	 0 = 离岗
	
	@Column(name ="roleslevel")
	private Integer	roleslevel;//1：市级，2：局级，3：其他人员
	
	@Column(name ="isonline")
	private Integer	isOnline;//0：离线，1：在线
	
	@Column(name ="registId")
	private String registId; //登录设备Id
	
	@Transient
	private Integer number;
	
	@Transient
	private String userRoleName;
	
	@Transient
	private String departName;// 部门名称
	
	@Transient
	private Integer wcnum; // 完成数量

	@Transient
	private String personliableName;// 责任人

	
	@Transient
	private String completeNumber;// 任务完成情况
	
	@Transient
	private Integer personNum;// 居民总数
	
	@Transient
	private Integer huNum;// 户总数
	
	@Transient
	private String wcl;// 完成率
	
	@Transient
	private String jwhname; //居委会名称
	
	@Transient
	private String dm; //居委会代码
	
	@Transient
	private String sbstart;// 开始时间
	
	@Transient
	private String sbend;// 结束时间
	
	@Transient
	private String jdId;// 街道id
	
	@Transient
	private String clientWidth;// 宽度
	
	@Transient
	private String screenWidth;// 分辨率
	@Transient
	private Integer taskNum;// 任务量
	@Transient
	private String personliablestatus;// 责任人状态
	
	@Transient
	private String uName;
	
	@Transient
	private String jwhId;//居委会id
	
	
	public String getJwhId() {
		return jwhId;
	}

	public void setJwhId(String jwhId) {
		this.jwhId = jwhId;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	// /////////////get set/////////////////
	public Depart getDepart() {
		return depart;
	}
	
	/*
	public CommStreet getStreet() {
		return street;
	}

	public void setStreet(CommStreet street) {
		this.street = street;
	}
*/
	public String getIsPersonLiableHz() {
		// TODO Auto-generated method stub
		String st="";
		if(isPersonLiable!=null){
			if("0".equals(isPersonLiable)){
				st= "否";
			}else if("1".equals(isPersonLiable)){
				st= "是";
			}
		}
		return st;
	}
	public String getStatusName() {
		// TODO Auto-generated method stub
		String st="";
		if(status!=null){
			if("1".equals(status)){
				st= "在岗";
			}else if("0".equals(status)){
				st= "离岗";
			}
		}
		return st;
	}
	/**
	 * 判断用户是否有该角色
	 * @param roleCode 角色代码
	 * @return
	 */
	public boolean hasRole(String roleCode){
		boolean flag=false;
		if(!StringUtil.isEmpty(roleCode) && null!=roles && roles.size()>0){
			for(Role r:roles){
				if(roleCode.equals(r.getCode())){
					flag=true;
					break;
				}
			}
		}
		return flag;
	}
	
	/**
	 * 是否锁定
	 * @return
	 */
	public String getLocked(){
		if(!StringUtil.isEmpty(islocked) && "TRUE".equals(islocked)){
			return "是";
		}
		return "否";
	}
	
	public String getDepartName(){
		if(null!=depart){
			departName=depart.getName();
		}
		return departName;
	}
	
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	
	/*public String getStreetName(){
		String streetName="";
		if(null!=street){
			streetName=street.getName();
		}
		return streetName;
	}*/
	

	

	public void setDepart(Depart depart) {
		this.depart = depart;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getFaxNo() {
		return faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getPostLevel() {
		return postLevel;
	}

	public void setPostLevel(String postLevel) {
		this.postLevel = postLevel;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	// 实现Authentication接口的方法

	public String getAuthAccount() {
		// TODO Auto-generated method stub
		return accountNo;
	}

	public String getAuthPassword() {
		// TODO Auto-generated method stub
		return password;
	}

	public String getIslocked() {
		return islocked;
	}

	public void setIslocked(String islocked) {
		this.islocked = islocked;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
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
	public String getCode() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getKeyCode() {
		return keyCode;
	}

	public void setKeyCode(String keyCode) {
		this.keyCode = keyCode;
	}

	public Timestamp getInvalidTime() {
		return invalidTime;
	}

	public void setInvalidTime(Timestamp invalidTime) {
		this.invalidTime = invalidTime;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

//	public List<Xstb> getXstbs() {
//		return xstbs;
//	}
//
//	public void setXstbs(List<Xstb> xstbs) {
//		this.xstbs = xstbs;
//	}


	public String getDwdm() {
		return dwdm;
	}

	public void setDwdm(String dwdm) {
		this.dwdm = dwdm;
	}

	public String getDwmc() {
		return dwmc;
	}

	public void setDwmc(String dwmc) {
		this.dwmc = dwmc;
	}

	public String getIsPersonLiable() {
		return isPersonLiable;
	}

	public void setIsPersonLiable(String isPersonLiable) {
		this.isPersonLiable = isPersonLiable;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getWcnum() {
		return wcnum;
	}

	public void setWcnum(Integer wcnum) {
		this.wcnum = wcnum;
	}

	public String getPersonliableName() {
		return personliableName;
	}

	public void setPersonliableName(String personliableName) {
		this.personliableName = personliableName;
	}

	public String getCompleteNumber() {
		return completeNumber;
	}

	public void setCompleteNumber(String completeNumber) {
		this.completeNumber = completeNumber;
	}

	public Integer getPersonNum() {
		return personNum;
	}

	public void setPersonNum(Integer personNum) {
		this.personNum = personNum;
	}

	public Integer getHuNum() {
		return huNum;
	}

	public void setHuNum(Integer huNum) {
		this.huNum = huNum;
	}

	public String getWcl() {
		return wcl;
	}

	public void setWcl(String wcl) {
		this.wcl = wcl;
	}

	public String getJwhname() {
		return jwhname;
	}

	public void setJwhname(String jwhname) {
		this.jwhname = jwhname;
	}

	public String getDm() {
		return dm;
	}

	public void setDm(String dm) {
		this.dm = dm;
	}

	public String getSbstart() {
		return sbstart;
	}

	public void setSbstart(String sbstart) {
		this.sbstart = sbstart;
	}

	public String getSbend() {
		return sbend;
	}

	public void setSbend(String sbend) {
		this.sbend = sbend;
	}

	public String getJdId() {
		return jdId;
	}

	public void setJdId(String jdId) {
		this.jdId = jdId;
	}

	public String getClientWidth() {
		return clientWidth;
	}

	public void setClientWidth(String clientWidth) {
		this.clientWidth = clientWidth;
	}

	public String getScreenWidth() {
		return screenWidth;
	}

	public void setScreenWidth(String screenWidth) {
		this.screenWidth = screenWidth;
	}

	public Integer getTaskNum() {
		return taskNum;
	}

	public void setTaskNum(Integer taskNum) {
		this.taskNum = taskNum;
	}

	public String getPersonliablestatus() {
		return personliablestatus;
	}

	public void setPersonliablestatus(String personliablestatus) {
		this.personliablestatus = personliablestatus;
	}

	public String getRoleCode() {
		if(roles.size()!=0){
			String roleIds="";
			for(Role role:roles){
				if("".equals(roleIds)){
					roleIds=role.getId();
				}else{
					roleIds=roleIds+"|"+role.getId();
				}
			}
			return roleIds;
		}
		return null;
	}
	public String getRoleName() {
		if(roles.size()!=0){
			String getNames="";
			for(Role role:roles){
				if("".equals(getNames)){
					getNames=role.getName();
				}else{
					getNames=getNames+"|"+role.getName();
				}
			}
			return getNames;
		}
		return null;
	}
	public String getDpID() {
		// TODO Auto-generated method stub
		String st="";
		if(depart!=null&&!StringUtil.isEmpty(depart.getId())){
			st=depart.getId();
		}
		return st;
	}

	
	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getUserRoleName() {
		return userRoleName;
	}

	public void setUserRoleName(String userRoleName) {
		this.userRoleName = userRoleName;
	}

	public Integer getRoleslevel() {
		return roleslevel;
	}

	public void setRoleslevel(Integer roleslevel) {
		this.roleslevel = roleslevel;
	}

	public Integer getIsOnline() {
		return isOnline;
	}

	public void setIsOnline(Integer isOnline) {
		this.isOnline = isOnline;
	}

	public String getiDnumber() {
		return iDnumber;
	}

	public void setiDnumber(String iDnumber) {
		this.iDnumber = iDnumber;
	}

	public String getPassportID() {
		return passportID;
	}

	public void setPassportID(String passportID) {
		this.passportID = passportID;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getRegistId() {
		return registId;
	}

	public void setRegistId(String registId) {
		this.registId = registId;
	}
	

	
	
	
	
}
