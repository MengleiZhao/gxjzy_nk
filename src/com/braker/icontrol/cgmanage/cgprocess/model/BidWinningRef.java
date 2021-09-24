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
 * 中标和供应商的关系映射实体类
 * @author 冉德茂
 * @createtime 2018-07-26
 * @updatetime 2018-07-26
 */

@Entity
@Table(name="T_BID_WINNING_REF")
public class BidWinningRef extends BaseEntityEmpty{
	
	@Id
	@Column(name = "F_MAIN_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)   //主键ID
	private Integer fmainId;
	
	@Column(name ="F_B_ID")							//过程登记ID
	private Integer fbIdId;
	
	@Column(name ="F_W_ID")							//供应商ID
	private Integer fwId;
		

	
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



	public Integer getFwId() {
		return fwId;
	}



	public void setFwId(Integer fwId) {
		this.fwId = fwId;
	}



	public Integer getNum() {
		return num;
	}



	public void setNum(Integer num) {
		this.num = num;
	}


	
	
	
	
	
	

}
