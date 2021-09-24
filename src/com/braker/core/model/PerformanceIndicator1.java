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
 * 一级绩效指标1
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_PERFORMANCE_INDICATOR1")
public class PerformanceIndicator1 extends BaseEntityEmpty implements Combobox{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_PER_ID1")
	private Integer fPerId1;//一级绩效指标主键
	
	@Column(name ="F_PER_CODE")
	private String fPerCode1;//一级绩效指标代码
	
	@Column(name ="F_PER_NAME")
	private String fPerName1;//一级绩效指标名称
	
	@Transient
	private Integer number;//序号

	public Integer getfPerId1() {
		return fPerId1;
	}

	public void setfPerId1(Integer fPerId1) {
		this.fPerId1 = fPerId1;
	}

	public String getfPerCode1() {
		return fPerCode1;
	}

	public void setfPerCode1(String fPerCode1) {
		this.fPerCode1 = fPerCode1;
	}

	public String getfPerName1() {
		return fPerName1;
	}

	public void setfPerName1(String fPerName1) {
		this.fPerName1 = fPerName1;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	@Override
	public String getCode() {
		return fPerCode1;
	}
	
	@Override
	public String getId() {
		return String.valueOf(fPerId1);
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
		return fPerName1;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
