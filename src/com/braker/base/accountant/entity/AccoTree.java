package com.braker.base.accountant.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;

@Entity
@Table(name="t_acco_tree")
public class AccoTree extends BaseEntity{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="F_EC_ID")
	private Integer fid;//F_EC_ID
	
	@Column(name ="F_Y_B_ID")
	private Integer fYBId;//年度科目外键
	
	@Column(name="F_EC_CODE")
	private String code;//科目编号
	
	@Column(name="F_EC_NAME")
	private String name;//科目名称
	
	@Column(name="F_EC_LEVE")
	private String leve;//科目级别
	
	@Column(name="F_P_EC_ID")
	private Integer pid;//上级科目编号
	
	@Column(name ="F_IS_ON")
	private String on;//是否启用
	
	@Column(name ="F_EC_TYPE")
	private String type;//科目类型
	
	@Transient
	private List daw;
	
	
	public List getDaw() {
		return daw;
	}

	public void setDaw(List daw) {
		this.daw = daw;
	}

	/*	@Column(name ="F_CREATE_USER")
	private String cuser;//创建人
	
	@Column(name="F_CREATE_TIME")
	private Date ctime;//创建时间
	
	@Column (name ="F_UPDATE_USER")
	private String uuser;//修改人
	
	@Column(name ="F_UPDATE_TIME")
	private Date utime;//修改时间
*/
	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLeve() {
		return leve;
	}

	public void setLeve(String leve) {
		this.leve = leve;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getOn() {
		return on;
	}

	public void setOn(String on) {
		this.on = on;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

/*	public String getCuser() {
		return cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	public Date getCtime() {
		return ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public String getUuser() {
		return uuser;
	}

	public void setUuser(String uuser) {
		this.uuser = uuser;
	}

	public Date getUtime() {
		return utime;
	}

	public void setUtime(Date utime) {
		this.utime = utime;
	}*/
	
	@Override
	public String getId() {
		return String.valueOf(fid);
	}

	public Integer getfYBId() {
		return fYBId;
	}

	public void setfYBId(Integer fYBId) {
		this.fYBId = fYBId;
	}
	
	
}
