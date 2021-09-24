package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.EntityDao;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


/**
 * 资金来源事项表   用于预算申报时   预算主办会计选择资金来源使用
 * @author zml
 */
@Entity
@Table(name = "t_capital_source_matter")
@JsonIgnoreProperties(ignoreUnknown = true)
public class TCapitalSourceMatter extends BaseEntityEmpty implements EntityDao{

	@Id
	@Column(name = "F_CSM_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer csmId;				//主键
	
	@Column(name = "F_CSM_CODE")
	private String csmCode;				//编码
	
	@Column(name = "F_CSM_NAME")
	private String csmName;				//名称
	
	@Column(name = "F_PARENT")
	private Integer parent;				//父级id
	
	
	public Integer getCsmId() {
		return csmId;
	}

	public void setCsmId(Integer csmId) {
		this.csmId = csmId;
	}

	public String getCsmCode() {
		return csmCode;
	}

	public void setCsmCode(String csmCode) {
		this.csmCode = csmCode;
	}

	public String getCsmName() {
		return csmName;
	}

	public void setCsmName(String csmName) {
		this.csmName = csmName;
	}

	public Integer getParent() {
		return parent;
	}

	public void setParent(Integer parent) {
		this.parent = parent;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return null;
	}

}
