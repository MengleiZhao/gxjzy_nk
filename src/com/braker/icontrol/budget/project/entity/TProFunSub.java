package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntity;

/**
 * 功能分类科目表
* <p>Title:TProFunSub </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月2日
 */
@Entity
@Table(name = "T_PRO_FUN_SUB")
public class TProFunSub extends BaseEntity  {
	
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fId;
	
	@Column(name="F_FUN_NAME")
	private String funName;
	
	@Column(name="F_FUN_CODE")
	private String funCode;

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getFunName() {
		return funName;
	}

	public void setFunName(String funName) {
		this.funName = funName;
	}

	public String getFunCode() {
		return funCode;
	}

	public void setFunCode(String funCode) {
		this.funCode = funCode;
	}
}