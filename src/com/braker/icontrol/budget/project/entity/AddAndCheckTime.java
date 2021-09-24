/**
 * <p>Title: AddAndCheckTime.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年9月26日
 */
package com.braker.icontrol.budget.project.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/** 
 * <p>Title: AddAndCheckTime</p>  
 * <p>Description: 预算设置申报审批节点时间表</p>  
 * @author 陈睿超
 * @date 2020年9月26日  
 */
@Entity
@Table(name ="T_ADDANDCHECKTIME")
public class AddAndCheckTime extends BaseEntity{

	@Id
	@Column(name ="F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fid; 
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_ADD_STARTTIME")
	private Date addStartTime;//新增开始时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_ADD_ENDTIME")
	private Date addEndTime;//新增结束时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_CHECK_STARTTIME")
	private Date checkStartTime;//审批开始时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_CHECK_ENDTIME")
	private Date checkEndTime;//审批结束时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_UPDATE_STARTTIME")
	private Date updateStartTime;//修改开始时间
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm",timezone = "GMT+8")
	@Column(name ="F_UPDATE_ENDTIME")
	private Date updateEndTime;//修改结束时间
	
	@Column(name ="F_DATA_TYPE")
	private Integer fDataType;//数据阶段1-一上,2-二上

	
	
	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public Date getAddStartTime() {
		return addStartTime;
	}

	public void setAddStartTime(Date addStartTime) {
		this.addStartTime = addStartTime;
	}

	public Date getAddEndTime() {
		return addEndTime;
	}

	public void setAddEndTime(Date addEndTime) {
		this.addEndTime = addEndTime;
	}

	public Date getCheckStartTime() {
		return checkStartTime;
	}

	public void setCheckStartTime(Date checkStartTime) {
		this.checkStartTime = checkStartTime;
	}

	public Date getCheckEndTime() {
		return checkEndTime;
	}

	public void setCheckEndTime(Date checkEndTime) {
		this.checkEndTime = checkEndTime;
	}

	public Date getUpdateStartTime() {
		return updateStartTime;
	}

	public void setUpdateStartTime(Date updateStartTime) {
		this.updateStartTime = updateStartTime;
	}

	public Date getUpdateEndTime() {
		return updateEndTime;
	}

	public void setUpdateEndTime(Date updateEndTime) {
		this.updateEndTime = updateEndTime;
	}

	public Integer getfDataType() {
		return fDataType;
	}

	public void setfDataType(Integer fDataType) {
		this.fDataType = fDataType;
	}
	
	
	
	
	
}
