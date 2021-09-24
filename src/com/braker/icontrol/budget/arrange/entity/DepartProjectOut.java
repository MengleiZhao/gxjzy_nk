package com.braker.icontrol.budget.arrange.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 部门项目支出
 * @author zhangxun
 */
@Entity
@Table(name = "T_PRO_EXPEND_DEPT")
@JsonIgnoreProperties(ignoreUnknown = true)
public class DepartProjectOut extends BaseEntityEmpty implements java.io.Serializable   {

	// Fields

	private static final long serialVersionUID = -1707169033632623738L;
	
	private Integer FPpId;//主键
	private TProBasicInfo FProId;//关联项目
	private DepartArrange arrange;//关联部门编制
	private Double FBudgetControl;//金额
	private String FCreateUser;
	private Date FCreateTime;
	private String FUpdateUser;
	private Date FUpdateTime;
	private Integer FType;//类型 1-当年 2-往年
	private String FExt1;//年度
	private String FExt2;//是否已经发布 1-是
	private String FExt3;
	private String FExt4;
	private String FExt5;
	
	//Transient Field
	
	//在预算编制-新增页面显示的字段
	private String pro_code;
	private String pro_name;
	private String pro_type;
	private String pro_person;
	private String pro_depart;
	private String pro_time;
	private String pro_money;

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "F_PP_ID", unique = true, nullable = false)
	public Integer getFPpId() {
		return this.FPpId;
	}

	public void setFPpId(Integer FPpId) {
		this.FPpId = FPpId;
	}

	@ManyToOne
	@JoinColumn(name = "F_PRO_ID")
	public TProBasicInfo getFProId() {
		return this.FProId;
	}

	public void setFProId(TProBasicInfo FProId) {
		this.FProId = FProId;
	}
	
	@ManyToOne
	@JoinColumn(name = "F_DC_ID")
	public DepartArrange getArrange() {
		return arrange;
	}

	public void setArrange(DepartArrange arrange) {
		this.arrange = arrange;
	}

	@Column(name = "F_BUDGET_CONTROL", precision = 22, scale = 0)
	public Double getFBudgetControl() {
		return this.FBudgetControl;
	}

	public void setFBudgetControl(Double FBudgetControl) {
		this.FBudgetControl = FBudgetControl;
	}

	@Column(name = "F_CREATE_USER", length = 20)
	public String getFCreateUser() {
		return this.FCreateUser;
	}

	public void setFCreateUser(String FCreateUser) {
		this.FCreateUser = FCreateUser;
	}

	@Column(name = "F_CREATE_TIME", length = 19)
	public Date getFCreateTime() {
		return this.FCreateTime;
	}

	public void setFCreateTime(Date FCreateTime) {
		this.FCreateTime = FCreateTime;
	}

	@Column(name = "F_UPDATE_USER", length = 20)
	public String getFUpdateUser() {
		return this.FUpdateUser;
	}

	public void setFUpdateUser(String FUpdateUser) {
		this.FUpdateUser = FUpdateUser;
	}

	@Column(name = "F_UPDATE_TIME", length = 19)
	public Date getFUpdateTime() {
		return this.FUpdateTime;
	}

	public void setFUpdateTime(Date FUpdateTime) {
		this.FUpdateTime = FUpdateTime;
	}

	@Column(name = "F_EXT_1", length = 50)
	public String getFExt1() {
		return this.FExt1;
	}

	public void setFExt1(String FExt1) {
		this.FExt1 = FExt1;
	}

	@Column(name = "F_EXT_2", length = 50)
	public String getFExt2() {
		return this.FExt2;
	}

	public void setFExt2(String FExt2) {
		this.FExt2 = FExt2;
	}

	@Column(name = "F_EXT_3", length = 50)
	public String getFExt3() {
		return this.FExt3;
	}

	public void setFExt3(String FExt3) {
		this.FExt3 = FExt3;
	}

	@Column(name = "F_EXT_4", length = 50)
	public String getFExt4() {
		return this.FExt4;
	}

	public void setFExt4(String FExt4) {
		this.FExt4 = FExt4;
	}

	@Column(name = "F_EXT_5", length = 50)
	public String getFExt5() {
		return this.FExt5;
	}

	public void setFExt5(String FExt5) {
		this.FExt5 = FExt5;
	}

	@Column(name = "F_TYPE")
	public Integer getFType() {
		return FType;
	}

	public void setFType(Integer fType) {
		FType = fType;
	}
	
	@Transient
	public String getXmbh() {
		if (FProId != null) {
			return FProId.getFProCode();
		}
		return "";
	}

	@Transient
	public String getXmmc() {
		if (FProId != null) {
			return FProId.getFProName();
		}
		return "";
	}

	
	@Transient
	public String getXmlb() {
		if (FProId != null) {
			return FProId.getFproClassName();
		}
		return "";
	}

	@Transient
	public String getSbr() {
		if (FProId != null) {
			return FProId.getFProAppliPeople();
		}
		return "";
	}

	@Transient
	public String getSbbm() {
		if (FProId != null) {
			return FProId.getFProAppliDepart();
		}
		return "";
	}

	@Transient
	public Date getSbsj() {
		if (FProId != null) {
			return FProId.getFProAppliTime();
		}
		return null;
	}

	@Transient
	public Double getSbje() {
		if (FProId != null) {
			return FProId.getFProBudgetAmount().doubleValue();
		}
		return null;
	}

	//项目信息
	
	@Transient
	public String getPro_code() {
		if (FProId != null) {
			return FProId.getFProCode();
		}
		return "";
	}

	public void setPro_code(String pro_code) {
		this.pro_code = pro_code;
	}

	@Transient
	public String getPro_name() {
		if (FProId != null) {
			return FProId.getFProName();
		}
		return "";
	}

	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}

	@Transient
	public String getPro_type() {
		if (FProId != null) {
			return FProId.getFproClassName();
		}
		return "";
	}

	public void setPro_type(String pro_type) {
		this.pro_type = pro_type;
	}

	@Transient
	public String getPro_person() {
		if (FProId != null) {
			return FProId.getFProAppliPeople();
		}
		return "";
	}

	public void setPro_person(String pro_person) {
		this.pro_person = pro_person;
	}

	@Transient
	public String getPro_depart() {
		if (FProId != null) {
			return FProId.getFProAppliDepart();
		}
		return "";
	}

	public void setPro_depart(String pro_depart) {
		this.pro_depart = pro_depart;
	}

	@Transient
	public String getPro_time() {
		if (FProId != null && FProId.getFProAppliTime() != null) {
			return new SimpleDateFormat("yyyy-MM-dd").format(FProId.getFProAppliTime());
		}
		return "";
	}

	public void setPro_time(String pro_time) {
		this.pro_time = pro_time;
	}

	@Transient
	public String getPro_money() {
		if (FProId != null && FProId.getFProcurementAmount() != null) {
			return String.valueOf(FProId.getFProcurementAmount());
		}
		return "";
	}

	public void setPro_money(String pro_money) {
		this.pro_money = pro_money;
	}

}
