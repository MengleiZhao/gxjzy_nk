package com.braker.icontrol.expend.apply.model;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 支出中差旅-预算指标多选
 * @author 赵孟雷
 *
 */
@Entity
@Table(name ="T_BUDGET_MESSAGE_LIST")
public class BudgetMessageList extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="P_ID")
	private Integer pID;
	
	@Column(name = "F_G_ID")
	private Integer gId;			//申请信息ID

	@Column(name = "F_R_ID")
	private Integer rId;			//报销信息ID
	
	@Column(name ="F_COST_NAME")
	private String fCostName;        //费用名称
	
	@Column(name ="F_COST_THEIR")
	private String fCostTheir;        //费用所属
	
	@Column(name ="F_COST_AMOUNT")
	private BigDecimal fCostAmount;        //费用金额
	
	@Column(name ="F_COST_CLASSIFY")
	private String fCostClassify;        //预算分类ID
	
	@Column(name ="F_COST_CLASSIFY_SHOW")
	private String fCostClassifyShow;        //预算分类NAME
	
	@Column(name ="F_INDEX_ID")
	private Integer fIndexId;        //指标ID
	
	@Column(name ="F_PRO_DETAIL_ID")
	private Integer fProDetailId;        //项目支出明细ID
	
	@Column(name ="F_INDEX_TYPE")
	private String fIndexType;        //指标类型
	
	@Column(name ="F_INDEX_NAME")
	private String fIndexName;        //指标名称
	
	@Column(name ="F_INDEX_PF_AMOUNT")
	private BigDecimal fIndexPFAmount;        //指标批复金额
	
	@Column(name ="F_INDEX_KY_AMOUNT")
	private BigDecimal fIndexKYAmount;        //指标可用金额
	
	@Column(name ="F_BUDGET_YEAR")
	private String fBudgetYear;        //预算年度

	public Integer getpID() {
		return pID;
	}

	public void setpID(Integer pID) {
		this.pID = pID;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getfCostName() {
		return fCostName;
	}

	public void setfCostName(String fCostName) {
		this.fCostName = fCostName;
	}

	public String getfCostTheir() {
		return fCostTheir;
	}

	public void setfCostTheir(String fCostTheir) {
		this.fCostTheir = fCostTheir;
	}

	public BigDecimal getfCostAmount() {
		return fCostAmount;
	}

	public void setfCostAmount(BigDecimal fCostAmount) {
		this.fCostAmount = fCostAmount;
	}

	public String getfCostClassify() {
		return fCostClassify;
	}

	public void setfCostClassify(String fCostClassify) {
		this.fCostClassify = fCostClassify;
	}

	public String getfCostClassifyShow() {
		return fCostClassifyShow;
	}

	public void setfCostClassifyShow(String fCostClassifyShow) {
		this.fCostClassifyShow = fCostClassifyShow;
	}

	public Integer getfIndexId() {
		return fIndexId;
	}

	public void setfIndexId(Integer fIndexId) {
		this.fIndexId = fIndexId;
	}

	public Integer getfProDetailId() {
		return fProDetailId;
	}

	public void setfProDetailId(Integer fProDetailId) {
		this.fProDetailId = fProDetailId;
	}

	public String getfIndexType() {
		return fIndexType;
	}

	public void setfIndexType(String fIndexType) {
		this.fIndexType = fIndexType;
	}

	public String getfIndexName() {
		return fIndexName;
	}

	public void setfIndexName(String fIndexName) {
		this.fIndexName = fIndexName;
	}

	public BigDecimal getfIndexPFAmount() {
		return fIndexPFAmount;
	}

	public void setfIndexPFAmount(BigDecimal fIndexPFAmount) {
		this.fIndexPFAmount = fIndexPFAmount;
	}

	public BigDecimal getfIndexKYAmount() {
		return fIndexKYAmount;
	}

	public void setfIndexKYAmount(BigDecimal fIndexKYAmount) {
		this.fIndexKYAmount = fIndexKYAmount;
	}

	public String getfBudgetYear() {
		return fBudgetYear;
	}

	public void setfBudgetYear(String fBudgetYear) {
		this.fBudgetYear = fBudgetYear;
	}
	
}
