package com.braker.icontrol.expend.standard.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntityEmpty;

/**
 * 地区表
* <p>Title:TDateBusyTime </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年5月17日
 */
@Entity
@Table(name = "REGION")
public class Region extends BaseEntityEmpty {
	
	@Id
	@Column(name = "CODE")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer code;				//主键ID
	
	@Column(name = "P_CODE")
	private Integer pCode;

	@Column(name = "NAME")
	private String name;

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Integer getpCode() {
		return pCode;
	}

	public void setpCode(Integer pCode) {
		this.pCode = pCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

