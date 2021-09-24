package com.braker.icontrol.incomemanage.capital.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.EntityDao;

/**
 * 资金垫支的model
 * 
 * @author 冉德茂
 * @createtime 2018-10-09
 * @updatetime 2018-10-09
 */
@Entity
@Table(name = "T_FUND_PAYFOR_INFO")
public class FundPayforInfo extends BaseEntity implements EntityDao{
	@Id
	@Column(name = "F_PAYFOR_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fpayforId;			//主键ID
	
	@Column(name = "F_CO_ID")
	private Integer fcoId;				//借款单id
	
	@Column(name = "F_CO_CODE")
	private String fcoCode;				//借款单编号（借款单带出）
	
	@Column(name = "F_AMOUNT")
	private Double famount;				//归垫/调整金额
	
	@Column(name = "F_OPERATE_USER")
	private String foperateUser;				//登记人
	
	@Column(name = "F_OPERATE_TIME")
	private Date foperateTime;				//还款时间
	
	@Column(name = "F_STAUTS")
	private String fstauts;				//删除状态
	
	@Column(name = "F_RE_INDEX_NAME")
	private String freIndexName;				//还款指标
	
	@Column(name = "F_RE_INDEX_ID")
	private Integer freIndexId;				//还款指标id
	
	@Column(name = "F_RE_INDEX_TYPE")
	private String freIndexType;				//还款指标类型
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	
	
	public String getFreIndexName() {
		return freIndexName;
	}

	public void setFreIndexName(String freIndexName) {
		this.freIndexName = freIndexName;
	}



	public Integer getFreIndexId() {
		return freIndexId;
	}

	public void setFreIndexId(Integer freIndexId) {
		this.freIndexId = freIndexId;
	}

	public String getFreIndexType() {
		return freIndexType;
	}

	public void setFreIndexType(String freIndexType) {
		this.freIndexType = freIndexType;
	}

	public Integer getFpayforId() {
		return fpayforId;
	}

	public void setFpayforId(Integer fpayforId) {
		this.fpayforId = fpayforId;
	}



	public Integer getFcoId() {
		return fcoId;
	}

	public void setFcoId(Integer fcoId) {
		this.fcoId = fcoId;
	}

	public String getFcoCode() {
		return fcoCode;
	}

	public void setFcoCode(String fcoCode) {
		this.fcoCode = fcoCode;
	}

	public Double getFamount() {
		return famount;
	}

	public void setFamount(Double famount) {
		this.famount = famount;
	}

	public String getFoperateUser() {
		return foperateUser;
	}

	public void setFoperateUser(String foperateUser) {
		this.foperateUser = foperateUser;
	}

	public Date getFoperateTime() {
		return foperateTime;
	}

	public void setFoperateTime(Date foperateTime) {
		this.foperateTime = foperateTime;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getFstauts() {
		return fstauts;
	}

	public void setFstauts(String fstauts) {
		this.fstauts = fstauts;
	}

	@Override
	public String getJoinTable() {
		// TODO Auto-generated method stub
		return "T_FUND_PAYFOR_INFO";
	}

	@Override
	public String getEntryId() {
		// TODO Auto-generated method stub
		return fpayforId.toString();
	}


	

	
	
	
}
