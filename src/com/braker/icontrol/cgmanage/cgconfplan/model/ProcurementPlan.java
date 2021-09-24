package com.braker.icontrol.cgmanage.cgconfplan.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;

/**
 * 采购计划配置管理的model
 * @author 冉德茂
 * @createtime 2018-10-11
 * @upadteName 陈睿超
 * @updatetime 2019-12-03
 */
@Entity
@Table(name="T_PROCUREMENT_PLAN")
public class ProcurementPlan extends BaseEntity  implements EntityDao,CheckEntity{
	
	/**
	 * 采购计划基本信息
	 */
	@Id
	@Column(name = "F_PL_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   
	private Integer fplId;							//主键ID	
	
	@Column(name = "F_LIST_NUM")
	private String flistNum;						//采购计划编号
	
	@Column(name = "F_REQ_USER_ID")
	private String freqUserId;						//申请人id
	
	@Column(name = "F_REQ_LINK_MEN")
	private String freqLinkMen;						//联系人
	
	@Column(name = "F_LINK_TEL")
	private String flinkTel;						//联系电话
	
	@Column(name = "F_REQ_DEPT_ID")
	private String freqDeptId;						//申请部门id
	
	@Column(name = "F_REQ_DEPT")
	private String freqDept;						//申请部门
	
	@Column(name = "F_REQ_TIME")
	private Date freqTime;							//申请日期
	
	@Column(name = "F_REQ_CONTENT")
	private String freqContent;						//申请内容
	
	@Column(name = "F_REMARK")
	private String fremark;							//备注
	
	@Column(name = "F_USER_NAME2")
	private String userName2;						//下环节处理人姓名
	
	@Column(name = "F_USER_CODE")
	private String fuserId;							//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;							//下节点节点编码
	
	@Column(name = "F_BRAND_MODEL")
	private String fbrandModel;						//品牌和规格(暂时不用)
	
	@Column(name = "F_BRAND_NUM")
	private String fbrandAndNum;					//品牌和数量(暂时不用)
	
	
	
	/**
	 *	项目支出明细
	 */
	@Column(name = "F_EXP_ID")
	private Integer pid;							//项目支出明细表的主键
	
	@Column(name = "F_EXP_CODE", length = 32)
	private String expCode;							//项目支出明细编码

	@Column(name = "F_SUB_COED")
	private String subCode;							//科目编码
	
	@Column(name = "F_SUB_NAME")
	private String subName;							//科目名称

	@Column(name = "F_OUT_AMOUNT")
	private Double outAmount;						//项目支出明细金额
	
	
	
	/**
	 * 指标明细
	 */
	@Column(name = "F_INDEX_ID")
	private Integer indexId;						//预算指标id
	
	@Column(name = "F_INDEX_CODE")
	private String indexCode;						//预算指标编码
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;						//预算指标名称
	
	@Column(name = "F_SY_AMOUNT")
	private Double syAmount;            			//可用金额
	
	
	
	/**
	 * 一上/一下
	 */
	@Column(name = "F_PUR_FIRST_AMOUNT")
	private Double purFirstAmount;					//一上申报金额
	
	@Column(name = "F_FIRST_ISSUED_STATUS")
	private Integer firstIssuedStatus;				//一下状态 0：未下达，1：已下达。
	/**
	 * 二上/二下
	 */
	@Column(name = "F_AMOUNT")
	private Double purSecondAmount;					//二上申报金额（后台流程配置中连线带金额判断的默认使用F_AMOUNT字段，唯一）
	
	@Column(name = "F_SECOND_ISSUED_STATUS")
	private Integer secondIssuedStatus;				//二下状态 0：未下达，1：已下达。
	/**
	 * 一下/二下
	 */
	@Column(name = "F_APP_USER_NAME")
	private String fapproveUserName;				//审核意见填写人
	
	@Column(name = "F_APP_TIME")
	private Date fapproveTime;						//审核时间
	
	@Column(name = "F_APP_IDEA")
	private String fapproveIdea;					//审核意见内容

	
	
	/**
	 * 属性状态位
	 */
	@Column(name = "F_PROCUR_TYPE")
	private String fprocurType;						//采购类型
	
	@Column(name = "F_REPORT_STAGE")
	private Integer freportStage;					//上报阶段  1：一上   2：二上   3：台账 
	
	@Column(name = "F_IS_CHECKED")
	private String fisChecked;						//采购是否已选择  状态  0：未选择 ，1：已选择

	@Column(name = "F_COMBINE_STAUTS")
	private Integer fCombineStauts;					//计划合并状态   0：未被合并过      1：被合并过(暂时不用)
	
	@Column(name = "F_STAUTS")
	private String fstauts;							//数据状态
	
	@Column(name = "F_CHECK_STAUTS")
	private String fcheckStauts;					//审批状态
	
	
	
	@Transient
	private String sblx;							//申报类型  yssb:一上申报,yssp:一上审批,yxxd:一下下达,essb:二上申报,essp:二上审批,exxd:二下指标下达,ndtz:预算台账
	
	@Transient
	private Integer num;							//序号(数据库中没有)
	
	@Transient
	private String combineState;					//是否可合并(数据库中没有)
	

	public Integer getFplId() {
		return fplId;
	}

	public void setFplId(Integer fplId) {
		this.fplId = fplId;
	}

	public String getFlistNum() {
		return flistNum;
	}

	public void setFlistNum(String flistNum) {
		this.flistNum = flistNum;
	}

	public String getFreqUserId() {
		return freqUserId;
	}

	public void setFreqUserId(String freqUserId) {
		this.freqUserId = freqUserId;
	}

	public String getFreqLinkMen() {
		return freqLinkMen;
	}

	public void setFreqLinkMen(String freqLinkMen) {
		this.freqLinkMen = freqLinkMen;
	}

	public String getFlinkTel() {
		return flinkTel;
	}

	public void setFlinkTel(String flinkTel) {
		this.flinkTel = flinkTel;
	}

	public String getFreqDept() {
		return freqDept;
	}

	public void setFreqDept(String freqDept) {
		this.freqDept = freqDept;
	}

	public Date getFreqTime() {
		return freqTime;
	}

	public void setFreqTime(Date freqTime) {
		this.freqTime = freqTime;
	}

	public String getFreqContent() {
		return freqContent;
	}

	public void setFreqContent(String freqContent) {
		this.freqContent = freqContent;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
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

	public String getFbrandModel() {
		return fbrandModel;
	}

	public void setFbrandModel(String fbrandModel) {
		this.fbrandModel = fbrandModel;
	}

	public String getFbrandAndNum() {
		return fbrandAndNum;
	}

	public void setFbrandAndNum(String fbrandAndNum) {
		this.fbrandAndNum = fbrandAndNum;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getExpCode() {
		return expCode;
	}

	public void setExpCode(String expCode) {
		this.expCode = expCode;
	}

	public String getSubCode() {
		return subCode;
	}

	public void setSubCode(String subCode) {
		this.subCode = subCode;
	}

	public String getSubName() {
		return subName;
	}

	public void setSubName(String subName) {
		this.subName = subName;
	}

	public Double getOutAmount() {
		return outAmount;
	}

	public void setOutAmount(Double outAmount) {
		this.outAmount = outAmount;
	}

	public Integer getIndexId() {
		return indexId;
	}

	public void setIndexId(Integer indexId) {
		this.indexId = indexId;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public Double getSyAmount() {
		return syAmount;
	}

	public void setSyAmount(Double syAmount) {
		this.syAmount = syAmount;
	}

	public Double getPurFirstAmount() {
		return purFirstAmount;
	}

	public void setPurFirstAmount(Double purFirstAmount) {
		this.purFirstAmount = purFirstAmount;
	}

	public Integer getFirstIssuedStatus() {
		return firstIssuedStatus;
	}

	public void setFirstIssuedStatus(Integer firstIssuedStatus) {
		this.firstIssuedStatus = firstIssuedStatus;
	}

	public Double getPurSecondAmount() {
		return purSecondAmount;
	}

	public void setPurSecondAmount(Double purSecondAmount) {
		this.purSecondAmount = purSecondAmount;
	}

	public Integer getSecondIssuedStatus() {
		return secondIssuedStatus;
	}

	public void setSecondIssuedStatus(Integer secondIssuedStatus) {
		this.secondIssuedStatus = secondIssuedStatus;
	}

	public String getFapproveUserName() {
		return fapproveUserName;
	}

	public void setFapproveUserName(String fapproveUserName) {
		this.fapproveUserName = fapproveUserName;
	}

	public Date getFapproveTime() {
		return fapproveTime;
	}

	public void setFapproveTime(Date fapproveTime) {
		this.fapproveTime = fapproveTime;
	}

	public String getFapproveIdea() {
		return fapproveIdea;
	}

	public void setFapproveIdea(String fapproveIdea) {
		this.fapproveIdea = fapproveIdea;
	}

	public String getFprocurType() {
		return fprocurType;
	}

	public void setFprocurType(String fprocurType) {
		this.fprocurType = fprocurType;
	}

	public Integer getFreportStage() {
		return freportStage;
	}

	public void setFreportStage(Integer freportStage) {
		this.freportStage = freportStage;
	}

	public String getFisChecked() {
		return fisChecked;
	}

	public void setFisChecked(String fisChecked) {
		this.fisChecked = fisChecked;
	}

	public Integer getfCombineStauts() {
		return fCombineStauts;
	}

	public void setfCombineStauts(Integer fCombineStauts) {
		this.fCombineStauts = fCombineStauts;
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

	public String getSblx() {
		return sblx;
	}

	public void setSblx(String sblx) {
		this.sblx = sblx;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getCombineState() {
		return combineState;
	}

	public void setCombineState(String combineState) {
		this.combineState = combineState;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_PROCUREMENT_PLAN";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fplId);
	}

	public String getFreqDeptId() {
		return freqDeptId;
	}

	public void setFreqDeptId(String freqDeptId) {
		this.freqDeptId = freqDeptId;
	}

	@Override
	public void setNextCheckUserName(String userName) {
		this.userName2=userName;
	}

	@Override
	public void setNextCheckUserId(String userId) {
		this.fuserId=userId;
	}

	@Override
	public void setNextCheckKey(String nCode) {
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		this.fcheckStauts=checkStatus;
	}
	
	@Override
	public String getCheckStauts() {
		return fcheckStauts;
	}
	
	@Override
	public void setStauts(String status) {
		this.fstauts=status;
	}
	
	@Override
	public String getBeanCode() {
		return flistNum;
	}
	
	@Override
	public Integer getBeanId() {
		return fplId;
	}

	@Override
	public String getNextCheckKey() {
		return nCode;
	}

	@Override
	public void setCashierType(String status) {
		
	}
	
	@Override
	public String getUserId() {
		return freqUserId;
	}

	@Override
	public String getBeanCodeField() {
		return "F_LIST_NUM";
	}

	@Override
	public String getNextCheckUserId() {
		return fuserId;
	}

	
}
