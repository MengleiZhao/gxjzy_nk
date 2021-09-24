package com.braker.icontrol.expend.reimburse.model;

import java.util.List;

/**
 * 发票信息（接口返回）
 * @author 张迅
 *
 */
public class InvoiceResponse {

	private String success = "false";	//接口返回情况
	
	private String fpdm;	//发票代码
	
	private String fphm;	//发票号码
	
	private String kprq;	//开票日期
	
	private String xfMc;	//销售方名称
	
	private String fplxName;//发票类型名称
	
	private String sfMc;	//省份名称
	
	private String sfCode;	//省份代码
	
	private String xfNsrsbh;//纳税人识别号
	
	private String xfContact;	//销售方地址、电话
	
	private String xfBank;		//销售方开户行及账号
	
	private String gfMc;		//购买方名称
	
	private String gfNsrsbh;	//购买方纳税人识别号
	
	private String gfContact;	//购买方地址、电话
	
	private String gfBank;		//购买方开户行及账号
	
	private String code;		//校验码
	
	private String num;			//机器编号
	
	private String del;			//是否作废
	
	private String taxamount;	//税额合计
	
	private String goodsamount;	//合计
	
	private String sumamount;	//价税合计
	
	private String quantityAmount;	//数量
	
	private String remark;		//备注
	
	private String updateTime;	//

	private List<InvoiceDetail> goodsData;	//列表-货物或应税劳务、服务
	
	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public String getFpdm() {
		return fpdm;
	}

	public void setFpdm(String fpdm) {
		this.fpdm = fpdm;
	}

	public String getFphm() {
		return fphm;
	}

	public void setFphm(String fphm) {
		this.fphm = fphm;
	}

	public String getKprq() {
		return kprq;
	}

	public void setKprq(String kprq) {
		this.kprq = kprq;
	}

	public String getXfMc() {
		return xfMc;
	}

	public void setXfMc(String xfMc) {
		this.xfMc = xfMc;
	}

	public String getFplxName() {
		return fplxName;
	}

	public void setFplxName(String fplxName) {
		this.fplxName = fplxName;
	}

	public String getSfMc() {
		return sfMc;
	}

	public void setSfMc(String sfMc) {
		this.sfMc = sfMc;
	}

	public String getSfCode() {
		return sfCode;
	}

	public void setSfCode(String sfCode) {
		this.sfCode = sfCode;
	}

	public String getXfNsrsbh() {
		return xfNsrsbh;
	}

	public void setXfNsrsbh(String xfNsrsbh) {
		this.xfNsrsbh = xfNsrsbh;
	}

	public String getXfContact() {
		return xfContact;
	}

	public void setXfContact(String xfContact) {
		this.xfContact = xfContact;
	}

	public String getXfBank() {
		return xfBank;
	}

	public void setXfBank(String xfBank) {
		this.xfBank = xfBank;
	}

	public String getGfMc() {
		return gfMc;
	}

	public void setGfMc(String gfMc) {
		this.gfMc = gfMc;
	}

	public String getGfNsrsbh() {
		return gfNsrsbh;
	}

	public void setGfNsrsbh(String gfNsrsbh) {
		this.gfNsrsbh = gfNsrsbh;
	}

	public String getGfContact() {
		return gfContact;
	}

	public void setGfContact(String gfContact) {
		this.gfContact = gfContact;
	}

	public String getGfBank() {
		return gfBank;
	}

	public void setGfBank(String gfBank) {
		this.gfBank = gfBank;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getTaxamount() {
		return taxamount;
	}

	public void setTaxamount(String taxamount) {
		this.taxamount = taxamount;
	}

	public String getGoodsamount() {
		return goodsamount;
	}

	public void setGoodsamount(String goodsamount) {
		this.goodsamount = goodsamount;
	}

	public String getSumamount() {
		return sumamount;
	}

	public void setSumamount(String sumamount) {
		this.sumamount = sumamount;
	}

	public String getQuantityAmount() {
		return quantityAmount;
	}

	public void setQuantityAmount(String quantityAmount) {
		this.quantityAmount = quantityAmount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public List<InvoiceDetail> getGoodsData() {
		return goodsData;
	}

	public void setGoodsData(List<InvoiceDetail> goodsData) {
		this.goodsData = goodsData;
	}
	
	
	
	
}
