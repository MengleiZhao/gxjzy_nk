package com.braker.icontrol.cgmanage.cgexpert.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.core.model.Lookups;

/**
 *评标专家的实体类
 * @author 冉德茂
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */

@Entity
@Table(name="T_EXPERT_INFO")
public class ExpertInfo extends BaseEntity implements CheckEntity{ 
	
	@Id
	@Column(name = "F_E_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer feId;
	
	@Column(name = "F_E_CODE")
	private String fexpertCode;			//专家编号
	
	@Column(name = "F_E_NAME")
	private String fexpertName;			//专家姓名
	
	@Column(name = "F_E_SEX")
	private String fexpertSex;			//专家性别

	@Column(name = "F_ID_CARD")
	private String fidNumber;			//身份证号	
	
	@Column(name = "F_BIRTHDAY")
	private Date fbirthday;			//出生日期
		
	@Column(name = "F_HIGH_EDUCATION")
	private String feducation;			//最高学历
	
	@Column(name = "F_DEGREE")
	private String fdegree;			//所获学位
	
	@Column(name = "F_GRAD_TIME")
	private Date fgradTime;			//毕（肄）业时间
	
	@Column(name = "F_GRAD_SCHOOL")
	private String fgradSchool;			//毕（肄）业学校
	
	@Column(name = "F_START_WORK_TIME")
	private Date fstartWorkTime;			//参加工作时间

	@Column(name = "F_NOW_WORK")
	private String fnowWork;			//现从事专业
	
	@Column(name = "F_NOW_WORK_TIME")
	private String fjobTime;			//现从事专业工作年限
	
	@Column(name = "F_STUDY_MAJOR")
	private String fstudyMajor;			//所学专业
	
	@Column(name = "F_WORK_UNIT")
	private String fworkUnit;			//工作单位
	
	@Column(name = "F_IS_GPW")
	private String fisGpw;			//是否高评委建库单位人员
	
	@Column(name = "F_ADMIN_DUT")
	private String fadminDut;			//行政职务
	
	@Column(name = "F_CURRT_QUALIT")
	private String fcurrtQualit;			//现有任职资格
	
	@Column(name = "F_CURRT_QUALIT_LEV")
	private String fcurrtQualitLev;			//资格级别
	
	@Column(name = "F_GET_TIME")
	private Date fgetTime;			//取得时间
	
	@Column(name = "F_SERIES")
	private String fseries;			//所属系列
	
	@Column(name = "F_APPOIN_SITUATION")
	private String fappoinSituation;			//聘任情况
	
	@Column(name = "F_GPW_NAME")
	private String fgpwName;			//高评委名称
	
	@ManyToOne
	@JoinColumn(name = "F_GPW_POST",referencedColumnName="lookupscode")
	private Lookups fgpwPost;			//职务
	
	@Column(name = "F_GPW_POST_TIME")
	private Date fgpwPostTime;			//任职时间
	
	@ManyToOne
	@JoinColumn(name = "F_GPW_POST_2",referencedColumnName="lookupscode")
	private Lookups fgpwPost2;			//高评委职务
	
	@Column(name = "F_GROUP_NAME")
	private String fgroupName;			//专业（审议）组
	
	@Column(name = "F_ADDR")
	private String fhomeAddr;			//通讯地址
	
	@Column(name = "F_POST")
	private String fPost;			//邮政编码
	
	@Column(name = "F_M_TEL")
	private String fmTel;			//手机

	@Column(name = "F_TEL")
	private String ftel;			//办公室电话
	
	@Column(name = "F_H_TEL")
	private String fhTel;			//住宅电话
	
	@Column(name = "F_EAMIL")
	private String femail;			//电子邮箱
		
	@Column(name = "F_FIELD")
	private String ffield;			//业务领域

	@Column(name = "F_REMARK")
	private String fremark;			//备注
	
	@Column(name = "F_STAUTS")
	private String fstauts;			//数据状态  99：删除 ，1：默认，2：出库
	
	@Column(name = "F_CHECK_STAUTS")
	private String fcheckStauts;			//专家审批状态
	
	@Column(name = "F_USER_NAME2")
	private String userName2;			//下环节处理人姓名
	
	@Column(name = "F_USER_CODE")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_IS_BLACK")
	private String fisBlack;			//是否黑名单
	
	@Column(name ="F_EXT_2")
	private String fisBlackStatus;		//黑名单审批状态
	
	@Column(name = "F_BLACK_TIME")
	private Date fblackTime;			//移入黑名单时间
	
	@Column(name = "F_ACC_FREQ")
	private Integer faccFreq;			//累计移入黑名单次数
	
	@Column(name = "F_BLACK_DESC")
	private String fblackDesc;			//移入黑名单原因描述
	
	@Column(name = "F_OP_NAME")
	private String fopName;			//操作人
	
	@Column(name ="F_REC_USER")
	private String fRecUser;//申請人
	
	@Column(name ="F_EXT_1")
	private String fRecUserId;//申请人id
	
	@Column(name ="F_REC_DEPT")
	private String fRecDept;//申请部门
	
	@Column(name ="F_REC_DEPT_ID")
	private String fRecDeptId;//申请部门id
	
	@Column(name ="F_REQ_TIME")
	private Date fRecTime;//申请时间
	//-------------------
	@Column(name = "F_CHECK_TYPE")
	private String fcheckType;			//数据审批类型   in,入库；out：出库；black：黑名单
	
	@Column(name ="F_EXT_3")
	private String fisOutStatus;		//出库审批状态
	
	@Column(name ="F_OUT_TIME")
	private Date foutTime;		//出库时间
	
	@Column(name ="F_OUT_MSG")
	private String foutMsg;		//出库原因描述
	
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	public Integer getFeId() {
		return feId;
	}

	public void setFeId(Integer feId) {
		this.feId = feId;
	}

	public String getFexpertCode() {
		return fexpertCode;
	}

	public void setFexpertCode(String fexpertCode) {
		this.fexpertCode = fexpertCode;
	}

	public String getFexpertName() {
		return fexpertName;
	}

	public void setFexpertName(String fexpertName) {
		this.fexpertName = fexpertName;
	}

	public String getFexpertSex() {
		return fexpertSex;
	}

	public void setFexpertSex(String fexpertSex) {
		this.fexpertSex = fexpertSex;
	}

	public String getFidNumber() {
		return fidNumber;
	}

	public void setFidNumber(String fidNumber) {
		this.fidNumber = fidNumber;
	}



	public Date getFbirthday() {
		return fbirthday;
	}

	public void setFbirthday(Date fbirthday) {
		this.fbirthday = fbirthday;
	}

	public String getFeducation() {
		return feducation;
	}

	public void setFeducation(String feducation) {
		this.feducation = feducation;
	}

	public String getFdegree() {
		return fdegree;
	}

	public void setFdegree(String fdegree) {
		this.fdegree = fdegree;
	}

	public Date getFgradTime() {
		return fgradTime;
	}

	public void setFgradTime(Date fgradTime) {
		this.fgradTime = fgradTime;
	}

	public String getFgradSchool() {
		return fgradSchool;
	}

	public void setFgradSchool(String fgradSchool) {
		this.fgradSchool = fgradSchool;
	}

	public Date getFstartWorkTime() {
		return fstartWorkTime;
	}

	public void setFstartWorkTime(Date fstartWorkTime) {
		this.fstartWorkTime = fstartWorkTime;
	}

	public String getFnowWork() {
		return fnowWork;
	}

	public void setFnowWork(String fnowWork) {
		this.fnowWork = fnowWork;
	}

	public String getFjobTime() {
		return fjobTime;
	}

	public void setFjobTime(String fjobTime) {
		this.fjobTime = fjobTime;
	}

	public String getFstudyMajor() {
		return fstudyMajor;
	}

	public void setFstudyMajor(String fstudyMajor) {
		this.fstudyMajor = fstudyMajor;
	}

	public String getFworkUnit() {
		return fworkUnit;
	}

	public void setFworkUnit(String fworkUnit) {
		this.fworkUnit = fworkUnit;
	}

	public String getFisGpw() {
		return fisGpw;
	}

	public void setFisGpw(String fisGpw) {
		this.fisGpw = fisGpw;
	}

	public String getFadminDut() {
		return fadminDut;
	}

	public void setFadminDut(String fadminDut) {
		this.fadminDut = fadminDut;
	}

	public String getFcurrtQualit() {
		return fcurrtQualit;
	}

	public void setFcurrtQualit(String fcurrtQualit) {
		this.fcurrtQualit = fcurrtQualit;
	}

	public String getFcurrtQualitLev() {
		return fcurrtQualitLev;
	}

	public void setFcurrtQualitLev(String fcurrtQualitLev) {
		this.fcurrtQualitLev = fcurrtQualitLev;
	}

	public Date getFgetTime() {
		return fgetTime;
	}

	public void setFgetTime(Date fgetTime) {
		this.fgetTime = fgetTime;
	}

	public String getFseries() {
		return fseries;
	}

	public void setFseries(String fseries) {
		this.fseries = fseries;
	}

	public String getFappoinSituation() {
		return fappoinSituation;
	}

	public void setFappoinSituation(String fappoinSituation) {
		this.fappoinSituation = fappoinSituation;
	}

	public String getFgpwName() {
		return fgpwName;
	}

	public void setFgpwName(String fgpwName) {
		this.fgpwName = fgpwName;
	}

	public Lookups getFgpwPost() {
		return fgpwPost;
	}

	public void setFgpwPost(Lookups fgpwPost) {
		this.fgpwPost = fgpwPost;
	}

	public Date getFgpwPostTime() {
		return fgpwPostTime;
	}

	public void setFgpwPostTime(Date fgpwPostTime) {
		this.fgpwPostTime = fgpwPostTime;
	}

	public Lookups getFgpwPost2() {
		return fgpwPost2;
	}

	public void setFgpwPost2(Lookups fgpwPost2) {
		this.fgpwPost2 = fgpwPost2;
	}

	public String getFgroupName() {
		return fgroupName;
	}

	public void setFgroupName(String fgroupName) {
		this.fgroupName = fgroupName;
	}

	public String getFhomeAddr() {
		return fhomeAddr;
	}

	public void setFhomeAddr(String fhomeAddr) {
		this.fhomeAddr = fhomeAddr;
	}

	public String getfPost() {
		return fPost;
	}

	public void setfPost(String fPost) {
		this.fPost = fPost;
	}

	public String getFmTel() {
		return fmTel;
	}

	public void setFmTel(String fmTel) {
		this.fmTel = fmTel;
	}

	public String getFtel() {
		return ftel;
	}

	public void setFtel(String ftel) {
		this.ftel = ftel;
	}

	public String getFhTel() {
		return fhTel;
	}

	public void setFhTel(String fhTel) {
		this.fhTel = fhTel;
	}

	public String getFemail() {
		return femail;
	}

	public void setFemail(String femail) {
		this.femail = femail;
	}

	public String getFfield() {
		return ffield;
	}

	public void setFfield(String ffield) {
		this.ffield = ffield;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public String getFstauts() {
		return fstauts;
	}

	public void setFstauts(String fstauts) {
		this.fstauts = fstauts;
	}

	public String getFcheckStauts() {
		return fcheckStauts;
	}

	public void setFcheckStauts(String fcheckStauts) {
		this.fcheckStauts = fcheckStauts;
	}

	public String getUserName2() {
		return userName2;
	}

	public void setUserName2(String userName2) {
		this.userName2 = userName2;
	}

	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getnCode() {
		return nCode;
	}

	public void setnCode(String nCode) {
		this.nCode = nCode;
	}

	public String getFisBlack() {
		return fisBlack;
	}

	public void setFisBlack(String fisBlack) {
		this.fisBlack = fisBlack;
	}

	public Date getFblackTime() {
		return fblackTime;
	}

	public void setFblackTime(Date fblackTime) {
		this.fblackTime = fblackTime;
	}

	public Integer getFaccFreq() {
		return faccFreq;
	}

	public void setFaccFreq(Integer faccFreq) {
		this.faccFreq = faccFreq;
	}

	public String getFblackDesc() {
		return fblackDesc;
	}

	public void setFblackDesc(String fblackDesc) {
		this.fblackDesc = fblackDesc;
	}

	public String getFopName() {
		return fopName;
	}

	public void setFopName(String fopName) {
		this.fopName = fopName;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getfRecUser() {
		return fRecUser;
	}

	public void setfRecUser(String fRecUser) {
		this.fRecUser = fRecUser;
	}

	public String getfRecDept() {
		return fRecDept;
	}

	public void setfRecDept(String fRecDept) {
		this.fRecDept = fRecDept;
	}


	public String getfRecDeptId() {
		return fRecDeptId;
	}

	public void setfRecDeptId(String fRecDeptId) {
		this.fRecDeptId = fRecDeptId;
	}

	public Date getfRecTime() {
		return fRecTime;
	}

	public void setfRecTime(Date fRecTime) {
		this.fRecTime = fRecTime;
	}

	public String getfRecUserId() {
		return fRecUserId;
	}

	public void setfRecUserId(String fRecUserId) {
		this.fRecUserId = fRecUserId;
	}

	public String getFisBlackStatus() {
		return fisBlackStatus;
	}

	public void setFisBlackStatus(String fisBlackStatus) {
		this.fisBlackStatus = fisBlackStatus;
	}

	public String getFcheckType() {
		return fcheckType;
	}

	public void setFcheckType(String fcheckType) {
		this.fcheckType = fcheckType;
	}

	public String getFisOutStatus() {
		return fisOutStatus;
	}

	public void setFisOutStatus(String fisOutStatus) {
		this.fisOutStatus = fisOutStatus;
	}

	public Date getFoutTime() {
		return foutTime;
	}

	public void setFoutTime(Date foutTime) {
		this.foutTime = foutTime;
	}

	public String getFoutMsg() {
		return foutMsg;
	}

	public void setFoutMsg(String foutMsg) {
		this.foutMsg = foutMsg;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		// TODO Auto-generated method stub
		this.userName2=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		// TODO Auto-generated method stub
		this.fuserId=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fcheckStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fcheckStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fstauts=status;
	}
	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fexpertCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return feId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fRecUserId;
	}

	@Override
	public String getJoinTable() {
		return "T_EXPERT_INFO";
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_E_CODE";
	}

	@Override
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}

}
