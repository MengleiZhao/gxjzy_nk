package com.braker.core.model;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 用于combobox在前台的数据显示
 * @author 赵孟雷
 * @createtime 2020-11-17
 * @updatetime 2020-11-17
 */
public class DefaultCombobox extends BaseEntityEmpty implements Combobox {
	
	private String id;
	
	private String code;
	
	private String name;
	
	private String parentCode;

	private Integer num;

	public void setId(String id) {
		this.id = id;
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
		return id.toString();
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
