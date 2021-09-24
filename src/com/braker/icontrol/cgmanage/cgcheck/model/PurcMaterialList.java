package com.braker.icontrol.cgmanage.cgcheck.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.core.model.Lookups;
/**
 * 采购品目model
 * @author 冉德茂
 * @createtime 2018-07-16
 * @updatetime 2018-07-16
 */
@Entity
@Table(name="T_PURC_MATERIAL_LIST")
public class PurcMaterialList extends BaseEntity{
	
	@Id
	@Column(name = "F_M_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer mId;			//主键ID

	@Column(name ="F_P_ID")
	private Integer fpId;			//外键ID
		
/*	@ManyToOne
	@JoinColumn(name = "F_M_TYPE",referencedColumnName="lookupscode")
	private Lookups fmType;//物品类型
*/	
	@Column(name = "F_M_TYPE")
	private String fmType;//物品类型
	
	@Column(name = "F_M_NAME")
	private String fmName;//物品名称
	
	@Column(name = "F_M_SPECIF")
	private String fmSpecif;//规格型号
	
	@Column(name = "F_M_MODEL")
	private String fmModel;//计量单位
	
	@Column(name = "F_P_NUM")
	private String fpNum;//采购数量
	
	@Column(name = "F_AMOUNT")
	private String famount;//金额
	
	@Column(name = "F_SIGN_PRICE")
	private String fsignPrice;//单价
	
	@Column(name = "F_REMARK")
	private String fRemark;//备注
	
	@Transient
	private Integer  num;			//序号
	
	
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}


	public String getFamount() {
		return famount;
	}

	public void setFamount(String famount) {
		this.famount = famount;
	}

	public String getFsignPrice() {
		return fsignPrice;
	}

	public void setFsignPrice(String fsignPrice) {
		this.fsignPrice = fsignPrice;
	}

	public Integer getmId() {
		return mId;
	}

	public void setmId(Integer mId) {
		this.mId = mId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}





	public String getFmType() {
		return fmType;
	}

	public void setFmType(String fmType) {
		this.fmType = fmType;
	}

	public String getFmName() {
		return fmName;
	}

	public void setFmName(String fmName) {
		this.fmName = fmName;
	}

	public String getFmSpecif() {
		return fmSpecif;
	}

	public void setFmSpecif(String fmSpecif) {
		this.fmSpecif = fmSpecif;
	}

	public String getFmModel() {
		return fmModel;
	}

	public void setFmModel(String fmModel) {
		this.fmModel = fmModel;
	}

	public String getFpNum() {
		return fpNum;
	}

	public void setFpNum(String fpNum) {
		this.fpNum = fpNum;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}




	
	
	
	
	
	
}
