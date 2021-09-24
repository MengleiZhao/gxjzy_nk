package com.braker.zzww.comm.entity;

import java.io.Serializable;
/**
 * 
 * @author administrator
 * 地图定位属性
 *
 */
public class LocationAttribute implements Serializable{
	private static final long serialVersionUID = -8964397505918845903L;
	
	private String markId;//唯一标识
	private String catoId;//类型标识，用于区分相同类型数据
	private String title;//标题
	private String address;//地址
	private String x;//地址x坐标
	private String y;//地址y坐标
	private int status=10;//目标状态 10=正常,其他值=发现问题
	
	public String getMarkId() {
		return markId;
	}
	public void setMarkId(String markId) {
		this.markId = markId;
	}
	public String getCatoId() {
		return catoId;
	}
	public void setCatoId(String catoId) {
		this.catoId = catoId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

}
