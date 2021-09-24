package com.braker.icontrol.cgmanage.cgprocess.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntityEmpty;

/**
 * 中标和评标专家的关系映射实体类
 * @author 冉德茂
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */

@Entity
@Table(name="T_BID_EXPERT_REF")
public class BidExpertRef extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_MAIN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fmainId;
	
	@Column(name ="F_BID_ID")							//中标表ID
	private Integer fbIdId;
	
	@Column(name ="F_E_ID")							//专家表ID
	private Integer feId;
		

	
	@Transient
	private Integer num;			//序号(数据库中没有)



	public Integer getFmainId() {
		return fmainId;
	}



	public void setFmainId(Integer fmainId) {
		this.fmainId = fmainId;
	}



	public Integer getFbIdId() {
		return fbIdId;
	}



	public void setFbIdId(Integer fbIdId) {
		this.fbIdId = fbIdId;
	}







	public Integer getFeId() {
		return feId;
	}



	public void setFeId(Integer feId) {
		this.feId = feId;
	}



	public Integer getNum() {
		return num;
	}



	public void setNum(Integer num) {
		this.num = num;
	}


	
	
	
	
	
	

}
