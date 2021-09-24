package com.braker.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;
import com.braker.zzww.comm.entity.Attachment;


/**
 * 制度中心基本信息model
 * 是制度中心基本信息的model类
 * @author 叶崇晖
 * @createtime 2018-07-04
 * @updatetime 2018-07-04
 */
@Entity
@Table(name = "T_SYSTEM_CENTER_INFO")
public class CheterInfo extends BaseEntity implements EntityDao{
	@Id
	@Column(name = "F_SYSTEM_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer systemId;			//主键ID
	
	@Column(name = "F_FILE_NAME")
	private String fileName;			//文件名称
	
	@Column(name = "F_FILE_SIZE")
	private String fileSize;			//文件大小
	
	@Column(name = "F_BELONG")
	private String belong;				//归属类型
	
	@Column(name = "F_RELEASE_TIME")
	private Date releseTime;			//上传时间
	
	@Column(name = "F_RELEASE_USER")
	private String releseUser;			//上传人
	
	@Column(name = "F_HELP_NUM")
	private String helpNum;				//文档编码
	
	@Column(name = "F_STAUTS")
	private String fstauts;			//数据删除状态
	
	@Column(name = "F_CLICK_NUM")
	private Integer clickNum;		//制度点击次数  叶添加
	
	@OneToOne
	@JoinColumn(name = "ATTACHMENT_ID")
	private Attachment attachment;
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private long discrepancyTime;

	
	public long getDiscrepancyTime() {
		return discrepancyTime;
	}

	public void setDiscrepancyTime(long discrepancyTime) {
		this.discrepancyTime = discrepancyTime;
	}

	public String getFstauts() {
		return fstauts;
	}

	public void setFstauts(String fstauts) {
		this.fstauts = fstauts;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getSystemId() {
		return systemId;
	}

	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getBelong() {
		return belong;
	}

	public void setBelong(String belong) {
		this.belong = belong;
	}

	public Date getReleseTime() {
		return releseTime;
	}

	public void setReleseTime(Date releseTime) {
		this.releseTime = releseTime;
	}

	public String getReleseUser() {
		return releseUser;
	}

	public void setReleseUser(String releseUser) {
		this.releseUser = releseUser;
	}

	public String getHelpNum() {
		return helpNum;
	}

	public void setHelpNum(String helpNum) {
		this.helpNum = helpNum;
	}

	public Integer getClickNum() {
		return clickNum;
	}

	public void setClickNum(Integer clickNum) {
		this.clickNum = clickNum;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_SYSTEM_CENTER_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return systemId.toString();
	}

	public Attachment getAttachment() {
		return attachment;
	}

	public void setAttachment(Attachment attachment) {
		this.attachment = attachment;
	}
	
	
}
