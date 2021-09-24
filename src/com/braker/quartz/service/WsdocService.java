package com.braker.quartz.service;

import java.util.List;

import com.braker.common.page.Pagination;
import com.braker.quartz.model.Wsdoc;

public interface WsdocService {
	
	/*
	 * 分页查询
	 * @author 安达
	 * @createtime 2019-03-12
	 * @updatetime 2019-03-12
	 */
	public Pagination pageList(Wsdoc bean, int pageNo, int pageSize);
	/**
	 * 从数据库获取所有任务
	 * @return
	 */
	public List<Wsdoc> getAllTarger();
	
	/**
	 * 根据名称查询任务
	 * @return
	 */
	public List<Wsdoc> getTargerByProperty(Wsdoc wsdoc);
	
	/**
	 * 增加或者修改任务
	 * @return
	 */
	public void saveTarger(Wsdoc wsdoc);
	
	/**
	 * 根据名称删除指定任务
	 * @return
	 */
	public void deleteTargerByProperty(Wsdoc wsdoc);
	/**
	 * 根据id查询指定任务
	 * @return
	 */
	public Wsdoc findById(String id);
	
	/**
	 * 根据key删除指定任务
	 * @return
	 */
	public void deleteTargerByTriggerName(String triggername);
}
