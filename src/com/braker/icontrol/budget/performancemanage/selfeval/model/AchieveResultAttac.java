package com.braker.icontrol.budget.performancemanage.selfeval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 绩效自评附件表的model
 * @author 冉德茂
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Entity
@Table(name = "T_ACHIEVE_RESULT_ATTAC")
public class AchieveResultAttac extends BaseEntity{
	@Id
	@Column(name = "F_ATT_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer noticeAttacId;			//主键ID
	
	@Column(name = "F_A_ID")
	private Integer aId;					//绩效自评的id
	
	@Column(name = "F_ATTAC_NAME")
	private String attacName;				//附件名称
	
	@Column(name = "F_ATTAC_TYPE")
	private String attacType;				//附件类别
	
	@Column(name = "F_FILE_SRC")
	private String attacSrc;				//存放路径
	
	@Column(name = "F_UPLOAD_TIME")
	private Date uploadTime;				//上传时间

	public Integer getNoticeAttacId() {
		return noticeAttacId;
	}

	public void setNoticeAttacId(Integer noticeAttacId) {
		this.noticeAttacId = noticeAttacId;
	}



	public Integer getaId() {
		return aId;
	}

	public void setaId(Integer aId) {
		this.aId = aId;
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

	public String getAttacSrc() {
		return attacSrc;
	}

	public void setAttacSrc(String attacSrc) {
		this.attacSrc = attacSrc;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	
	
	
	
}
