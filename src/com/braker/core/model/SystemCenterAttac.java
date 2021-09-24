package com.braker.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;


/**
 * 制度中心的model
 * 是制度model类
 * @author 叶崇晖
 * @createtime 2018-07-04
 * @updatetime 2018-07-04
 */
@Entity
@Table(name = "T_SYSTEM_CENTER_ATTAC")
public class SystemCenterAttac extends BaseEntity {
	@Id
	@Column(name = "F_N_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer naId;			//主键ID
	
	@Column(name = "F_SYSTEM_ID")
	private Integer systemId;		//外键
	
	@Column(name = "F_ATTAC_NAME")
	private String attacName;		//附件名称
	
	@Column(name = "F_ATTAC_TYPE")
	private String attacType;		//附件类别
	
	@Column(name = "F_FILE_SRC")
	private String fileSrc;			//存放路径
	
	@Column(name = "F_UPLOAD_TIME")
	private Date uploadTime;		//上传时间

	public Integer getNaId() {
		return naId;
	}

	public void setNaId(Integer naId) {
		this.naId = naId;
	}

	public Integer getSystemId() {
		return systemId;
	}

	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}

	public String getAttacName() {
		return attacName;
	}

	public void setAttacName(String attacName) {
		this.attacName = attacName;
	}

	public String getAttacType() {
		return attacType;
	}

	public void setAttacType(String attacType) {
		this.attacType = attacType;
	}

	public String getFileSrc() {
		return fileSrc;
	}

	public void setFileSrc(String fileSrc) {
		this.fileSrc = fileSrc;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	
	
}
