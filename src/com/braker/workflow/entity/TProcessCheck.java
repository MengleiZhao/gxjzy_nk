package com.braker.workflow.entity;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.EntityDao;

/**
 * 流程审批表
 * @author 安达
 */
@Entity
@Table(name = "T_PROCESS_CHECK")
public class TProcessCheck implements java.io.Serializable ,EntityDao{

	
	@Id
	@Column(name = "F_P_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer FpcId;
	
	@Column(name ="F_P_ID")	
	private Integer FPId;//流程定义id
	
	
	@Column(name ="F_O_CODE")
	private String  foCode; //被审批的对象编码
	
	@Column(name = "F_BY_USER_ID")
	private String fbyUserId;			//被审批人id
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//审批人ID
	
	@Column(name = "F_USER_NAME")
	private String fuserName;		//审批人名字
	
	@Column(name = "F_ROLE_NAME")
	private String froleName;		//审批人岗位
	
	@Column(name = "F_ROLE_ID")
	private String froleId;		//审批人岗位编号
		
	@Column(name = "F_LEVEL")
	private String flevel;			//审批级别
	
	@Column(name = "F_RESULT")
	private String fcheckResult;		//审批结果  1通过   0不通过
	
	@Column(name = "F_CHECK_TIME")
	private Date fcheckTime;			//审批时间
	
	@Column(name = "F_REMARK")
	private String fcheckRemake;		//审批内容
	
	@Column(name = "NODE_KEY")
	private String nodeKey;				//审批节点key
	
	@Column(name = "F_STAUTS")
	private String stauts;				//审批信息状态 1:历史记录；0:默认

	@Column(name ="F_FILEPID")
	private String filesPid;            //附件主键ID
	
	@Column(name = "F_OVER_FLAG")
	private Integer overFlag;				//审批结束状态，  0未结束。  1已经结束

	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String FProName;		//项目名称(数据库中没有)
	
	@Transient
	private String FProOrBasic;		//支出类型(数据库中没有)
	
	@Transient
	private String FProCode;		//项目编号(数据库中没有)
	
	@Transient
	private String FProHead;		//项目负责人(数据库中没有)
	
	@Transient
	private Date FProAppliTime;		//申报时间(数据库中没有)
	
	@Transient
	private String checkDeptName;		//审批人所在部门(数据库中没有)
	
	@Transient
	private String checkDeptId;		//审批人所在部门Id(数据库中没有)
	
	@Transient
	private String fcheckTimes;		//审批时间(数据库中没有)   显示年月日
	
	@Transient
	private Integer FProID;		//项目ID(数据库中没有)
	
	public String getCheckDeptId() {
		return checkDeptId;
	}

	public void setCheckDeptId(String checkDeptId) {
		this.checkDeptId = checkDeptId;
	}

	public String getFcheckTimes() {
		return fcheckTimes;
	}

	public void setFcheckTimes(String fcheckTimes) {
		this.fcheckTimes = fcheckTimes;
	}

	public String getCheckDeptName() {
		return checkDeptName;
	}

	public void setCheckDeptName(String checkDeptName) {
		this.checkDeptName = checkDeptName;
	}

	public String getFProOrBasic() {
		return FProOrBasic;
	}

	public void setFProOrBasic(String fProOrBasic) {
		FProOrBasic = fProOrBasic;
	}

	public String getFProHead() {
		return FProHead;
	}

	public void setFProHead(String fProHead) {
		FProHead = fProHead;
	}

	public Date getFProAppliTime() {
		return FProAppliTime;
	}

	public void setFProAppliTime(Date fProAppliTime) {
		FProAppliTime = fProAppliTime;
	}

	public String getFProName() {
		return FProName;
	}

	public void setFProName(String fProName) {
		FProName = fProName;
	}

	public String getFProCode() {
		return FProCode;
	}

	public void setFProCode(String fProCode) {
		FProCode = fProCode;
	}

	public Integer getOverFlag() {
		return overFlag;
	}

	public void setOverFlag(Integer overFlag) {
		this.overFlag = overFlag;
	}

	public String getFroleId() {
		return froleId;
	}

	public void setFroleId(String froleId) {
		this.froleId = froleId;
	}

	public Integer getFpcId() {
		return FpcId;
	}

	public void setFpcId(Integer fpcId) {
		FpcId = fpcId;
	}

	public Integer getFPId() {
		return FPId;
	}

	public void setFPId(Integer fPId) {
		FPId = fPId;
	}


	public String getFuserId() {
		return fuserId;
	}

	public void setFuserId(String fuserId) {
		this.fuserId = fuserId;
	}

	public String getFuserName() {
		return fuserName;
	}

	public void setFuserName(String fuserName) {
		this.fuserName = fuserName;
	}

	public String getFroleName() {
		return froleName;
	}

	public void setFroleName(String froleName) {
		this.froleName = froleName;
	}

	public String getFlevel() {
		return flevel;
	}

	public void setFlevel(String flevel) {
		this.flevel = flevel;
	}

	public String getFcheckResult() {
		return fcheckResult;
	}

	public void setFcheckResult(String fcheckResult) {
		this.fcheckResult = fcheckResult;
	}

	public Date getFcheckTime() {
		return fcheckTime;
	}

	public void setFcheckTime(Date fcheckTime) {
		this.fcheckTime = fcheckTime;
	}

	public String getFcheckRemake() {
		return fcheckRemake;
	}

	public void setFcheckRemake(String fcheckRemake) {
		this.fcheckRemake = fcheckRemake;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getFilesPid() {
		return filesPid;
	}

	public void setFilesPid(String filesPid) {
		this.filesPid = filesPid;
	}

	public String getFbyUserId() {
		return fbyUserId;
	}

	public void setFbyUserId(String fbyUserId) {
		this.fbyUserId = fbyUserId;
	}

	public String getFoCode() {
		return foCode;
	}

	public void setFoCode(String foCode) {
		this.foCode = foCode;
	}

	public Integer getFProID() {
		return FProID;
	}

	public void setFProID(Integer fProID) {
		FProID = fProID;
	}

	public TProcessCheck(Integer fpcId, Integer fPId, String foCode,
			String fuserId, String fuserName, String froleName, String flevel,
			String fcheckResult, Date fcheckTime, String fcheckRemake,
			String stauts, Integer num) {
		super();
		FpcId = fpcId;
		FPId = fPId;
		this.foCode = foCode;
		this.fuserId = fuserId;
		this.fuserName = fuserName;
		this.froleName = froleName;
		this.flevel = flevel;
		this.fcheckResult = fcheckResult;
		this.fcheckTime = fcheckTime;
		this.fcheckRemake = fcheckRemake;
		this.stauts = stauts;
		this.num = num;
	}
  public TProcessCheck(){}
  
  public TProcessCheck(String fcheckResult, String fcheckRemake){
	  this.fcheckResult = fcheckResult;
	  this.fcheckRemake = fcheckRemake;
  }

  
  
public String getNodeKey() {
	return nodeKey;
}

public void setNodeKey(String nodeKey) {
	this.nodeKey = nodeKey;
}

@Transient
@Override
public String getJoinTable() {
	return "T_PROCESS_CHECK";
}

@Transient
@Override
public String getEntryId() {
	return String.valueOf(FpcId);
}
}