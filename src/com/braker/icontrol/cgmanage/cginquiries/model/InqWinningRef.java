package com.braker.icontrol.cgmanage.cginquiries.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;



import com.braker.common.entity.BaseEntity;

/**
 * 询比价供应商映射表的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
@Entity
@Table(name = "T_INQ_WINNING_REF")
public class InqWinningRef extends BaseEntity{
	@Id
	@Column(name = "F_MAIN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fmainId;			//主键ID
	
	@Column(name = "F_P_ID")
	private Integer fpId;	  //采购id
	
	@Column(name = "F_W_ID") //供应商id 
	private Integer fwId;
	
	@Column(name = "F_FINAL_PRICE")
	private String ffinalPrice;				//最终报价
			
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String  selName;			//供应商名称
	
	@Transient
	private String  selUser;			//联系人
	
	@Transient
	private String  selTel;			//联系人电话
	
	@Transient
	private String  selAddr;			//办公地址
	
	@Transient
	private String  selRemark;			//备注
	
	@Transient
	private List<InqWinningList> qingdan;	//

	
	

	public String getSelAddr() {
		return selAddr;
	}

	public void setSelAddr(String selAddr) {
		this.selAddr = selAddr;
	}

	public String getSelRemark() {
		return selRemark;
	}

	public void setSelRemark(String selRemark) {
		this.selRemark = selRemark;
	}

	public String getSelName() {
		return selName;
	}

	public void setSelName(String selName) {
		this.selName = selName;
	}

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

	public Integer getFmainId() {
		return fmainId;
	}

	public void setFmainId(Integer fmainId) {
		this.fmainId = fmainId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getFwId() {
		return fwId;
	}

	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}

	public String getFfinalPrice() {
		return ffinalPrice;
	}

	public void setFfinalPrice(String ffinalPrice) {
		this.ffinalPrice = ffinalPrice;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public List<InqWinningList> getQingdan() {
		return qingdan;
	}

	public void setQingdan(List<InqWinningList> qingdan) {
		this.qingdan = qingdan;
	}

	
	
	
	
	
}
