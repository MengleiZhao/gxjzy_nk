package com.braker.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 系统主题配置model
 * @author 叶崇晖
 * @createtime 2018-12-12
 * @updatetime 2018-12-12
 */
@Entity
@Table(name = "T_SYSTEM_THEMES")
public class SystemThemes extends BaseEntityEmpty {
	@Id
	@Column(name = "F_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fId;			//主键ID
	
	@Column(name = "F_NAME")
	private String name;			//主题名称
	
	@Column(name = "F_CODE")
	private String code;			//主题编码
	
	@Column(name = "F_URL1")
	private String url1;			//路径1
	
	@Column(name = "F_URL2")
	private String url2;			//路径2
	
	@Column(name = "F_URL3")
	private String url3;			//路径3
	
	@Column(name = "F_START_DATE")
	private Date startDate;			//开始时间
	
	@Column(name = "F_END_DATE")
	private Date endDate;			//结束时间
	
	@Column(name = "F_STAUTS")
	private String stauts;			//激活状态

	public Integer getfId() {
		return fId;
	}

	public void setfId(Integer fId) {
		this.fId = fId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getUrl1() {
		return url1;
	}

	public void setUrl1(String url1) {
		this.url1 = url1;
	}

	public String getUrl2() {
		return url2;
	}

	public void setUrl2(String url2) {
		this.url2 = url2;
	}

	public String getUrl3() {
		return url3;
	}

	public void setUrl3(String url3) {
		this.url3 = url3;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getStauts() {
		return stauts;
	}

	public void setStauts(String stauts) {
		this.stauts = stauts;
	}
	
	
}