package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.braker.common.entity.GenericEntityNow;

/**
 * 
 *  @Description 籍贯信息表
 */
@Entity
@Table(name = "popu_birth_place_dict")
public class BirthPlace extends GenericEntityNow implements java.io.Serializable {
	private static final long serialVersionUID = 6384048057486129013L;

	@Column(name = "code")
	private String code;
	@Column(name = "name")
	private String name;

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
	
}
