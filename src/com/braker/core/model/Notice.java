package com.braker.core.model;

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
 * 公告中心的model
 * 是公告的model类
 * @author 叶崇晖
 * @createtime 2018-06-6
 * @updatetime 2018-06-6
 */
@Entity
@Table(name = "T_NOTICE_INFO")
public class Notice extends BaseEntity implements EntityDao{
	@Id
	@Column(name = "F_NOTICE_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer noticeId;			//主键ID
	
	@Column(name = "F_NOTICE_TITLE")
	private String noticeTitle;			//公告标题
	
	@Column(name = "F_NOTICE_SUBTITLE")
	private String noticeSubtitle;		//公告副标题
	
	@Column(name = "F_RELEASE_TIME")
	private Date releaseTime;			//发布时间
	
	@Column(name = "F_RELEASE_USER")
	private String releaseUser;			//发布人
	
	@Column(name = "F_NOTIC_NUM")
	private Double noticeNum;			//排序号
	
	@Column(name = "F_CONTENT")
	private String content;				//内容
	
	@Transient
	private Integer num;				//序号(数据库中没有)
	
	@Column(name = "F_STICK")
	private Integer stick;				//是否置顶(数据库中没有)
	
	@Column(name = "F_NOTICE_STATUS")
	private Integer fNoticeStatus;				//状态  1  保存   2  发布  3删除
	
	@Transient
	private String releaseDates;
	
	@Transient
	private String releaseDatee;
	
	@Transient
	private long discrepancyTime;

	
	public Integer getfNoticeStatus() {
		return fNoticeStatus;
	}

	public void setfNoticeStatus(Integer fNoticeStatus) {
		this.fNoticeStatus = fNoticeStatus;
	}

	public long getDiscrepancyTime() {
		return discrepancyTime;
	}

	public void setDiscrepancyTime(long discrepancyTime) {
		this.discrepancyTime = discrepancyTime;
	}

	public Integer getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(Integer noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeSubtitle() {
		return noticeSubtitle;
	}

	public void setNoticeSubtitle(String noticeSubtitle) {
		this.noticeSubtitle = noticeSubtitle;
	}

	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}

	public String getReleaseUser() {
		return releaseUser;
	}

	public void setReleaseUser(String releaseUser) {
		this.releaseUser = releaseUser;
	}

	public Double getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(Double noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getStick() {
		return stick;
	}

	public void setStick(Integer stick) {
		this.stick = stick;
	}

	public String getReleaseDates() {
		return releaseDates;
	}

	public void setReleaseDates(String releaseDates) {
		this.releaseDates = releaseDates;
	}

	public String getReleaseDatee() {
		return releaseDatee;
	}

	public void setReleaseDatee(String releaseDatee) {
		this.releaseDatee = releaseDatee;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_NOTICE_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return noticeId.toString();
	}
	
	

}
