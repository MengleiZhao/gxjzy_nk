package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;
import com.braker.common.entity.BaseEntityEmpty;

/**
 * 支出事项表
 * @author 陈睿超
 * @createtime 2018-10-18
 */
@Entity
@Table(name ="T_EXPENDITURE")
public class ExpenditureMatter extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_E_ID")
	private Integer feId;
	
	@Column(name ="F_E_CODE")
	private String feCode;//支出事项编码
	
	@Column(name ="F_E_NAME")
	private String feName;//支出事项名称
	
	@Column(name ="F_E_STANDARD")
	private String feStandard;//支出事项标准
	
	@Column(name ="F_E_REMARK")
	private String feRemark;//支出事项说明
	
	@Column(name ="F_E_TYPE")
	private String feType;//支出事项分类(通用事项：1	会议：2	培训：3	差旅：4	因公接待：5		公务用车：6		因公出国：7		直接报销：8)
	
	@Column(name ="F_ROLE_IDS")
	private String roleIds;//适用角色ID
	
	@Column(name ="F_ROLE_NAME")
	private String roleName;//适用角色名称
	
	@Column(name ="F_EXT_1")
	private String fext1;//费用类型
	
	@Column(name ="F_EXT_2")
	private String fext2;//识别码2 	差旅：城市等级
	
	@Column(name ="F_EXT_3")
	private String fext3;//扩展3		差旅费：旺季区间-起始
	
	@Column(name ="F_EXT_4")
	private String fext4;//扩展4		差旅费：旺季区间-结束
	
	@Column(name ="F_EXT_5")
	private String fext5;//扩展5		差旅费：旺季上浮比例
	
	@Column(name ="F_EXT_6")
	private String fext6;//扩展6
	
	@Transient
	private Integer number;//序号

	
	
	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getFeId() {
		return feId;
	}

	public void setFeId(Integer feId) {
		this.feId = feId;
	}

	public String getFeCode() {
		return feCode;
	}

	public void setFeCode(String feCode) {
		this.feCode = feCode;
	}

	public String getFeName() {
		return feName;
	}

	public void setFeName(String feName) {
		this.feName = feName;
	}

	public String getFeStandard() {
		return feStandard;
	}

	public void setFeStandard(String feStandard) {
		this.feStandard = feStandard;
	}

	public String getFeRemark() {
		return feRemark;
	}

	public void setFeRemark(String feRemark) {
		this.feRemark = feRemark;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getFeType() {
		return feType;
	}

	public void setFeType(String feType) {
		this.feType = feType;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public String getFext1() {
		return fext1;
	}

	public void setFext1(String fext1) {
		this.fext1 = fext1;
	}

	public String getFext2() {
		return fext2;
	}

	public void setFext2(String fext2) {
		this.fext2 = fext2;
	}

	public String getFext3() {
		return fext3;
	}

	public void setFext3(String fext3) {
		this.fext3 = fext3;
	}

	public String getFext4() {
		return fext4;
	}

	public void setFext4(String fext4) {
		this.fext4 = fext4;
	}

	public String getFext5() {
		return fext5;
	}

	public void setFext5(String fext5) {
		this.fext5 = fext5;
	}

	public String getFext6() {
		return fext6;
	}

	public void setFext6(String fext6) {
		this.fext6 = fext6;
	}
	
	
	
	
}
