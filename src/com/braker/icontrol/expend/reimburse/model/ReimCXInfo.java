package com.braker.icontrol.expend.reimburse.model;

import java.math.BigDecimal;
import java.util.Date;


/**
 * 还款申报中，查询报销单冲销数据   只用作返回数据
 * @author 赵孟雷
 *
 */
public class ReimCXInfo {

	private Integer rId;		//报销Id
	
	private Date reimburseReqTime;		//报销时间
	
	private String gName;	//报销单摘要
	
	private Integer type;	//报销类型
	
	private BigDecimal cxAmount;		//冲销金额

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Date getReimburseReqTime() {
		return reimburseReqTime;
	}

	public void setReimburseReqTime(Date reimburseReqTime) {
		this.reimburseReqTime = reimburseReqTime;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
	}

	public BigDecimal getCxAmount() {
		return cxAmount;
	}

	public void setCxAmount(BigDecimal cxAmount) {
		this.cxAmount = cxAmount;
	}
	
	
}
