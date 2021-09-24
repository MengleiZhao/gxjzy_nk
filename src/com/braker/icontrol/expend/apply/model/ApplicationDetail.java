package com.braker.icontrol.expend.apply.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;


/**
 * 通用申请费用明细表的model
 * 是通用申请费用明细表的model类
 * 会议、培训报销明细中也使用（沈帆注）
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Entity
@Table(name = "T_APPLI_DETAIL")
public class ApplicationDetail extends BaseEntity{
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer cId;			//主键ID
	
	@Column(name = "F_G_ID")
	private Integer gId;			//事前申请信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;			//报销信息ID(沈帆加)
	
	@Column(name = "F_COST_DETAILl")
	private String costDetail;		//支出事项
	
	@Column(name = "F_SPENDING_STANDAR")
	private String standard;		//支出标准
	
	@Column(name = "F_AMOUNT")
	private Double applySum;		//申请金额
	
	@Column(name = "F_REMARK")
	private String remark;			//备注描述
	
	@Column(name = "F_REIMB_AMOUNT")
	private Double remibAmount;			//报销金额(沈帆加)

	@Column(name = "F_STATUS")
	private Integer fStatus;//数据状态0-事前申请，1-事后报销
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	

	@Column(name = "F_TOTAL_STANDAR")
	private String totalStandard;		//支出标准总额
	
	
	
	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
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

	public String getTotalStandard() {
		return totalStandard;
	}

	public void setTotalStandard(String totalStandard) {
		this.totalStandard = totalStandard;
	}

	public Double getRemibAmount() {
		return remibAmount;
	}

	public void setRemibAmount(Double remibAmount) {
		this.remibAmount = remibAmount;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}


	
	

}
