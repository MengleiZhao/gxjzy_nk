package com.braker.icontrol.expend.apply.model;


import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntity;
/**
 * 公务接待餐费明细
 * @author 沈帆
 *
 */
@Entity
@Table(name ="T_RECEPTION_OTEHR")
public class ReceptionOther extends BaseEntity{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_O_ID")
	private Integer oID;
	
	@Column(name = "F_G_ID")
	private Integer gId;			//申请信息ID

	@Column(name = "F_R_ID")
	private Integer rId;			//报销信息ID
	
	@Column(name ="F_COST_NAME")
	private String fCostName;        //费用名称
	
	@Column(name ="F_COST")
	private BigDecimal fCost;//支出金额
	
	@Column(name ="F_COST_STD")
	private BigDecimal fCostStd;//支出标准(差旅为教师标准)
	
	@Column(name ="F_STUDENT_COST_STD")
	private BigDecimal fStudentCostStd;//学生支出标准
	
	@Column(name ="F_TEACHER_COST")
	private BigDecimal fTeacherCost;//教师金额
	
	@Column(name ="F_STUDENT_COST")
	private BigDecimal fStudentCost;//学生金额
	
	@Column(name ="F_REMARK")
	private String fRemark;  //备注
	
	@Column(name ="F_TYPE")
	private String fType;  //类型       1、差旅费     2、会务、培训费

	@Column(name = "F_STATUS")
	private Integer fStatus;//数据状态0-事前申请，1-事后报销

	public String getfType() {
		return fType;
	}

	public void setfType(String fType) {
		this.fType = fType;
	}

	public BigDecimal getfCostStd() {
		return fCostStd;
	}

	public void setfCostStd(BigDecimal fCostStd) {
		this.fCostStd = fCostStd;
	}

	public BigDecimal getfTeacherCost() {
		return fTeacherCost;
	}

	public void setfTeacherCost(BigDecimal fTeacherCost) {
		this.fTeacherCost = fTeacherCost;
	}

	public BigDecimal getfStudentCost() {
		return fStudentCost;
	}

	public void setfStudentCost(BigDecimal fStudentCost) {
		this.fStudentCost = fStudentCost;
	}

	public Integer getfStatus() {
		return fStatus;
	}

	public void setfStatus(Integer fStatus) {
		this.fStatus = fStatus;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getgId() {
		return gId;
	}

	public void setgId(Integer gId) {
		this.gId = gId;
	}

	public Integer getoID() {
		return oID;
	}

	public void setoID(Integer oID) {
		this.oID = oID;
	}

	public String getfCostName() {
		return fCostName;
	}

	public void setfCostName(String fCostName) {
		this.fCostName = fCostName;
	}

	public BigDecimal getfCost() {
		return fCost;
	}

	public void setfCost(BigDecimal fCost) {
		this.fCost = fCost;
	}

	public String getfRemark() {
		return fRemark;
	}

	public void setfRemark(String fRemark) {
		this.fRemark = fRemark;
	}

	public BigDecimal getfStudentCostStd() {
		return fStudentCostStd;
	}

	public void setfStudentCostStd(BigDecimal fStudentCostStd) {
		this.fStudentCostStd = fStudentCostStd;
	}



	
}
