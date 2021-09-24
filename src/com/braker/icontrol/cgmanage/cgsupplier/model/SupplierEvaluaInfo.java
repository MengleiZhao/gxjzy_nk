package com.braker.icontrol.cgmanage.cgsupplier.model;

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
 * 供应商评价信息表的model
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */

@Entity
@Table(name="T_SUPPLIER_EVALUA_INFO")
public class SupplierEvaluaInfo extends BaseEntityEmpty {

	
	@Id
	@Column(name = "F_E_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer feId;
	
	@Column(name ="F_P_ID")
	private Integer fpId;	//采购id
	
	@Column(name ="F_W_ID")
	private Integer fwId;	//供应商id

	@Column(name = "F_P_NAME")
	private String fpName;		//采购名称
	
	@Column(name = "F_P_CODE")
	private String fpCode;		//采购编码
	
	@Column(name = "F_COMP_SCORE")
	private String fcompScore;			//综合评分
	
	@Column(name = "F_PRICE_SCORE")
	private String fpriceScore;		//价格
	
	@Column(name = "F_COST_PERF")
	private String fcostPerf;		//性价比
		
	@Column(name = "F_QUALITY")
	private String fquality;			//质量
	
	@Column(name = "F_SERVICE")
	private String fservice;		//服务
	
	@Column(name = "F_REMARK")
	private String fremark;			//评价意见
	
	@Column(name = "F_USER_NAME")
	private String fuserName;		//评价人姓名
	
	@Column(name = "F_DEPT_NAME")
	private String fdeptName;		//评价人部门
	
	
	@Column(name = "F_SUP_TIME")
	private Date fsupTime;		//评价时间
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private Date  cgTime;			//采购申请时间
	
	

	public Date getCgTime() {
		return cgTime;
	}

	public void setCgTime(Date cgTime) {
		this.cgTime = cgTime;
	}

	public Integer getFeId() {
		return feId;
	}

	public void setFeId(Integer feId) {
		this.feId = feId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getFwId() {
		return fwId;
	}

	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}

	public String getFpName() {
		return fpName;
	}

	public void setFpName(String fpName) {
		this.fpName = fpName;
	}

	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public String getFcompScore() {
		return fcompScore;
	}

	public void setFcompScore(String fcompScore) {
		this.fcompScore = fcompScore;
	}

	public String getFpriceScore() {
		return fpriceScore;
	}

	public void setFpriceScore(String fpriceScore) {
		this.fpriceScore = fpriceScore;
	}

	public String getFcostPerf() {
		return fcostPerf;
	}

	public void setFcostPerf(String fcostPerf) {
		this.fcostPerf = fcostPerf;
	}

	public String getFquality() {
		return fquality;
	}

	public void setFquality(String fquality) {
		this.fquality = fquality;
	}

	public String getFservice() {
		return fservice;
	}

	public void setFservice(String fservice) {
		this.fservice = fservice;
	}

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public String getFuserName() {
		return fuserName;
	}

	public void setFuserName(String fuserName) {
		this.fuserName = fuserName;
	}

	public String getFdeptName() {
		return fdeptName;
	}

	public void setFdeptName(String fdeptName) {
		this.fdeptName = fdeptName;
	}

	public Date getFsupTime() {
		return fsupTime;
	}

	public void setFsupTime(Date fsupTime) {
		this.fsupTime = fsupTime;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	
	
}
