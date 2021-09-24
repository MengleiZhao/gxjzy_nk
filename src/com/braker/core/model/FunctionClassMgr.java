package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import com.braker.common.entity.BaseEntityEmpty;

/**
 * 功能分类科目管理
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */

@Entity
@Table(name="T_FUNCTION_CLASS_MGR")
public class FunctionClassMgr extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_M_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fmId;

	@Column(name = "F_EC_CODE")
	private String fecCode;			//科目编号
	
	@Column(name = "F_EC_NAME")
	private String fecName;			//科目名称
	
	@Column(name = "F_EC_DESC")
	private String fecDesc;			//科目说明

	@Transient
	private Integer num;			//序号(数据库中没有)

	
	
	public Integer getFmId() {
		return fmId;
	}

	public void setFmId(Integer fmId) {
		this.fmId = fmId;
	}

	public String getFecCode() {
		return fecCode;
	}

	public void setFecCode(String fecCode) {
		this.fecCode = fecCode;
	}

	public String getFecName() {
		return fecName;
	}

	public void setFecName(String fecName) {
		this.fecName = fecName;
	}

	public String getFecDesc() {
		return fecDesc;
	}

	public void setFecDesc(String fecDesc) {
		this.fecDesc = fecDesc;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}





	

}
