package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 首页快捷方式配置model
 * @author 叶崇晖
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Entity
@Table(name = "T_INDEX_SHORTCUT")
public class IndexShortcut extends BaseEntityEmpty {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;		//主键ID
	
	@Column(name = "F_USER_ID")
	private String userId;		//用户ID
	
	@Column(name = "F_MENU_CODE")
	private String menuCode;	//功能菜单编号
	
	@Column(name = "F_MENU_NAME")
	private String menuName;	//菜单名称
	
	@Column(name = "F_MENU_URL")
	private String menuUrl;		//菜单URL
	
	@Column(name = "F_ORDER")
	private Integer order;		//菜单序号
	
	@Column(name = "F_MENU_IMG")
	private String menuImg;		//菜单图片

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public String getMenuImg() {
		return menuImg;
	}

	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
	
	
}
