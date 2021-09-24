package com.braker.common.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;

import com.braker.common.util.StringUtil;
import com.braker.core.model.User;

@MappedSuperclass
public class DefaultEntity extends AbstractEntity {

	/** 系统字段 **/

	@Id
	@Column(name = "PID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;								//主键ID
	
	@ManyToOne()
	@JoinColumn(name = "CREATOR", updatable=false)
	private User creator;							//创建人
	
	@ManyToOne
	@JoinColumn(name = "UPDATER")
	private User updator;							//更新人
	
	@Column(name = "CREATETIME", updatable=false)
	private Date createtime = new Date();			//创建时间
	
	@Column(name = "UPDATETIME")
	private Date updateTime;						//更新时间
	
	@Column(name = "PFLAG")
	private Integer flag;							//删除标记
	
	/** getter/setter **/
	
	@Override
	public String getId() {
		return String.valueOf(this.id);
	}
	
	@Override
	public void setId(String id) {
		if (!StringUtil.isEmpty(id)) {
			this.id = Integer.valueOf(id);
		}
	}
	
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public User getUpdator() {
		return updator;
	}

	public void setUpdator(User updator) {
		this.updator = updator;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}
}
