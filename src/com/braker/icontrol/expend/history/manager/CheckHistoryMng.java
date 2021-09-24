package com.braker.icontrol.expend.history.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.workflow.entity.TProcessCheck;

public interface CheckHistoryMng  extends BaseManager<TProcessCheck>{
	/**
	 * 根据类型获取审批历史纪录
	 * @param type
	 * @param foCode
	 * @param stauts
	 * @return
	 */
	public List<TProcessCheck> findCheckHistorys(String type,String foCode,String stauts);
	
	/**
	 * 根据类型和id获取编码
	 * @param type
	 * @param id
	 * @return
	 */
	public String getFoCodeById(String type, Integer id);
	
}
