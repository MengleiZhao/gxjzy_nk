package com.braker.icontrol.budget.project.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 
 * <p>Description: 项目支出明细</p>
 * @author:安达
 * @date： 2019年6月13日下午7:37:53
 */

@Entity
@Table(name = "T_PRO_EXPEND_DETAIL")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TProExpendDetail extends BaseEntityEmpty implements Combobox{

	@Id
	@Column(name = "F_EXP_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer pid;				//主键
	
	@Column(name = "F_EXP_CODE")
	private String expCode;				//支出明细编码
	
	@Column(name = "F_PRO_ID")
	private Integer FProId;				//项目id  
	
	@Column(name = "F_PRO_ACTIVITY")
	private String activity;			//项目活动

	@Column(name = "F_PRO_ACTIVITY_DESC")
	private String actDesc;				//摘要

	@Column(name = "F_P_S_ACTIVITE")
	private String sonActivity;			//子活动

	@Column(name = "F_P_S_ACTIVITY_DESC")
	private String sonActDesc; 			//对子活动的描述

	@Column(name = "F_NUM")
	private String number;				//数量/频率

	@Column(name = "F_SING_AMOUNT")
	private String standards;			//价格/标准

	@Column(name = "F_APPLI_AMOUNT")
	private BigDecimal outAmount;			//支出计划（元）

	@Column(name = "F_EXPEND_AMOUNT")
	private BigDecimal expendAmount;		//已用金额（元）

	@Column(name = "F_REMARK")
	private String remark;				//备注

	@Column(name = "F_SUB_NUM")
	private String subCode;				//科目编码
	
	@Column(name = "F_SUB_NAME")
	private String subName;				//科目名称
	
	@Column(name = "F_FUN_SUB_CODE")
	private String funSubCode;				//功能科目编码
	
	@Column(name = "F_FUN_SUB_NAME")
	private String funSubName;				//功能科目名称
	
	@Column(name = "F_CAPITAL_SOURCE_NAME")
	private String capitalSourceName;		//资金来源名称
	
	@Column(name = "F_CAPITAL_SOURCE_CODE")
	private String capitalSourceCode;		//资金来源编号
	
	@Column(name = "F_ACCORDING")
	private String according;			//测算依据
	
	@Column(name = "F_XD_AMOUNT")
	private BigDecimal xdAmount; 			//指标累计下达金额（元）
	
	@Column(name = "F_SY_AMOUNT")
	private BigDecimal syAmount; 			//指标可用金额（元）
	
	@Column(name = "F_DJ_AMOUNT")
	private BigDecimal djAmount; 			//指标冻结金额（元）
	
	@Column(name = "F_CREATE_STATUS")
	private String createStatus; 		//生成状态 null-申报生成 1-调整生成
	
	@Transient
	private String pageOrder;
	
	@Transient
	private Integer bId;			//主键ID   指标表的
	
	@Transient
	private String fProOrBasic;//预算支出类型     区分基本支出或项目支出：0=基本支出，1=项目支出 2=大项目
	
	@Transient
	private String years; 			//预算年度
	
	@Transient
	private String proName; 			//项目名称
	
	public String getCreateStatus() {
		return createStatus;
	}
	public void setCreateStatus(String createStatus) {
		this.createStatus = createStatus;
	}
	public String getFunSubCode() {
		return funSubCode;
	}
	public void setFunSubCode(String funSubCode) {
		this.funSubCode = funSubCode;
	}
	public String getFunSubName() {
		return funSubName;
	}
	public void setFunSubName(String funSubName) {
		this.funSubName = funSubName;
	}
	public String getCapitalSourceName() {
		return capitalSourceName;
	}
	public void setCapitalSourceName(String capitalSourceName) {
		this.capitalSourceName = capitalSourceName;
	}
	public String getCapitalSourceCode() {
		return capitalSourceCode;
	}
	public void setCapitalSourceCode(String capitalSourceCode) {
		this.capitalSourceCode = capitalSourceCode;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public String getfProOrBasic() {
		return fProOrBasic;
	}
	public void setfProOrBasic(String fProOrBasic) {
		this.fProOrBasic = fProOrBasic;
	}
	public Integer getbId() {
		return bId;
	}
	public void setbId(Integer bId) {
		this.bId = bId;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	
	public String getActDesc() {
		return actDesc;
	}
	public void setActDesc(String actDesc) {
		this.actDesc = actDesc;
	}
	
	public String getSonActivity() {
		return sonActivity;
	}
	public void setSonActivity(String sonActivity) {
		this.sonActivity = sonActivity;
	}
	
	public String getSonActDesc() {
		return sonActDesc;
	}
	public void setSonActDesc(String sonActDesc) {
		this.sonActDesc = sonActDesc;
	}
	
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	
	public String getStandards() {
		return standards;
	}
	public void setStandards(String standards) {
		this.standards = standards;
	}
	
	public BigDecimal getOutAmount() {
		return outAmount;
	}
	public void setOutAmount(BigDecimal outAmount) {
		this.outAmount = outAmount;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getSubCode() {
		return subCode;
	}
	public void setSubCode(String subCode) {
		this.subCode = subCode;
	}
	
	public String getSubName() {
		return subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}
	
	public String getAccording() {
		return according;
	}
	public void setAccording(String according) {
		this.according = according;
	}
	
	
	public String getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(String pageOrder) {
		this.pageOrder = pageOrder;
	}
	
	public BigDecimal getExpendAmount() {
		return expendAmount;
	}
	public void setExpendAmount(BigDecimal expendAmount) {
		this.expendAmount = expendAmount;
	}
	public Integer getFProId() {
		return FProId;
	}
	public void setFProId(Integer fProId) {
		FProId = fProId;
	}
	public BigDecimal getXdAmount() {
		return xdAmount;
	}
	public void setXdAmount(BigDecimal xdAmount) {
		this.xdAmount = xdAmount;
	}
	public BigDecimal getSyAmount() {
		return syAmount;
	}
	public void setSyAmount(BigDecimal syAmount) {
		this.syAmount = syAmount;
	}
	public BigDecimal getDjAmount() {
		return djAmount;
	}
	public void setDjAmount(BigDecimal djAmount) {
		this.djAmount = djAmount;
	}
	public String getExpCode() {
		return expCode;
	}
	public void setExpCode(String expCode) {
		this.expCode = expCode;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	@Override
	public String getCode() {
		return expCode;
	}
	@Override
	public String getGridCode() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getSftjCode() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getText() {
		return activity;
	}
	@Override
	public String getDesc() {
		return null;
	}
	@Override
	public String getId() {
		return String.valueOf(pid);
	}
}
