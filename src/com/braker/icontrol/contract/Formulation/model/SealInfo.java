package com.braker.icontrol.contract.Formulation.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;

/**
 * 
 * @ClassName SealInfo.java
 * @Description 盖章基本信息 
 * @author 汪耀
 * @Date 2020年2月27日
 *
 */
@Entity
@Table(name = "T_CONTRACT_SEAL_INFO")
public class SealInfo extends BaseEntity implements EntityDao{
	/**
	 * 基本信息
	 */
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "F_SEAL_ID")
	private Integer fsId;					//盖章主键
	
	@Column(name = "F_SEAL_CODE")
	private String fsCode;					//盖章编号
	
	@Column(name = "F_CONT_ID")
	private Integer fcId;					//合同基本信息外键
	
	@Column(name = "F_APP_USER_ID")
	private String fappUserId;				//盖章人id
	
	@Column(name = "F_APP_USER_NAME")
	private String fappUserName;			//盖章人
	
	@Column(name = "F_APP_TIME")
	private Date fappTime;					//盖章时间
	
	@Column(name = "F_SEAL_NAME")
	private String fsealName;				//印鉴名称
	
	@Column(name = "F_REMARK")
	private String fremark;					//备注
	
	/**
	 * 属性及状态
	 */
	@Column(name = "F_SEAL_TYPE")
	private String fsealType;				//印鉴类型	1-公章
	
	@Column(name = "F_STATUS")
	private String fstatus;					//数据状态	0-未存		1-已存		99-删除
	
	
	@Transient
	private Date fSignTime;
	
	public Integer getFsId() {
		return fsId;
	}

	public void setFsId(Integer fsId) {
		this.fsId = fsId;
	}

	public String getFsCode() {
		return fsCode;
	}

	public void setFsCode(String fsCode) {
		this.fsCode = fsCode;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public String getFappUserId() {
		return fappUserId;
	}

	public void setFappUserId(String fappUserId) {
		this.fappUserId = fappUserId;
	}

	public String getFappUserName() {
		return fappUserName;
	}

	public void setFappUserName(String fappUserName) {
		this.fappUserName = fappUserName;
	}

	public Date getFappTime() {
		return fappTime;
	}

	public void setFappTime(Date fappTime) {
		this.fappTime = fappTime;
	}

	public String getFsealName() {
		return fsealName;
	}

	public void setFsealName(String fsealName) {
		this.fsealName = fsealName;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public String getFsealType() {
		return fsealType;
	}

	public void setFsealType(String fsealType) {
		this.fsealType = fsealType;
	}

	public String getFstatus() {
		return fstatus;
	}

	public void setFstatus(String fstatus) {
		this.fstatus = fstatus;
	}

	public Date getfSignTime() {
		return fSignTime;
	}

	public void setfSignTime(Date fSignTime) {
		this.fSignTime = fSignTime;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_CONTRACT_SEAL_INFO";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fsId);
	}

}
