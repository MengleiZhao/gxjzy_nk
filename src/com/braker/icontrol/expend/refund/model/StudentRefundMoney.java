package com.braker.icontrol.expend.refund.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 学生退费明细表
 * @author 陈睿超
 * @createTime 2019-11-27
 */
@Entity
@Table(name = "T_STUDENT_REFUND_MONEY")
@JsonIgnoreProperties(ignoreUnknown = true)
public class StudentRefundMoney extends BaseEntity {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer fId;					//主键
	
	@Column(name = "F_R_ID")
	private Integer fRId;					//外键
	
	@Column(name = "F_STUDENT_NAME")
	private String studentName;				//学生姓名
	
	@Column(name = "F_ID_NUMBER")
	private String idNumber;				//学号
	
	@Column(name = "F_MONEY_CODE")
	private String moneyCode;				//收费单号
	
	@Column(name = "F_IDENTITY_ID")
	private String identityId;				//身份证号
	
	@Column(name = "F_REFUND_TUITION")
	private Double refundTuition;			//应退学费
	
	@Column(name = "F_REFUND_ROOM")
	private Double refundRoom;				//应退住宿费
	
	@Column(name = "F_SUM_MONEY")
	private Double sumMoney;				//应退合计金额
	
	@Column(name = "F_CLASS_TEACHER")
	private String classTeacher;			//班主任
	
	@Column(name = "F_STUDENT_COLLEGE")
	private String studentCollege;			//所属学院(陈睿超2020.11.30)
	
	@Column(name = "F_STUDENT_CLASS")
	private String studentClass;			//专业班级(陈睿超2020.11.30)
	
	@Column(name = "F_REFUND_REASON")
	private String refundReason;			//退费原因(陈睿超2020.11.30)
	
	@Column(name = "F_PAYED_TUITION")
	private Double payedTuition;			//已交学费(陈睿超2020.11.30)
	
	@Column(name = "F_PAYED_ROOM")
	private Double payedRoom;				//已交住宿费(陈睿超2020.11.30)
	
	@Column(name = "F_TEL")
	private String tel;						//联系电话(陈睿超2020.11.30)
	
	@Column(name = "F_FILE_FID")
	private String fileFid;					//附件ID(赵孟雷2020.12.05)
	
	@Transient
	private String chineseSumMoney;			//中文应退合计金额(陈睿超2020.12.03)
	
	@Transient
	private String chinesePayedSumMoney;	//中文已交合计金额(陈睿超2020.12.03)
	
	@Transient
	private Integer num;					//序号

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public Integer getfRId() {
		return fRId;
	}

	public void setfRId(Integer fRId) {
		this.fRId = fRId;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getMoneyCode() {
		return moneyCode;
	}

	public void setMoneyCode(String moneyCode) {
		this.moneyCode = moneyCode;
	}

	public String getIdentityId() {
		return identityId;
	}

	public void setIdentityId(String identityId) {
		this.identityId = identityId;
	}

	public Double getRefundTuition() {
		return refundTuition;
	}

	public void setRefundTuition(Double refundTuition) {
		this.refundTuition = refundTuition;
	}

	public Double getRefundRoom() {
		return refundRoom;
	}

	public void setRefundRoom(Double refundRoom) {
		this.refundRoom = refundRoom;
	}

	public Double getSumMoney() {
		return sumMoney;
	}

	public void setSumMoney(Double sumMoney) {
		this.sumMoney = sumMoney;
	}

	public String getClassTeacher() {
		return classTeacher;
	}

	public void setClassTeacher(String classTeacher) {
		this.classTeacher = classTeacher;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStudentCollege() {
		return studentCollege;
	}

	public void setStudentCollege(String studentCollege) {
		this.studentCollege = studentCollege;
	}

	public String getStudentClass() {
		return studentClass;
	}

	public void setStudentClass(String studentClass) {
		this.studentClass = studentClass;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public Double getPayedTuition() {
		return payedTuition;
	}

	public void setPayedTuition(Double payedTuition) {
		this.payedTuition = payedTuition;
	}

	public Double getPayedRoom() {
		return payedRoom;
	}

	public void setPayedRoom(Double payedRoom) {
		this.payedRoom = payedRoom;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getChineseSumMoney() {
		return chineseSumMoney;
	}

	public void setChineseSumMoney(String chineseSumMoney) {
		this.chineseSumMoney = chineseSumMoney;
	}

	public String getChinesePayedSumMoney() {
		return chinesePayedSumMoney;
	}

	public void setChinesePayedSumMoney(String chinesePayedSumMoney) {
		this.chinesePayedSumMoney = chinesePayedSumMoney;
	}

	public String getFileFid() {
		return fileFid;
	}

	public void setFileFid(String fileFid) {
		this.fileFid = fileFid;
	}


}
