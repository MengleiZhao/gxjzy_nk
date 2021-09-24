package com.braker.icontrol.purchase.apply.model;

import java.math.BigDecimal;
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

import org.apache.poi.xwpf.converter.core.utils.StringUtils;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.EntityDao;
import com.braker.common.util.LookupsUtil;
import com.braker.core.model.Lookups;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="T_PURCHASE_APPLY_BASIC")
@JsonIgnoreProperties(ignoreUnknown = true)
public class PurchaseApplyBasic extends BaseEntity implements EntityDao,CheckEntity{
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_P_ID")
	private Integer fpId;
	
	@Column(name = "F_PL_ID")
	private Integer fplId;//配置计划的主键id（读取）
	
	@Column(name = "F_PL_CODE")
	private String fplCode;//采购预算计划编号（读取配置计划的单据编号）
	
	@Column(name = "F_P_CODE")
	private String fpCode;//采购批次号 自动生成
	
	@Column(name = "F_P_NAME")
	private String fpName;//采购名称
	
	@Column (name ="F_DEPT_NAME")
	private String fDeptName;//申报部门
	
	@Column (name ="F_DEPT_ID")
	private String fDeptId;//申报部门id
	
	@Column (name ="F_USER")
	private String fUser;//申报人id
	
	@Column (name ="F_USER_NAME")
	private String fUserName;//申报人
	
	@Column (name ="F_AMOUNT")
	private BigDecimal fpAmount;//采购金额
	
	@Column (name="F_REQ_TIME")
	private Date fReqTime;//申请时间
	
	@Column (name ="F_P_PYPE")
	private String fpPype;//采购类型
	
	@Column (name ="F_AMOUNT_RANGE")
	private String fAmountRange;//采购金额区间
	
	/*@ManyToOne
	@JoinColumn(name = "F_ORG_TYPE",referencedColumnName="lookupscode")
	private Lookups fOrgType;//组织形式
	
	@ManyToOne
	@JoinColumn(name = "F_EVA_METHOD",referencedColumnName="lookupscode")
	private Lookups fEvaMethod;//评价方法
	
	@ManyToOne
	@JoinColumn(name = "F_P_METHOD",referencedColumnName="lookupscode")
	private Lookups fpMethod;//采购方式
*/	
	@Column (name ="F_P_METHOD")
	private String fpMethod;//采购方式
	
	@Column (name ="F_AGENCY_NAME")
	private String fAgencyName;//代理机构
	
	@Column (name ="F_IS_IMP")
	private String fIsImp;//进口货物服务
	
	@Column (name ="F_REMARK")
	private String fRemark;//采购说明
	
	@Column (name ="F_OTHER_REMARK")
	private String fOtherRemark;//其他需求
	
	@Column (name ="F_CHECK_STAUTS")
	private String fCheckStauts;//采购审批状态
	
	@Column (name ="F_STAUTS")
	private String fStauts;//采购数据的删除状态
	
	@Column (name ="F_IS_RECEIVE")
	private String fIsReceive;//验收状态    如果是空或者是0：未验收   如果是1：正在验收    如果是2：已验收     赵孟雷   2020-12-11修改字段代表含义
	
	@Column (name ="F_IS_INQUIRY")
	private String fIsInquiry;//询价状态   焦广兴更改为 是否论证状态 
	
	@Column (name ="F_BID_STAUTS")
	private String fbidStauts;//中标状态	焦广兴更改为 登记状态 0-未登记，1-已登记，2-暂存
	
	@Column (name ="F_EVAL_STAUTS")
	private String fevalStauts;//(供应商)评价状态

	@Column (name ="F_PAY_STAUTS")
	private String fpayStauts;//付款申请的审批状态
	
	@Column (name ="F_TENDING_STAUTS")
	private String ftendingStauts;//招标状态  10月23更改需求 不允许流标  以前功能存在流标
	
	@Column(name = "F_INDEX_ID")
	private Integer indexId;			//支出科目ID
	
