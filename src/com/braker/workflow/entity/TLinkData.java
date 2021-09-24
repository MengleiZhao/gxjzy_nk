package com.braker.workflow.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 流程流转表 
 * @author anda
 * 2019-4-23
 */
@Entity
@Table(name = "t_link_data")
public class TLinkData  implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	@Column(name ="F_L_Id")	
	private Integer FNId;//主键
	@Column(name ="F_P_ID")	
	private Integer FPId;//流程定义id
	@Column(name ="FROM_KEY")	
	private Integer fromKey;//出发点
	@Column(name ="TO_KEY")	
	private Integer toKey;//到达点
	@Column(name ="TEXT")	
	private String text;//备注
	@Column(name ="COLOR")	
	private String color;//颜色
	@Column(name ="LOC")	
	private String loc; //坐标
	@Column(name ="FROM_PORT")	
	private String fromPort; //出发点  T顶端    L左边   R右边 
	@Column(name ="TO_PORT")	
	private String toPort; //到达点
	@Column(name ="CUSTOM")	
	private String custom; //条件表达式，根据条件自定义跳转
	
	
	@Transient
	private Integer from;	//映射到数据库字段 FROM_KEY  因为数据库的 "from" 这个字段是关键字，不允许当成字段
	@Transient
	private Integer to;	//映射到数据库字段 TO_KEY  因为数据库的 "to" 这个字段是关键字，不允许当成字段
	
	
	public Integer getFrom() {
		if(from==null){
			return fromKey;
		}else{
			return from;
		}
		
	}
	public void setFrom(Integer from) {
		this.from = from;
	}
	public Integer getTo() {
		if(to==null){
			return toKey;
		}else{
			return to;
		}
	}
	public void setTo(Integer to) {
		this.to = to;
	}
	public Integer getFNId() {
		return FNId;
	}
	public void setFNId(Integer fNId) {
		FNId = fNId;
	}
	public Integer getFPId() {
		return FPId;
	}
	public void setFPId(Integer fPId) {
		FPId = fPId;
	}
	

	public Integer getFromKey() {
		return fromKey;
	}
	public void setFromKey(Integer fromKey) {
		this.fromKey = fromKey;
	}
	public Integer getToKey() {
		return toKey;
	}
	public void setToKey(Integer toKey) {
		this.toKey = toKey;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getFromPort() {
		return fromPort;
	}
	public void setFromPort(String fromPort) {
		this.fromPort = fromPort;
	}
	public String getToPort() {
		return toPort;
	}
	public void setToPort(String toPort) {
		this.toPort = toPort;
	}
	public String getCustom() {
		return custom;
	}
	public void setCustom(String custom) {
		this.custom = custom;
	}
	

}