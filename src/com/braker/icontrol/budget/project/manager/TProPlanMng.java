package com.braker.icontrol.budget.project.manager;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface TProPlanMng extends BaseManager<TProPlan>{

	/**
	 * 保存
	 */
	public void save(List<TProPlan> planList, User user, TProBasicInfo project);
	
	public TProPlan save(TProBasicInfo project, User user, TProPlan plan);
	
	/**
	 * 保存项目计划信息
	 * @param project
	 * @param user
	 * @param list
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 * @throws ParseException 
	 */
	public void savePlanByProject(TProBasicInfo project, User user,String planJson) throws JsonParseException, JsonMappingException, IOException, ParseException;
	
	/**
	 * 解析数据集合生成计划集合
	 * @param dataList 数据集合
	 * @return
	 * @throws ParseException 
	 */
	public List<TProPlan> generatePlanFromDataEntity(List<DataEntity> dataList) throws ParseException;


	/**
	 * 获得项目所有计划
	 * @param proId 项目id
	 * @return
	 */
	public List<TProPlan> getTProPlansByPro(String proId);

	/**
	 * 删除某项目的部分计划表
	 * @param proId 项目id
	 * @param editList 不删除的项目列表
	 * @return
	 */
	public void deletePlanByProject(Integer fProId, List<TProPlan> editList);

}
