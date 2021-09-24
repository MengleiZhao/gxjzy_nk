package com.braker.icontrol.expend.standard.entity;

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
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;

/**
 * 培训费用的配置信息
 * @author 张迅
 * @createtime 2019-05-24
 * @updatetime 2019-05-24
 */
@Entity
@Table(name = "T_TRAIN_STANDARD")
public class TrainStandard extends Standard  {
	
	
	/** 业务字段 **/
	
	@Column(name = "T_COST_HOTEL")
	private Double costHotel;						//住宿费
	
	@Column(name = "T_COST_FOOD")
	private Double costFood;						//伙食费
	
	@Column(name = "T_COST_BOOK")
	private Double costBook;						//资料、交通费、场地费
	
	@Column(name = "T_COST_OTHER")
	private Double costOther;						//其他费用
	
	@Column(name = "T_COST_EXTERNAL_HOTEL")
	private Double costExternalHotel;				//外部住宿费
	
	@Column(name = "T_COST_EXTERNAL_FOOD")
	private Double costExternalFood;				//外部伙食费
	
	@Column(name = "T_COST_EXTERNAL_BOOK")
	private Double costExternalBook;				//外部资料、交通费、场地费
	
	@Column(name = "T_COST_EXTERNAL_OTHER")
	private Double costExternalOther;				//外部其他费用
	
	@Column(name = "T_COST_TEACH1")
	private Double costTeach1;						//1级师资费（院士、全国知名专家）
	
	@Column(name = "T_COST_TEACH2")
	private Double costTeach2;						//2级师资费（正高级技术职称专业人员）
	
	@Column(name = "T_COST_TEACH3")
	private Double costTeach3;						//3级师资费（副高级技术职称专业人员）
		
	@Column(name = "F_TRAIN_TYPE")					
	private Integer fTrainType;						//培训类型 1-一类培训 2-二类培训 3-三类培训
	
	@Transient
	private int pageOrder; 							//页面显示排序

	/** getter/setter **/
	

	public int getPageOrder() {
		return pageOrder;
	}

	public void setPageOrder(int pageOrder) {
		this.pageOrder = pageOrder;
	}

	public Double getCostHotel() {
		return costHotel;
	}

	public void setCostHotel(Double costHotel) {
		this.costHotel = costHotel;
	}

	public Double getCostFood() {
		return costFood;
	}

	public void setCostFood(Double costFood) {
		this.costFood = costFood;
	}

	public Double getCostBook() {
		return costBook;
	}

	public void setCostBook(Double costBook) {
		this.costBook = costBook;
	}

	public Double getCostOther() {
		return costOther;
	}

	public void setCostOther(Double costOther) {
		this.costOther = costOther;
	}

	public Double getCostTeach1() {
		return costTeach1;
	}

	public void setCostTeach1(Double costTeach1) {
		this.costTeach1 = costTeach1;
	}

	public Double getCostTeach2() {
		return costTeach2;
	}

	public void setCostTeach2(Double costTeach2) {
		this.costTeach2 = costTeach2;
	}

	public Double getCostTeach3() {
		return costTeach3;
	}

	public void setCostTeach3(Double costTeach3) {
		this.costTeach3 = costTeach3;
	}

	public Integer getfTrainType() {
		return fTrainType;
	}

	public void setfTrainType(Integer fTrainType) {
		this.fTrainType = fTrainType;
	}

	public Double getCostExternalHotel() {
		return costExternalHotel;
	}

	public void setCostExternalHotel(Double costExternalHotel) {
		this.costExternalHotel = costExternalHotel;
	}

	public Double getCostExternalFood() {
		return costExternalFood;
	}

	public void setCostExternalFood(Double costExternalFood) {
		this.costExternalFood = costExternalFood;
	}

	public Double getCostExternalBook() {
		return costExternalBook;
	}

	public void setCostExternalBook(Double costExternalBook) {
		this.costExternalBook = costExternalBook;
	}

	public Double getCostExternalOther() {
		return costExternalOther;
	}

	public void setCostExternalOther(Double costExternalOther) {
		this.costExternalOther = costExternalOther;
	}

	
	
	
}

