package com.braker.icontrol.expend.apply.model;

import java.sql.Time;
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
 * 培训日程model
 * @author 张迅
 * @createtime 2020-02-13
 */
@Entity
@Table(name = "t_meet_plan")
public class MeetPlan extends BaseEntity{
	@Id
	@Column(name = "F_P_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer planId;				//主键ID
	
	@Column(name = "F_J_ID")
	private Integer tId;				//培训信息ID
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	@Column(name = "F_TIME_START")
	private Date timeStart;				//起始日期     用作培训日期
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name = "F_TIME_END")
	private Date timeEnd;				//结束日期
	
	@Column(name = "F_ARRANGE")
	private String arrange;				//事项安排
	
	@Column(name = "F_LESSON_TIME")
	private String lessonTime;				//学时
	
	@Column(name = "F_LECTURER_NAME")
	private String lecturerName;				//讲师姓名
	
	@Column(name = "F_LECTURER_NUMBER")
	private String lecturerNumber;				//讲师编号或者是身份证号
	
	@Column(name = "F_START_HOUR_MINUTE")
	private String startHourMinute;				//培训开始时分
	
	@Column(name = "F_END_HOUR_MINUTE")
	private String endHourMinute;				//培训结束时分
	
	
	@Transient
	private String status;				//状态值easyui插件中带的，装换json时用(数据库中没有)

	public String getLecturerNumber() {
		return lecturerNumber;
	}

	public void setLecturerNumber(String lecturerNumber) {
		this.lecturerNumber = lecturerNumber;
	}

	public Integer getPlanId() {
		return planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public String getStartHourMinute() {
		return startHourMinute;
	}

	public void setStartHourMinute(String startHourMinute) {
		this.startHourMinute = startHourMinute;
	}

	public String getEndHourMinute() {
		return endHourMinute;
	}

	public void setEndHourMinute(String endHourMinute) {
		this.endHourMinute = endHourMinute;
	}

	public Integer gettId() {
		return tId;
	}

	public void settId(Integer tId) {
		this.tId = tId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(Date timeStart) {
		this.timeStart = timeStart;
	}

	public Date getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(Date timeEnd) {
		this.timeEnd = timeEnd;
	}

	public String getArrange() {
		return arrange;
	}

	public void setArrange(String arrange) {
		this.arrange = arrange;
	}

	public String getLessonTime() {
		return lessonTime;
	}

	public void setLessonTime(String lessonTime) {
		this.lessonTime = lessonTime;
	}

	public String getLecturerName() {
		return lecturerName;
	}

	public void setLecturerName(String lecturerName) {
		this.lecturerName = lecturerName;
	}
	
	
}
