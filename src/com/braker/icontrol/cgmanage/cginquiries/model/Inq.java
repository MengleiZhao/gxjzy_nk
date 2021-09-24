package com.braker.icontrol.cgmanage.cginquiries.model;


/**
 * 商品的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-06
 * @updatetime 2018-08-06
 */
public class Inq{
	private String proName;				//商品名称
	
	private String price;				//优惠后总价
	
	private String ffactoryPrice;				//单价
	
	private String fdiscountPrice;				//优惠后价格
	
	private String isImpe;				//是否进口
	
	private String proVendor;				//生产商名称
	
	private String proArea;				//商品产地
	
	private String proVersion;				//商品型号
	
	private String remark;				//备注
	
	
	
	public String getFfactoryPrice() {
		return ffactoryPrice;
	}

	public void setFfactoryPrice(String ffactoryPrice) {
		this.ffactoryPrice = ffactoryPrice;
	}

	public String getFdiscountPrice() {
		return fdiscountPrice;
	}

	public void setFdiscountPrice(String fdiscountPrice) {
		this.fdiscountPrice = fdiscountPrice;
	}

	public String getIsImpe() {
		return isImpe;
	}

	public void setIsImpe(String isImpe) {
		this.isImpe = isImpe;
	}

	public String getProVendor() {
		return proVendor;
	}

	public void setProVendor(String proVendor) {
		this.proVendor = proVendor;
	}

	public String getProArea() {
		return proArea;
	}

	public void setProArea(String proArea) {
		this.proArea = proArea;
	}

	public String getProVersion() {
		return proVersion;
	}

	public void setProVersion(String proVersion) {
		this.proVersion = proVersion;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	

	
	
	
}