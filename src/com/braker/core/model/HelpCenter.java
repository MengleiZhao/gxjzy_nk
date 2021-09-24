package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

/**
 * 帮助中心的model
 * 是帮助的model类
 * @author 叶崇晖
 * @createtime 2018-06-11
 * @updatetime 2018-06-11
 */
@Entity
@Table(name = "T_HELP_CENTER_INFO")
public class HelpCenter extends BaseEntity{
	@Id
	@Column(name = "F_HELP_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer helpId;			//主键ID
	
	@Column(name = "F_FILE_NAME")
	private String helpName;		//文件名称
	
	@Column(name = "F_FILE_SIZE")
	private String helpSize;		//文件大小
	
	@Column(name = "F_RELEASE_TIME")
	private String releaseTime;		//上传时间
	
	@Column(name = "F_RELEASE_USER")
	private String releaseUser;		//上传人
	
	@Column(name = "F_HELP_NUM")
	private Double helpNum;			//排序号
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	
	public Integer getHelpId() {
		return helpId;
	}

	public void setHelpId(Integer helpId) {
		this.helpId = helpId;
	}

	public String getHelpName() {
		return helpName;
	}

	public void setHelpName(String helpName) {
		this.helpName = helpName;
	}

	public String getHelpSize() {
		return helpSize;
	}

	public void setHelpSize(String helpSize) {
		this.helpSize = helpSize;
	}

	public String getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}

	public String getReleaseUser() {
		return releaseUser;
	}

	public void setReleaseUser(String releaseUser) {
		this.releaseUser = releaseUser;
	}

	public Double getHelpNum() {
		return helpNum;
	}

	public void setHelpNum(Double helpNum) {
		this.helpNum = helpNum;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	
	
	
}
