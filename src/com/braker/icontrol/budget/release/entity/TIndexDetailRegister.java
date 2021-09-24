package com.braker.icontrol.budget.release.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;


/**
 * 预算指标支出流水登记表model
 * @author 赵孟雷
 * @createtime 2021-08-02
 * @updatetime 2021-08-02
 */
@Entity
@Table(name = "T_INDEX_DETAIL_REGISTER")
public class TIndexDetailRegister extends BaseEntityEmpty{
	@Id
	@Column(name = "F_R_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer rId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer proId;			//项目主键ID
	
	@Column(name = "F_PRO_DETAIL_ID")
	private Integer proDetailId;	//项目支出明细主键ID
	
	@Column(name = "F_TYPE")
	private String fType;			//费用类型1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销
	
	@Column(name = "F_DEPARTMENT")
	private String department;		//操作部门名称
	
	@Column(name = "F_DEPT_CODE")
	private String departmentId;	//操作部门id
	
	@Column(name = "F_USER_ID")
	private String userId;			//操作人
	
	@Column(name = "F_USER_NAME")
	private String userName;			//操作人名称
	
	@Column(name = "F_TIME")
	private Date time;				//操作时间
	
	@Column(name = "F_AMOUNT")
	private BigDecimal amount;			//流水金额如支出流水记录金额为：-100如收入流水记录金额为：100
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;		//指标名称
	
	@Column(name = "F_INDEX_CODE")
	private String indexCode;		//指标编码
	
	@Column(name = "F_INDEX_TYPE")
	private String indexType;		//指标类型1、基本支出2、项目支出
	
	@Column(name = "F_PROJECT_NAME")
	private String projectName;		//项目名称
	
	@Column(name = "F_PROJECT_CODE")
	private String projectCode;		//项目编号
	
	@Column(name = "F_EXT_1")
	private String url;				//单据路径(保存单据的查看路径)
	
	@Column(name = "F_EXT_2")
	private String billsCode;		//单据编号
	
	@Column(name = "F_PRO_ACTIVITY")
	private String proActivity;		//具体业务
	
	@Transient
	private String username;
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	@Transient
	private String begintime;			//查询时间(数据库中没有)
	
	@Transient
	private String endtime;			//查询时间(数据库中没有)
	
	public Integer getProId() {
		return proId;
	}

	public void setProId(Integer proId) {
		this.proId = proId;
	}

	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getIndexCode() {
		return indexCode;
	}

	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}

	public String getIndexType() {
		return indexType;
	}

	public void setIndexType(String indexType) {
		this.indexType = indexType;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectCode() {
		return projectCode;
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getBillsCode() {
		return billsCode;
	}

	public void setBillsCode(String billsCode) {
		this.billsCode = billsCode;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public String getProActivity() {
		return proActivity;
	}

	public void setProActivity(String proActivity) {
		this.proActivity = proActivity;
	}

	public Integer getProDetailId() {
		return proDetailId;
	}

	public void setProDetailId(Integer proDetailId) {
		this.proDetailId = proDetailId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
