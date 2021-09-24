package com.braker.icontrol.cgmanage.cginquiries.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 询比价的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
@Entity
@Table(name = "T_INQ_WINNING_LIST")
public class InqWinningList extends BaseEntity{
	@Id
	@Column(name = "F_INQ_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer finqId;			//主键ID
	
	@Column(name = "F_MAIN_ID")
	private Integer fmainId;	  //管理采购供应商关系映射表id
	
	@Column(name = "F_P_L_ID")
	private Integer fplId;	  //采购清单id
	
	@Column(name = "F_PRO_NAME")
	private String fproName;				//商品名称
	
	@Column(name = "F_IS_IMPE")
	private String fisImpe;				//是否进口
	
	@Column(name = "F_PRO_VENDOR")
	private String fproVendor;				//生厂商名称
	
	@Column(name = "F_PRO_AREA")
	private String fproArea;				//商品产地

	@Column(name = "F_PRO_VERSION")
	private String fproVerdsion;				//商品型号
	
	@Column(name = "F_PRO_AMOUNT")
	private String fproAmount;				//商品数量
	
	@Column(name = "F_FACTORY_PRICE")
	private String ffactoryPrice;				//额定价格
	
	@Column(name = "F_DISCOUNT_PRICE")
	private String fdiscountPrice;				//优惠幅度
	
	@Column(name = "F_FINAL_PRICE")
	private String ffinalPrice;				//优惠后总价
	
	@Column(name = "F_REMARK")
	private String fremark;				//备注
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String fpurName;//采购目录名称
	
	@Transient
	private String fpurBrand;//采购品牌
	
	@Transient
	private String fspecifModel;//规格型号
	
	@Transient
	private Integer fnum;//数量
	
	

	public String getFpurBrand() {
		return fpurBrand;
	}

	public void setFpurBrand(String fpurBrand) {
		this.fpurBrand = fpurBrand;
	}

	public String getFspecifModel() {
		return fspecifModel;
	}

	public void setFspecifModel(String fspecifModel) {
		this.fspecifModel = fspecifModel;
	}

	public Integer getFnum() {
		return fnum;
	}

	public void setFnum(Integer fnum) {
		this.fnum = fnum;
	}

	public Integer getFinqId() {
		return finqId;
	}

	public void setFinqId(Integer finqId) {
		this.finqId = finqId;
	}



	public Integer getFmainId() {
		return fmainId;
	}

	public void setFmainId(Integer fmainId) {
		this.fmainId = fmainId;
	}

	public String getFproName() {
		return fproName;
	}

	public void setFproName(String fproName) {
		this.fproName = fproName;
	}

	public String getFisImpe() {
		return fisImpe;
	}

	public void setFisImpe(String fisImpe) {
		this.fisImpe = fisImpe;
	}

	public String getFproVendor() {
		return fproVendor;
	}

	public void setFproVendor(String fproVendor) {
		this.fproVendor = fproVendor;
	}

	public String getFproArea() {
		return fproArea;
	}

	public void setFproArea(String fproArea) {
		this.fproArea = fproArea;
	}

	public String getFproVerdsion() {
		return fproVerdsion;
	}

	public void setFproVerdsion(String fproVerdsion) {
		this.fproVerdsion = fproVerdsion;
	}

	public String getFproAmount() {
		return fproAmount;
	}

	public void setFproAmount(String fproAmount) {
		this.fproAmount = fproAmount;
	}

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

	public String getFfinalPrice() {
		return ffinalPrice;
	}

	public void setFfinalPrice(String ffinalPrice) {
		this.ffinalPrice = ffinalPrice;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getFplId() {
		return fplId;
	}

	public void setFplId(Integer fplId) {
		this.fplId = fplId;
	}

	public String getFpurName() {
		return fpurName;
	}

	public void setFpurName(String fpurName) {
		this.fpurName = fpurName;
	}

	
	
	
}
