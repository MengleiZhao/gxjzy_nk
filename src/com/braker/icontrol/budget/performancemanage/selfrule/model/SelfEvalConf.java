package com.braker.icontrol.budget.performancemanage.selfrule.model;

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
import com.braker.core.model.Lookups;

/**
 * 绩效评价配置管理的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-14
 * @updatetime 2018-08-14
 */
@Entity
@Table(name = "T_SELF_EVAL_CONF")
public class SelfEvalConf extends BaseEntityEmpty{
	@Id
	@Column(name = "F_C_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fcId;			//主键ID
	
	@Column(name = "F_T_ID")
	private Integer ftId;			//外键    模版表id
	
	@ManyToOne
	@JoinColumn(name = "F_EVAL_TYPE",referencedColumnName="lookupscode")
	private Lookups fevalType;				//自评规则类型
	
	@Column(name = "F_IS_AVOID")
	private String fisAvoid;				//是否规避
	
	@Column(name = "F_AMOUNT_MIN")
	private String famountMin;				//评选项目金额最小值
	
	@Column(name = "F_AMOUNT_MAX")
	private String famountMax;				//评选项目金额最大值
	
	@Column(name = "F_RATE")
	private String frate;				//筛选比例
	
	@Column(name = "F_RANDOM_MOUNT")
	private String frandomMount;				//随机筛选个数

	@Column(name = "F_FIXED_MOUNT")
	private String ffixedMount;				//固定筛选数量 选择按钮    1 全部 2一半3 其他数量

	@Column(name = "F_OTHER_MOUNT")
	private String fotherMount;				//乘上   固定筛选数量选其他数量才有
	
	@Column(name = "F_EVAL_DATE_START")
	private Date fevalDateStart;				//自评开始时间（定时调度）
	
	@Column(name = "F_EVAL_DATE_END")
	private Date fevalDateEnd;				//自评结束时间	
	
	@Transient
	private Integer num;			//序号(数据库中没有)
	
	@Transient
	private String  evaltype;			//自评规则类型  用于详情页面查看
	

	public String getEvaltype() {
		if (fevalType != null) {
			return fevalType.getName();
		}
		return evaltype;
	}

	public void setEvaltype(String evaltype) {
		this.evaltype = evaltype;
	}

	public Integer getFcId() {
		return fcId;
	}

	public void setFcId(Integer fcId) {
		this.fcId = fcId;
	}

	public Integer getFtId() {
		return ftId;
	}

	public void setFtId(Integer ftId) {
		this.ftId = ftId;
	}

	public Lookups getFevalType() {
		return fevalType;
	}

	public void setFevalType(Lookups fevalType) {
		this.fevalType = fevalType;
	}

	public String getFisAvoid() {
		return fisAvoid;
	}

	public void setFisAvoid(String fisAvoid) {
		this.fisAvoid = fisAvoid;
	}

	public String getFamountMin() {
		return famountMin;
	}

	public void setFamountMin(String famountMin) {
		this.famountMin = famountMin;
	}

	public String getFamountMax() {
		return famountMax;
	}

	public void setFamountMax(String famountMax) {
		this.famountMax = famountMax;
	}



	public Date getFevalDateStart() {
		return fevalDateStart;
	}

	public void setFevalDateStart(Date fevalDateStart) {
		this.fevalDateStart = fevalDateStart;
	}

	public Date getFevalDateEnd() {
		return fevalDateEnd;
	}

	public void setFevalDateEnd(Date fevalDateEnd) {
		this.fevalDateEnd = fevalDateEnd;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}



	public String getFrate() {
		return frate;
	}

	public void setFrate(String frate) {
		this.frate = frate;
	}

	public String getFfixedMount() {
		return ffixedMount;
	}

	public void setFfixedMount(String ffixedMount) {
		this.ffixedMount = ffixedMount;
	}

	public String getFrandomMount() {
		return frandomMount;
	}

	public void setFrandomMount(String frandomMount) {
		this.frandomMount = frandomMount;
	}

	public String getFotherMount() {
		return fotherMount;
	}

	public void setFotherMount(String fotherMount) {
		this.fotherMount = fotherMount;
	}





	
}
