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

/**
 * 个人消息表
 * @author 陈睿超
 * @createTime 2019-05-06
 *
 */
@Entity
@Table(name ="T_PRIVATE_INFORMATION")
public class PrivateInformation extends BaseEntity{

	
	@Id
	@Column(name ="F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer ifID;//主键
	
	@Column(name ="F_TITLE")
	private String fTitle;//消息标题
	
	@Column(name ="F_MESSAGE")
	private String fMessage;//消息内容
	
	@Column(name ="F_INFO_ID")
	private Integer fInfo;//关联主键
	
	@Column(name ="F_INFO_CODE")
	private String fInfoCode;//关联编码
	
	@Column(name ="F_TYPE")
	private String fType;//消息操作类型0、删除1、待审批2、查看3、退回修改
	
	@Column(name ="F_URL1")
	private String fUrl1;//操作路径1(查看路径)
	
	@Column(name ="F_URL2")
	private String fUrl2;//操作路径2(修改路径)
	
	@Column(name ="F_URL3")
	private String fUrl3;//操作路径3()

	@Column(name ="F_SEND_USER_ID")
	private String fSendUserID;//发送人ID
	
	@Column(name ="F_SEND_USER")
	private String fSendUser;//发送人名称
	
	@Column(name ="F_SEND_TIME")
	private Date fSendTime;//发送时间
	
	@Column(name ="F_USER_ID")
	private String fUserID;//接受人id
	
	@Column(name ="F_STAUTS")
	private String fStauts;//消息装调99-删除1-正常
	
	@Column(name ="F_MESSAGE_STAUTS")
	private String fMessageStauts;//星标状态0-未收藏,1-已收藏
	
	@Column(name ="F_READ_STAUTS")
	private String fReadStauts;//查看状态0-未查看1-已查看
	
	@Column(name ="F_READING_TIME")
	private Date fReadingTime;//查看时间
	
	@Transient
	private String today;//消息推送列表用，判断是否是当天的0-不是当天。1-是当天
	
	@Transient
	private String recipient;//收件人，详情页显示使用

	@Transient
	private Integer number;//序号
	
	@Transient
	private String id;//因为基类有这个便于json转化用，无实际意义
	
	
	public Integer getIfID() {
		return ifID;
	}

	public void setIfID(Integer ifID) {
		this.ifID = ifID;
	}

	public String getfTitle() {
		return fTitle;
	}

	public void setfTitle(String fTitle) {
		this.fTitle = fTitle;
	}

	public String getfMessage() {
		return fMessage;
	}

	public void setfMessage(String fMessage) {
		this.fMessage = fMessage;
	}

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public String getfUrl1() {
		return fUrl1;
	}

	public void setfUrl1(String fUrl1) {
		this.fUrl1 = fUrl1;
	}

	public String getfUrl2() {
		return fUrl2;
	}

	public void setfUrl2(String fUrl2) {
		this.fUrl2 = fUrl2;
	}

	public String getfUrl3() {
		return fUrl3;
	}

	public void setfUrl3(String fUrl3) {
		this.fUrl3 = fUrl3;
	}

	public String getfUserID() {
		return fUserID;
	}

	public void setfUserID(String fUserID) {
		this.fUserID = fUserID;
	}

	public String getfMessageStauts() {
		return fMessageStauts;
	}

	public void setfMessageStauts(String fMessageStauts) {
		this.fMessageStauts = fMessageStauts;
	}

	public String getfReadStauts() {
		return fReadStauts;
	}

	public void setfReadStauts(String fReadStauts) {
		this.fReadStauts = fReadStauts;
	}

	public Date getfReadingTime() {
		return fReadingTime;
	}

	public void setfReadingTime(Date fReadingTime) {
		this.fReadingTime = fReadingTime;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Date getfSendTime() {
		return fSendTime;
	}

	public void setfSendTime(Date fSendTime) {
		this.fSendTime = fSendTime;
	}

	public String getfSendUserID() {
		return fSendUserID;
	}

	public void setfSendUserID(String fSendUserID) {
		this.fSendUserID = fSendUserID;
	}

	public String getfSendUser() {
		return fSendUser;
	}

	public void setfSendUser(String fSendUser) {
		this.fSendUser = fSendUser;
	}

	public Integer getfInfo() {
		return fInfo;
	}

	public void setfInfo(Integer fInfo) {
		this.fInfo = fInfo;
	}

	public String getfInfoCode() {
		return fInfoCode;
	}

	public void setfInfoCode(String fInfoCode) {
		this.fInfoCode = fInfoCode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getfStauts() {
		return fStauts;
	}

	public void setfStauts(String fStauts) {
		this.fStauts = fStauts;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	
}
