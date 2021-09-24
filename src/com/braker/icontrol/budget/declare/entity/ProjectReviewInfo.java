package com.braker.icontrol.budget.declare.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;

/**
 * 
 * <p>Description: 项目评审结果</p>
 * @author:安达
 * @date： 2019年5月29日上午10:09:18
 */
@Entity
@Table(name = "T_PRO_REVIEW_INFO")
public class ProjectReviewInfo extends BaseEntity implements EntityDao{
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer rId;			//主键ID
	
	@Column(name = "SB_IDS")
	private String  sbIds;			//上报通过的项目id串
	
	@Column(name = "LX_IDS")
	private String lxIds;			//落选的项目id串
	
	@Column(name = "SB_COUNT")
	private Integer sbCount;			//申报项目总数
	
	@Column(name = "SB_YEAR")
	private String sbYear;	//上报年份
	
	@Column(name = "F_REVIEW_TIME")
	private Date reviewTime;		//评审时间
	
	@Column(name = "SB_AMOUNT")
	private Double sbMount;		//申报总金额
	
	@Column(name = "F_REVIEW_PEOPLE")
	private String reviewPeople;	//参与人员
	
	@Column(name = "OPERATOR")
	private String operator;		//操作员名字
	
	@Column(name = "OPERATOR_ID")
	private String operatorId;			//操作员用户id

	
	@Transient
	private Integer num;			//序号
	
	@Transient
	private String timea;		//查询区 开始时间
	
	@Transient
	private String timeb;		//查询区 结束时间

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getSbIds() {
		return sbIds;
	}

	public void setSbIds(String sbIds) {
		this.sbIds = sbIds;
	}

	public String getLxIds() {
		return lxIds;
	}

	public void setLxIds(String lxIds) {
		this.lxIds = lxIds;
	}

	public String getSbYear() {
		return sbYear;
	}

	public void setSbYear(String sbYear) {
		this.sbYear = sbYear;
	}

	public Date getReviewTime() {
		return reviewTime;
	}

	public void setReviewTime(Date reviewTime) {
		this.reviewTime = reviewTime;
	}

	public Double getSbMount() {
		return sbMount;
	}

	public void setSbMount(Double sbMount) {
		this.sbMount = sbMount;
	}

	public String getReviewPeople() {
		return reviewPeople;
	}

	public void setReviewPeople(String reviewPeople) {
		this.reviewPeople = reviewPeople;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getTimea() {
		return timea;
	}

	public void setTimea(String timea) {
		this.timea = timea;
	}

	public String getTimeb() {
		return timeb;
	}

	public void setTimeb(String timeb) {
		this.timeb = timeb;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_PRO_REVIEW_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return rId.toString();
	}

	public Integer getSbCount() {
		return sbCount;
	}

	public void setSbCount(Integer sbCount) {
		this.sbCount = sbCount;
	}
	


	
}
