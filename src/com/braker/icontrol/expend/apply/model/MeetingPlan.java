package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;


/**
 * 会议日程实体类
 * @author 张迅
 * @createtime 2020-01-17
 */
@Entity
@Table(name = "T_MEETING_PLAN")
public class MeetingPlan extends BaseEntity{
	@Id
	@Column(name = "PLAN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer planId;				//主键ID

	@Column(name = "F_G_ID")
	private Integer gId;				//事前申请信息ID
	
	@Column(name = "F_R_ID")
	private Integer rId;				//报销信息ID
	
	@Column(name = "F_MEET_ID")
	private Integer meetId;				//会议信息ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name = "F_START_TIME")
	private Date times;				//起始时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	@Column(name = "F_END_TIME")
	private Date timee;				//结束时间
	
	@Column(name = "F_CONTENT")
	private String content;				//事项安排


	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getPlanId() {
		return planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public Integer getMeetId() {
		return meetId;
	}

	public void setMeetId(Integer meetId) {
		this.meetId = meetId;
	}

	public Date getTimes() {
		return times;
	}

	public void setTimes(Date times) {
		this.times = times;
	}

	public Date getTimee() {
		return timee;
	}

	public void setTimee(Date timee) {
		this.timee = timee;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	

	
	
	
}
