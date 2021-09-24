package com.braker.common.entity;

import java.io.Serializable;

public class HighCharts implements Serializable{
	
	
	private static final long serialVersionUID = -8355599378971583705L;
	
	private String xaxis;//x轴
	
	private String series;//数据
	
	private String total;//合计

	public String getXaxis() {
		return xaxis;
	}

	public void setXaxis(String xaxis) {
		this.xaxis = xaxis;
	}

	public String getSeries() {
		return series;
	}

	public void setSeries(String series) {
		this.series = series;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	
}
