package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;

/**
 * 支出申请单据附件的model
 * 是支出申请单据附件的model类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Entity
@Table(name = "T_APPLICTION_ATTAC")
public class ApplicationAttac extends BaseEntity{
	@Id
	@Column(name = "F_N_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer noticeAttacId;			//主键ID
	
	@Column(name = "F_G_ID")
	private Integer gId;					//支出申请ID
	
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

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
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

	@Override
	public String toString() {
		return "ApplicationAttac [noticeAttacId=" + noticeAttacId + ", gId="
				+ gId + ", attacName=" + attacName + ", attacType=" + attacType
				+ ", attacSrc=" + attacSrc + ", uploadTime=" + uploadTime + "]";
	}

	
	
	
	
	
}
