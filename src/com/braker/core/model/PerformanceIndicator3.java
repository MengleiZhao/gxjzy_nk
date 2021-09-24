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
@Table(name ="T_PERFORMANCE_INDICATOR3")
public class PerformanceIndicator3 extends BaseEntityEmpty implements Combobox{

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name ="F_PER_ID3")
	private Integer fPerId3;//三级绩效指标主键
	
	@Column(name ="F_PER_ID2")
	private Integer pi2;//二级指标外键
	
	@Column(name ="F_PER_CODE3")
	private String fPerCode3;//三级绩效指标代码
	
	@Column(name ="F_PER_NAME3")
	private String fPerName3;//三级绩效指标名称
	
	@Transient
	private Integer fP1;//页面传输是存储一级指标主键
	
	@Transient
	private Integer number;//序号
	
	@Transient
	private String fPerName1;
	
	@Transient
	private String fPerid1;

	public Integer getfPerId3() {
		return fPerId3;
	}

	public void setfPerId3(Integer fPerId3) {
		this.fPerId3 = fPerId3;
	}

	public Integer getPi2() {
		return pi2;
	}

	public void setPi2(Integer pi2) {
		this.pi2 = pi2;
	}

	public String getfPerCode3() {
		return fPerCode3;
	}

	public void setfPerCode3(String fPerCode3) {
		this.fPerCode3 = fPerCode3;
	}

	public String getfPerName3() {
		return fPerName3;
	}

	public void setfPerName3(String fPerName3) {
		this.fPerName3 = fPerName3;
	}

	public Integer getfP1() {
		return fP1;
	}

	public void setfP1(Integer fP1) {
		this.fP1 = fP1;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
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
	public String getCode() {
		// TODO Auto-generated method stub
		return String.valueOf(fPerId3);
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
		return fPerName3;
	}

	@Override
	public String getDesc() {
		// TODO Auto-generated method stub
		return null;
	}

	
}
