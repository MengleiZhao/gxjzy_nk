package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;


/**
 * 公告中心附件的model
 * 是公告附件的model类
 * @author 叶崇晖
 * @createtime 2018-06-7
 * @updatetime 2018-06-7
 */
@Entity
@Table(name = "T_NOTICE_ATTAC")
public class NoticeAttac extends BaseEntity {
	@Id
	@Column(name = "F_N_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer noticeAttacId;			//主键ID
	
	@Column(name = "F_NOTICE_ID")
	private String noticeId;				//公告ID
	
	@Column(name = "F_ATTAC_NAME")
	private String noticeAttacName;			//附件名称
	
	@Column(name = "F_FILE_SRC")
	private String noticeAttacSrc;			//存放路径
	
	@Column(name = "F_UPLOAD_TIME")
	private String noticeUploadTime;		//上传时间

	
	
	public Integer getNoticeAttacId() {
		return noticeAttacId;
	}

	public void setNoticeAttacId(Integer noticeAttacId) {
		this.noticeAttacId = noticeAttacId;
	}

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeAttacName() {
		return noticeAttacName;
	}

	public void setNoticeAttacName(String noticeAttacName) {
		this.noticeAttacName = noticeAttacName;
	}

	public String getNoticeAttacSrc() {
		return noticeAttacSrc;
	}

	public void setNoticeAttacSrc(String noticeAttacSrc) {
		this.noticeAttacSrc = noticeAttacSrc;
	}

	public String getNoticeUploadTime() {
		return noticeUploadTime;
	}

	public void setNoticeUploadTime(String noticeUploadTime) {
		this.noticeUploadTime = noticeUploadTime;
	}
	
}
