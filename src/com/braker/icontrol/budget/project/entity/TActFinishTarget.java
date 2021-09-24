package com.braker.icontrol.budget.project.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;
import com.braker.common.entity.EntityDao;

/**
 * 项目绩效目标实际完成表的model
 * @author 冉德茂
 * @createtime 2018-09-17
 * @updatetime 2018-09-17
 */

@Entity
@Table(name="T_ACT_FINISH_TARGET")
public class TActFinishTarget extends BaseEntityEmpty  implements EntityDao{
	
	@Id
	@Column(name = "F_G_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fgId;
	
	@Column(name = "F_PRO_ID")
	private Integer fproId;			//项目基本信息id
	
	@Column(name = "F_TOTAL_YEAR")
	private Double ftoalYear;			//年度资金总额实际全年执行数
	
	@Column(name = "F_TOTAL_GOAL")
	private Double ftotalGoal;			//年度资金总额实际分值
	
	@Column(name = "F_TOTAL_RATE")
	private Double ftotalRate;			//年度资金总额实际执行率
	
	@Column(name = "F_TOTAL_SCORE")
	private Double ftotalScore;			//年度资金总额实际得分
	
	@Column(name = "F_ECO_YEAR")
	private Double fecoYear;			//财政拨款实际全年执行数
	
	@Column(name = "F_ECO_GOAL")
	private Double fecoGoal;			//财政拨款实际分值
	
	@Column(name = "F_ECO_RATE")
	private Double fecoRate;			//财政拨款实际执行率
	
	@Column(name = "F_ECO_SCORE")
	private Double fecoScore;			//财政拨款实际得分
	
	@Column(name = "F_OTHER_YEAR")
	private Double fotherYear;			//其他资金实际全年执行数
	
	@Column(name = "F_OTHER_GOAL")
	private Double fotherGoal;			//其他资金实际分值
	
	@Column(name = "F_OTHER_RATE")
	private Double fotherRate;			//其他资金实际执行率
	
	@Column(name = "F_OTHER_SCORE")
	private Double fotherScore;			//其他资金实际得分
	
	@Column(name = "F_REMARK")
	private String fremark;			//目标实际完成情况
		
	@Transient
	private Integer num;			//序号(数据库中没有)

	
	
	

	public String getFremark() {
		return fremark;
	}

	public void setFremark(String fremark) {
		this.fremark = fremark;
	}

	public Integer getFgId() {
		return fgId;
	}

	public void setFgId(Integer fgId) {
		this.fgId = fgId;
	}

	public Integer getFproId() {
		return fproId;
	}

	public void setFproId(Integer fproId) {
		this.fproId = fproId;
	}

	public Double getFtoalYear() {
		return ftoalYear;
	}

	public void setFtoalYear(Double ftoalYear) {
		this.ftoalYear = ftoalYear;
	}

	public Double getFtotalGoal() {
		return ftotalGoal;
	}

	public void setFtotalGoal(Double ftotalGoal) {
		this.ftotalGoal = ftotalGoal;
	}

	public Double getFtotalRate() {
		return ftotalRate;
	}

	public void setFtotalRate(Double ftotalRate) {
		this.ftotalRate = ftotalRate;
	}

	public Double getFtotalScore() {
		return ftotalScore;
	}

	public void setFtotalScore(Double ftotalScore) {
		this.ftotalScore = ftotalScore;
	}

	public Double getFecoYear() {
		return fecoYear;
	}

	public void setFecoYear(Double fecoYear) {
		this.fecoYear = fecoYear;
	}

	public Double getFecoGoal() {
		return fecoGoal;
	}

	public void setFecoGoal(Double fecoGoal) {
		this.fecoGoal = fecoGoal;
	}

	public Double getFecoRate() {
		return fecoRate;
	}

	public void setFecoRate(Double fecoRate) {
		this.fecoRate = fecoRate;
	}

	public Double getFecoScore() {
		return fecoScore;
	}

	public void setFecoScore(Double fecoScore) {
		this.fecoScore = fecoScore;
	}

	public Double getFotherYear() {
		return fotherYear;
	}

	public void setFotherYear(Double fotherYear) {
		this.fotherYear = fotherYear;
	}

	public Double getFotherGoal() {
		return fotherGoal;
	}

	public void setFotherGoal(Double fotherGoal) {
		this.fotherGoal = fotherGoal;
	}

	public Double getFotherRate() {
		return fotherRate;
	}

	public void setFotherRate(Double fotherRate) {
		this.fotherRate = fotherRate;
	}

	public Double getFotherScore() {
		return fotherScore;
	}

	public void setFotherScore(Double fotherScore) {
		this.fotherScore = fotherScore;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Transient
	@Override
	public String getJoinTable() {
		return "T_ACT_FINISH_TARGET";
	}

	@Transient
	@Override
	public String getEntryId() {
		return String.valueOf(fgId);
	}


	

}
