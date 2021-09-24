package com.braker.icontrol.expend.apply.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.braker.common.entity.BaseEntity;


/**
 * 公务接待-参考观察安排信息model
 * @author 沈帆
 * @createtime 2020-10-22
 * @updatetime 2020-10-22
 */
@Entity
@Table(name = "T_RECEPTION_OBSERVE_PLAN")
public class ReceptionObservePlan extends BaseEntity{
	@Id
	@Column(name = "F_O_ID")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer oId;			//主键ID
	
	@Column(name = "F_J_ID")
	private Integer jId;				//接待信息ID
	
	@Column(name = "F_OBSERVE_TIME")
	private Date observeTime;	//时间
	
	@Column(name = "F_PERSON_NUM")
	private String personNum;			//人数
	
	@Column(name = "F_ACCOMPANY_PERSON")
	private String accompanyPerson;			//其中陪同人员
	
	@Column(name = "F_PROJECT")
	private String fProject;			//项目
	
	public Integer getoId() {
		return oId;
	}

	public void setoId(Integer oId) {
		this.oId = oId;
	}

	public Integer getjId() {
		return jId;
	}

	public void setjId(Integer jId) {
		this.jId = jId;
	}

	public Date getObserveTime() {
		return observeTime;
	}

	public void setObserveTime(Date observeTime) {
		this.observeTime = observeTime;
	}

	public String getPersonNum() {
		return personNum;
	}

	public void setPersonNum(String personNum) {
		this.personNum = personNum;
	}

	public String getAccompanyPerson() {
		return accompanyPerson;
	}

	public void setAccompanyPerson(String accompanyPerson) {
		this.accompanyPerson = accompanyPerson;
	}

	public String getfProject() {
		return fProject;
	}

	public void setfProject(String fProject) {
		this.fProject = fProject;
	}
	
	
	
	
}
