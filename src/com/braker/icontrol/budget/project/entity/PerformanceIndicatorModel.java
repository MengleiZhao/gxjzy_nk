package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * <p>Description: 项目申报  绩效指标</p>
 * @author:焦广兴
 * @date： 2019年10月09日
 */
@Entity
@Table(name = "T_PERFORMANCE_INDICATOR")
public class PerformanceIndicatorModel extends BaseEntityEmpty  {
	
	@Id
	@Column(name = "T_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private String tPId;
	
	@Column(name = "F_PRO_ID")
	private Integer fProId;  //项目id
	
	@Column(name = "T_ONE_CODE")
	private String tOneCode;  //一级指标编码
	
	@Column(name = "T_ONE_NAME")
	private String tOneName;  //一级指标名称
	
	@Column(name = "T_TWO_CODE")
	private String tTwoCode;  //二级指标编号
	
	@Column(name = "T_TWO_NAME")
	private String tTwoName;  //二级指标名称

	@Column(name = "T_INDEX_VAL")
	private String tIndexVal;  //指标值

	
	@Column(name = "T_INDEX_CONTENT")
	private String indexContent;	 //指标内容
	
	@Transient
	private Integer num;			//序号(数据库中没有)

	public String gettPId() {
		return tPId;
	}

	public Integer getfProId() {
		return fProId;
	}

	public String gettOneCode() {
		return tOneCode;
	}

	public String gettOneName() {
		return tOneName;
	}

	public String gettTwoName() {
		return tTwoName;
	}

	public String gettIndexVal() {
		return tIndexVal;
	}

	public Integer getNum() {
		return num;
	}

	public void settPId(String tPId) {
		this.tPId = tPId;
	}

	public void setfProId(Integer fProId) {
		this.fProId = fProId;
	}

	public void settOneCode(String tOneCode) {
		this.tOneCode = tOneCode;
	}

	public void settOneName(String tOneName) {
		this.tOneName = tOneName;
	}

	public void settTwoName(String tTwoName) {
		this.tTwoName = tTwoName;
	}

	public void settIndexVal(String tIndexVal) {
		this.tIndexVal = tIndexVal;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getIndexContent() {
		return indexContent;
	}

	public void setIndexContent(String indexContent) {
		this.indexContent = indexContent;
	}

	public String gettTwoCode() {
		return tTwoCode;
	}

	public void settTwoCode(String tTwoCode) {
		this.tTwoCode = tTwoCode;
	}
	
}