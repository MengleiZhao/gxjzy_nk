package com.braker.zzww.comm.entity;

import java.io.Serializable;
/**
 * 街道首页和居委首页-今日工作
 * @author zhou_liang
 *
 */
public class TodayJob implements Serializable{
	private static final long serialVersionUID = 3651958848626536983L;
	
	private int sftjNotStartTask;//矛盾调处未开始
	private int sftjRunningTask;//矛盾调处进行中
	private int dzxcNotStartTask;//电子巡查未开始
	private int dzxcRunningTask;//电子巡查进行中
	
	private int elogNotStartTask;//电子走访未开始
	private int elogRunningTask;//电子走访进行中
	
	private int dzzfNotStartTask;//社区走访（已上报）
	private int dzzfRunningTask;//社区走访（已接收）
	private int sqmysbNotStartTask;//社情民意（已上报）
	private int sqmysbRunningTask;//社情民意（已接收，审核未通过）
	
	private int xfNotStartTask;//信访未开始
	private int xfRunningTask;//信访进行中
	private int gridNotStartTask;//网格化管理未开始
	private int gridRunningTask;//网格化管理进行中
	
	public int getSftjNotStartTask() {
		return sftjNotStartTask;
	}
	public void setSftjNotStartTask(int sftjNotStartTask) {
		this.sftjNotStartTask = sftjNotStartTask;
	}
	public int getSftjRunningTask() {
		return sftjRunningTask;
	}
	public void setSftjRunningTask(int sftjRunningTask) {
		this.sftjRunningTask = sftjRunningTask;
	}
	public int getDzxcNotStartTask() {
		return dzxcNotStartTask;
	}
	public void setDzxcNotStartTask(int dzxcNotStartTask) {
		this.dzxcNotStartTask = dzxcNotStartTask;
	}
	public int getDzxcRunningTask() {
		return dzxcRunningTask;
	}
	public void setDzxcRunningTask(int dzxcRunningTask) {
		this.dzxcRunningTask = dzxcRunningTask;
	}
	public int getDzzfNotStartTask() {
		return dzzfNotStartTask;
	}
	public void setDzzfNotStartTask(int dzzfNotStartTask) {
		this.dzzfNotStartTask = dzzfNotStartTask;
	}
	public int getDzzfRunningTask() {
		return dzzfRunningTask;
	}
	public void setDzzfRunningTask(int dzzfRunningTask) {
		this.dzzfRunningTask = dzzfRunningTask;
	}
	public int getXfNotStartTask() {
		return xfNotStartTask;
	}
	public void setXfNotStartTask(int xfNotStartTask) {
		this.xfNotStartTask = xfNotStartTask;
	}
	public int getXfRunningTask() {
		return xfRunningTask;
	}
	public void setXfRunningTask(int xfRunningTask) {
		this.xfRunningTask = xfRunningTask;
	}
	public int getGridNotStartTask() {
		return gridNotStartTask;
	}
	public void setGridNotStartTask(int gridNotStartTask) {
		this.gridNotStartTask = gridNotStartTask;
	}
	public int getGridRunningTask() {
		return gridRunningTask;
	}
	public void setGridRunningTask(int gridRunningTask) {
		this.gridRunningTask = gridRunningTask;
	}
	public int getElogNotStartTask() {
		return elogNotStartTask;
	}
	public void setElogNotStartTask(int elogNotStartTask) {
		this.elogNotStartTask = elogNotStartTask;
	}
	public int getElogRunningTask() {
		return elogRunningTask;
	}
	public void setElogRunningTask(int elogRunningTask) {
		this.elogRunningTask = elogRunningTask;
	}
	public int getSqmysbNotStartTask() {
		return sqmysbNotStartTask;
	}
	public void setSqmysbNotStartTask(int sqmysbNotStartTask) {
		this.sqmysbNotStartTask = sqmysbNotStartTask;
	}
	public int getSqmysbRunningTask() {
		return sqmysbRunningTask;
	}
	public void setSqmysbRunningTask(int sqmysbRunningTask) {
		this.sqmysbRunningTask = sqmysbRunningTask;
	}
	
}
