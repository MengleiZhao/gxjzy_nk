package com.braker.icontrol.budget.project.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.poi.xwpf.converter.core.utils.StringUtils;
import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.common.util.LookupsUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.workflow.entity.TProcessCheck;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 
 * <p>Description: 项目资金来源明细</p>
 * @author:安达
 * @date： 2019年5月23日下午3:00:45
 */
@Entity
@Table(name = "T_PRO_BASIC_FUNDS")
public class TProBasicFunds extends BaseEntityEmpty  {
	
	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private String id;
	
	@Column(name = "F_PRO_ID")
	private Integer FProId;  //项目id
	
	@Column(name = "FUNDS_SOURCE")
	private String fundsSource;  //资金来源编号   0-财政拨款收入、1-教育事业收入、2-科研事业收入、3-非同级拨款收入、4-其他收入、5-利息收入
	
	@Column(name = "AMOUNT")
	private BigDecimal amount;			//金额

	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Column(name = "FUNDS_SOURCE_TEXT")
	private String fundsSourceText;		//资金来源名称
	
	public String getFundsSourceText() {
		return fundsSourceText;
	}

	public void setFundsSourceText(String fundsSourceText) {
		this.fundsSourceText = fundsSourceText;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getFProId() {
		return FProId;
	}

	public void setFProId(Integer fProId) {
		FProId = fProId;
	}

	public String getFundsSource() {
		return fundsSource;
	}

	public void setFundsSource(String fundsSource) {
		this.fundsSource = fundsSource;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	

	
	
}