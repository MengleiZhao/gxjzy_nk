package com.braker.common.entity;

import java.io.Serializable;

public interface EntityDao extends Serializable {
	/**
	 * ��ȡentity������
	 * @return
	 */
	public String getJoinTable();
	/**
	 * ��ȡentity��ID
	 * @return
	 */
	public String getEntryId();
}
