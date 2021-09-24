package com.braker.core.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
/**
 * 自定义表
 * @author zhang_lianhai
 *
 */
@Entity
@Table(name="COMM_PARAM")
public class SysParam implements Serializable{
	private static final long serialVersionUID = 2005335674290610420L;
	
	@Id
    @Column(name = "PID")
    @GeneratedValue(generator = "hibernate-uuid")
    @GenericGenerator(name = "hibernate-uuid", strategy = "guid")
	private String id;//主键ID
	@Column(name = "param_key")
	private String paramKey;//属性key
	@Column(name = "param_value")
	private String paramValue;//属性值
	@Column(name = "remark")
	private String remark;//备注
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParamKey() {
		return paramKey;
	}
	public void setParamKey(String paramKey) {
		this.paramKey = paramKey;
	}
	public String getParamValue() {
		return paramValue;
	}
	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
}
