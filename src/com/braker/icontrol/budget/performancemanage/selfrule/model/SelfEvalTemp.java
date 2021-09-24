package com.braker.icontrol.budget.performancemanage.selfrule.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import com.braker.common.entity.BaseEntity;

/**
 * 自评模版的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-14
 * @updatetime 2018-08-14
 */
@Entity
@Table(name = "T_SELF_EVAL_TEMP")
public class SelfEvalTemp extends BaseEntity{
	@Id
	@Column(name = "F_T_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer ftId;			//主键ID
	
	@Column(name = "F_TEMP_NAME")
	private String ftempName;				//模版名称
	
	@Column(name = "F_TEMP_DESC")
	private String ftempDesc;				//模版说明
	
	@Column(name = "F_TEMP_CODE")
	private String ftempCode;				//模版编码
	
	@Column(name = "F_YEAR")
	private String fyear;				//应用年度
	
	@Column(name = "F_IS_ON")
	private String fisOn;				//是否启用
	
	@Column(name = "F_IS_CO")
	private String fisCo;				//是否已配置规则
	
	@Column(name = "F_STAUTS")
	private String fstauts;				//数据的删除标志
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	
	public String getFstauts() {
		return fstauts;
	}

	public void setFstauts(String fstauts) {
		this.fstauts = fstauts;
	}

	public Integer getFtId() {
		return ftId;
	}

	public void setFtId(Integer ftId) {
		this.ftId = ftId;
	}

	public String getFtempName() {
		return ftempName;
	}

	public void setFtempName(String ftempName) {
		this.ftempName = ftempName;
	}

	public String getFtempDesc() {
		return ftempDesc;
	}

	public void setFtempDesc(String ftempDesc) {
		this.ftempDesc = ftempDesc;
	}

	public String getFtempCode() {
		return ftempCode;
	}

	public void setFtempCode(String ftempCode) {
		this.ftempCode = ftempCode;
	}

	public String getFyear() {
		return fyear;
	}

	public void setFyear(String fyear) {
		this.fyear = fyear;
	}

	public String getFisOn() {
		return fisOn;
	}

	public void setFisOn(String fisOn) {
		this.fisOn = fisOn;
	}

	public String getFisCo() {
		return fisCo;
	}

	public void setFisCo(String fisCo) {
		this.fisCo = fisCo;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}



	
	
	
}
