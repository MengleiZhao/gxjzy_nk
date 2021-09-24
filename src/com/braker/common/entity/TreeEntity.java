package com.braker.common.entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TreeEntity{
	private String id;
	private String text;
	private String state;//节点状态
	private boolean isLeaf;//是否为叶子节点
	private String code;
	private String haveChild;//是否含有子节点
	private String parentId;//父节点id
	private String parentCode;//父节点编码
	private List<TreeEntity> children;//子节点集合
	public boolean selected;//是否选择
	public boolean checked;//是否选中
	public String isdepartment;//是否本部门指标
	
	
	private String col1;
	private String col2;
	private String col3;
	private String col4;
	private String col5;
	private String col6;
	private String col7;
	private String col8;
	private String col9;
	private String col10;
	
	//部门表中 个人涉稳相关字段 
	private String grww_zrld;
	private String grww_zrlddh;
	private String grww_lxr;
	private String grww_lxrdh;
	
	//二下表中 金额相关字段
	private Double amount;//本次下达金额
	private Double residAmount;	//科目剩余金额
	private String departName;		//所属部门名称
	
	
	public String getIsdepartment() {
		return isdepartment;
	}
	public void setIsdepartment(String isdepartment) {
		this.isdepartment = isdepartment;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public boolean isLeaf() {
		return isLeaf;
	}
	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getHaveChild() {
		return haveChild;
	}
	public void setHaveChild(String haveChild) {
		this.haveChild = haveChild;
	}
	public List<TreeEntity> getChildren() {
		return children;
	}
	public void setChildren(List<TreeEntity> children) {
		this.children = children;
	}
	public String getGrww_zrld() {
		return grww_zrld;
	}
	public void setGrww_zrld(String grwwZrld) {
		grww_zrld = grwwZrld;
	}
	public String getGrww_zrlddh() {
		return grww_zrlddh;
	}
	public void setGrww_zrlddh(String grwwZrlddh) {
		grww_zrlddh = grwwZrlddh;
	}
	public String getGrww_lxr() {
		return grww_lxr;
	}
	public void setGrww_lxr(String grwwLxr) {
		grww_lxr = grwwLxr;
	}
	public String getGrww_lxrdh() {
		return grww_lxrdh;
	}
	public void setGrww_lxrdh(String grwwLxrdh) {
		grww_lxrdh = grwwLxrdh;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getCol1() {
		return col1;
	}
	public void setCol1(String col1) {
		this.col1 = col1;
	}
	public String getCol2() {
		return col2;
	}
	public void setCol2(String col2) {
		this.col2 = col2;
	}
	public String getCol3() {
		return col3;
	}
	public void setCol3(String col3) {
		this.col3 = col3;
	}
	public String getCol4() {
		return col4;
	}
	public void setCol4(String col4) {
		this.col4 = col4;
	}
	public String getCol5() {
		return col5;
	}
	public void setCol5(String col5) {
		this.col5 = col5;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public String getCol6() {
		return col6;
	}
	public void setCol6(String col6) {
		this.col6 = col6;
	}
	public String getCol7() {
		return col7;
	}
	public void setCol7(String col7) {
		this.col7 = col7;
	}
	public String getCol8() {
		return col8;
	}
	public void setCol8(String col8) {
		this.col8 = col8;
	}
	public String getCol9() {
		return col9;
	}
	public void setCol9(String col9) {
		this.col9 = col9;
	}
	public String getCol10() {
		return col10;
	}
	public void setCol10(String col10) {
		this.col10 = col10;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getResidAmount() {
		return residAmount;
	}
	public void setResidAmount(Double residAmount) {
		this.residAmount = residAmount;
	}
	public String getDepartName() {
		return departName;
	}
	public void setDepartName(String departName) {
		this.departName = departName;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	
}