	@Column (name ="F_INDEX_CODE")
	private String indexCode;			//支出科目编码
	
	@Column (name ="F_INDEX_NAME")
	private String indexName;			//支出科目名称
	
	@Column (name ="F_INDEX_TYPE")
	private String indexType;			//支出科目类型
	
	@Column (name ="F_PRO_DETAIL_ID")
	private Integer proDetailId;		//项目支出明细id

	@Column(name = "F_ITEMS")
	private String fItems;			//采购品目 2020-12-10沈帆新增
	
	@Column(name = "F_ITEMS_DETAIL")
	private String fItemsDetail;			//采购细目 2020-12-10沈帆新增
	
	@Column(name = "F_ITEMS_DETAIL_IDS")
	private String fItemsDetailIds;			//采购细目ids 2020-12-10沈帆新增
	
	@Column (name ="F_IS_CONTRACT")
	private String fIsContract;				//是否签订合同  2020-12-10沈帆新增   用于采购申请上的选项
	
	@Column (name ="F_CONTRACT_STS")
	private String fContractSts;				//签订合同状态  2020-12-21  赵孟雷新增     空\null：代表未签订合同    1：合同签订中   2：合同已签
	
	@Column (name ="F_P_TYPE")
	private String fPType;				//采购分类（1-采购金额小于1w并签订合同. 2-采购金额小于1w并且没有签订合同. 3-采购金额大于等于1w.）  2020-12-10沈帆新增
	
	@Column(name = "F_USER_NAME2")
	private String userName2;		//下环节处理人姓名
	
	@Column(name = "F_USER_CODE")
	private String fuserId;			//下环节处理人编码
	
	@Column(name = "F_N_CODE")
	private String nCode;			//下节点节点编码
	
	@Column(name = "F_R_ID")
	private Integer rId;			//报销单id （2020-12-15 沈帆加）
	
	@Column(name = "MEETING_SUMMARY_YEAR1")
	private String meetingSummaryYear1;   //校长办公会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME1")
	private String meetingSummaryTime1; //校长办公会会议纪要次数
	
	@Column(name = "MEETING_SUMMARY_YEAR2")
	private String meetingSummaryYear2;   //党委会会议纪要年数
	
	@Column(name = "MEETING_SUMMARY_TIME2")
	private String meetingSummaryTime2;  //党委会会议纪要次数
	
	@Column (name ="F_IS_GOVERN")
	private String fIsGovern;	//是否政府采购
	
	@Column (name ="F_ORG_TYPE")
	private String orgType;	//组织形式
	
	@Column (name ="F_BID_TIME")
	private Date bidTime;	//登记时间
	
	@Column (name ="F_BID_ALREADY")
	private String bidAlready;	//是否登记通过 1-是 
	
	@Column(name = "F_HTCODE")
	private String fHtCode;	 //合同编号
	
	@Transient
	private String reimbStatus;     //报销审批状态（2020-12-15 沈帆加）
	
	@Transient
	private String cashierType;		//出纳受理状态0未受理1已受理 （2020-12-17 沈帆加）
	
	@Transient
	private BigDecimal payAmount;      //报销付款金额（2020-12-15 沈帆加）
	
	@Transient
	private int number;					//序号(数据库里没有的)
	
	@Transient
	private String fpMethodStr;
	
	/*@Transient
	private String forgtype;			//采购组织形式
	
	@Transient
	private String  fevamethod;			//评价方法
	*/
	@Transient
	private String  fpmethod;			//采购方式
	
	
	@Transient
	private String fOrgName;        //中标组织名称
	
	@Transient
	private BigDecimal fpAmount1;	//采购金额(查询用)
	
	@Transient
	private BigDecimal fpAmount2;	//采购金额(查询用)
	
	@Transient
	private Integer contractId;	//合同id
	
	@Transient
	private Integer fAcpId;	//验收id
	
	//预算信息
	@Transient
	private BigDecimal pfAmount; 		//预算批复金额
	
	@Transient
	private String pfDate;			//预算批复时间
	
