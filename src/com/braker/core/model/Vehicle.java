package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 交通工具维护的model
 * 用于支出申请中的交通工具选择用
 * @author 叶崇晖
 * @createtime 2019-01-09
 * @updatetime 2019-01-09
 */
@Entity
@Table(name = "T_VEHICLE")
public class Vehicle extends BaseEntityEmpty implements Combobox {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;
	
	@Column(name = "F_CODE")
	private String code;
	
	@Column(name = "F_NAME")
	private String name;
	
	@Column(name = "F_PARENT_CODE")
	private String parentCode;

	@Column(name = "F_USE_LEVEL")
	private String fUseLevel;
	
	public String getfUseLevel() {
		return fUseLevel;
	}

	public void setfUseLevel(String fUseLevel) {
		this.fUseLevel = fUseLevel;
	}

	@Transient
	private Integer num;

	
	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
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

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	
	
	
	
	
	
	/**一下为继承Combobox类前台所需的方法**/
	
	public String getId() {
		return fId.toString();
	}

	public String getCode() {
		return code;
	}
	
	@Override
	public String getGridCode() {
		return null;
	}

	@Override
	public String getSftjCode() {
		return null;
	}

	@Override
	public String getText() {
		return name;
	}

	@Override
	public String getDesc() {
		return null;
	}
	
	
}
