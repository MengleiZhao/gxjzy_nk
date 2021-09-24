package com.braker.core.model;

/**
 * 首页快速入口编辑json携带类
 * @author 叶崇晖
 * @createtime 2018-09-13
 * @updatetime 2018-09-13
 */
public class DsSelect {
	private String id;
	private String name;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public DsSelect(String id, String name) {
		this.id = id;
		this.name = name;
	}
	
}
