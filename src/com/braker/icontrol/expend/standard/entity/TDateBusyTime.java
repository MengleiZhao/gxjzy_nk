package com.braker.icontrol.expend.standard.entity;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.braker.common.entity.BaseEntityEmpty;

/**
 * 差旅费的配置信息中的旺季时间
* <p>Title:TDateBusyTime </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年5月17日
 */
@Entity
@Table(name = "T_DATE_BUSY_TIME")
public class TDateBusyTime extends BaseEntityEmpty {
	
	@Id
	@Column(name = "F_D_B_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer dbId;				//主键ID
	
	@Column(name = "P_ID")
	private Integer pId;

	@Column(name = "F_DATE_BUSY_START")
	private Date busyDateStart;						//旺季期间（开始）
	
	@Column(name = "F_DATE_BUSY_END")
	private Date busyDateEnd;						//旺季期间（结束）

	public Integer getDbId() {
		return dbId;
	}

	public void setDbId(Integer dbId) {
		this.dbId = dbId;
	}

	public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

	public Date getBusyDateStart() {
		return busyDateStart;
	}

	public void setBusyDateStart(Date busyDateStart) {
		this.busyDateStart = busyDateStart;
	}

	public Date getBusyDateEnd() {
		return busyDateEnd;
	}

	public void setBusyDateEnd(Date busyDateEnd) {
		this.busyDateEnd = busyDateEnd;
	}
}

