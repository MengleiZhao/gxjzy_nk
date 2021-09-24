package com.braker.core.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;

/**
 * 
 * ClassName: SysDepartEconomic 
 * @Description: 部门和科目的关系的model
 * @author 赵孟雷
 * @date 2019年10月10日
 */
@Entity
@Table(name = "sys_depart_economic")
public class SysDepartEconomic extends BaseEntityEmpty  implements Combobox{
	@Id
	@Column(name = "DEID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private String deId;			//主键ID
	
	@Column(name = "PID")
	private String pId;			//部门ID
	
	@Column(name = "F_EC_CODE")
	private String fEcCode;		//科目code
	
	@Column(name = "F_EC_LEVE")
	private String fEcLeve;		//科目级别
	
	@Column(name = "F_EC_NAME")
	private String fEcName;		//科目名称
	
	@Column(name = "F_EJ_PRO_CODE")
	private String fEjProCode;		//二级分类code
	
	@Column(name = "F_EJ_PRO_NAME")
	private String fEjProName;		//二级分类名称

	@Column(name = "F_DE_YEAR")
	private Integer fDEYear;		//对应关系的年份

	@Transient
	private String funcIds;//科目ID
	
	@Transient
	private String funcCode;//科目code
	
	
	public String getfEjProCode() {
		return fEjProCode;
	}

	public void setfEjProCode(String fEjProCode) {
		this.fEjProCode = fEjProCode;
	}

	public String getfEjProName() {
		return fEjProName;
	}

	public void setfEjProName(String fEjProName) {
		this.fEjProName = fEjProName;
	}

	public String getfEcName() {
		return fEcName;
	}

	public void setfEcName(String fEcName) {
		this.fEcName = fEcName;
	}

	public String getFuncCode() {
		return funcCode;
	}

	public void setFuncCode(String funcCode) {
		this.funcCode = funcCode;
	}

	public String getFuncIds() {
		return funcIds;
	}

	public void setFuncIds(String funcIds) {
		this.funcIds = funcIds;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getfEcCode() {
		return fEcCode;
	}

	public void setfEcCode(String fEcCode) {
		this.fEcCode = fEcCode;
	}

	public String getfEcLeve() {
		return fEcLeve;
	}

	public void setfEcLeve(String fEcLeve) {
		this.fEcLeve = fEcLeve;
	}

	public String getDeId() {
		return deId;
	}

	public void setDeId(String deId) {
		this.deId = deId;
	}

	public Integer getfDEYear() {
		return fDEYear;
	}

	public void setfDEYear(Integer fDEYear) {
		this.fDEYear = fDEYear;
	}

	@Override
	public String getCode() {
		// TODO Auto-generated method stub
		return fEjProCode;
	}

	@Override
	public String getGridCode() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSftjCode() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return fEjProName;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
