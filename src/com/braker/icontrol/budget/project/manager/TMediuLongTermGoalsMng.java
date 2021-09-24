package com.braker.icontrol.budget.project.manager;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TMediuLongTermGoals;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface TMediuLongTermGoalsMng extends BaseManager<TMediuLongTermGoals>{
	
	/**
	 * 保存中长期目标信息
	 * @param project
	 * @param user
	 * @param list
	 */
	public void saveLongAimByProject(TProBasicInfo project, User user,List<TMediuLongTermGoals> aimList);
	

	/**
	 * 保存中长期目标信息
	 * @param project
	 * @param user
	 * @param longAimJson
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 * @throws ParseException 
	 */
	public void saveLongAimByProject(TProBasicInfo project, User user, String longAimJson) throws JsonParseException, JsonMappingException, IOException, ParseException;
	
	/**
	 * 解析数据集合生成中长期目标集合
	 * @param dataList 数据集合
	 * @return
	 * @throws ParseException 
	 */
	public List<TMediuLongTermGoals> generateLongAimFromDataEntity(List<DataEntity> dataList) throws ParseException;
	
	/**
	 * 获得某项目的所有中长期目标
	 * @param proId 项目id
	 * @return
	 */
	public List<TMediuLongTermGoals> getGoalByPro(String proId);

	/**
	 * 删除某项目的中长期目标
	 * @param proId 项目id
	 * @return editList 不能删除的目标列表
	 */
	public void deleteGoalByProject(Integer fProId, List<TMediuLongTermGoals> editList);

	
}
