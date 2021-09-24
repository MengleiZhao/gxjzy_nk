package com.braker.icontrol.budget.manager.entity;

import java.util.Date;

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
import com.braker.core.model.Depart;
import com.braker.core.model.User;

/**
 * 指标支出流水记录
 * @author 张迅
 * @createtime 2019-01-17
 * @updatetime 2019-01-17
 */
@Entity
@Table(name = "t_index_detail")
public class TOutcomeLog extends BaseEntityEmpty {
	
	
	@Id
	@Column(name = "F_L_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer pid;		//主键
	
	@Column(name = "F_TYPE")
	private String type;		//类型
	
	@Column(name = "F_DEPARTMENT")
	private String depart;		//单位id
	
	@ManyToOne
	@JoinColumn(name = "F_USER_ID")
	private User user;			//用户id
	
	@Column(name = "F_TIME")
	private Date date;			//操作时间
	
	@Column(name = "F_AMOUNT")
	private Double amount;		//变更金额
	
	@Column(name = "F_INDEX_NAME")
	private String indexName;	//指标名称
	
	@Column(name = "F_INDEX_CODE")
	private String indexCode;	//指标编号
	
	@Column(name = "F_EXT_1")
	private String url;	//路径
	
	@Transient
	private int pageOrder;
	@Transient
	private String userName;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getIndexName() {
		return indexName;
	}
	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}
	public String getIndexCode() {
		return indexCode;
	}
	public void setIndexCode(String indexCode) {
		this.indexCode = indexCode;
	}
	public int getPageOrder() {
		return pageOrder;
	}
	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}
	public String getUserName() {
		if (user != null) {
			return user.getName();
		}
		return "";
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
