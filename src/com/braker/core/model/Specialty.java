package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.braker.common.entity.GenericEntityNew;
/**
 * 
 *  @Description 职业种类表
 *  @author li_chong
 *  @createDate 2017-3-30下午4:49:58
 *  @version 1.0
 */
@Entity
@Table(name = "popu_specialty_dict")
public class Specialty extends GenericEntityNew implements java.io.Serializable {
	private static final long serialVersionUID = -7181338412213772627L;
	@Column(name = "code")
	private String code;
	@Column(name = "name")
	private String name;
	@Column(name = "description")
	private String description;
	@Column(name = "pinyin")
	private String pinyin;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPinyin() {
		return pinyin;
	}
	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}
	
}
