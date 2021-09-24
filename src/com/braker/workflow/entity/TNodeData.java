package com.braker.workflow.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.core.model.User;

/**
 * 流程节点表 
 * @author anda
 * 2019-4-19
 */
@Entity
@Table(name = "t_node_data")
public class TNodeData implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	@Column(name ="F_N_Id")	
	private Integer FNId;//主键
	@Column(name ="F_P_ID")	
	private Integer FPId;//流程定义id
	@Column(name ="KEY_ID")	
	private Integer keyId;//key值
	@Column(name ="TEXT")	
	private String text;//节点名称
	@Column(name ="FIGURE")	
	private String figure;//图形
	@Column(name ="FILL")	
	private String fill;//图形颜色
	@Column(name ="STEP_TYPE")	
	private String stepType; //节点类型
	@Column(name ="LOC")	
	private String loc; //坐标
	@Column(name ="ROLE_ID")	
	private String roleId; //角色id
	@Column(name ="DEPART_ID")	
	private String departId; //部门id
	@Column(name ="USER_ID")	
	private String userId; //用户id
	@Column(name ="AGREE")	
	private Integer agree; //同意跳转节点
	@Column(name ="REFUSE")	
	private Integer refuse; //拒绝跳转节点
	@Column(name ="CATEGORY")	
	private String category; //拒绝跳转节点
	@Column(name ="CUSTOM")	
	private String custom; //条件表达式，根据条件自定义跳转
	
	@Transient
	private String roleName;	//角色名称(数据库中没有)
	
	@Transient
	private Integer key;	//映射到数据库字段 key_id  因为数据库的 "key" 这个字段是关键字，不允许当成字段

	@Transient
	private User user;//审批用户信息，数据库不存在用于携带信息到前台
	@Transient
	private TProcessCheck checkInfo;//审批记录
	
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Integer getKey() {
		return key;
	}

	public void setKey(Integer key) {
		this.key = key;
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


	public Integer getKeyId() {
		return keyId;
	}

	public void setKeyId(Integer keyId) {
		this.keyId = keyId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getFigure() {
		return figure;
	}

	public void setFigure(String figure) {
		this.figure = figure;
	}

	public String getFill() {
		return fill;
	}

	public void setFill(String fill) {
		this.fill = fill;
	}

	public String getStepType() {
		return stepType;
	}

	public void setStepType(String stepType) {
		this.stepType = stepType;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getDepartId() {
		return departId;
	}

	public void setDepartId(String departId) {
		this.departId = departId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getAgree() {
		return agree;
	}

	public void setAgree(Integer agree) {
		this.agree = agree;
	}

	public Integer getRefuse() {
		return refuse;
	}

	public void setRefuse(Integer refuse) {
		this.refuse = refuse;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public TProcessCheck getCheckInfo() {
		return checkInfo;
	}

	public void setCheckInfo(TProcessCheck checkInfo) {
		this.checkInfo = checkInfo;
	}

	public String getCustom() {
		return custom;
	}

	public void setCustom(String custom) {
		this.custom = custom;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public TNodeData(){}
	
	public TNodeData(String roleId,String roleName){
		this.roleId = roleId;
		this.roleName = roleName;
	}

	public TNodeData(Integer fNId, Integer fPId, Integer keyId, String text,
			String figure, String fill, String stepType, String loc,
			String roleId, String departId, String userId, Integer agree,
			Integer refuse, String category, String custom, String roleName,
			Integer key, User user, TProcessCheck checkInfo) {
		super();
		FNId = fNId;
		FPId = fPId;
		this.keyId = keyId;
		this.text = text;
		this.figure = figure;
		this.fill = fill;
		this.stepType = stepType;
		this.loc = loc;
		this.roleId = roleId;
		this.departId = departId;
		this.userId = userId;
		this.agree = agree;
		this.refuse = refuse;
		this.category = category;
		this.custom = custom;
		this.roleName = roleName;
		this.key = key;
		this.user = user;
		this.checkInfo = checkInfo;
	}


}