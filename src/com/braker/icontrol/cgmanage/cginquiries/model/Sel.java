package com.braker.icontrol.cgmanage.cginquiries.model;

import java.util.List;

import javax.persistence.Transient;

/**
 * 供应商的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
public class Sel {
	private String selName;		//供应商名称
	
	private String totalPrice;
	
	private String  selUser;			//联系人
	
	private String  selTel;			//联系人电话
	
	private List<InqWinningList> inqList;	//商品

	
	
	
	public String getSelUser() {
		return selUser;
	}

	public void setSelUser(String selUser) {
		this.selUser = selUser;
	}

	public String getSelTel() {
		return selTel;
	}

	public void setSelTel(String selTel) {
		this.selTel = selTel;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getSelName() {
		return selName;
	}

	public void setSelName(String selName) {
		this.selName = selName;
	}

	public List<InqWinningList> getInqList() {
		return inqList;
	}

	public void setInqList(List<InqWinningList> inqList) {
		this.inqList = inqList;
	}
	
	
}
