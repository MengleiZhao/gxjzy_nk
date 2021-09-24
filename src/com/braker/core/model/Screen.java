package com.braker.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "SCREEN")
public class Screen implements java.io.Serializable {
	private static final long serialVersionUID = 2529024679239141956L;

	/**
	 * 
	 */
	private String nid;
	
	private String userAccount;     //登录账号

	private Integer clientWidth;     //网页可见区域宽

	private Integer screenWidth;     //屏幕分辨率的宽

	private Date opDate;            //数据入库时间
	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "guid")
	@Column(name = "PID")
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	
	@Column(name = "USER_ACCOUNT")
	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	@Column(name = "CLIENT_WIDTH")
	public Integer getClientWidth() {
		return clientWidth;
	}

	public void setClientWidth(Integer clientWidth) {
		this.clientWidth = clientWidth;
	}
	@Column(name = "SCREEN_WIDTH")
	public Integer getScreenWidth() {
		return screenWidth;
	}

	public void setScreenWidth(Integer screenWidth) {
		this.screenWidth = screenWidth;
	}
	@Column(name = "OP_DATE")
	public Date getOpDate() {
		return opDate;
	}

	public void setOpDate(Date opDate) {
		this.opDate = opDate;
	}

	

	
}
