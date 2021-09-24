package com.braker.icontrol.budget.performancemanage.selfeval.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntityEmpty;

/**
 *生成的自评项目的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-29
 * @updatetime 2018-08-29
 */
@Entity
@Table(name = "T_SELF_EVALUATION")
public class SelfEvaluation extends BaseEntityEmpty{
	@Id
	@Column(name = "F_MAIN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fmainId;			//主键ID
	
	@Column(name = "F_C_ID")
	private Integer fcId;			//外键    配置表的id
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;			//外键    项目表的id
	
	@Column(name = "F_IS_SHOW")
	private String  fisShow;			//是否启用的 状态
	
	@Column(name = "F_IS_EVAL")
	private String  fisEval;			//是否已经自评的 状态

	public Integer getFmainId() {
		return fmainId;
	}

	public void setFmainId(Integer fmainId) {
		this.fmainId = fmainId;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public Integer getFproId() {
		return fproId;
	}

	public void setFproId(Integer fproId) {
		this.fproId = fproId;
	}

	public String getFisShow() {
		return fisShow;
	}

	public void setFisShow(String fisShow) {
		this.fisShow = fisShow;
	}

	public String getFisEval() {
		return fisEval;
	}

	public void setFisEval(String fisEval) {
		this.fisEval = fisEval;
	}
	
	
	
	
}
