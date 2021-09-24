package com.braker.icontrol.purchase.apply.model;


import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;
import com.braker.icontrol.cgmanage.cginquiries.model.Sel;
/**
 * 采购细目表
 * @author 沈帆
 * @createtime 2020-12-10
 * @updatetime 2020-12-10
 */
@Entity
@Table(name="T_PURCHASE_ITEMS_DETAIL")
public class PurchaseItemsDetail extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer pId;			//主键ID
	
	@Column(name ="F_NAME")
	private String fName;			//细目名称
	
	@Column(name ="F_CODE")
	private String fCode;			//细目编码
	
	@Column(name = "F_ITEM")
	private String fItem;     //归属品目

	@Transient
	private int number;					//序号(数据库里没有的)
	
	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getfCode() {
		return fCode;
	}

	public void setfCode(String fCode) {
		this.fCode = fCode;
	}

	public String getfItem() {
		return fItem;
	}

	public void setfItem(String fItem) {
		this.fItem = fItem;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}
	
	
	
}
