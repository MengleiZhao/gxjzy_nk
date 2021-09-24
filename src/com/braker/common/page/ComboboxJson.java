package com.braker.common.page;

import java.io.Serializable;

public class ComboboxJson implements Serializable{

	private static final long serialVersionUID = 6777379740318824580L;
	
	public String id;
	public String code;
	public String gridCode;
	public String SftjCode;	
	public String text;
	public String desc;
	public boolean selected;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getGridCode() {
		return gridCode;
	}
	public void setGridCode(String gridCode) {
		this.gridCode = gridCode;
	}
	public String getSftjCode() {
		return SftjCode;
	}
	public void setSftjCode(String sftjCode) {
		SftjCode = sftjCode;
	}
}
