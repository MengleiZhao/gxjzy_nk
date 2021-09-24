package com.braker.icontrol.budget.release.entity;

import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.util.StringUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


/**
 * 基本支出预算指标下达明细model
 * @author 叶崇晖
 * @createtime 2018-07-12
 * @updatetime 2018-07-12
 */
@Entity
@Table(name = "T_BUDGETARY_INDIC_BASIC_ITF")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TBudgetaryIndicBasicItf extends BaseEntityEmpty{
	@Id
	@Column(name = "F_B_I_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer biId;			//主键ID
	
	@ManyToOne
	@JoinColumn(name = "F_B_B_ID")
	@JsonIgnore
	private TBudgetaryIndicBasic bbId;	//基本支出预算指标下达（二下）的副键
	
	@ManyToOne
	@JoinColumn(name = "F_PARENT_ID")
	@JsonIgnore
	private TBudgetaryIndicBasicItf parentId;		//父节点id
	
	@Column(name = "F_BUDGET_SUB_CODE")
	private String indexCode;		//本次下达预算科目编码
	
	@Column(name = "F_BUDGET_SUB_NAME")
	private String indexName;		//本次下达预算科目名称
	
	@Column(name = "F_BUDGET_SUB_AMOUNT")
	private Double subAmount;		//该科目预算总金额
	
	@Column(name = "F_SUB_ARRIVAL_AMOUNT")
	private Double amount;			//本次下达金额
	
	@Column(name = "F_SUB_RESID_AMOUNT")
	private Double residAmount;		//科目剩余金额
	
	@Column(name = "F_FREEZ_AMOUNT")
	private Double freezAmount;		//冻结金额
	
	@Column(name = "F_TYPE")
	private String type; 			//科目类型 1-人员支出 2-公用支出
	
	@Transient
	private Double changeAmount;	//调整金额(数据库中没有)
	
	@Transient
	private String departName;		//指标归口部门（名称）
	
	@Transient
	private int pageOrder; 			//页面显示排序
	
	@Transient
	@JsonIgnore
	private String year;			//年度
	
	@Transient
	@JsonIgnore
	private String releaseUserName;	//下达人
	
	@Transient
	@JsonIgnore
	private String releaseDate;		//下达日期
	
	@Transient
	@JsonIgnore
	private String ArrangeIndexId;	//关联预算编制指标id
	
	//Field For Query
	@Transient
	@JsonIgnore
	private String qCode; 
	@Transient
	@JsonIgnore
	private String qName;
	@Transient
	@JsonIgnore
	private String qYear;
	@Transient
	@JsonIgnore
	private String qPerson;
	
	public String getReleaseDate() {
		if (bbId != null && bbId.getOpTime() != null) {
			new SimpleDateFormat("yyyy-MM-dd").format(bbId.getOpTime());
		}
		return null;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getReleaseUserName() {
		if (bbId != null && bbId.getUserId() != null) {
			return bbId.getUserId().getName();
		}
		return "";
	}

	public void setReleaseUserName(String releaseUserName) {
		this.releaseUserName = releaseUserName;
	}

	public String getYear() {
		if (bbId != null) {
			return bbId.getYaers();
		}
		return "";
	}

	public void setYear(String year) {
		this.year = year;
	}

	public Integer getBiId() {
		return biId;
	}

	public void setBiId(Integer biId) {
		this.biId = biId;
	}

	public TBudgetaryIndicBasicItf getParentId() {
		return parentId;
	}

	public void setParentId(TBudgetaryIndicBasicItf parentId) {
		this.parentId = parentId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public Double getSubAmount() {
		return subAmount;
	}

	public void setSubAmount(Double subAmount) {
		this.subAmount = subAmount;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getResidAmount() {
		return residAmount;
	}

	public void setResidAmount(Double residAmount) {
		this.residAmount = residAmount;
	}

	public Double getChangeAmount() {
		return changeAmount;
	}

	public void setChangeAmount(Double changeAmount) {
		this.changeAmount = changeAmount;
	}

	public String getDepartName() {
		if (!StringUtil.isEmpty(departName)) {
			return departName;
		} else if (bbId != null) {
			return bbId.getDepartName();
		}
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public TBudgetaryIndicBasic getBbId() {
		return bbId;
	}

	public void setBbId(TBudgetaryIndicBasic bbId) {
		this.bbId = bbId;
	}

	public Double getFreezAmount() {
		return freezAmount;
	}

	public void setFreezAmount(Double freezAmount) {
		this.freezAmount = freezAmount;
	}

	public String getArrangeIndexId() {
		return ArrangeIndexId;
	}

	public void setArrangeIndexId(String arrangeIndexId) {
		ArrangeIndexId = arrangeIndexId;
	}

	public String getqCode() {
		return qCode;
	}

	public void setqCode(String qCode) {
		this.qCode = qCode;
	}

	public String getqName() {
		return qName;
	}

	public void setqName(String qName) {
		this.qName = qName;
	}

	public String getqYear() {
		return qYear;
	}

	public void setqYear(String qYear) {
		this.qYear = qYear;
	}

	public String getqPerson() {
		return qPerson;
	}

	public void setqPerson(String qPerson) {
		this.qPerson = qPerson;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	
	
	
	
	
	
}
