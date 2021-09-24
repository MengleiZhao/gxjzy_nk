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
 * 预算自评附件表的model
 * @author 冉德茂
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Entity
@Table(name = "T_BUDGET_RESULT_ATTAC")
public class BudgetResultAttac extends BaseEntity{
	@Id
	@Column(name = "F_ATT_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer noticeAttacId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;					//预算表的ID
	
	@Column(name = "F_ATTAC_NAME")
	private String attacName;				//附件名称
	
	@Column(name = "F_ATTAC_TYPE")
	private String attacType;				//附件类别
	
	@Column(name = "F_FILE_SRC")
	private String attacSrc;				//存放路径
	
	@Column(name = "F_EVAL_USER")
	private String fevalUser;				//自评负责人
	
	@Column(name = "F_EVAL_METHOD")
	private String fevalMethod;				//自评方式
	
	@Column(name = "F_UPLOAD_TIME")
	private Date uploadTime;				//上传时间

	
	
	public String getFevalUser() {
		return fevalUser;
	}

	public void setFevalUser(String fevalUser) {
		this.fevalUser = fevalUser;
	}

	public String getFevalMethod() {
		return fevalMethod;
	}

	public void setFevalMethod(String fevalMethod) {
		this.fevalMethod = fevalMethod;
	}

	public Integer getNoticeAttacId() {
		return noticeAttacId;
	}

	public void setNoticeAttacId(Integer noticeAttacId) {
		this.noticeAttacId = noticeAttacId;
	}



	public Integer getFproId() {
		return fproId;
	}

	public void setFproId(Integer fproId) {
		this.fproId = fproId;
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
