package com.braker.common.entity;

/**
 * datagrid 中需要合并的单元格信息
 * @author zhangxun
 */
public class MergeCellInfo {

	private int index;//行坐标
	private int rowspan;//合并行数
	private int colspan;//合并列数
	
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getRowspan() {
		return rowspan;
	}
	public void setRowspan(int rowspan) {
		this.rowspan = rowspan;
	}
	public int getColspan() {
		return colspan;
	}
	public void setColspan(int colspan) {
		this.colspan = colspan;
	}
	
	
}
