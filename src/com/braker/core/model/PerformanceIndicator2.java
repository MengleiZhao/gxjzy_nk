package com.braker.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.Combobox;
/**
 * 二级绩效指标2
 * @author 陈睿超
 *
 */
@Entity
@Table(name ="T_PERFORMANCE_INDICATOR2")
public class PerformanceIndicator2 extends BaseEntityEmpty implements Combobox{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_PER_ID2")
	private Integer fPerId2;//二级绩效指标主键
	
	@Column(name ="F_PER_ID1")
	private Integer pi1;//一级指标外键
	
	@Column(name ="F_PER_CODE2")
	private String fPerCode2;//二级绩效指标代码
	
	@Column(name ="F_PER_NAME2")
	private String fPerName2;//二级绩效指标名称
	
	@Transient
	private Integer fP1;//页面传输是存储一级指标主键
	
	@Transient
	private Integer number;//序号
	
	@Transient
	private String fPerName1;
	
	@Transient
	private String fPerid1;

	public Integer getfPerId2() {
		return fPerId2;
	}

	public void setfPerId2(Integer fPerId2) {
		this.fPerId2 = fPerId2;
	}

	public String getfPerCode2() {
		return fPerCode2;
	}

	public void setfPerCode2(String fPerCode2) {
		this.fPerCode2 = fPerCode2;
	}

	public String getfPerName2() {
		return fPerName2;
	}

	public void setfPerName2(String fPerName2) {
		this.fPerName2 = fPerName2;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getfP1() {
		return fP1;
	}

	public void setfP1(Integer fP1) {
		this.fP1 = fP1;
	}

	public String getfPerName1() {
		return fPerName1;
	}

	public void setfPerName1(String fPerName1) {
		this.fPerName1 = fPerName1;
	}

	public String getfPerid1() {
		return fPerid1;
	}

	public void setfPerid1(String fPerid1) {
		this.fPerid1 = fPerid1;
	}

	@Override
	public String getId() {
		return String.valueOf(fPerId2);
	}
	
	@Override
	public String getCode() {
		return fPerCode2;
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
		return fPerName2;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}

	

}
