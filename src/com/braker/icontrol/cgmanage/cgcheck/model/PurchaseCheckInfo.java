package com.braker.icontrol.cgmanage.cgcheck.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
/**
 * 采购审批记录的model
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */

@Entity
@Table(name="T_PURCHASE_CHECK_INFO")
public class PurchaseCheckInfo extends BaseEntity {

	
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer cId;
	
	@Column(name ="F_P_ID")							//外键ID  链接T_PURCHASE_APPLY_BASIC (F_P_ID);
	private Integer fpId;
	
	@Column(name ="T_P_F_P_ID")
	private Integer tpfpId;							//流程定ID 链接T_PROCESS_DEFIN (F_P_ID);
	
	@Column(name = "F_USER_ID")
	private String fuserId;			//审批人ID
	
	@Column(name = "F_USER_NAME")
	private String fuserName;		//审批人名字
	
	@Column(name = "F_ROLE_NAME")
	private String froleName;		//审批人岗位
		
	@Column(name = "F_LEVEL")
	private String flevel;			//审批级别
	
	@Column(name = "F_RESULT")
	private String fcheckResult;		//审批意见
	
	@Column(name = "F_CHECK_TIME")
	private Date fcheckTime;			//审批时间
	
	@Column(name = "F_REMARK")
	private String fcheckRemake;		//审批内容
	
	@Column(name = "F_STAUTS")
	private String stauts;				//审批信息状态
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	public Integer getcId() {
		return cId;
	}

	public void setcId(Integer cId) {
		this.cId = cId;
	}

	public Integer getFpId() {
		return fpId;
	}

	public void setFpId(Integer fpId) {
		this.fpId = fpId;
	}

	public Integer getTpfpId() {
		return tpfpId;
	}

	public void setTpfpId(Integer tpfpId) {
		this.tpfpId = tpfpId;
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

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	
	
	
	
}
