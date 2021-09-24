package com.braker.workflow.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
  * 流程节点跳转规则表 
 * @author anda
 * @createtime 2019-04-19
 */
@Entity
@Table(name = "t_link_rule")
public class TLinkRule implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	@Column(name ="F_R_Id")	
	private Integer fRid;//主键
	@Column(name ="F_P_ID")	
	private Integer FPId;//流程定义id
	@Column(name ="FROM_KEY")	
	private Integer fromKey;//出发点key
	@Column(name ="TO_KEY")	
	private Integer toKey;//到达节点key
	@Column(name ="FIELD_NAME")	
	private String fieldName;//字段名
	@Column(name ="CUSTOM")	
	private String custom;//条件
	@Column(name ="FIELD_VALUE")	
	private String fieldValue;//值
	public Integer getfRid() {
		return fRid;
	}
	public void setfRid(Integer fRid) {
		this.fRid = fRid;
	}
	public Integer getFPId() {
		return FPId;
	}
	public void setFPId(Integer fPId) {
		FPId = fPId;
	}
	public Integer getFromKey() {
		return fromKey;
	}
	public void setFromKey(Integer fromKey) {
		this.fromKey = fromKey;
	}
	public Integer getToKey() {
		return toKey;
	}
	public void setToKey(Integer toKey) {
		this.toKey = toKey;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	public String getCustom() {
		return custom;
	}
	public void setCustom(String custom) {
		this.custom = custom;
	}
	
	

	
	

}