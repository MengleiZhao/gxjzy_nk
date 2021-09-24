package com.braker.core.model;


/**
 * 用于返回页面指定的几个字段     已用于差旅人员选择
 * @author 赵孟雷
 *
 */
public class UserTransient {
	
	private String id;
	private String accountNo;//账号
	private String name;//姓名
	private String departName;// 部门名称
	private Integer	roleslevel;//1：市级，2：局级，3：其他人员
	private String	roleslevelname;//1：市级，2：局级，3：其他人员
	private String idcard;//身份证号
	private String passportNumber;//护照号
	private String phoneNumber;//联系电话
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public Integer getRoleslevel() {
		return roleslevel;
	}
	public void setRoleslevel(Integer roleslevel) {
		this.roleslevel = roleslevel;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getPassportNumber() {
		return passportNumber;
	}
	public void setPassportNumber(String passportNumber) {
		this.passportNumber = passportNumber;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getRoleslevelname() {
		return roleslevelname;
	}
	public void setRoleslevelname(String roleslevelname) {
		this.roleslevelname = roleslevelname;
	}
	
}
