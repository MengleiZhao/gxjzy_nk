package com.braker.quartz.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
 
 
@Entity
@Table(name="t_wsdoc")
public class Wsdoc extends BaseEntity {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private String id;
	
	@Column(name = "TRIGGER_NAME")
	private String triggername;  //这个不用填写，根据uuid自动生成
	@Column(name = "CRONEX_PRESSION")
	private String cronexpression;//必填   这个要写表达式，不要出现空格
	@Column(name = "JOB_DETAIL_NAME")
	private String jobdetailname;//必填   这个就写任务名字
	@Column(name = "TARGET_OBJECT")
	private String targetobject;//必填    任务对应的类的全路径
	@Column(name = "METHOND_NAME")
	private String methodname; //必填  类名对应的方法名
	@Column(name = "CONCURRENT")
	private String concurrent;//设置是否并发启动任务 0是false 非0是true
	
	@Column(name = "STATE")
	private String state;// 如果计划任务不存则为1 存在则为0
	
	@Column(name = "README")
	private String readme;//任务描述
	
	@Column(name = "ARGUMENTS")
	private String arguments;//动态传参数
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTriggername() {
		return triggername;
	}
	public void setTriggername(String triggername) {
		this.triggername = triggername;
	}
	public String getCronexpression() {
		return cronexpression;
	}
	public void setCronexpression(String cronexpression) {
		this.cronexpression = cronexpression;
	}
	public String getJobdetailname() {
		return jobdetailname;
	}
	public void setJobdetailname(String jobdetailname) {
		this.jobdetailname = jobdetailname;
	}
	public String getTargetobject() {
		return targetobject;
	}
	public void setTargetobject(String targetobject) {
		this.targetobject = targetobject;
	}
	public String getMethodname() {
		return methodname;
	}
	public void setMethodname(String methodname) {
		this.methodname = methodname;
	}
	public String getConcurrent() {
		return concurrent;
	}
	public void setConcurrent(String concurrent) {
		this.concurrent = concurrent;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReadme() {
		return readme;
	}
	public void setReadme(String readme) {
		this.readme = readme;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getArguments() {
		return arguments;
	}
	public void setArguments(String arguments) {
		this.arguments = arguments;
	}


}

