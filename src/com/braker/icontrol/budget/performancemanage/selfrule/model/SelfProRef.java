package com.braker.icontrol.budget.performancemanage.selfrule.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntityEmpty;

/**
 *自评配置和需要规避的项目映射信息的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-14
 * @updatetime 2018-08-14
 */
@Entity
@Table(name = "T_SELF_PRO_REF")
public class SelfProRef extends BaseEntityEmpty{
	@Id
	@Column(name = "F_MAIN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fmainId;			//主键ID
	
	@Column(name = "F_C_ID")
	private Integer fcId;			//外键    配置表的id
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;			//外键    项目表的id

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
	
	
	
	
}