	@Transient
	private String pfDepartName;	//使用部门
	
	@Transient
	private BigDecimal syAmount;		//可用余额
	
	@Transient
	private BigDecimal fbidAmount;		//中标金额
	
	@Transient
	private String proDetailName;		//预算支出明细名称
	
	@Transient
	private String proCharger;		//项目负责人
	
	
	
	public String getfHtCode() {
		return fHtCode;
	}

	public void setfHtCode(String fHtCode) {
		this.fHtCode = fHtCode;
	}

	public String getBidAlready() {
		return bidAlready;
	}

	public void setBidAlready(String bidAlready) {
		this.bidAlready = bidAlready;
	}

	public Date getBidTime() {
		return bidTime;
	}

	public void setBidTime(Date bidTime) {
		this.bidTime = bidTime;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

	public String getfIsGovern() {
		return fIsGovern;
	}

	public void setfIsGovern(String fIsGovern) {
		this.fIsGovern = fIsGovern;
	}

	public String getMeetingSummaryYear1() {
		return meetingSummaryYear1;
	}

	public void setMeetingSummaryYear1(String meetingSummaryYear1) {
		this.meetingSummaryYear1 = meetingSummaryYear1;
	}

	public String getMeetingSummaryTime1() {
		return meetingSummaryTime1;
	}

	public void setMeetingSummaryTime1(String meetingSummaryTime1) {
		this.meetingSummaryTime1 = meetingSummaryTime1;
	}

	public String getMeetingSummaryYear2() {
		return meetingSummaryYear2;
	}

	public void setMeetingSummaryYear2(String meetingSummaryYear2) {
		this.meetingSummaryYear2 = meetingSummaryYear2;
	}

	public String getMeetingSummaryTime2() {
		return meetingSummaryTime2;
	}

	public void setMeetingSummaryTime2(String meetingSummaryTime2) {
		this.meetingSummaryTime2 = meetingSummaryTime2;
	}

	public String getfContractSts() {
		return fContractSts;
	}

	public void setfContractSts(String fContractSts) {
		this.fContractSts = fContractSts;
	}

	public Integer getfAcpId() {
		return fAcpId;
	}

	public void setfAcpId(Integer fAcpId) {
		this.fAcpId = fAcpId;
	}

	public String getFplCode() {
		return fplCode;
	}

	public void setFplCode(String fplCode) {
		this.fplCode = fplCode;
	}

	public Integer getContractId() {
		return contractId;
	}

	public void setContractId(Integer contractId) {
		this.contractId = contractId;
	}

	public String getFtendingStauts() {
		return ftendingStauts;
	}

	public void setFtendingStauts(String ftendingStauts) {
		this.ftendingStauts = ftendingStauts;
	}

	public Integer getFplId() {
		return fplId;
	}

	public void setFplId(Integer fplId) {
		this.fplId = fplId;
	}

	public String getFpName() {
		return fpName;
	}

	public void setFpName(String fpName) {
		this.fpName = fpName;
	}

	public String getFevalStauts() {
		return fevalStauts;
	}

	public void setFevalStauts(String fevalStauts) {
		this.fevalStauts = fevalStauts;
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

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	public String getFpayStauts() {
		return fpayStauts;
	}

	public void setFpayStauts(String fpayStauts) {
		this.fpayStauts = fpayStauts;
	}

	public String getFbidStauts() {
		return fbidStauts;
	}

	public void setFbidStauts(String fbidStauts) {
		this.fbidStauts = fbidStauts;
	}

	public String getfIsInquiry() {
		return fIsInquiry;
	}

	public void setfIsInquiry(String fIsInquiry) {
		this.fIsInquiry = fIsInquiry;
	}

	public String getfIsReceive() {
		return fIsReceive;
	}

	public void setfIsReceive(String fIsReceive) {
		this.fIsReceive = fIsReceive;
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

	public String getfStauts() {
		return fStauts;
	}

	public void setfStauts(String fStauts) {
		this.fStauts = fStauts;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public String getfDeptName() {
		return fDeptName;
	}

	public void setfDeptName(String fDeptName) {
		this.fDeptName = fDeptName;
	}

	public String getfUser() {
		return fUser;
	}

	public void setfUser(String fUser) {
		this.fUser = fUser;
	}

	public String getfUserName() {
		return fUserName;
	}

	public void setfUserName(String fUserName) {
		this.fUserName = fUserName;
	}



	public BigDecimal getFpAmount() {
		return fpAmount;
	}

	public void setFpAmount(BigDecimal fpAmount) {
		this.fpAmount = fpAmount;
	}

	public Date getfReqTime() {
		return fReqTime;
	}

	public void setfReqTime(Date fReqTime) {
		this.fReqTime = fReqTime;
	}

	public String getFpPype() {
		return fpPype;
	}

	public void setFpPype(String fpPype) {
		this.fpPype = fpPype;
	}

	public String getfAmountRange() {
		return fAmountRange;
	}

	public void setfAmountRange(String fAmountRange) {
		this.fAmountRange = fAmountRange;
	}

	public String getfAgencyName() {
		return fAgencyName;
	}

	public void setfAgencyName(String fAgencyName) {
		this.fAgencyName = fAgencyName;
	}

	public String getfIsImp() {
		return fIsImp;
	}

	public void setfIsImp(String fIsImp) {
		this.fIsImp = fIsImp;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public String getfOtherRemark() {
		return fOtherRemark;
	}

	public void setfOtherRemark(String fOtherRemark) {
		this.fOtherRemark = fOtherRemark;
	}

	public String getfCheckStauts() {
		return fCheckStauts;
	}

	public void setfCheckStauts(String fCheckStauts) {
		this.fCheckStauts = fCheckStauts;
	}
	
	/*public Lookups getfOrgType() {
		return fOrgType;
	}

	public void setfOrgType(Lookups fOrgType) {
		this.fOrgType = fOrgType;
	}

	public Lookups getfEvaMethod() {
		return fEvaMethod;
	}

	public void setfEvaMethod(Lookups fEvaMethod) {
		this.fEvaMethod = fEvaMethod;
	}

	public Lookups getFpMethod() {
		return fpMethod;
	}

	public void setFpMethod(Lookups fpMethod) {
		this.fpMethod = fpMethod;
	}

	public String getForgtype() {
		if (fOrgType != null) {
			return fOrgType.getName();
		}
		return forgtype;
	}

	public void setForgtype(String forgtype) {
		this.forgtype = forgtype;
	}

	public String getFevamethod() {
		if (fEvaMethod != null) {
			return fEvaMethod.getName();
		}
		return fevamethod;
	}

	public void setFevamethod(String fevamethod) {
		this.fevamethod = fevamethod;
	}*/

	public String getFpMethod() {
		return fpMethod;
	}

	public void setFpMethod(String fpMethod) {
		this.fpMethod = fpMethod;
	}

	public String getFpmethod() {
		if(StringUtils.isNotEmpty(fpMethod)){
			Lookups lookups=LookupsUtil.findByLookCode(fpMethod);
			if(lookups!=null){
				return lookups.getName();
			}
		}
		return fpmethod;
	}

	public void setFpmethod(String fpmethod) {
		this.fpmethod = fpmethod;
	}

	public String getFpMethodStr() {
		return fpMethodStr;
	}

	public void setFpMethodStr(String fpMethodStr) {
		this.fpMethodStr = fpMethodStr;
	}

	public String getfOrgName() {
		return fOrgName;
	}

	public void setfOrgName(String fOrgName) {
		this.fOrgName = fOrgName;
	}
	
	public BigDecimal getFpAmount1() {
		return fpAmount1;
	}

	public void setFpAmount1(BigDecimal fpAmount1) {
		this.fpAmount1 = fpAmount1;
	}

	public BigDecimal getFpAmount2() {
		return fpAmount2;
	}

	public void setFpAmount2(BigDecimal fpAmount2) {
		this.fpAmount2 = fpAmount2;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_PURCHASE_APPLY_BASIC";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fpId);
	}

	public String getfDeptId() {
		return fDeptId;
	}

	public void setfDeptId(String fDeptId) {
		this.fDeptId = fDeptId;
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
	public String getNextCheckUserId() {
		// TODO Auto-generated method stub
		return fuserId;
	}
	@Override
	public void setNextCheckKey(String nCode) {
		// TODO Auto-generated method stub
		this.nCode=nCode;
	}

	@Override
	public void setCheckStauts(String checkStatus) {
		// TODO Auto-generated method stub
		this.fCheckStauts=checkStatus;
	}
	@Override
	public String getCheckStauts() {
		// TODO Auto-generated method stub
		return fCheckStauts;
	}
	@Override
	public void setStauts(String status) {
		// TODO Auto-generated method stub
		this.fStauts=status;
	}

	@Override
	public String getBeanCode() {
		// TODO Auto-generated method stub
		return fpCode;
	}
	@Override
	public Integer getBeanId() {
		// TODO Auto-generated method stub
		return fpId;
	}

	@Override
	public String getNextCheckKey() {
		// TODO Auto-generated method stub
		return nCode;
	}

	@Override
	public void setCashierType(String cashierType) {
		// TODO Auto-generated method stub
		this.cashierType=cashierType;
		
	}
	@Override
	public String getUserId() {
		// TODO Auto-generated method stub
		return fUser;
	}

	@Override
	public String getBeanCodeField() {
		// TODO Auto-generated method stub
		return "F_P_CODE";
	}

	public BigDecimal getPfAmount() {
		return pfAmount;
	}

	public void setPfAmount(BigDecimal pfAmount) {
		this.pfAmount = pfAmount;
	}

	public String getPfDate() {
		return pfDate;
	}

	public void setPfDate(String pfDate) {
		this.pfDate = pfDate;
	}

	public String getPfDepartName() {
		return pfDepartName;
	}

	public void setPfDepartName(String pfDepartName) {
		this.pfDepartName = pfDepartName;
	}

	public BigDecimal getSyAmount() {
		return syAmount;
	}

	public void setSyAmount(BigDecimal syAmount) {
		this.syAmount = syAmount;
	}

	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
	}

	public Integer getIndexId() {
		return indexId;
	}

	public void setIndexId(Integer indexId) {
		this.indexId = indexId;
	}

	public BigDecimal getFbidAmount() {
		return fbidAmount;
	}

	public void setFbidAmount(BigDecimal fbidAmount) {
		this.fbidAmount = fbidAmount;
	}

	public String getfItems() {
		return fItems;
	}

	public void setfItems(String fItems) {
		this.fItems = fItems;
	}

	public String getfItemsDetail() {
		return fItemsDetail;
	}

	public void setfItemsDetail(String fItemsDetail) {
		this.fItemsDetail = fItemsDetail;
	}

	public String getfItemsDetailIds() {
		return fItemsDetailIds;
	}

	public void setfItemsDetailIds(String fItemsDetailIds) {
		this.fItemsDetailIds = fItemsDetailIds;
	}

	public String getfIsContract() {
		return fIsContract;
	}

	public void setfIsContract(String fIsContract) {
		this.fIsContract = fIsContract;
	}

	public String getfPType() {
		return fPType;
	}

	public void setfPType(String fPType) {
		this.fPType = fPType;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getReimbStatus() {
		return reimbStatus;
	}

	public void setReimbStatus(String reimbStatus) {
		this.reimbStatus = reimbStatus;
	}

	public BigDecimal getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(BigDecimal payAmount) {
		this.payAmount = payAmount;
	}

	public String getCashierType() {
		return cashierType;
	}

	public String getProDetailName() {
		return proDetailName;
	}

	public void setProDetailName(String proDetailName) {
		this.proDetailName = proDetailName;
	}

	public String getProCharger() {
		return proCharger;
	}

	public void setProCharger(String proCharger) {
		this.proCharger = proCharger;
	}
	
	
}
