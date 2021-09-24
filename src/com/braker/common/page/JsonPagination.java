package com.braker.common.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class JsonPagination implements Serializable{
	
	private static final long serialVersionUID = -2554174279007555328L;
	
	private boolean success=true;
	private int totalRows;
	private int curPage;
	private List data;
	private Integer total;
	private List rows;
	private List footer;
	
	
	public List getFooter() {
		return footer;
	}
	public void setFooter(List footer) {
		this.footer = footer;
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	
	
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List getRows() {
		if(rows==null){ //20190723 安达  防止页面报 Uncaught TypeError: Cannot read property 'length' of null  错误
			return new ArrayList();
		}
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}
	/**
	 * 分组grid数据格式
	 */
}
