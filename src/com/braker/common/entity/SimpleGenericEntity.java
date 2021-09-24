package com.braker.common.entity;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.GenericGenerator;

@SuppressWarnings("serial")
@MappedSuperclass
public class SimpleGenericEntity extends AbstractEntity {
	@Id
    @Column(name = "pid")
    @GeneratedValue(generator = "hibernate-uuid")
    @GenericGenerator(name = "hibernate-uuid", strategy = "guid")
    private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
