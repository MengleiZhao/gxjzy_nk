package com.braker.icontrol.budget.arrange.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 单位预算指标下达情况表
 * @author zhangxun
 */
@Entity
@Table(name = "T_DEPT_INDIC_INFO")
public class DepartIndexInfo extends BaseEntityEmpty implements java.io.Serializable  {

	private Integer pid;	//主键
	private String year;	//年度
	private String status;	//下达状态 0-未下达 1-正在下达 2-已下达
	private Double process;	//下达进度
	private Double amount;	//批复总额
	private int pageOrder;	//序号
	
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "PID", unique = true, nullable = false)
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	@Column(name = "F_YEAR")
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	@Column(name = "F_STATUS")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name = "F_PROCESS")
	public double getProcess() {
		return process;
	}
	public void setProcess(double process) {
		this.process = process;
	}
	@Column(name = "F_AMOUNT")
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	@Transient
	public int getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}
	
	
	
}
