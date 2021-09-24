package com.braker.icontrol.budget.performancemanage.selfeval.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 *绩效自评结果的model
 * 
 * @author 冉德茂
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Entity
@Table(name = "T_ACHIEVE_RESULT")
public class AchieveResult extends BaseEntityEmpty{
	@Id
	@Column(name = "F_A_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer faId;			//主键ID
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;			//外键    项目表的id
	
	@Column(name = "F_B_INDEX_CODE")
	private String  fbIndexCodeb;			//指标编码
	
	@Column(name = "F_B_INDEX_NAME")
	private String  col4;			//指标名称
	
	@Column(name = "F_INDEX_AMOUNT")
	private Double  col10;			//指标预算金额
	
	@Column(name = "F_INDEX_AMOUNT_YEAR")
	private Double  col7;			//本年度执行目标
	
	@Transient
	private Integer col1;			//序号(数据库中没有)
	@Transient
	private String  col2;			//一级指标
	@Transient
	private String  col3;			//二级指标
	
	
	@Column(name = "F_INDEX_AMOUNT_YAER_ACTUAL")
	private Double  findexAmountYearActualb;			//本年度实际完成额
	
	@Column(name = "F_EXEC_RATE")
	private Double  fexecRateb;			//完成率
	
	@Column(name = "F_DEVIATION")
	private Double  fdeviationb;			//实际偏差

	@Column(name = "F_DEVIATION_DESC")
	private String  fdeviationDescb;			//偏差原因分析
	
	@Column(name = "F_REMARK")
	private String  fremarkb;			//备注
	
	@Column(name = "F_USER_NAME")
	private String  fuserNameb;			//自评负责人
	
	@Column(name = "F_EVAL_TYPE")
	private String  fevalTypeb;			//自评方式
	
	@Column(name = "F_EVAL_TIME")
	private Date  fevalTimeb;			//自评提交时间

	public Integer getFaId() {
		return faId;
	}

	public void setFaId(Integer faId) {
		this.faId = faId;
	}

	public Integer getFproId() {
		return fproId;
	}

	public void setFproId(Integer fproId) {
		this.fproId = fproId;
	}

	public String getFbIndexCodeb() {
		return fbIndexCodeb;
	}

	public void setFbIndexCodeb(String fbIndexCodeb) {
		this.fbIndexCodeb = fbIndexCodeb;
	}

	public String getCol4() {
		return col4;
	}

	public void setCol4(String col4) {
		this.col4 = col4;
	}

	public Double getCol10() {
		return col10;
	}

	public void setCol10(Double col10) {
		this.col10 = col10;
	}

	public Double getCol7() {
		return col7;
	}

	public void setCol7(Double col7) {
		this.col7 = col7;
	}

	public Double getFindexAmountYearActualb() {
		return findexAmountYearActualb;
	}

	public void setFindexAmountYearActualb(Double findexAmountYearActualb) {
		this.findexAmountYearActualb = findexAmountYearActualb;
	}

	public Double getFexecRateb() {
		return fexecRateb;
	}

	public void setFexecRateb(Double fexecRateb) {
		this.fexecRateb = fexecRateb;
	}

	public Double getFdeviationb() {
		return fdeviationb;
	}

	public void setFdeviationb(Double fdeviationb) {
		this.fdeviationb = fdeviationb;
	}

	public String getFdeviationDescb() {
		return fdeviationDescb;
	}

	public void setFdeviationDescb(String fdeviationDescb) {
		this.fdeviationDescb = fdeviationDescb;
	}

	public String getFremarkb() {
		return fremarkb;
	}

	public void setFremarkb(String fremarkb) {
		this.fremarkb = fremarkb;
	}

	public String getFuserNameb() {
		return fuserNameb;
	}

	public void setFuserNameb(String fuserNameb) {
		this.fuserNameb = fuserNameb;
	}

	public String getFevalTypeb() {
		return fevalTypeb;
	}

	public void setFevalTypeb(String fevalTypeb) {
		this.fevalTypeb = fevalTypeb;
	}

	public Date getFevalTimeb() {
		return fevalTimeb;
	}

	public void setFevalTimeb(Date fevalTimeb) {
		this.fevalTimeb = fevalTimeb;
	}

	public Integer getCol1() {
		return col1;
	}

	public void setCol1(Integer col1) {
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

	@Override
	public String toString() {
		return "AchieveResult [faId=" + faId + ", fproId=" + fproId
				+ ", fbIndexCodeb=" + fbIndexCodeb + ", col4=" + col4
				+ ", col10=" + col10 + ", col7=" + col7
				+ ", findexAmountYearActualb=" + findexAmountYearActualb
				+ ", fexecRateb=" + fexecRateb + ", fdeviationb=" + fdeviationb
				+ ", fdeviationDescb=" + fdeviationDescb + ", fremarkb="
				+ fremarkb + ", fuserNameb=" + fuserNameb + ", fevalTypeb="
				+ fevalTypeb + ", fevalTimeb=" + fevalTimeb + "]";
	}


	
	
	
	
	
	
	
}
