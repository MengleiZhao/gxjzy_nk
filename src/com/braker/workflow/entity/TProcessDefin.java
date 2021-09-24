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
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * 流程定义表
 * @author zhangxun
 */
@Entity
@Table(name = "T_PROCESS_DEFIN")
public class TProcessDefin implements java.io.Serializable{
	
	//Static Fields
	public static String PROAPPLY = "FLOW001";//项目申报流程
	public static String ARRANGE = "FLOW013";//部门预算编制流程

	//Common Fields

	private Integer FPId;//主键
	private String FPName;//流程显示名称
	private String FPCode;//流程定义代码
	private String FPath;//所属业务目录
	private Integer FOrderNum;//流程排序号
	private String FPDesc;//流程描述
	private String FStauts;//流程状态
	private String FCreateUser;//最后一次发布者
	private Date FUpdateTime;//最后一次发布时间
	private Date FStartTime;//开始执行时间
	private String FCycle;//执行周期（频率）
	private String FQzFormula;//QZ正则表达式
	private String FBusiArea;//业务范围
	private String departCode;//单位编号
	private String departName;//部门名称
	
	
	private Integer haveChildrenDate;//是否有节点信息
	private Integer number;//序号
	
	@Transient
	public Integer getHaveChildrenDate() {
		return haveChildrenDate;
	}

	public void setHaveChildrenDate(Integer haveChildrenDate) {
		this.haveChildrenDate = haveChildrenDate;
	}
	
	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_P_ID", unique = true, nullable = false)
	public Integer getFPId() {
		return this.FPId;
	}

	public void setFPId(Integer FPId) {
		this.FPId = FPId;
	}

	@Column(name = "F_P_NAME", length = 100)
	public String getFPName() {
		return this.FPName;
	}

	public void setFPName(String FPName) {
		this.FPName = FPName;
	}

	@Column(name = "F_P_CODE", length = 50)
	public String getFPCode() {
		return this.FPCode;
	}

	public void setFPCode(String FPCode) {
		this.FPCode = FPCode;
	}

	@Column(name = "F_PATH", length = 50)
	public String getFPath() {
		return this.FPath;
	}

	public void setFPath(String FPath) {
		this.FPath = FPath;
	}

	@Column(name = "F_ORDER_NUM", length = 3)
	public Integer getFOrderNum() {
		return this.FOrderNum;
	}

	public void setFOrderNum(Integer FOrderNum) {
		this.FOrderNum = FOrderNum;
	}

	@Column(name = "F_P_DESC", length = 200)
	public String getFPDesc() {
		return this.FPDesc;
	}

	public void setFPDesc(String FPDesc) {
		this.FPDesc = FPDesc;
	}

	@Column(name = "F_STAUTS", length = 2)
	public String getFStauts() {
		return this.FStauts;
	}

	public void setFStauts(String FStauts) {
		this.FStauts = FStauts;
	}

	@Column(name = "F_CREATE_USER", length = 20)
	public String getFCreateUser() {
		return this.FCreateUser;
	}

	public void setFCreateUser(String FCreateUser) {
		this.FCreateUser = FCreateUser;
	}

	@Column(name = "F_UPDATE_TIME", length = 19)
	public Date getFUpdateTime() {
		return this.FUpdateTime;
	}

	public void setFUpdateTime(Date FUpdateTime) {
		this.FUpdateTime = FUpdateTime;
	}

	@Column(name = "F_START_TIME", length = 19)
	public Date getFStartTime() {
		return this.FStartTime;
	}

	public void setFStartTime(Date FStartTime) {
		this.FStartTime = FStartTime;
	}

	@Column(name = "F_CYCLE", length = 20)
	public String getFCycle() {
		return this.FCycle;
	}

	public void setFCycle(String FCycle) {
		this.FCycle = FCycle;
	}

	@Column(name = "F_QZ_FORMULA", length = 20)
	public String getFQzFormula() {
		return this.FQzFormula;
	}

	public void setFQzFormula(String FQzFormula) {
		this.FQzFormula = FQzFormula;
	}

	@Column(name = "F_BUSI_AREA", length = 20)
	public String getFBusiArea() {
		return this.FBusiArea;
	}

	public void setFBusiArea(String FBusiArea) {
		this.FBusiArea = FBusiArea;
	}

	@Column(name = "DEPART_CODE", length = 50)
	public String getDepartCode() {
		return this.departCode;
	}

	public void setDepartCode(String departCode) {
		this.departCode = departCode;
	}
	
	@Column(name ="DEPART_NAME", length = 50)
	public String getDepartName() {
		return departName;
	}

	public void setDepartName(String departName) {
		this.departName = departName;
	}

	@Transient
	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}	
     public TProcessDefin(){}
}