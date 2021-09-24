package com.braker.icontrol.expend.reimburse.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 直接报销申请费用明细表的model
 * @author 叶崇晖
 * @createtime 2018-08-04
 * @updatetime 2018-08-04
 */
@Entity
@Table(name = "T_DIRECTLY_REIMB_DETAIL")
public class DirectlyReimbDetail extends BaseEntity {
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer cId;			//主键ID
	
	@Column(name = "F_DR_ID",updatable=false)
	private Integer drId;			//申请信息ID
	
	@Column(name = "F_COST_DETAILl")
	private String costDetail;		//费用明细
	
	@Column(name = "F_SPENDING_STANDAR")
	private String standard;		//开支标准
	
	@Column(name = "F_AMOUNT")
	private Double applySum;		//申请金额
	
	@Column(name = "F_REMARK")
	private String remark;			//备注
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	

	
	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Integer getDrId() {
		return drId;
	}

	public void setDrId(Integer drId) {
		this.drId = drId;
	}

	public String getCostDetail() {
		return costDetail;
	}

	public void setCostDetail(String costDetail) {
		this.costDetail = costDetail;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public Double getApplySum() {
		return applySum;
	}

	public void setApplySum(Double applySum) {
		this.applySum = applySum;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}


	
}
